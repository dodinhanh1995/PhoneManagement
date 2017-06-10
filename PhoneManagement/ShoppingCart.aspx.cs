using Controllers;
using Models;
using System;
using System.Web.UI.WebControls;

namespace PhoneManagement
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        public string CustomerName { private set; get; }
        public string Gender { private set; get; }

        CartController cart;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["cart"] == null)
                {
                    Session.Clear();
                    pnlTitle.Visible = false;
                    return;
                }
                LoadShoppingCart();
                mulViewShoppingCart.ActiveViewIndex = 1;
            }
        }

        void LoadShoppingCart()
        {
            cart = new CartController();
            cart = Session["cart"] as CartController;

            gvCart.DataSource = cart.ShowCart();
            gvCart.DataBind();
        }

        public string TotalCart()
        {
            return cart.TotalCart.ToString("0,0");
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!String.IsNullOrEmpty(e.CommandName))
            {
                LinkButton lb = (LinkButton)e.CommandSource;
                GridViewRow gvr = lb.NamingContainer as GridViewRow;

                string index = gvCart.DataKeys[gvr.RowIndex].Value.ToString();

                cart = Session["cart"] as CartController;

                if (e.CommandName.Equals("Plus"))
                {
                    cart.UpdateCart(new CartInfo(index, Convert.ToInt32(e.CommandArgument) + 1));
                    LoadShoppingCart();
                }

                if (e.CommandName.Equals("Minus"))
                {
                    if (Convert.ToInt32(e.CommandArgument) <= 1)
                    {
                        LinkButton Minus = gvr.FindControl("lbtnMinus") as LinkButton;
                        Minus.Enabled = false;
                        Minus.CssClass = "disabled list-group-item";
                        return;
                    }

                    cart.UpdateCart(new CartInfo(index, Convert.ToInt32(e.CommandArgument) - 1));
                    LoadShoppingCart();
                }

                if (e.CommandName.Equals("Remove"))
                {
                    cart.DeleteItem(index);
                    if (cart.CartList.Count <= 0)
                    {
                        Session["cart"] = null;
                        Response.Redirect("~/");
                    }
                    LoadShoppingCart();
                }
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            mulViewShoppingCart.ActiveViewIndex = 2;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mulViewShoppingCart.ActiveViewIndex = 1;
        }

        protected void lbtnPayWhenReceived_Click(object sender, EventArgs e)
        {
            CustomerInfo custInfo = new CustomerInfo();
            custInfo.Name = txtFullName.Text;
            custInfo.Gender = Convert.ToByte(radGender.SelectedValue);
            custInfo.Telephone = txtTelephone.Text;
            custInfo.Email = txtEmail.Text;

            int CustomerID = CustomerController.Instance.CustomerInsertAndGetLastID(custInfo);

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.CustomerID = CustomerID;
            orderInfo.ShipAddress = txtShipAddress.Text.Trim();
            orderInfo.Note = txtNote.Text;

            int OrderID = OrderController.Instance.OrderInsertAndGetLastID(orderInfo);
            
            foreach (GridViewRow row in gvCart.Rows)
            {
                OrderItemInfo orderItem = new OrderItemInfo();
                orderItem.ProductID = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value.ToString());
                orderItem.OrderID = OrderID;
                orderItem.Amount = Convert.ToInt32(((TextBox)gvCart.Rows[row.RowIndex].FindControl("txtQuantity")).Text);
                OrderItemController.Instance.OrderItems("Insert", orderItem);
            }
            pnlTitle.Visible = false;

            cart = Session["cart"] as CartController;

            if (cart == null)
            {
                Response.Redirect("~/");
            }

            gvCartFinish.DataSource = cart.ShowCart();
            gvCartFinish.DataBind();

            lblTotalCartFinish.Text = cart.TotalCart.ToString("0,0");
            CustomerName = txtFullName.Text;
            Gender = radGender.SelectedItem.Text.ToLower();

            Session["cart"] = null;

            mulViewShoppingCart.ActiveViewIndex = 3;
        }

    }
}