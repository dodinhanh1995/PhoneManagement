using System;
using Controllers;

namespace PhoneManagement.UserControls.Templates
{
    public partial class UcLogoOfBrand : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLogoBand();
            }
        }

        public void LoadLogoBand()
        {
            rptLogo.DataSource = CommonController.Instance.GetDataByChoose("brand");
            rptLogo.DataBind();
        }
    }
}