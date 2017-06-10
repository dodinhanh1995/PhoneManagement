using Common;
using Controllers;
using Models;
using System;

namespace PhoneManagement.Admin.UserControlsAdmin
{
    public partial class UcMemberForm : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Validation.Instance.ClearControls(pnlMemberAddNew);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string Username = txtUsername.Text.Trim();
            string DisplayName = txtDisplayName.Text.Trim();
            string Password = txtPassword.Text;
            string Email = txtEmail.Text;
            string Telephone = txtTelephone.Text;
            string UrlAvatar = fuUrlAvatar.FileName;

            if (MemberController.Instance.CheckUsernameOrEmailIsExists(Username, Email))
            {
                Validation.Instance.Alert("Tên đăng nhập hoặc Địa chỉ email đã tồn tại");
                return;
            }
            if (fuUrlAvatar.HasFile && !Validation.Instance.CheckFileType(UrlAvatar))
            {
                errUrlAvatar.Visible = true;
                return;
            }
            else
            {
                if (!String.IsNullOrEmpty(UrlAvatar))
                {
                    UrlAvatar = DateTime.Now.ToString("ddMMyyyyhhmmss") + UrlAvatar;
                    fuUrlAvatar.SaveAs(Server.MapPath("~/public/upload/members/" + UrlAvatar));
                }
                if (String.IsNullOrEmpty(UrlAvatar))
                    UrlAvatar = "none.png";

                MemberInfo member = new MemberInfo(Username, DisplayName, Password, Email, Telephone, UrlAvatar);
                if (MemberController.Instance.Members("Insert", member))
                {
                    Validation.Instance.ClearControls(pnlMemberAddNew);
                    Session["Success"] = "Bạn đã thêm mới thông tin thành viên \"" + Username + "\" thành công.";
                    Response.Redirect("~/Admin/MembersAdmin.aspx");
                }
                Validation.Instance.Alert("Có lỗi xảy ra khi thêm thông tin thành viên! Vui lòng thử lại.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/MembersAdmin.aspx");
        }
    }
}