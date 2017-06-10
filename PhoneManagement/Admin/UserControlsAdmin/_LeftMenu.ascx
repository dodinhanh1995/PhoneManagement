<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="_LeftMenu.ascx.cs" Inherits="PhoneManagement.Admin.UserControlsAdmin._LeftMenu" %>

<div class="left_col scroll-view">
    <div class="navbar nav_title" style="border: 0;">
        <a class="site_title"><img src="../public/upload/logo/logo_red.png" width="50"/> <span>AnhDo Area!</span></a>
    </div>
    <div class="clearfix"></div>
    <!-- menu profile quick info -->
    <div class="profile clearfix">
        <div class="profile_pic">
            <img src="../public/upload/members/<%: Common.Validation.Instance.Session_Get("UrlAvatar") %>" alt="..." class="img-circle profile_img">
        </div>
        <div class="profile_info">
            <span>Welcome,</span>
            <h2><%: Common.Validation.Instance.Session_Get("DisplayName") %></h2>
        </div>
    </div>
    <!-- /menu profile quick info -->
    <br />
    <!-- sidebar menu -->
    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
        <div class="menu_section">
            <ul class="nav side-menu">
                <li>
                    <a href="../Admin/Dashboard.aspx"><i class="fa fa-dashboard"></i>Thống kê chung</a>
                </li>
                <li>
                    <a><i class="fa fa-mobile"></i>Sản phẩm<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/ProductsAdmin.aspx">Danh sách sản phẩm<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-android"></i>Thương hiệu <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/BrandAdmin.aspx">Danh sách thương hiệu<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-shopping-basket"></i>Đơn hàng <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/OrdersAdmin.aspx">Danh sách đơn hàng<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-camera"></i>Quảng cáo <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/AdvertisementsAdmin.aspx">Danh sách quảng cáo<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-file-text"></i>Tin tức <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/NewsAdmin.aspx">Danh sách tin tức<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-users"></i>Khách hàng <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/CustomersAdmin.aspx">Danh sách khách hàng<span class="fa arrow"></span></a></li>
                    </ul>
                </li>
                <li>
                    <a><i class="fa fa-user"></i>Thành viên <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="../Admin/MembersAdmin.aspx">Danh sách thành viên<span class="fa arrow"></span></a></li>
                    </ul>
                </li>                        
            </ul>
        </div>
    </div>
    <!-- /sidebar menu -->
    <!-- /menu footer buttons -->
    <div class="sidebar-footer hidden-small">
        <a data-toggle="tooltip" data-placement="top" title="Settings">
            <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
        </a>
        <a data-toggle="tooltip" data-placement="top" title="FullScreen">
            <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
        </a>
        <a data-toggle="tooltip" data-placement="top" title="Lock">
            <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
        </a>
        <a data-toggle="tooltip" data-placement="top" title="Logout" href="#">
            <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
        </a>
    </div>
    <!-- /menu footer buttons -->
</div>
