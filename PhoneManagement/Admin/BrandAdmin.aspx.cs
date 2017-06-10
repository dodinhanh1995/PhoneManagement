using Controllers;
using Models;
using Common;
using System;
using System.IO;
using System.Web.UI.WebControls;

namespace PhoneManagement
{
    public partial class BrandAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindingGridView();
            }
        }

        private void BindingGridView()
        {
            gvBrandList.DataSource = CommonController.Instance.GetDataByChoose("brand");
            gvBrandList.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            string Name = ((TextBox)gvBrandList.FooterRow.FindControl("txtAddName")).Text.Trim();

            FileUpload Logo = (FileUpload)gvBrandList.FooterRow.FindControl("fuAddLogo");
            string fileName = DateTime.Now.ToString("ddMMyyyyhhmmss") + Logo.FileName;
            string filePath = Server.MapPath("~/public/upload/logo/" + fileName);

            if (BrandController.Instance.CheckByNameIsExists(Name))
            {
                lblNotify.Text = "Tên thương hiệu đã tồn tại! Vui lòng nhập tên khác.";
                return;
            }
            if (!Validation.Instance.CheckFileType(fileName))
            {
                lblNotify.Text = "Định dạng ảnh Logo không hợp lệ!";
                return;
            }
            if (File.Exists(filePath + fileName))
            {
                lblNotify.Text = "Tên hình ảnh Logo đã tồn tại! Vui lòng chọn hình ảnh khác.";
                return;
            }

            BrandInfo bi = new BrandInfo(Name, fileName);
            if (BrandController.Instance.Brand("Insert", bi))
            {
                Logo.SaveAs(filePath);
                lblNotify.Text = "Thêm thương hiệu \"" + Name + "\" thành công.";
                BindingGridView();
                return;
            }
            lblNotify.Text = "Có lỗi khi thêm thương hiệu! Vui lòng thử lại.";
        }

        protected void gvBrandList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBrandList.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvBrandList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(gvBrandList.DataKeys[e.RowIndex].Value);

            string OldLogo = BrandController.Instance.BrandGetLogo(ID);
            string fileName = Server.MapPath("~/public/upload/logo/" + OldLogo);


            if (BrandController.Instance.BrandDelete(ID))
            {
                if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }
                lblNotify.Text = "Xóa thương hiệu thành công.";
                BindingGridView();
                return;
            }
            lblNotify.Text = "Có lỗi khi xóa thương hiệu! Vui lòng thử lại.";
        }

        protected void gvBrandList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBrandList.EditIndex = -1;
            BindingGridView();
        }

        protected void gvBrandList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBrandList.EditIndex = e.NewEditIndex;
            BindingGridView();
        }

        protected void gvBrandList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ID = Convert.ToInt32(gvBrandList.DataKeys[e.RowIndex].Value);
            string OldName = ((HiddenField)gvBrandList.Rows[e.RowIndex].FindControl("hdfEditName")).Value;

            string Name = ((TextBox)gvBrandList.Rows[e.RowIndex].FindControl("txtEditName")).Text.Trim();
            FileUpload Logo = ((FileUpload)gvBrandList.Rows[e.RowIndex].FindControl("fuEditLogo"));
            string fileName = string.Empty;


            if (BrandController.Instance.CheckByNameIsExists(Name) && !Name.Equals(OldName))
            {
                lblNotify.Text = "Tên thương hiệu đã tồn tại! Vui lòng nhập tên khác.";
                return;
            }

            string OldLogo = BrandController.Instance.BrandGetLogo(ID);
            if (Logo.HasFile)
            {
                string filePath = Server.MapPath("~/public/upload/logo/");
                fileName = DateTime.Now.ToString("ddMMyyyyhhmmss") + Logo.FileName;

                if (!Validation.Instance.CheckFileType(fileName))
                {
                    lblNotify.Text = "Định dạng ảnh Logo không hợp lệ!";
                    return;
                }
                if (!File.Exists(filePath + fileName))
                {
                    if (File.Exists(filePath + OldLogo))
                    {
                        File.Delete(filePath + OldLogo);
                    }
                    Logo.SaveAs(filePath + fileName);
                    goto bi;
                }
                else
                {
                    lblNotify.Text = "Tên hình ảnh logo đã tồn tại! Vui lòng chọn hình ảnh khác.";
                    return;
                }
            }
            fileName = OldLogo;

        bi: BrandInfo bi = new BrandInfo(Name, fileName, ID);
            if (BrandController.Instance.Brand("Update", bi))
            {
                lblNotify.Text = "Cập nhật thương hiệu \"" + OldName + "\" thành công.";
                gvBrandList.EditIndex = -1;
                BindingGridView();
                return;
            }
            lblNotify.Text = "Có lỗi khi cập nhật thương hiệu! Vui lòng thử lại.";
        }
    }
}