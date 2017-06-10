
namespace Models
{
    public class AdvertisementInfo
    {

        public AdvertisementInfo(string name = "", string picture = "", string position = "", int id = 0)
        {
            this.Name = name;
            this.Picture = picture;
            this.Position = position;
            this.Id = id;
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

        private string picture;

        public string Picture
        {
            get { return picture; }
            set { picture = value; }
        }

        private string position;

        public string Position
        {
            get { return position; }
            set { position = value; }
        }
    }
}
