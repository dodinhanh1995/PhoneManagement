<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcLogoOfBrand.ascx.cs" Inherits="PhoneManagement.UserControls.Templates.UcLogoOfBrand" EnableViewState="false" %>
<%@ OutputCache Duration="82400" VaryByParam="none" %>

<div class="margin_top10"></div>
<header id="manufacturer" class="container">
    <div class="row">
        <ul>
            <asp:Repeater ID="rptLogo" runat="server">
                <ItemTemplate>
                    <li>
                        <a href='<%# Eval("name_url", "thuong-hieu-{0}") %>' title='<%# Eval("name") %>'>
                            <img class="img-responsive" src='<%# Eval("logo", "public/upload/logo/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' width="100%"/>
                        </a>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</header>
