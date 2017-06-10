using Controllers;
using System;
using System.Data;

namespace PhoneManagement.UserControls.Home
{
    public partial class UcProducts : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductIos();

                LoadAdvertiseHomeMiddle();

                LoadProductAdroid();
            }
        }

        void LoadProductIos()
        {
            rptIosProductBox.DataSource = ProductController.Instance.ProductGetListByIosOrAndroid("1");
            rptIosProductBox.DataBind();
        }

        void LoadProductAdroid()
        {
            rptAdroidProductBox.DataSource = ProductController.Instance.ProductGetListByIosOrAndroid("2");
            rptAdroidProductBox.DataBind();
        }

        void LoadAdvertiseHomeMiddle()
        {
            DataRow drMiddle = AdvertisementController.Instance.GetUrlPictureByChoose("Home-Middle").Rows[0];
            imgHomeMiddle.ImageUrl = "~/public/upload/advertisements/" + drMiddle["picture"].ToString();
            imgHomeMiddle.AlternateText = drMiddle["name"].ToString();
        }
    }
}