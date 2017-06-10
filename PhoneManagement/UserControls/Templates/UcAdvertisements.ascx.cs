using Controllers;
using System;
using System.Data;

namespace PhoneManagement.UserControls.Templates
{
    public partial class UcAdvertisements : System.Web.UI.UserControl
    {
        public DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSlideShow();

                LoadAdvertiseHomeTopRight();
            }
        }

        public void LoadSlideShow()
        {
            dt = AdvertisementController.Instance.GetUrlPictureByChoose("slideshow", 5, "id DESC");
            rptSlideShow.DataSource = dt;
            rptSlideShow.DataBind();
        }

        public void LoadAdvertiseHomeTopRight()
        {
            rptBannerTopRight.DataSource = AdvertisementController.Instance.GetUrlPictureByChoose("home-top-right");
            rptBannerTopRight.DataBind();
        }
    }
}