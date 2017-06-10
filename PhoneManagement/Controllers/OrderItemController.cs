using Models;
using System.Data;

namespace Controllers
{
    public class OrderItemController
    {
        private static OrderItemController instance;

        public static OrderItemController Instance
        {
            get { if (instance == null) instance = new OrderItemController(); return OrderItemController.instance; }
        }

        private OrderItemController() { }

        public bool OrderItems(string action, OrderItemInfo data)
        {
            string query = "EXEC sp_OrderItems @action , @id , @productID , @orderID , @amount";
            return DataProvider.Instance.ExecuteNonQuery(query, new object[] { action, data.Id, data.ProductID, data.OrderID, data.Amount }) > 0;
        }

        public bool OrderItemDelete(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_OrderItems 'Delete', @id", new object[] { id }) > 0;
        }

        public bool OrderItemsCheckOrderIdIsExists(int orderID)
        {
            return (int)DataProvider.Instance.ExecuteScalarQuery("EXEC sp_OrderItems 'CheckOrderIdIsExists', 0, 0, @orderID", new object[] { orderID }) > 0;
        }

        public DataTable GetOrderIDByProductID(int productID)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC dbo.sp_OrderItems 'CountProduct', 0, @productID", new object[] { productID });
        }

    }
}
