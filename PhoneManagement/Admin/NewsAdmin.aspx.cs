using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class NewsAdmin : System.Web.UI.Page
    {
        DataTable dtNews = new DataTable();

        public string NotifyMessage { get; set; }

        public void Message(string message)
        {
            if (!String.IsNullOrEmpty(message))
            {
                NotifyMessage = message;
                notifyMessage.Visible = true;
            }
        }

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
            dtNews = NewsController.Instance.NewsGetList();
            gvNewsList.DataSource = dtNews;
            gvNewsList.DataBind();
        }

        protected void gvNewsList_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindingGridView();

            if (this.SortType == "ASC")
                this.SortType = "DESC";
            else
                this.SortType = "ASC";

            DataView view = new DataView(dtNews);
            view.Sort = e.SortExpression + " " + this.SortType;
            gvNewsList.DataSource = view;
            gvNewsList.DataBind();

        }

        protected void gvNewsList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNewsList.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvNewsList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string ID = ((Label)gvNewsList.Rows[e.RowIndex].FindControl("lblID")).Text;
            string Title = ((Label)gvNewsList.Rows[e.RowIndex].FindControl("lblTitle")).Text;
            string Picture = ((Image)gvNewsList.Rows[e.RowIndex].FindControl("imgPicture")).ImageUrl;

            if (NewsController.Instance.NewsDelete(Convert.ToInt32(ID)))
            {
                if (File.Exists(Server.MapPath(Picture)))
                {
                    File.Delete(Server.MapPath(Picture));
                }
                Message("Xóa thông tin tin tức \"" + Title + "\" thành công.");
                BindingGridView();
            }
            else
                Validation.Instance.Alert("Có lỗi xảy ra khi xóa thông tin tin tức! Vui lòng thử lại.");
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            btnUpdate.Visible = false;
            mulvNews.ActiveViewIndex = 1;
        }

        #region News Form
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Validation.Instance.ClearControls(viewNewsForm);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnUpdate.Visible = false;
            string Title = txtTitle.Text.Trim();
            string Content = txtContent.Text;
            string Picture = fuPicture.FileName;

            if (String.IsNullOrEmpty(Content))
            {
                rfValidContent.Enabled = true;
                return;
            }

            if (NewsController.Instance.CheckTitleIsExists(Title))
            {
                Validation.Instance.Alert("Tên tiêu đề đã tồn tại! Vui lòng chọn tên khác");
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
                fuPicture.SaveAs(Server.MapPath("~/public/upload/news/" + Picture));

                NewsInfo news = new NewsInfo(Title, Content, Picture);
                if (NewsController.Instance.News("Insert", news))
                {
                    Validation.Instance.ClearControls(viewNewsForm);
                    Message("Bạn đã thêm mới thông tin tin tức \"" + Title + "\" thành công.");
                    BindingGridView();
                    mulvNews.ActiveViewIndex = 0;
                    return;
                }
                Validation.Instance.Alert("Có lỗi xảy ra khi thêm thông tin tin tức! Vui lòng thử lại.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/NewsAdmin.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            btnAdd.Visible = false;
            int ID = Convert.ToInt32(hdfID.Value);
            string Title = txtTitle.Text.Trim();
            string Content = txtContent.Text;
            string Picture = fuPicture.FileName;

            DataRow rows = NewsController.Instance.NewsGetListByID(ID).Rows[0];

            if (String.IsNullOrEmpty(Content))
            {
                rfValidContent.Enabled = true;
                return;
            }
            if (NewsController.Instance.CheckTitleIsExists(Title) && Title != rows["title"].ToString())
            {
                Validation.Instance.Alert("Tên tiêu đề đã tồn tại! Vui lòng chọn tên khác");
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
                    string filePath = Server.MapPath("~/public/upload/news/");
                    Picture = DateTime.Now.ToString("ddMMyyyyhhmmss") + Picture;
                    fuPicture.SaveAs(filePath + Picture);

                    if (File.Exists(filePath + rows["picture"]))
                    {
                        File.Delete(filePath + rows["picture"]);
                    }
                }
                else if (!fuPicture.HasFile)
                {
                    Picture = rows["picture"].ToString();
                }

                NewsInfo news = new NewsInfo(Title, Content, Picture, ID);
                if (NewsController.Instance.News("Update", news))
                {
                    Validation.Instance.ClearControls(viewNewsForm);
                    Message("Bạn đã cập nhật thông tin tin tức \"" + Title + "\" thành công.");
                    BindingGridView();
                    mulvNews.ActiveViewIndex = 0;
                    return;
                }
                Validation.Instance.Alert("Có lỗi xảy ra khi cập nhật thông tin tin tức! Vui lòng thử lại.");
            }
        }
        #endregion

        protected void gvNewsList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            hdfID.Value = ((Label)gvNewsList.Rows[e.RowIndex].FindControl("lblID")).Text;
            txtTitle.Text = ((Label)gvNewsList.Rows[e.RowIndex].FindControl("lblTitle")).Text;
            txtContent.Text = ((HiddenField)gvNewsList.Rows[e.RowIndex].FindControl("hdfContent")).Value;
            imgPicture.ImageUrl = ((Image)gvNewsList.Rows[e.RowIndex].FindControl("imgPicture")).ImageUrl;

            rfValidPicture.Enabled = btnAdd.Visible = false;
            imgPicture.Visible = true;
            mulvNews.ActiveViewIndex = 1;
        }

    }
}