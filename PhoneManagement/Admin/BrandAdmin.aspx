<%@ Page Title="Quản lý thương hiệu" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="BrandAdmin.aspx.cs" Inherits="PhoneManagement.BrandAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Content -->
    <div class="container-fluid" id="home">
        <div class="row">
            <div class="col-md-12">
                <h3><i class="fa fa-android"></i> Quản lý thương hiệu</h3>
                <hr />

                <div class="text-center">
                    <asp:Label ID="lblNotify" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
                </div>
                <asp:GridView ID="gvBrandList" runat="server" AllowPaging="True" DataKeyNames="id"
                    AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover margin_top10"
                    PageSize="5" ShowFooter="True" OnPageIndexChanging="gvBrandList_PageIndexChanging" OnRowDeleting="gvBrandList_RowDeleting" OnRowCancelingEdit="gvBrandList_RowCancelingEdit"
                    OnRowEditing="gvBrandList_RowEditing" OnRowUpdating="gvBrandList_RowUpdating">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <%# Eval("id") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên thương hiệu">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdfEditName" runat="server" Value='<%# Eval("name") %>' />
                                <asp:TextBox ID="txtEditName" CssClass="form-control" runat="server" placeholder="Nhập tên thương hiệu." Text='<%# Eval("name") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="validateEditName" runat="server" ValidationGroup="groupEdit" ErrorMessage="Vui lòng nhập tên Thương hiệu" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên Thương hiệu" ControlToValidate="txtEditName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox CssClass="form-control" ID="txtAddName" placeholder="Nhập tên thương hiệu." runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="validateName" runat="server" ErrorMessage="Vui lòng nhập tên Thương hiệu" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên Thương hiệu" ControlToValidate="txtAddName" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Logo thương hiệu">
                            <ItemTemplate>
                                <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Eval("logo", "~/public/upload/logo/{0}") %>' Width="90px" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:FileUpload ID="fuEditLogo" CssClass="form-control" runat="server" />
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:FileUpload ID="fuAddLogo" CssClass="form-control" runat="server" />
                                <asp:RequiredFieldValidator ID="validateLogo" runat="server" ControlToValidate="fuAddLogo" ErrorMessage="Vui lòng chọn Logo Thương hiệu" Font-Bold="True" ForeColor="Red" ToolTip="Chọn Logo Thương hiệu" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Chức năng">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-default"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" EnableViewState="false" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" EnableViewState="false" runat="server" ValidationGroup="groupEdit" CommandName="Update" Text="Cập nhật" CssClass="btn btn-sm btn-success" />
                                <asp:LinkButton ID="btnCancel" EnableViewState="false" runat="server" CommandName="Cancel" Text="Hủy bỏ" CssClass="btn btn-sm btn-warning" />
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:LinkButton ValidationGroup="groupAddNew" EnableViewState="false" ID="btnAddNew" runat="server" OnClick="btnAddNew_Click" CssClass="btn btn-sm btn-primary"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</asp:LinkButton>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <PagerStyle CssClass="pagination-ys" />
                </asp:GridView>

            </div>
        </div>
    </div>
</asp:Content>
