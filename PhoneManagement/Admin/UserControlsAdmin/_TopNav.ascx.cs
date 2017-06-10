using System;

namespace PhoneManagement.Admin.UserControlsAdmin
{
    public partial class _TopNav : System.Web.UI.UserControl
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("../dang-nhap");
        }
    }
}