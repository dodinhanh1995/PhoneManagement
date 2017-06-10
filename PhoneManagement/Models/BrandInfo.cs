
namespace Models
{
   public class BrandInfo
    {
           public BrandInfo(string name = "", string logo = "", int id = 0, string name_url = "")
            {
                this.Name = name;
                this.Logo = logo;
                this.Id = id;
                this.NameUrl = name_url;
            }

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

            private string nameUrl;

            public string NameUrl
            {
                get { return nameUrl; }
                set { nameUrl = value; }
            }

            private string logo;

            public string Logo
            {
                get { return logo; }
                set { logo = value; }
            }

    }
}
