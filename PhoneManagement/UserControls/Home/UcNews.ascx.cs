using Controllers;
using System;

namespace PhoneManagement.UserControls.Home
{
    public partial class UcNews : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNewestNews();
            }
        }

        void LoadNewestNews()
        {
            rptNewsTitle.DataSource = CommonController.Instance.GetDataByChoose("news", "id, title, urlTitle, [view], picture, dateCreated", "7", "", "dateCreated DESC");
            rptNewsTitle.DataBind();
        }
    }
}