using Controllers;
using System;
using System.Data;
using System.Web.UI;

namespace PhoneManagement
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Key() != null)
            {
                LoadTopAdvertise();

                LoadProduct();
            }
        }

        public string Key()
        {
            return RouteData.Values["key"] != null ? RouteData.Values["key"] as string : "";
        }

        void LoadTopAdvertise()
        {
            rptAdvertiseTop.DataSource = AdvertisementController.Instance.GetUrlPictureByChoose("SlideShow", 2, "id DESC");
            rptAdvertiseTop.DataBind();
        }

        void LoadProduct()
        {
            DataTable dtProducts = ProductController.Instance.ProductSearchByKey(Key());

            rptProductBox.DataSource = dtProducts;
            rptProductBox.DataBind();
            lblTotalRecords.Text = dtProducts.Rows.Count.ToString() + " Điện thoại";
            lblKey.Text = "Tìm kiếm sản phẩm với từ khóa \"" + Key() + "\"";
            Page.Title = "Tìm kiếm sản phẩm với từ khóa " + Key() + " | AnhDo Mobile";
        }
    }
}