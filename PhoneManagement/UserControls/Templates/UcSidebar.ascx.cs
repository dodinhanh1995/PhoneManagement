using System;

namespace PhoneManagement.UserControls.Templates
{
    public partial class UcSidebar : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["cart"] != null)
                {
                    hplShoppingCart.Visible = true;
                }
            }
        }

        protected void lbtnSearch_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtKey.Text))
            {
                Response.Redirect("tim-kiem-tu-khoa-" + txtKey.Text);
            }
            Response.Redirect("~/");
            
        }
    }
}