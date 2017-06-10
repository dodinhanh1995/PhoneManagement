
namespace Models
{
    public class MemberInfo
    {
        public MemberInfo(string username, string displayName, string password, string email, string telephone, string urlAvatar, int id = 0) 
        {
            this.Username = username;
            this.DisplayName = displayName;
            this.Password = password;
            this.Email = email;
            this.Telephone = telephone;
            this.UrlAvatar = urlAvatar;
            this.Id = id;
        }

        public MemberInfo() { }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string username;

        public string Username
        {
            get { return username; }
            set { username = value; }
        }

        private string displayName;

        public string DisplayName
        {
            get { return displayName; }
            set { displayName = value; }
        }

        private string password;

        public string Password
        {
            get { return password; }
            set { password = value; }
        }

        private string email;

        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        private string telephone;

        public string Telephone
        {
            get { return telephone; }
            set { telephone = value; }
        }

        private string urlAvatar;

        public string UrlAvatar
        {
            get { return urlAvatar; }
            set { urlAvatar = value; }
        }
    }
}
