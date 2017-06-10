using Controllers;
using Models;
using System;

namespace PhoneManagement.Admin.UserControlsAdmin
{
    public partial class _MemberProfile : System.Web.UI.UserControl
    {
        public string Message { private set; get; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInfo();
            }
        }

        void LoadInfo()
        {
            if (Session["Username"] != null)
            {
                txtUsername.Text = Session["Username"].ToString();
                txtDisplayName.Text = Session["DisplayName"].ToString();
                txtEmail.Text = Session["Email"].ToString();
                txtTelephone.Text = Session["Telephone"].ToString();
                return;
            }
            Response.Redirect("../dang-nhap");
        }

        protected void ckbChangePassword_CheckedChanged(object sender, EventArgs e)
        {
            pnlPassword.Visible = ckbChangePassword.Checked ? true : false;
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (!MemberController.Instance.CheckUsernameAndPasswordIsExists(txtUsername.Text.Trim(), txtOldPassword.Text))
            {
                Message = "Mật khẩu cũ không đúng! Vui lòng nhập lại";
                return;
            }
            if (MemberController.Instance.CheckUsernameOrEmailIsExists("", txtEmail.Text) && txtEmail.Text != Session["Email"].ToString())
            {
                Message = "Địa chỉ Email đã tồn tại! Vui lòng nhập địa chỉ khác";
                return;
            }
            if (ckbChangePassword.Checked && txtNewPassword.Text.Length < 6)
            {
                Message = "Mật khẩu mới tổi thiểu phải đủ 6 ký tự!";
                return;
            }

            MemberInfo info = new MemberInfo();
            info.Username = txtUsername.Text.Trim();
            info.DisplayName = txtDisplayName.Text.Trim();
            info.Password = txtOldPassword.Text;
            info.Email = txtEmail.Text;
            info.Telephone = txtTelephone.Text;
            info.UrlAvatar = Session["UrlAvatar"].ToString();

            if (!MemberController.Instance.MembersUpdateProfile(info, txtNewPassword.Text))
            {
                Message = "Có lỗi xảy ra khi Cập nhật thông tin cá nhân! Vui lòng thử lại.";
                return;
            }
            Session["DisplayName"] = txtDisplayName.Text.Trim();
            Session["Email"] = txtEmail.Text;
            Session["Telephone"] = txtTelephone.Text;
            Session["UpdatedProfile"] = "Cập nhật thông tin cá nhân tài khoản \"" + txtUsername.Text + "\" thành công.";

            Response.Redirect("~/Admin/Dashboard.aspx");

        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
    }
}