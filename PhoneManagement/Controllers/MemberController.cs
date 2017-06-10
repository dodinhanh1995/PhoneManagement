using Models;
using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace Controllers
{
    public class MemberController
    {
        private static MemberController instance;

        public static MemberController Instance
        {
            get { if (instance == null) instance = new MemberController(); return MemberController.instance; }
        }

        private MemberController() { }

        public bool Members(string action, MemberInfo data)
        {
            string query = "EXEC sp_Members @action , @id , @username , @displayName , @password , @email , @telphone  , @urlAvatar";
            object[] para = new object[] 
            { 
                action, data.Id, data.Username, data.DisplayName, HasPassword(data.Password),
                data.Email, data.Telephone, data.UrlAvatar
            };
            return DataProvider.Instance.ExecuteNonQuery(query, para) > 0;
        }


        public bool MemberDelete(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Members 'Delete', @id", new object[] { id }) > 0;
        }

        public DataTable MemberGetByInfo()
        {
            return CommonController.Instance.GetDataByChoose("members", "id, username, displayName, email, telephone, urlAvatar, dateCreated");
        }

        public bool MembersUpdateProfile(MemberInfo data, string NewPassword)
        {
            NewPassword = String.IsNullOrEmpty(NewPassword) ? "" : HasPassword(NewPassword);
            string query = "EXEC sp_MembersUpdateProfile @Username , @DisplayName , @Email , @Telephone , @UrlAvatar , @OldPassword , @NewPassword";
            object[] para = new object[]
            { 
                data.Username, data.DisplayName, data.Email, data.Telephone,
                data.UrlAvatar, HasPassword(data.Password), NewPassword
            };
            return DataProvider.Instance.ExecuteNonQuery(query, para) > 0;
        }

        public DataTable MemberGetInfoByUsername(string username)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_Members 'GetInfoByUsername', 0, @username", new object[] { username });
        }

        public bool CheckUsernameOrEmailIsExists(string username, string email)
        {
            string query = "EXEC sp_Members 'CheckUsernameOrEmailIsExists', 0, @username ,'', '', @email";
            object[] para = new object[] { username, email };
            return (int)DataProvider.Instance.ExecuteScalarQuery(query, para) > 0;
        }

        public bool CheckUsernameAndPasswordIsExists(string username, string password)
        {
            string query = "EXEC sp_Members 'CheckUsernameAndPasswordIsExists', 0, @username , '', @password";
            return (int)DataProvider.Instance.ExecuteScalarQuery(query, new object[] { username, HasPassword(password) }) > 0;
        }

        public string HasPassword(string password)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(password);
            byte[] hasPassword = new MD5CryptoServiceProvider().ComputeHash(temp);

            StringBuilder str = new StringBuilder();

            foreach (byte item in hasPassword)
            {
                str.Append(item);
            }
            return str.ToString();

            //string str = "";

            //foreach (byte item in hasPassword)
            //{
            //    str += item;
            //}
            //return str;
        }

    }
}
