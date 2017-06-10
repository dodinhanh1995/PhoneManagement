
namespace Models
{
    public class CartInfo
    {
        public CartInfo(string id, int quantity)
        {
            this.Id = id;
            this.Quantity = quantity;              
        }

        public CartInfo() { }

        private string id;

        public string Id
        {
            get { return id; }
            set { id = value; }
        }

        private int quantity;

        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }
        
    }
}
