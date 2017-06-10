using Models;
using System;
using System.Data;

namespace Controllers
{
    public class ProductController
    {
        private static ProductController instance;

        public static ProductController Instance
        {
            get { if (instance == null) instance = new ProductController(); return instance; }
        }

        private ProductController() { }

        public bool Products(string action, ProductInfo data)
        {
            string query = "EXEC sp_Products @action , @id , @name , @price , @discount , @quantity , @picture , @description , @brandID";
            object[] para = new object[] 
            { 
                action, data.Id, data.Name, data.Price, data.Discount,
                data.Quantity, data.Picture, data.Description, data.BrandId
            };
            return DataProvider.Instance.ExecuteNonQuery(query, para) > 0;
        }

        public bool ProductDelete(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Products 'Delete', @id", new object[] { id }) > 0;
        }

        public DataTable ProductGetList(string key)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductGetList '', @key", new object[] { key });
        }

        public DataTable ProductGetListByIosOrAndroid(string brandID, string top = "9")
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductGetListByIosOrAndroid @brandID , @top", new object[] { brandID, top });
        }

        public DataTable ProductSearchByKey(string key)
        {
            object[] para = new object[] { key };
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductSearchByKey @key", para);
        }

        public DataTable ProductGetDataByBrandName(string brandName, string action, double fromPrice, double toPrice, string sort)
        {
            object[] para = new object[] { brandName, action, fromPrice, toPrice, sort };
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductGetDataByBrand @brandName , @action , @fromPrice , @toPrice , @sort", para);
        }

        public bool ProductCheckNameIsExists(string name)
        {
            return Convert.ToInt32(DataProvider.Instance.ExecuteScalarQuery("sp_Products 'CheckNameIsExists', 0, @name", new object[] { name })) > 0;
        }

        public string ProductGetPicture(string id)
        {
            string query = "EXEC sp_GetDataByChoose @Table , 'picture' , '1' , @Where";
            return DataProvider.Instance.ExecuteScalarQuery(query, new object[] { "products", "id = '" + id + "'" }).ToString();
        }

        public DataTable ProductGetDetailByID(string id)
        {
            string query = "EXEC dbo.sp_GetDataByChoose 'products', 'name, name_url, price, discount, quantity, picture', '1', @Where";
            return DataProvider.Instance.ExecuteQuery(query, new object[] { "id = '" + id + "'" });
        }

        public DataTable ProductGetDetailByID_Main(string nameUrl)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductGetList @nameUrl", new object[] { nameUrl });
        }

        public bool DeleteProductByBrand(int brandID)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Products 'DeleteByBrandID', 0, '', 0, 0, 0, '', '', @brandID", new object[] { brandID }) > 0;
        }

        public DataTable ProductGetSuggestion(string id, string brandID)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_Products 'GetSuggestion',  @id , '', 0, 0, 0, '', '', @brandID", new object[] { id, brandID });
        }

        public string CalculationProductPrice(int price, int discount)
        {
            return (price * (100 - discount) / 100).ToString("0,0");
        }

        public DataTable ProductShowCart(string id, int quantity)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC sp_ProductShowCart @id , @quantity", new object[] { id, quantity });
        }

        public bool ProductUpdateView(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Products 'UpdateView', @id", new object[] { id }) > 0;
        }
    }
}
