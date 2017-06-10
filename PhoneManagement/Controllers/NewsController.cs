using Models;
using System.Data;

namespace Controllers
{
    public class NewsController
    {
        private static NewsController instance;

        public static NewsController Instance
        {
            get { if (instance == null) instance = new NewsController(); return instance; }
        }

        private NewsController() { }

        public bool News(string action, NewsInfo data)
        {
            string query = "EXEC sp_News @action , @id , @title , @content , @picture";
            return DataProvider.Instance.ExecuteNonQuery(query, new object[] { action, data.Id, data.Title, data.Content, data.Picture }) > 0;
        }

        public bool NewsUpdateView(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_News 'UpdateView', @id", new object[] { id }) > 0;
        }

        public bool NewsDelete(int id)
        {
            return DataProvider.Instance.ExecuteNonQuery("EXEC sp_News 'Delete', @id", new object[] { id }) > 0;
        }

        public DataTable NewsGetList()
        {
            return CommonController.Instance.GetDataByChoose("news");
        }

        public DataTable NewsGetListByID(int id)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC dbo.sp_News 'GetInfoByID', @id", new object[] { id });
        }

        public bool CheckTitleIsExists(string title)
        {
            string query = "EXEC sp_News 'CheckTitleIsExists', 0, @title";
            return (int)DataProvider.Instance.ExecuteScalarQuery(query, new object[] { title }) > 0;
        }
    }
}
