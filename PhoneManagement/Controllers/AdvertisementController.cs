using Models;
using System;
using System.Data;

namespace Controllers
{
    public class AdvertisementController
    {
        private static AdvertisementController instance;

        public static AdvertisementController Instance
        {
            get { if (instance == null) instance = new AdvertisementController(); return AdvertisementController.instance; }
        }

        private AdvertisementController() { }

        public bool Advertisements(string action, AdvertisementInfo data)
        {
            string query = "EXEC sp_Advertisements @action , @id , @name , @picture , @position";
            object[] para = new object[] 
            { 
                action, data.Id, data.Name, data.Picture, data.Position
            };
            return DataProvider.Instance.ExecuteNonQuery(query, para) > 0;
        }

        public bool AdvertisementDelete(int id)
        {
            string query = "EXEC sp_Advertisements 'Delete', @id";
            return DataProvider.Instance.ExecuteNonQuery(query, new object[] { id }) > 0;
        }

        public bool CheckByNameIsExists(string name)
        {
            string query = "EXEC sp_Advertisements 'CheckNameIsExists', '', @name";
            object[] para = new object[] { name };
            return Convert.ToInt32(DataProvider.Instance.ExecuteScalarQuery(query, para)) > 0;
        }

        public string GetPictureByID(int id)
        {
            string query = "EXEC sp_Advertisements 'GetPicture', @id";
            return DataProvider.Instance.ExecuteScalarQuery(query, new object[] { id }).ToString();
        }

        public DataTable GetUrlPictureByChoose(string position, int top = 2, string orderby = "")
        {
            return CommonController.Instance.GetDataByChoose("advertisements",
                                                        "name, picture",
                                                        top.ToString(),
                                                        "position = '" + position + "'",
                                                        orderby);
        }
    }
}
