using Controllers;
using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Text;

namespace PhoneManagement
{
    public partial class Phone : System.Web.UI.Page
    {
        DataTable dtProducts;
        public int CurrentPage
        {
            get
            {
                if (ViewState["CurrentPage"] != null)
                {
                    return Convert.ToInt32(ViewState["CurrentPage"]);
                }
                else
                {
                    return 0;
                }
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTopAdvertise();

            LoadProduct(15);
        }

       

        void LoadTopAdvertise()
        {
            rptAdvertiseTop.DataSource = AdvertisementController.Instance.GetUrlPictureByChoose("Phone-Main", 3);
            rptAdvertiseTop.DataBind();
        }

        void LoadLinkFilter(double From, double To, string Sort)
        {
            hplLessThan3m.NavigateUrl = "dtdd-gia-duoi-3000000";
            hpl3mTo6m.NavigateUrl = "dtdd-gia-tu-3000000-den-6000000";
            hpl6mTo10m.NavigateUrl = "dtdd-gia-tu-6000000-den-10000000";
            hpl10mTo15m.NavigateUrl = "dtdd-gia-tu-10000000-den-15000000";
            hplGreaterThan15m.NavigateUrl = "dtdd-gia-tren-15000000";

            hplASC.NavigateUrl = "dtdd-sx-gia-asc";
            hplDESC.NavigateUrl = "dtdd-sx-gia-desc";

            string url = HttpContext.Current.Request.Url.PathAndQuery;
            if (url.Contains("-sx-gia-"))
            {
                string temp = "-sx-gia-" + Sort;

                hplLessThan3m.NavigateUrl += temp;
                hpl3mTo6m.NavigateUrl += temp;
                hpl6mTo10m.NavigateUrl += temp;
                hpl10mTo15m.NavigateUrl += temp;
                hplGreaterThan15m.NavigateUrl += temp;
            }
        }

        void LoadProduct(int pageSize)
        {
            double From = RouteData.Values["from"] != null ? Convert.ToDouble(RouteData.Values["from"]) : 0;
            double To = RouteData.Values["to"] != null ? Convert.ToDouble(RouteData.Values["to"]) : 0;
            string Sort = RouteData.Values["sort"] != null ? RouteData.Values["sort"].ToString() : "";

            LoadLinkFilter(From, To, Sort);

            string Action = String.Empty;

            if (From > 0) { Action = "LESSTHAN"; }
            if (To > 0) { Action = "GREATERTHAN"; }
            if (From > 0 & To > 0) { Action = "BETWEEN"; }

            dtProducts = ProductController.Instance.ProductGetDataByBrandName("", Action, From, To, Sort);

            rptProductBox.DataSource = dtProducts;
            rptProductBox.DataBind();
            lblTotalRecords.Text = dtProducts.Rows.Count.ToString() + " Điện thoại";


            //Create PagedDatasource
            PagedDataSource pageSource = new PagedDataSource();
            pageSource.DataSource = dtProducts.DefaultView;
            pageSource.AllowPaging = true;

            pageSource.PageSize = pageSize;
            pageSource.CurrentPageIndex = this.CurrentPage;
            if (pageSource.PageCount > 1)
            {
                rptPagination.Visible = true;
                ArrayList pages = new ArrayList();
                for (int i = 0; i <= pageSource.PageCount - 1; i++)
                {
                    pages.Add((i + 1).ToString());
                }
                rptPagination.DataSource = pages;
                rptPagination.DataBind();
            }
            else
            {
                rptPagination.Visible = false;
            }

            rptProductBox.DataSource = pageSource;
            rptProductBox.DataBind();
            lblTotalRecords.Text = dtProducts.Rows.Count.ToString() + " Điện thoại";
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            this.CurrentPage = Convert.ToInt32(e.CommandArgument) - 1;
            LoadProduct(15);
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