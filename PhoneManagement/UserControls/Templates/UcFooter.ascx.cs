using Controllers;
using System;

namespace PhoneManagement.UserControls.Templates
{
    public partial class UcFooter : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTopViewProduct();
            }
        }

        void LoadTopViewProduct()
        {
            rptTopViewProduct.DataSource = CommonController.Instance.GetDataByChoose("products", "id, name, name_url", "5", "", "[view] DESC");
            rptTopViewProduct.DataBind();
        }
    }
}