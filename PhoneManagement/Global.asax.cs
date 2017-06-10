using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using PhoneManagement;

namespace PhoneManagement
{
    public class Global : HttpApplication
    {
        void RegisterRouters(RouteCollection routers)
        {
            routers.MapPageRoute("About", "gioi-thieu-cong-ty", "~/About.aspx");
            routers.MapPageRoute("Contact", "lien-he", "~/Contact.aspx");
            routers.MapPageRoute("Branch", "he-thong-sieu-thi", "~/Branch.aspx");
            routers.MapPageRoute("ShoppingCart", "gio-hang", "~/ShoppingCart.aspx");
            routers.MapPageRoute("Login", "dang-nhap", "~/Login.aspx");
            routers.MapPageRoute("News", "tin-tuc-{id}", "~/News.aspx");
            routers.MapPageRoute("Details", "dien-thoai-{id}", "~/Details.aspx");
            routers.MapPageRoute("Search", "tim-kiem-tu-khoa-{key}", "~/Search.aspx");

            routers.MapPageRoute("Phone Filter LessThan And Sort", "dtdd-gia-duoi-{from}-sx-gia-{sort}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Filter GreaterThan And Sort", "dtdd-gia-tren-{to}-sx-gia-{sort}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Filter Between And Sort", "dtdd-gia-tu-{from}-den-{to}-sx-gia-{sort}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Filter LessThan", "dtdd-gia-duoi-{from}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Filter GreaterThan", "dtdd-gia-tren-{to}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Filter Between", "dtdd-gia-tu-{from}-den-{to}", "~/Phone.aspx");
            routers.MapPageRoute("Phone Sort", "dtdd-sx-gia-{sort}", "~/Phone.aspx");
            routers.MapPageRoute("Phone", "dtdd", "~/Phone.aspx");

            routers.MapPageRoute("Brand Filter LessThan And Sort", "thuong-hieu-{id}-gia-duoi-{from}-sx-gia-{sort}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Filter GreaterThan And Sort", "thuong-hieu-{id}-gia-tren-{to}-sx-gia-{sort}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Filter Between And Sort", "thuong-hieu-{id}-gia-tu-{from}-den-{to}-sx-gia-{sort}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Filter LessThan", "thuong-hieu-{id}-gia-duoi-{from}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Filter GreaterThan", "thuong-hieu-{id}-gia-tren-{to}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Filter Between", "thuong-hieu-{id}-gia-tu-{from}-den-{to}", "~/Brand.aspx");
            routers.MapPageRoute("Brand Sort", "thuong-hieu-{id}-sx-gia-{sort}", "~/Brand.aspx");
            routers.MapPageRoute("Brand", "thuong-hieu-{id}", "~/Brand.aspx");
        }
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AuthConfig.RegisterOpenAuth();
            RegisterRouters(RouteTable.Routes);
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }
    }
}
