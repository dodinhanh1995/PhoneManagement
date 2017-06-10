using Controllers;
using System;
using System.Data;
using System.Globalization;
using System.Text;
using System.Threading;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CultureInfo culture = new CultureInfo("vi-VN");

            Thread.CurrentThread.CurrentCulture = culture;

            if (!IsPostBack)
            {
                if (Session["UpdatedProfile"] != null)
                {
                    pnlUpdatedProfile.Visible = true;
                    lblUpdateProfile.Text = Session["UpdatedProfile"].ToString();
                    Session["UpdatedProfile"] = null;
                }
                LoadDefaultDateTime();

                LoadDashBoard();
            }
        }

        void LoadDefaultDateTime()
        {
            DateTime now = Convert.ToDateTime(DateTime.Now.ToShortDateString());

            DateTime fromDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = fromDate.ToShortDateString();

            txtToDate.Text = fromDate.AddMonths(1).AddDays(-1).ToShortDateString();
        }

        void LoadDashBoard()
        {
            string fromDate = "";
            string toDate = "";
            try
            {
                fromDate = Convert.ToDateTime(txtFromDate.Text).ToString("yyyy/MM/dd");
                toDate = Convert.ToDateTime(txtToDate.Text).ToString("yyyy/MM/dd");
            }
            catch { Response.Write("Errors Date"); }

            LoadOrderStatistics(fromDate, toDate);

            LoadTopOrder(fromDate, toDate);
        }

        void LoadOrderStatistics(string from, string to)
        {
            lblOrderToDay.Text = OrderController.Instance.OrderGetStatistics("OrderNumber", from, to).ToString();
            lblServedCustomer.Text = OrderController.Instance.OrderGetStatistics("ServedCustomer", from, to).ToString();
            lblOrderTotalSales.Text = OrderController.Instance.OrderGetStatistics("OrderTotalSales", from, to).ToString("0,0<sup>đ</sup>");
            lblOrderTotalProduct.Text = OrderController.Instance.OrderGetStatistics("OrderTotalProduct", from, to).ToString();
        }

        void LoadTopOrder(string from, string to)
        {
            gvTopOrderValued.DataSource = OrderController.Instance.TopOrderStatistics("TopOrderValued", from, to);
            gvTopOrderValued.DataBind();

            gvTopCustomerOutstanding.DataSource = OrderController.Instance.TopOrderStatistics("TopCustomerOutstanding", from, to);
            gvTopCustomerOutstanding.DataBind();

            gvTopProductBestSelling.DataSource = OrderController.Instance.TopOrderStatistics("TopProductBestSelling", from, to);
            gvTopProductBestSelling.DataBind();

            gvOrderPending.DataSource = OrderController.Instance.TopOrderStatistics("OrderPending", from, to);
            gvOrderPending.DataBind();
        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {
            LoadDashBoard();
        }

        protected void txtToDate_TextChanged(object sender, EventArgs e)
        {
            LoadDashBoard();
        }     

        protected void gvOrderPending_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvOrderPending.PageIndex = e.NewPageIndex;
            LoadDashBoard();
        }
    }
}