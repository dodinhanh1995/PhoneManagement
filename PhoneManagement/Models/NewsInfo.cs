
namespace Models
{
    public class NewsInfo
    {

        public NewsInfo(string title, string content, string picture, int id = 0)
        {
            this.Title = title;
            this.Content = content;
            this.Picture = picture;
            this.Id = id;
        }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string title;

        public string Title
        {
            get { return title; }
            set { title = value; }
        }

        private string content;

        public string Content
        {
            get { return content; }
            set { content = value; }
        }

        private string picture;

        public string Picture
        {
            get { return picture; }
            set { picture = value; }
        }
    }
}
