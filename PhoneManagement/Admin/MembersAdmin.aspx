<%@ Page Title="Quản lý thành viên" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="MembersAdmin.aspx.cs" Inherits="PhoneManagement.Admin.MembersAdmin" %>

<%@ Register Src="~/Admin/UserControlsAdmin/UcMemberForm.ascx" TagPrefix="uc1" TagName="UcMemberForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><i class="fa fa-user"></i>Quản lý thành viên</h2>
    <hr />
    <p class="text-center">
        <asp:Label ID="lblNotifyAction" CssClass="alert alert-success" Visible="false" runat="server"></asp:Label></p>
    <asp:MultiView ID="mulvMembers" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewMembersList" runat="server">
            <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-primary btn-sm" OnClick="btnAddNew_Click"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</asp:LinkButton>
            <asp:GridView ID="gvMembersList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover margin_top10"
                OnPageIndexChanging="gvMembersList_PageIndexChanging" OnRowDeleting="gvMembersList_RowDeleting"
                OnSorting="gvMembersList_Sorting" PageSize="6" ShowFooter="True" DataKeyNames="id">
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="id">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tên đăng nhập" SortExpression="username">
                        <ItemTemplate>
                            <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("username") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tên hiển thị" SortExpression="displayName">
                        <ItemTemplate>
                            <asp:Label ID="lblDisplayName" runat="server" Text='<%# Eval("displayName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Số điện thoại" SortExpression="telephone">
                        <ItemTemplate>
                            <asp:Label ID="lblTelephone" runat="server" Text='<%# Eval("telephone") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ảnh đại diện">
                        <ItemTemplate>
                            <asp:Image ID="imgUrlAvatar" runat="server" ImageUrl='<%# Eval("urlAvatar", "~/public/upload/members/{0}") %>' Width="50px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày tạo">
                        <ItemTemplate>
                            <asp:Label ID="lblDateCreated" runat="server" Text='<%# Eval("dateCreated", "{0: dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Chức năng">
                        <ItemTemplate>                            
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </asp:View>


        <asp:View ID="viewMembersForm" runat="server">
            <uc1:UcMemberForm runat="server" ID="UcMemberForm" />
        </asp:View>
    </asp:MultiView>

</asp:Content>
