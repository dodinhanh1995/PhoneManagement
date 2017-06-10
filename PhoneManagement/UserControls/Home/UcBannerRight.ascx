<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcBannerRight.ascx.cs" Inherits="PhoneManagement.UserControls.Home.UcBannerRight" %>
<%@ OutputCache Duration="3600" VaryByParam="none" %>
<asp:Repeater ID="rptAdvertiseHomeRight" runat="server" EnableViewState="false">
    <ItemTemplate>
        <div class="banner_aside margin_top10">
            <img src='<%# Eval("picture", "public/upload/advertisements/{0}") %>' width="100%" alt='<%# Eval("name") %>' title='<%# Eval("name") %>' />
        </div>
    </ItemTemplate>
</asp:Repeater>
