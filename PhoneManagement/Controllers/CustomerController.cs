using Models;
using System;
using System.Data;

namespace Controllers
{
    public class CustomerController
    {
        private static CustomerController instance;

        public static CustomerController Instance
        {
            get { if (instance == null) instance = new CustomerController(); return instance; }
        }

        private CustomerController() { }

        public bool Customers(string action, CustomerInfo data)
        {
            string query = "EXEC sp_Customers @action , @id , @name , @gender , @email , @telephone";
            object[] para = new object[] 
            { 
                action, data.Id, data.Name, data.Gender, data.Email, data.Telephone
            };
            return DataProvider.Instance.ExecuteNonQuery(query, para) > 0;
        }

        public bool Customers(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Customers 'Delete', @id", new object[] { id }) > 0;
        }

        public int CustomerInsertAndGetLastID(CustomerInfo data)
        {
            string query = "EXEC sp_Customers 'InsertAndGetLastID', 0, @name , @gender , @email , @telephone";
            object[] para = new object[] 
            { 
                data.Name, data.Gender, data.Email, data.Telephone
            };
            return Convert.ToInt32(DataProvider.Instance.ExecuteScalarQuery(query, para));
        }

        public DataTable GetCustomerByOrderID(int orderID)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_Customers 'GetCustomerByOrderID', 0, '', '', '', '', @orderID", new object[] { orderID });
        }
    }
}
