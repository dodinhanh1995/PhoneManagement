<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="_TopNav.ascx.cs" Inherits="PhoneManagement.Admin.UserControlsAdmin._TopNav" %>
<%@ Register Src="~/Admin/UserControlsAdmin/_MemberProfile.ascx" TagPrefix="uc1" TagName="_MemberProfile" %>


<uc1:_MemberProfile runat="server" id="_MemberProfile" />
<div class="top_nav">
    <div class="nav_menu">
        <nav>
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li role="presentation" class="dropdown">
                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <%: Common.Validation.Instance.Session_Get("DisplayName") %>
                        <span class=" fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu pull-right">
                        <li><a href="#" data-toggle="modal" data-target="#MemberModal">Profile</a></li>
                        <li><asp:LinkButton ID="lbtnLogout" EnableViewState="false" OnClick="lbtnLogout_Click" runat="server"><i class="fa fa-sign-out pull-right"></i> Log out</asp:LinkButton></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</div>
