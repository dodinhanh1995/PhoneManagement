using Controllers;
using System;
using System.Data;
using System.Web.UI;

namespace PhoneManagement
{
    public partial class News : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNews();
            }
        }

        void LoadNews()
        {
            string urlTitle = RouteData.Values["id"] != null ? RouteData.Values["id"] as string : "20-dien-thoai-ban-chay-nhat-nhung-ngay-dau-thang-4-tai-anhdo";

            DataTable dt = CommonController.Instance.GetDataByChoose("news", "*", "1", "urlTitle = '" + urlTitle + "'");

            lvNewsDetails.DataSource = dt;
            lvNewsDetails.DataBind();
            Page.Title = dt.Rows[0]["title"].ToString() + " | AnhDo Mobile";
            NewsController.Instance.NewsUpdateView(Convert.ToInt32(dt.Rows[0]["id"]));
        }
    }
}