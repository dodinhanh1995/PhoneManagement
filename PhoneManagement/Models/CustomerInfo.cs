
namespace Models
{
    public class CustomerInfo
    {
        public CustomerInfo(string name = "", byte gender = 1, string email = "", string telephone = "", int id = 0)
        {
            this.Name = name;
            this.Gender = gender;
            this.Email = email;
            this.Telephone = telephone;
            this.Id = id;
        }

        public CustomerInfo() { }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string name;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private byte gender;

        public byte Gender
        {
            get { return gender; }
            set { gender = value; }
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
    }
}
