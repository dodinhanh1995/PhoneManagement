<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcSidebar.ascx.cs" Inherits="PhoneManagement.UserControls.Templates.UcSidebar" EnableViewState="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!--Navigation -->
<nav class="navbar navbar-default navbar-fixed-top" id="main_menu" role="navigation">
    <div class="container">
        <div class="row">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a style="padding: 10px 14px" class="navbar-brand" title="AnhDo Mobile" href="./">
                    <img src="public/upload/logo/logo_transparent.png" alt="logo" title="AnhDo Mobile" width="200" />
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="myNavbar">
                <div class="col-md-4">
                    <ul class="nav navbar-left">
                        <li>
                            <asp:Panel ID="pnlSearch" CssClass="navbar-form navbar-left" runat="server" DefaultButton="lbtnSearch">
                                <div class="input-group">
                                    <asp:TextBox ID="txtKey" CssClass="form-control" runat="server" placeholder="Tìm máy (ví dụ iPhone 7..)"></asp:TextBox>
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="lbtnSearch" OnClick="lbtnSearch_Click" CssClass="btn btn-danger" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="completionList"
     CompletionListItemCssClass="listItem"
     CompletionListHighlightedItemCssClass="itemHighlighted" ID="AutoCompleteExtenderSearch" runat="server" EnableCaching="False" ServiceMethod="AutoCompleteAjaxRequest" ServicePath="AutoComplete.asmx" TargetControlID="txtKey" CompletionInterval="100" MinimumPrefixLength="2">
                            </ajaxToolkit:AutoCompleteExtender>
                        </li>
                    </ul>
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="dtdd" title="Điện thoại"><i style="font-size:14px" class="fa fa-mobile"></i> Điện Thoại</a>
                    </li>
                    <li>
                        <asp:HyperLink ID="hplShoppingCart" title="Giỏ hàng" runat="server" Visible="false" NavigateUrl="~/gio-hang"><span class="fa fa-shopping-bag"></span> Giỏ Hàng</asp:HyperLink>
                    </li>
                    <li>
                        <a href="lien-he" title="Liên hệ"><span class="fa fa-phone-square"></span> Liên Hệ</a>
                    </li>
                    <li>
                        <a href="gioi-thieu-cong-ty" title="Giới thiệu"><span class="fa fa-pencil-square"></span> Giới Thiệu</a>
                    </li>
                    <li>
                        <a href="he-thong-sieu-thi" title="Hệ thống"><span class="fa fa-map-marker"></span> Hệ Thống</a>
                    </li>
                    
                </ul>
            </div>
            
            <!-- /.navbar-collapse -->
        </div>
        <!-- row -->
    </div>
    <!-- /.container -->

</nav>
<!-- End Navigation-->
