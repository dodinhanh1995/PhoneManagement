using Models;
using System;

namespace Controllers
{
    public class BrandController
    {
        private static BrandController instance;

        public static BrandController Instance
        {
            get { if (instance == null) instance = new BrandController(); return instance; }
        }

        private BrandController() { }

        public bool Brand(string Action, BrandInfo data)
        {
            object[] para = new object[] 
            { 
                Action, data.Id, data.Name, data.Logo
            };
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Brand @action , @id , @name , @logo", para) > 0;
        }

        public bool BrandDelete(int id)
        {
            ProductController.Instance.DeleteProductByBrand(id);

            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_Brand 'Delete', @id", new object[] { id }) > 0;
        }

        public bool CheckByNameIsExists(string name)
        {
            string query = "EXEC sp_Brand 'CheckNameIsExists', '', @name";
            return Convert.ToInt32(DataProvider.Instance.ExecuteScalarQuery(query, new object[] { name })) > 0;
        }

        public string BrandGetLogo(int id)
        {
            return DataProvider.Instance.ExecuteScalarQuery("EXEC sp_Brand 'GetLogo', @id", new object[] { id }).ToString();
        }
    }
}
