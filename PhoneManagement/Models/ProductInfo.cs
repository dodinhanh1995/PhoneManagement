
namespace Models
{
    public class ProductInfo
    {
        public ProductInfo(string name,double price, double discount, int quantity, string picture, string description, int brandID, int id = 0) 
        {
            this.Name = name;
            this.Price = price;
            this.Discount = discount;
            this.Quantity = quantity;
            this.Picture = picture;
            this.Description = description;
            this.BrandId = brandID;
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

        private string nameUrl;

        public string NameUrl
        {
            get { return nameUrl; }
            set { nameUrl = value; }
        }

        private double price;

        public double Price
        {
            get { return price; }
            set { price = value; }
        }

        private double discount;

        public double Discount
        {
            get { return discount; }
            set { discount = value; }
        }

        private int quantity;

        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        private string picture;

        public string Picture
        {
            get { return picture; }
            set { picture = value; }
        }

        private string description;

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        private int view;

        public int View
        {
            get { return view; }
            set { view = value; }
        }

        private int brandId;

        public int BrandId
        {
            get { return brandId; }
            set { brandId = value; }
        }
    }
}
