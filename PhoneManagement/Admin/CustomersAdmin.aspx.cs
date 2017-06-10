using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class CustomersAdmin : System.Web.UI.Page
    {
        DataTable dtCustomer = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindingGridView();
            }
        }

        private void BindingGridView()
        {
            dtCustomer = CommonController.Instance.GetDataByChoose("customers");
            gvCustomersList.DataSource = dtCustomer;
            gvCustomersList.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            string Name = ((TextBox)gvCustomersList.FooterRow.FindControl("txtAddName")).Text;
            string Gender = ((DropDownList)gvCustomersList.FooterRow.FindControl("ddlAddGender")).SelectedValue;
            string Email = ((TextBox)gvCustomersList.FooterRow.FindControl("txtAddEmail")).Text;
            string Telephone = ((TextBox)gvCustomersList.FooterRow.FindControl("txtAddTelephone")).Text;


            if (CustomerController.Instance.Customers("Insert", new CustomerInfo(Name, Convert.ToByte(Gender), Email, Telephone)))
            {
                Validation.Instance.Alert("Thêm khách hàng thành công.");
                BindingGridView();
                return;
            }
            Validation.Instance.Alert("Có lỗi khi thêm khách hàng! Vui lòng thử lại.");
        }

        protected void gvCustomersList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCustomersList.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvCustomersList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string ID = ((Label)gvCustomersList.Rows[e.RowIndex].FindControl("lblID")).Text;

            if (CustomerController.Instance.Customers(Convert.ToInt32(ID)))
            {
                Validation.Instance.Alert("Xóa khách hàng thành công.");
                BindingGridView();
            }
            else
                Validation.Instance.Alert("Có lỗi xảy ra khi xóa khách hàng! Vui lòng thử lại.");
        }

        protected void gvCustomersList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCustomersList.EditIndex = -1;
            BindingGridView();
        }

        protected void gvCustomersList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCustomersList.EditIndex = e.NewEditIndex;
            BindingGridView();
        }

        protected void gvCustomersList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ID = int.Parse(((Label)gvCustomersList.Rows[e.RowIndex].FindControl("lblID")).Text);
            string Name = ((TextBox)gvCustomersList.Rows[e.RowIndex].FindControl("txtEditName")).Text;
            string Gender = ((DropDownList)gvCustomersList.Rows[e.RowIndex].FindControl("ddlEditGender")).SelectedValue;
            string Email = ((TextBox)gvCustomersList.Rows[e.RowIndex].FindControl("txtEditEmail")).Text;
            string Telephone = ((TextBox)gvCustomersList.Rows[e.RowIndex].FindControl("txtEditTelephone")).Text;

            if (CustomerController.Instance.Customers("Update", new CustomerInfo(Name, Convert.ToByte(Gender), Email, Telephone, ID)))
            {
                gvCustomersList.EditIndex = -1;
                Validation.Instance.Alert("Cập nhật thông tin khách hàng thành công.");
                BindingGridView();
                return;
            }
            Validation.Instance.Alert("Có lỗi khi cập nhật thông tin khách hàng! Vui lòng thử lại.");
        }

        protected void gvCustomersList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit || e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate))
            {
                DropDownList ddlGender = (DropDownList)e.Row.FindControl("ddlEditGender");

                ddlGender.SelectedValue = ((HiddenField)e.Row.FindControl("hdfEditGender")).Value == "True" ? "1" : "0";

            }
        }
    }
}
