
namespace Models
{
    public class OrderInfo
    {
        public OrderInfo(int customerID, string shipAddress, string note, byte status, int id = 0)
        {
            this.CustomerID = customerID;
            this.ShipAddress = shipAddress;
            this.Note = note;
            this.Status = status;
            this.Id = id;
        }

        public OrderInfo() { }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private int customerID;

        public int CustomerID
        {
            get { return customerID; }
            set { customerID = value; }
        }

        private string shipAddress;

        public string ShipAddress
        {
            get { return shipAddress; }
            set { shipAddress = value; }
        }

        private string note;

        public string Note
        {
            get { return note; }
            set { note = value; }
        }

        private byte status;

        public byte Status
        {
            get { return status; }
            set { status = value; }
        }
    }
}
