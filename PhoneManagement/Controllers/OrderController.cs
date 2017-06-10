using Models;
using System;
using System.Data;

namespace Controllers
{
    public class OrderController
    {
        private static OrderController instance;

        public static OrderController Instance
        {
            get { if (instance == null) instance = new OrderController(); return OrderController.instance; }
        }

        private OrderController() { }

        public bool Orders(string action, OrderInfo data)
        {
            object[] para = new object[] { action, data.Id, data.CustomerID, data.ShipAddress, data.Note, data.Status };
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Orders @action , @ID , @CustomerID , @ShipAddress , @Note , @Status", para) > 0;
        }

        public bool OrderByID(string action, int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Orders @action , @id", new object[] { action, id }) > 0;
        }

        public int OrderInsertAndGetLastID(OrderInfo data)
        {
            string query = "EXEC sp_Orders 'Insert', 0, @customerID , @shipAddress , @Note";
            return Convert.ToInt32(DataProvider.Instance.ExecuteScalarQuery(query, new object[] { data.CustomerID, data.ShipAddress, data.Note }));
        }

        public DataTable OrderBrief()
        {
            return DataProvider.Instance.ExecuteQuery("SELECT * FROM view_OrdersBrief ORDER BY id DESC");
        }

        public DataTable GetInfoByID(string action, int id)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_Orders @action , @id", new object[] { action, id });
        }

        public int OrderGetStatistics(string Action, string From, string To)
        {
            object result = DataProvider.Instance.ExecuteScalarQuery("EXEC sp_OrdersStatistics @Action , @From , @To", new object[] { Action, From, To });
            return String.IsNullOrEmpty(result.ToString()) ? 0 : Convert.ToInt32(result);
        }

        public DataTable TopOrderStatistics(string Action, string From, string To)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_OrdersStatistics @Action , @From , @To", new object[] { Action, From, To });
        }

        public DataTable CheckQuantityByOrderID(int orderID)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC dbo.sp_CheckQuantityByOrderID @orderID", new object[] { orderID });
        }

    }
}
