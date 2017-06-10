using System.IO;
using System.Text;
using System.Web.UI;
using System.Security.Cryptography;
using System.Web.UI.WebControls;
using System.Web;

namespace Common
{
    public class Validation : Page
    {
        private static Validation instance;

        public static Validation Instance
        {
            get
            {
                if (instance == null)
                    instance = new Validation();
                return Validation.instance;
            }
        }

        private Validation() { }

        public bool CheckFileType(string fileName)
        {
            string ext = Path.GetExtension(fileName);
            switch (ext.ToLower())
            {
                case ".jpg": return true;
                case ".png": return true;
                case ".jpeg": return true;
                case ".gif": return true;
                default: return false;
            }
        }

        public void ClearControls(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if ((c.GetType() == typeof(TextBox)))  //Clear TextBox
                {
                    ((TextBox)(c)).Text = "";
                }
                if ((c.GetType() == typeof(DropDownList)))  //Clear DropDownList
                {
                    ((DropDownList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(CheckBox)))  //Clear CheckBox
                {
                    ((CheckBox)(c)).Checked = false;
                }
                if ((c.GetType() == typeof(CheckBoxList)))  //Clear CheckBoxList
                {
                    ((CheckBoxList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(RadioButton)))  //Clear RadioButton
                {
                    ((RadioButton)(c)).Checked = false;
                }
                if ((c.GetType() == typeof(RadioButtonList)))  //Clear RadioButtonList
                {
                    ((RadioButtonList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(HiddenField)))  //Clear HiddenField
                {
                    ((HiddenField)(c)).Value = "";
                }
                if ((c.GetType() == typeof(Label)))  //Clear Label
                {
                    ((Label)(c)).Text = "";
                }
                if (c.HasControls())
                {
                    ClearControls(c);
                }
            }
        }

        public string HasPassword(string password)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(password);
            byte[] hasPassword = new MD5CryptoServiceProvider().ComputeHash(temp);

            StringBuilder str = new StringBuilder();

            foreach (byte item in hasPassword)
            {
                str.Append(item);
            }
            return str.ToString();
        }

        public void Alert(object message)
        {
            HttpContext.Current.Response.Write("<script>alert('" + message + "')</script>");
        }

        public string Input_Get(string input, string def = null)
        {
            return HttpContext.Current.Request.QueryString[input] != null ? HttpContext.Current.Request.QueryString[input] : def;
        }

        public string Session_Get(string key)
        {
            return HttpContext.Current.Session[key] != null ? HttpContext.Current.Session[key].ToString() : null;
        }
    }
}
