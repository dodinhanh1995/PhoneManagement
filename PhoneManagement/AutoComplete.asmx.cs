using Controllers;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;

namespace PhoneManagement
{
    /// <summary>
    /// Summary description for AutoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AutoComplete : System.Web.Services.WebService
    {

        [WebMethod]
        public string[] AutoCompleteAjaxRequest(string prefixText)
        {
            List<string> listName = new List<string>();
            DataTable dt = DataProvider.Instance.ExecuteQuery("EXEC dbo.sp_ProductSearchByKey @prefixText", new object[] { prefixText });

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    listName.Add(row["name"].ToString());
                }
            }
            return listName.ToArray();
        }
    }
}
