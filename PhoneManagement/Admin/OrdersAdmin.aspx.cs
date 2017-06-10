using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class OrdersAdmin : System.Web.UI.Page
    {
        DataTable dtOrderBrief;

        public string Message { private set; get; }

        string SortType
        {
            get
            {
                if (ViewState["SortType"] == null)
                    ViewState["SortType"] = "ASC";
                return ViewState["SortType"].ToString();
            }
            set { ViewState["SortType"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Validation.Instance.Session_Get("deleted") != null)
                {
                    lblDeletedNotify.Text = Session["deleted"].ToString();
                    plhMessage.Visible = true;
                    Session["deleted"] = null;
                }
                LoadOrdersBrief();
            }
            lblNotifyPay.Text = lblNotifyInfoProduct.Text = null;

        }

        private void BindingInfoProduct(string id)
        {
            LoadOrderDetailInfoProductByID(Convert.ToInt32(id));
            LoadOrderGetPayInfoByID(Convert.ToInt32(id));
            LoadOrdersBrief();
        }

        void LoadOrdersBrief()
        {
            dtOrderBrief = OrderController.Instance.OrderBrief();
            gvOrdersBrief.DataSource = dtOrderBrief;
            gvOrdersBrief.DataBind();
        }

        void LoadCustomerByOrderID(int id)
        {
            dlCustomerInfo.DataSource = CustomerController.Instance.GetCustomerByOrderID(id);
            dlCustomerInfo.DataBind();
        }

        void LoadOrderGetPayInfoByID(int id)
        {
            dlPayInfo.DataSource = OrderController.Instance.GetInfoByID("GetPayInfoByID", id);
            dlPayInfo.DataBind();
        }

        void LoadOrderDetailInfoProductByID(int id)
        {
            gvOrderInfoProduct.DataSource = OrderController.Instance.GetInfoByID("DetailInfoProductByID", id);
            gvOrderInfoProduct.DataBind();
        }

        protected void gvOrdersBrief_Sorting(object sender, GridViewSortEventArgs e)
        {
            LoadOrdersBrief();

            if (this.SortType == "ASC")
                this.SortType = "DESC";
            else
                this.SortType = "ASC";

            DataView view = new DataView(dtOrderBrief);
            view.Sort = e.SortExpression + " " + this.SortType;
            gvOrdersBrief.DataSource = view;
            gvOrdersBrief.DataBind();
        }

        protected void gvOrdersBrief_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            int id = Convert.ToInt32(gvOrdersBrief.DataKeys[e.NewSelectedIndex].Value.ToString());

            LoadCustomerByOrderID(id);

            LoadOrderGetPayInfoByID(id);

            LoadOrderDetailInfoProductByID(id);

            mulViewOrders.ActiveViewIndex = 1;
        }

        protected void lbtnBack_Click(object sender, EventArgs e)
        {
            mulViewOrders.ActiveViewIndex = 0;
        }

        protected void gvOrdersBrief_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvOrdersBrief.DataKeys[e.RowIndex].Value);

            if (OrderController.Instance.OrderByID("Delete", id))
            {
                Message = "Xóa đơn hàng \"" + id + "\" thành công.";
                plhMessage.Visible = true;
                LoadOrdersBrief();
                return;
            }
            Validation.Instance.Alert("Có lỗi xảy ra khi xóa đơn hàng! Vui lòng thử lại.");
        }

        protected void dlPayInfo_EditCommand(object source, DataListCommandEventArgs e)
        {
            dlPayInfo.EditItemIndex = e.Item.ItemIndex;
            string id = dlPayInfo.DataKeys[e.Item.ItemIndex].ToString();
            BindingInfoProduct(id);
        }

        protected void dlPayInfo_CancelCommand(object source, DataListCommandEventArgs e)
        {
            dlPayInfo.EditItemIndex = -1;
            string id = dlPayInfo.DataKeys[e.Item.ItemIndex].ToString();
            BindingInfoProduct(id);
        }

        protected void dlPayInfo_UpdateCommand(object source, DataListCommandEventArgs e)
        {
            int ID = Convert.ToInt32(dlPayInfo.DataKeys[e.Item.ItemIndex]);
            string ShipAddress = ((TextBox)dlPayInfo.Items[e.Item.ItemIndex].FindControl("txtEditShipAddress")).Text;
            string Note = ((TextBox)dlPayInfo.Items[e.Item.ItemIndex].FindControl("txtEditNote")).Text;
            byte Status = Convert.ToByte(((DropDownList)dlPayInfo.Items[e.Item.ItemIndex].FindControl("ddlEditStatus")).SelectedValue);

            if (Status == 1)
            {
                DataTable data = OrderController.Instance.CheckQuantityByOrderID(ID);

                StringBuilder str = new StringBuilder();
                if (data.Rows.Count > 0)
                {
                    foreach (DataRow row in data.Rows)
                    {
                        str.Append((row["ProductName"] + "<br />"));
                    }
                    lblNotifyPay.Text = "Sản phẩm <br />" + str.ToString() + " trong kho không đủ số lượng để thanh toán đơn hàng " + ID + " ! Vui lòng kiểm trả lại số lượng sản phẩm.";
                    return;
                }
            }

            if (OrderController.Instance.Orders("Update", new OrderInfo(0, ShipAddress, Note, Status, ID)))
            {
                dlPayInfo.EditItemIndex = -1;
                BindingInfoProduct(ID.ToString());
                lblNotifyPay.Text = "Cập nhật thông tin thanh toán đơn hàng " + ID + " thành công.";
                return;
            }
            lblNotifyPay.Text = "Có lỗi khi cập nhật thông tin thanh toán đơn hàng " + ID + "! Vui lòng thử lại.";
        }

        protected void dlPayInfo_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                string status = ((HiddenField)e.Item.FindControl("hdfStatus")).Value.ToString();
                DropDownList ddl = e.Item.FindControl("ddlEditStatus") as DropDownList;

                ddl.SelectedValue = status == "True" ? "1" : "0";
            }
        }


        protected void gvOrderInfoProduct_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOrderInfoProduct.EditIndex = e.NewEditIndex;
            string OrderID = ((HiddenField)gvOrderInfoProduct.Rows[e.NewEditIndex].FindControl("hdfOrderID")).Value;
            BindingInfoProduct(OrderID);
        }

        protected void gvOrderInfoProduct_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrderInfoProduct.EditIndex = -1;
            string OrderID = ((HiddenField)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("hdfOrderID")).Value;
            BindingInfoProduct(OrderID);
        }

        protected void gvOrderInfoProduct_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(gvOrderInfoProduct.DataKeys[e.RowIndex].Value);
            string OrderID = ((HiddenField)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("hdfOrderID")).Value;
            string Name = ((Label)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("lblProductName")).Text;

            if (OrderItemController.Instance.OrderItemDelete(ID))
            {
                if (!OrderItemController.Instance.OrderItemsCheckOrderIdIsExists(Convert.ToInt32(OrderID)))
                {
                    Session["deleted"] = "Xóa sản phẩm \"" + Name + "\" trong đơn hàng \"" + OrderID + "\" thành công.";
                    Response.Redirect("~/Admin/OrdersAdmin.aspx");
                }
                BindingInfoProduct(OrderID);
                lblNotifyInfoProduct.Text = "Xóa sản phẩm " + Name + " trong đơn hàng thành công.";
                return;
            }
            lblNotifyInfoProduct.Text = "Có lỗi xảy ra khi xóa sản phẩm trong đơn hàng! Vui lòng thử lại.";
        }

        protected void gvOrderInfoProduct_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ID = Convert.ToInt32(gvOrderInfoProduct.DataKeys[e.RowIndex].Value);
            string OrderID = ((HiddenField)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("hdfOrderID")).Value.ToString();
            string Name = ((Label)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("lblProductName")).Text;
            string Amount = ((TextBox)gvOrderInfoProduct.Rows[e.RowIndex].FindControl("txtEditAmount")).Text;

            if (OrderItemController.Instance.OrderItems("Update", new OrderItemInfo(ID, Convert.ToInt32(Amount))))
            {

                gvOrderInfoProduct.EditIndex = -1;
                BindingInfoProduct(OrderID);
                lblNotifyInfoProduct.Text = "Cập nhật sản phẩm " + Name + " trong đơn hàng thành công.";
                return;
            }
            lblNotifyInfoProduct.Text = "Có lỗi xảy ra khi cập nhật sản phẩm trong đơn hàng! Vui lòng thử lại.";
        }

        protected void gvOrdersBrief_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvOrdersBrief.PageIndex = e.NewPageIndex;
            LoadOrdersBrief();
        }

        protected void gvOrderInfoProduct_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            gvOrderInfoProduct.PageIndex = e.NewPageIndex;

            string OrderID = String.Empty;
            foreach (GridViewRow row in gvOrderInfoProduct.Rows)
            {
                OrderID = ((HiddenField)gvOrderInfoProduct.Rows[row.RowIndex].FindControl("hdfOrderID")).Value.ToString();
            }

            BindingInfoProduct(OrderID);
        }

    }
}