using Common;
using Controllers;
using Models;
using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace PhoneManagement.Admin
{
    public partial class MembersAdmin : System.Web.UI.Page
    {
        DataTable dtMember = new DataTable();

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
                if (Session["Success"] != null)
                {
                    lblNotifyAction.Text = Session["Success"].ToString();
                    lblNotifyAction.Visible = true;
                    Session["Success"] = null;
                }
                BindingGridView();
            }
        }

        private void BindingGridView()
        {
            dtMember = MemberController.Instance.MemberGetByInfo();
            gvMembersList.DataSource = dtMember;
            gvMembersList.DataBind();
        }

        protected void gvMembersList_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindingGridView();

            if (this.SortType == "ASC")
                this.SortType = "DESC";
            else
                this.SortType = "ASC";

            DataView view = new DataView(dtMember);
            view.Sort = e.SortExpression + " " + this.SortType;
            gvMembersList.DataSource = view;
            gvMembersList.DataBind();
        }

        protected void gvMembersList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMembersList.PageIndex = e.NewPageIndex;
            BindingGridView();
        }

        protected void gvMembersList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string ID = ((Label)gvMembersList.Rows[e.RowIndex].FindControl("lblID")).Text;
            string Username = ((Label)gvMembersList.Rows[e.RowIndex].FindControl("lblUsername")).Text;
            string UrlAvatar = ((Image)gvMembersList.Rows[e.RowIndex].FindControl("imgUrlAvatar")).ImageUrl;

            if (Convert.ToInt32(Session["ID"]) == Convert.ToInt32(ID))
            {
                Validation.Instance.Alert("Bạn không thể xóa chính bạn được! Vui lòng thử lại.");
                return;
            }

            if (Username.Equals("admin"))
            {
                Validation.Instance.Alert("Bạn không thể xóa supper admin! Vui lòng thử lại.");
                return;
            }

            if (MemberController.Instance.MemberDelete(Convert.ToInt32(ID)))
            {
                if (File.Exists(Server.MapPath(UrlAvatar)) && !UrlAvatar.Substring(UrlAvatar.Length - 9).Equals("/none.png"))
                {
                    File.Delete(Server.MapPath(UrlAvatar));
                }
                Session["Success"] = "Xóa thông tin thành viên <b>" + Username + "</b> thành công.";
                Response.Redirect("~/Admin/MembersAdmin.aspx");
            }
            Validation.Instance.Alert("Có lỗi xảy ra khi xóa thông tin thành viên! Vui lòng thử lại.");
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Session["Success"] = null;
            mulvMembers.ActiveViewIndex = 1;
        }
    }
}
