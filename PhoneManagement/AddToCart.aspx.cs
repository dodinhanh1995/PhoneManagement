using Common;
using Controllers;
using Models;
using System;

namespace PhoneManagement
{
    public partial class AddToCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CartController cart = new CartController();
                if (Session["cart"] != null)
                {
                    cart = Session["cart"] as CartController;
                }
                cart.AddToCart(new CartInfo(Validation.Instance.Input_Get("id"), 1));

                Session["cart"] = cart;

                Response.Redirect("gio-hang");
            }
        }
    }
}