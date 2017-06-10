using Controllers;
using System;
using System.Data;

namespace PhoneManagement
{
    public partial class Login : System.Web.UI.Page
    {
        public string Message { private set; get; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUsername.Focus();
            }
        }

        void LoadLogin()
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            if (!MemberController.Instance.CheckUsernameAndPasswordIsExists(username, password))
            {
                Message = "Tên đăng nhập hoặc Mật khẩu không đúng! Vui lòng nhập lại.";
                plhMessage.Visible = true;
                return;
            }
            DataRow row = MemberController.Instance.MemberGetInfoByUsername(username).Rows[0];
            Session["ID"] = row["id"].ToString();
            Session["Username"] = username;
            Session["DisplayName"] = row["displayName"].ToString();
            Session["Email"] = row["email"].ToString();
            Session["Telephone"] = row["telephone"].ToString();
            Session["UrlAvatar"] = row["urlAvatar"].ToString();

            Response.Redirect("~/Admin/Dashboard.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            LoadLogin();
        }
    }
}