<%@ Page Title="Đăng nhập | AnhDo Mobile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PhoneManagement.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="clearfix">
            <br />
        </div>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4 bg_white">
                <div class="clearfix margin_top20"></div>
                <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" EnableViewState="false" runat="server" CssClass="panel panel-default">
                    <div class="panel-heading">
                        <h2>Đăng nhập</h2>
                    </div>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:PlaceHolder ID="plhMessage" Visible="false" EnableViewState="false" runat="server">
                                <p class="text-center text-danger"><%: Message %></p>
                            </asp:PlaceHolder>
                            <div class="panel-body">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                    <asp:TextBox ID="txtUsername" CssClass="form-control" placeholder="Nhập tên đăng nhập." runat="server"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfUsername" ValidationGroup="groupLogin" CssClass="price" runat="server" ControlToValidate="txtUsername" ErrorMessage="Vui lòng nhập tên đăng nhập!" Display="Dynamic" Font-Size="Medium"></asp:RequiredFieldValidator>
                                <br />
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                    <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Nhập mật khẩu." runat="server"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfPassword" ValidationGroup="groupLogin" CssClass="price" runat="server" ControlToValidate="txtPassword" ErrorMessage="Vui lòng nhập mật khẩu!" Display="Dynamic" Font-Size="Medium"></asp:RequiredFieldValidator>
                                <div class="clearfix">
                                    <hr />
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9">
                                        <asp:Button ID="btnLogin" EnableViewState="false" CssClass="btn btn-primary" runat="server" Text="Đăng nhập" ValidationGroup="groupLogin" OnClick="btnLogin_Click" />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>

            </div>
        </div>
        <div class="col-md-4"></div>
    </div>
    <!-- end Page Content -->
    <br />
</asp:Content>
