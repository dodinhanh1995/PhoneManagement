using System.Data;

namespace Controllers
{
    public class CommonController
    {
        private static CommonController instance;

        public static CommonController Instance
        {
            get { if (instance == null) instance = new CommonController(); return CommonController.instance; }
        }

        private CommonController() { }

        public DataTable GetDataByChoose(string table = "products", string column = "*", string top = "", string where = "", string orderby = "")
        {
            object[] para = new object[] { table, column, top, where, orderby };
            return DataProvider.Instance.ExecuteQuery("EXEC sp_GetDataByChoose @table , @column , @top , @where , @orderby", para);
        }
    }
}
