using Controllers;
using System;
using System.Data;
using System.Web.UI;

namespace PhoneManagement
{
    public partial class Details : System.Web.UI.Page
    {
        DataTable dtDetails;

        public int brandID { private set; get; }

        public string brandName { private set; get; }

        public string brandNameUrl { private set; get; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductDetails();

                LoadProductSuggestion();
            }
        }

        public bool CheckQuantity()
        {
            return Convert.ToInt32(dtDetails.Rows[0]["quantity"]) == 0 ? false : true;
        }

        void LoadProductDetails()
        {
            string name_url = RouteData.Values["id"] != null ? RouteData.Values["id"] as string : "apple-iphone-7plus-256gb";

            dtDetails = ProductController.Instance.ProductGetDetailByID_Main(name_url);
            lvProductDetails.DataSource = dtDetails;
            lvProductDetails.DataBind();

            Page.Title =  dtDetails.Rows[0]["name"] as string + " | AnhDoMobile";
            brandID = Convert.ToInt32(dtDetails.Rows[0]["brandID"]);
            brandName = dtDetails.Rows[0]["brandName"].ToString();
            brandNameUrl = dtDetails.Rows[0]["brandNameUrl"].ToString();

            ProductController.Instance.ProductUpdateView(Convert.ToInt32(dtDetails.Rows[0]["id"]));
        }

        public string CalculationPrice()
        {
            return ProductController.Instance.CalculationProductPrice(Convert.ToInt32(dtDetails.Rows[0]["price"]), Convert.ToInt32(dtDetails.Rows[0]["discount"]));   
        }

        void LoadProductSuggestion()
        { 
            var rows = dtDetails.Rows[0];
            rptProductSuggestion.DataSource = ProductController.Instance.ProductGetSuggestion(rows["id"].ToString(), rows["brandID"].ToString());
            rptProductSuggestion.DataBind();
        }
    }
}