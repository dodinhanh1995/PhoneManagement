using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class AdvertisementsAdmin : System.Web.UI.Page
    {
        DataTable dtAdvertise = new DataTable();

        public string SortType
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
                BindingGridView();
            }
        }

        private void BindingGridView()
        {
            dtAdvertise = CommonController.Instance.GetDataByChoose("advertisements");
            gvAdvertise.DataSource = dtAdvertise;
            gvAdvertise.DataBind();
        }

        protected void gvAdvertise_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindingGridView();

            if (this.SortType == "ASC")
                this.SortType = "DESC";
            else
                this.SortType = "ASC";

            DataView view = new DataView(dtAdvertise);
            view.Sort = e.SortExpression + " " + this.SortType;
            gvAdvertise.DataSource = view;
            gvAdvertise.DataBind();
        }

        protected void gvAdvertise_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAdvertise.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvAdvertise_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(gvAdvertise.DataKeys[e.RowIndex].Value.ToString());
            string Name = ((Label)gvAdvertise.Rows[e.RowIndex].FindControl("lblName")).Text;

            string Picture = AdvertisementController.Instance.GetPictureByID(ID);
            string fileName = Server.MapPath("~/public/upload/advertisements/" + Picture);

            if (AdvertisementController.Instance.AdvertisementDelete(ID))
            {
                if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }
                lblNotify.Text = "Xóa thông tin Quảng cáo <b>" + Name + "</b> thành công.";
                BindingGridView();
                return;
            }
            lblNotify.Text = "Có lỗi khi xóa thông tin Quảng cáo! Vui lòng thử lại.";
        }

        protected void gvAdvertise_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAdvertise.EditIndex = -1;
            BindingGridView();
        }

        protected void gvAdvertise_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAdvertise.EditIndex = e.NewEditIndex;
            BindingGridView();
        }

        protected void gvAdvertise_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string ID = gvAdvertise.DataKeys[e.RowIndex].Value.ToString();
            string OldName = ((HiddenField)gvAdvertise.Rows[e.RowIndex].FindControl("hdfEditName")).Value;

            string Name = ((TextBox)gvAdvertise.Rows[e.RowIndex].FindControl("txtEditName")).Text.Trim();
            string Position = ((TextBox)gvAdvertise.Rows[e.RowIndex].FindControl("txtEditPosition")).Text.Trim();

            FileUpload Picture = ((FileUpload)gvAdvertise.Rows[e.RowIndex].FindControl("fuEditPicture"));
            string OldPicture = AdvertisementController.Instance.GetPictureByID(Convert.ToInt32(ID));
            string filePath = Server.MapPath("~/public/upload/advertisements/");
            string fileName = Picture.HasFile ? DateTime.Now.ToString("ddMMyyyyhhmmss") + Picture.FileName : OldPicture;

            if (AdvertisementController.Instance.CheckByNameIsExists(Name) && !Name.Equals(OldName))
            {
                lblNotify.Text = "Tên thương hiệu \"" + Name + "\" đã tồn tại! Vui lòng nhập tên khác";
                return;
            }
            if (!Validation.Instance.CheckFileType(fileName))
            {
                lblNotify.Text = "Định dạng hình ảnh Quảng cáo không hợp lệ!";
                return;
            }
            if (File.Exists(filePath + fileName) && fileName != OldPicture)
            {
                lblNotify.Text = "Tên hình ảnh quảng cáo đã tồn tại! Vui lòng chọn hình ảnh khác.";
                return;
            }
            if (AdvertisementController.Instance.Advertisements("Update", new AdvertisementInfo(Name, fileName, Position, Convert.ToInt32(ID))))
            {
                if (!File.Exists(filePath + fileName))
                {
                    if (File.Exists(filePath + OldPicture))
                    {
                        File.Delete(filePath + OldPicture);
                    }
                    Picture.SaveAs(filePath + fileName);
                }
                lblNotify.Text = "Cập nhật thông tin Quảng cáo \"" + Name + "\" thành công.";
                gvAdvertise.EditIndex = -1;
                BindingGridView();
                return;
            }
            lblNotify.Text = "Có lỗi khi cập nhật thông tin quảng cáo! Vui lòng thử lại.";
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            string Name = ((TextBox)gvAdvertise.FooterRow.FindControl("txtAddName")).Text.Trim();
            FileUpload Picture = (FileUpload)gvAdvertise.FooterRow.FindControl("fuAddPicture");
            string Position = ((TextBox)gvAdvertise.FooterRow.FindControl("txtAddPosition")).Text.Trim();

            string fileName = DateTime.Now.ToString("ddMMyyyyhhmmss") + Picture.FileName;
            string filePath = Server.MapPath("~/public/upload/advertisements/" + fileName);

            if (AdvertisementController.Instance.CheckByNameIsExists(Name))
            {
                lblNotify.Text = "Tên thương hiệu \"" + Name + "\" đã tồn tại! Vui lòng nhập tên khác.";
                return;
            }
            if (!Validation.Instance.CheckFileType(fileName))
            {
                lblNotify.Text = "Định dạng Hình ảnh quảng cáo không hợp lệ!";
                return;
            }
            AdvertisementInfo advertise = new AdvertisementInfo(Name, fileName, Position);

            if (AdvertisementController.Instance.Advertisements("Insert", advertise))
            {
                if (!File.Exists(filePath))
                {
                    Picture.SaveAs(filePath);
                    lblNotify.Text = "Thêm mới thương hiệu \"" + Name + "\" thành công.";
                    BindingGridView();
                    return;
                }
                lblNotify.Text = "Tên hình ảnh Quảng cáo đã tồn tại! Vui lòng chọn hình ảnh khác";
            }
            lblNotify.Text = "Có lỗi khi thêm mới thông tin Quảng cáo! Vui lòng thử lại.";
        }
    }
}