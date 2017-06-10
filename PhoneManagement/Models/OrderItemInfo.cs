
namespace Models
{
    public class OrderItemInfo
    {
        public OrderItemInfo(int productID, int orderID, int amount, int id = 0)
        {
            this.ProductID = productID;
            this.OrderID = orderID;
            this.Amount = amount;
            this.Id = id;
        }

        public OrderItemInfo(int id, int amount)
        {
            this.Id = id;
            this.Amount = amount;
        }

        public OrderItemInfo() { }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private int productID;

        public int ProductID
        {
            get { return productID; }
            set { productID = value; }
        }

        private int orderID;

        public int OrderID
        {
            get { return orderID; }
            set { orderID = value; }
        }

        private int amount;

        public int Amount
        {
            get { return amount; }
            set { amount = value; }
        }
    }
}
