using Controllers;
using System;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;

namespace PhoneManagement
{
    public partial class Brand : System.Web.UI.Page
    {
        DataTable dtProducts;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTopAdvertise();

            LoadProduct();
        }

        void LoadTopAdvertise()
        {
            rptAdvertiseTop.DataSource = CommonController.Instance.GetDataByChoose("advertisements", "name, picture", "2", "position = 'SlideShow'", "id DESC");
            rptAdvertiseTop.DataBind();
        }

        void LoadLinkFilter(string BrandName, double From, double To, string Sort)
        {
            hplLessThan3m.NavigateUrl = "thuong-hieu-" + BrandName + "-gia-duoi-3000000";
            hpl3mTo6m.NavigateUrl = "thuong-hieu-" + BrandName + "-gia-tu-3000000-den-6000000";
            hpl6mTo10m.NavigateUrl = "thuong-hieu-" + BrandName + "-gia-tu-6000000-den-10000000";
            hpl10mTo15m.NavigateUrl = "thuong-hieu-" + BrandName + "-gia-tu-10000000-den-15000000";
            hplGreaterThan15m.NavigateUrl = "thuong-hieu-" + BrandName + "-gia-tren-15000000";

            hplASC.NavigateUrl = "thuong-hieu-" + BrandName + "-sx-gia-asc";
            hplDESC.NavigateUrl = "thuong-hieu-" + BrandName + "-sx-gia-desc";

            string url = HttpContext.Current.Request.Url.PathAndQuery;
            if(url.Contains("-sx-gia-"))
            {
                string temp = "-sx-gia-" + Sort;

                hplLessThan3m.NavigateUrl += temp;
                hpl3mTo6m.NavigateUrl += temp;
                hpl6mTo10m.NavigateUrl += temp;
                hpl10mTo15m.NavigateUrl += temp;
                hplGreaterThan15m.NavigateUrl += temp;
            }
        }

        void LoadProduct()
        {
            string BrandName = RouteData.Values["id"] != null ? RouteData.Values["id"].ToString() : "apple";
            double From = RouteData.Values["from"] != null ? Convert.ToDouble(RouteData.Values["from"]) : 0;
            double To = RouteData.Values["to"] != null ? Convert.ToDouble(RouteData.Values["to"]) : 0;
            string Sort = RouteData.Values["sort"] != null ? RouteData.Values["sort"].ToString() : "";

            LoadLinkFilter(BrandName, From, To, Sort);

            string Action = String.Empty;

            if (From > 0) { Action = "LESSTHAN"; }
            if (To > 0) { Action = "GREATERTHAN"; }
            if (From > 0 & To > 0) { Action = "BETWEEN"; }

            dtProducts = ProductController.Instance.ProductGetDataByBrandName(BrandName, Action, From, To, Sort);

            rptProductBox.DataSource = dtProducts;
            rptProductBox.DataBind();
            Page.Title = "AnhDo Mobile | " + BrandName.ToUpper();
            lblTotalRecords.Text = dtProducts.Rows.Count.ToString() + " Điện thoại";
        }

        public string writeText(int id, int priceMain)
        {
            StringBuilder str = new StringBuilder();
            str.Append("<span class=\"price pull-left\">");
            str.Append("<b>" + priceMain.ToString("0,0") + "<sup>đ</sup></b>");
            str.Append("</span><a href='AddToCart.aspx?id=" + id + "' class='btn btn-xs btn-warning pull-right'>");
            str.Append("<span class=\"fa fa-cart-plus\"> <b>Đặt mua</b></span></a>");
            return str.ToString();
        }
    }
}