using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;

namespace PhoneManagement
{
    public partial class Products : System.Web.UI.Page
    {
        DataTable dtProduct = new DataTable();

        public string message { private set; get; }

        protected void Message(string message)
        {
            if (!String.IsNullOrEmpty(message))
            {
                this.message = message;
                plhMessage.Visible = true;
            }
        }

        public string SortType
        {
            get
            {
                if (ViewState["SortType"] == null)
                {
                    ViewState["SortType"] = "DESC";
                }
                return ViewState["SortType"].ToString();
            }
            set { ViewState["SortType"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtSearch.Text))
            {
                BindingGridView(txtSearch.Text);
            }

            if (!IsPostBack)
            {
                BindingGridView();
            }
        }

        public void BindingGridView(string key = "")
        {
            dtProduct = ProductController.Instance.ProductGetList(key);
            gvListProducts.DataSource = dtProduct;
            gvListProducts.DataBind();

            BindingDllBrand();
        }

        public void BindingDllBrand()
        {
            ddlBrand.DataSource = CommonController.Instance.GetDataByChoose("brand", "id, name");
            ddlBrand.DataTextField = "name";
            ddlBrand.DataValueField = "id";
            ddlBrand.DataBind();
        }

        protected void gvListProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvListProducts.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvListProducts_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindingGridView();

            if (this.SortType == "DESC")
                this.SortType = "ASC";
            else
                this.SortType = "DESC";

            DataView view = new DataView(dtProduct);
            view.Sort = e.SortExpression + " " + this.SortType;
            gvListProducts.DataSource = view;
            gvListProducts.DataBind();
        }

        protected void gvListProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string ID = ((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblID")).Text;
            string Name = ((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblName")).Text;

            string picture = ProductController.Instance.ProductGetPicture(ID);

            DataTable data = OrderItemController.Instance.GetOrderIDByProductID(Convert.ToInt32(ID));

            StringBuilder str = new StringBuilder();
            if (data.Rows.Count > 0)
            {
                foreach (DataRow row in data.Rows)
                {
                    str.Append((row["orderID"] + ",").Trim(','));
                }
                Message("Thông tin sản phẩm " + Name + " đang trong đơn hàng " + str.ToString() + " không thể xóa bỏ.");
                return;
            }

            if (ProductController.Instance.ProductDelete(Convert.ToInt32(ID)))
            {
                string filePath = Server.MapPath("~/public/upload/products/" + picture);

                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
                Message("Bạn đã xóa sản phẩm \"" + Name + "\" thành công.");
                BindingGridView();
                return;
            }
            Validation.Instance.Alert("Có lỗi xảy ra khi xóa sản phẩm! Vui lòng thử lại.");
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
            imgPicture.Visible = false;
            mulvProducts.ActiveViewIndex = 1;
        }

        protected void gvListProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            hdfID.Value = gvListProducts.DataKeys[e.RowIndex].Value.ToString();
            txtName.Text = ((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblName")).Text;
            ddlBrand.SelectedValue = ((HiddenField)gvListProducts.Rows[e.RowIndex].FindControl("hdfBrandID")).Value;
            double price = Convert.ToDouble(((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblPrice")).Text);
            txtPrice.Text = String.Format("{0:0.0}", price);
            txtDiscount.Text = ((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblDiscount")).Text;
            txtQuantity.Text = ((Label)gvListProducts.Rows[e.RowIndex].FindControl("lblQuantity")).Text;
            txtDescription.Text = ((HiddenField)gvListProducts.Rows[e.RowIndex].FindControl("hdfDescription")).Value;

            imgPicture.ImageUrl = ((Image)gvListProducts.Rows[e.RowIndex].FindControl("imgPicture")).ImageUrl;

            btnAdd.Visible = false;
            btnUpdate.Visible = imgPicture.Visible = true;
            rfValidPicture.Enabled = false;
            mulvProducts.ActiveViewIndex = 1;
        }


        #region Product From
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string Name = txtName.Text.Trim();
            int BrandID = Convert.ToInt32(ddlBrand.SelectedValue);
            double Price = float.Parse(txtPrice.Text);
            double Discount = Convert.ToDouble(txtDiscount.Text);
            int Quantity = Convert.ToInt32(txtQuantity.Text);
            string Description = txtDescription.Text;
            string Picture = fuPicture.FileName;

            if (ProductController.Instance.ProductCheckNameIsExists(Name))
            {
                Validation.Instance.Alert("Tên sản phẩm đã tồn tại! Vui lòng nhập tên khác");
                return;
            }
            if (fuPicture.HasFile && !Validation.Instance.CheckFileType(Picture))
            {
                Validation.Instance.Alert("Vui lòng chọn định dạng file ảnh hợp lệ!");
                return;
            }
            else
            {
                Picture = DateTime.Now.ToString("ddMMyyyyhhmmss") + Picture;
                fuPicture.SaveAs(Server.MapPath("~/public/upload/products/" + Picture));

                ProductInfo product = new ProductInfo(Name, Price, Discount, Quantity, Picture, Description, BrandID);
                if (ProductController.Instance.Products("Insert", product))
                {
                    Message("Bạn đã thêm mới thông tin sản phẩm \"" + Name + "\" thành công.");
                    Validation.Instance.ClearControls(viewProductForm);
                    mulvProducts.ActiveViewIndex = 0;
                    BindingGridView();
                }
                else
                    Validation.Instance.Alert("Có lỗi xảy ra khi thêm thông tin sản phẩm! Vui lòng thử lại.");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string Name = txtName.Text;
            int BrandID = Convert.ToInt32(ddlBrand.SelectedValue);
            double Price = Convert.ToDouble(txtPrice.Text);
            double Discount = Convert.ToDouble(txtDiscount.Text);
            int Quantity = Convert.ToInt32(txtQuantity.Text);
            string Description = txtDescription.Text;
            string Picture = fuPicture.FileName;

            DataRow rows = ProductController.Instance.ProductGetDetailByID(hdfID.Value).Rows[0];

            if (ProductController.Instance.ProductCheckNameIsExists(Name) && Name != rows["name"].ToString())
            {
                Validation.Instance.Alert("Tên sản phẩm đã tồn tại! Vui lòng nhập tên khác");
                return;
            }
            if (fuPicture.HasFile && !Validation.Instance.CheckFileType(Picture))
            {
                Validation.Instance.Alert("Vui lòng chọn định dạng file ảnh hợp lệ!");
                return;
            }
            else
            {
                if (fuPicture.HasFile)
                {
                    string filePath = Server.MapPath("~/public/upload/products/");

                    if (File.Exists(filePath + rows["picture"]))
                    {
                        File.Delete(filePath + rows["picture"]);
                    }
                    Picture = DateTime.Now.ToString("ddMMyyyyhhmmss") + Picture;
                    fuPicture.SaveAs(filePath + Picture);
                }
                else if (!fuPicture.HasFile)
                {
                    Picture = rows["picture"].ToString();
                }

                ProductInfo product = new ProductInfo(Name, Price, Discount, Quantity, Picture, Description, BrandID, Convert.ToInt32(hdfID.Value));
                if (ProductController.Instance.Products("Update", product))
                {
                    Message("Bạn đã cập nhật thông tin sản phẩm \"" + Name + "\" thành công.");
                    Validation.Instance.ClearControls(viewProductForm);
                    mulvProducts.ActiveViewIndex = 0;
                    BindingGridView();
                }
                else
                    Validation.Instance.Alert("Có lỗi xảy ra khi cập nhật thông tin sản phẩm <b>" + Name + "</b>! Vui lòng thử lại.");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Validation.Instance.ClearControls(viewProductForm);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Validation.Instance.ClearControls(viewProductForm);
            mulvProducts.ActiveViewIndex = 0;
        }
        #endregion



    }
}
