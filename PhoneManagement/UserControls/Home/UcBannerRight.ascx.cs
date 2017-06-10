using Controllers;
using System;

namespace PhoneManagement.UserControls.Home
{
    public partial class UcBannerRight : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdvertiseHomeRight();
            }
        }
        void LoadAdvertiseHomeRight()
        {
            rptAdvertiseHomeRight.DataSource = CommonController.Instance.GetDataByChoose("advertisements", "name, picture", "", "position = 'Home-Right'");
            rptAdvertiseHomeRight.DataBind();

        }
    }
}