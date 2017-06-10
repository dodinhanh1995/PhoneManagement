<%@ Page Title="Quản lý quảng cáo" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdvertisementsAdmin.aspx.cs" Inherits="PhoneManagement.Admin.AdvertisementsAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">
        <div class="col-md-12">


            <h3><i class="fa fa-camera"></i> Quản lý quảng cáo</h3>
    <hr />

    <div class="text-center">
        <asp:Label ID="lblNotify" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
    </div>

    <asp:GridView ID="gvAdvertise" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover margin_top10"
        PageSize="6" ShowFooter="True" OnSorting="gvAdvertise_Sorting" OnPageIndexChanging="gvAdvertise_PageIndexChanging" OnRowDeleting="gvAdvertise_RowDeleting" OnRowCancelingEdit="gvAdvertise_RowCancelingEdit"
        OnRowEditing="gvAdvertise_RowEditing" OnRowUpdating="gvAdvertise_RowUpdating" DataKeyNames="id">
        <Columns>
            <asp:TemplateField HeaderText="ID" HeaderStyle-Width="20px" SortExpression="id">
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Tên quảng cáo" SortExpression="name">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="hdfEditName" runat="server" Value='<%# Eval("name") %>' />
                    <asp:TextBox ID="txtEditName" CssClass="form-control" runat="server" Text='<%# Eval("name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEditName" runat="server" ValidationGroup="groupEdit" ErrorMessage="Vui lòng nhập tên Quảng cáo" Font-Bold="True" ForeColor="Red" ControlToValidate="txtEditName" Display="Dynamic"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox CssClass="form-control" ID="txtAddName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateName" runat="server" ErrorMessage="Vui lòng nhập tên Quảng cáo" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên Quảng cáo" ControlToValidate="txtAddName" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Hình ảnh" HeaderStyle-Width="200px">
                <ItemTemplate>
                    <asp:Image ID="imgPicture" runat="server" ImageUrl='<%# Eval("picture", "~/public/upload/advertisements/{0}") %>' Width="200px" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:FileUpload ID="fuEditPicture" CssClass="form-control" runat="server" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:FileUpload ID="fuAddPicture" CssClass="form-control" runat="server" />
                    <asp:RequiredFieldValidator ID="validatePicture" runat="server" ControlToValidate="fuAddPicture" ErrorMessage="Vui lòng chọn Hình ảnh quảng cáo" Font-Bold="True" ForeColor="Red" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Vị trí hiển thị" SortExpression="position">
                <ItemTemplate>
                    <asp:Label ID="lblPosition" runat="server" Text='<%# Eval("position") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditPosition" CssClass="form-control" Text='<%# Eval("position") %>' runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEditPosition" runat="server" ControlToValidate="txtEditPosition" ErrorMessage="Vui lòng chọn vị trí hiển thị Quảng cáo" Font-Bold="True" ForeColor="Red" Display="Dynamic" ValidationGroup="groupEdit"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtAddPosition" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateAddPosition" runat="server" ControlToValidate="txtAddPosition" ErrorMessage="Vui lòng chọn vị trí hiển thị Quảng cáo" Font-Bold="True" ForeColor="Red" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ngày tạo" SortExpression="dateCreated">
                <ItemTemplate>
                    <asp:Label ID="lblDateCreated" runat="server" Text='<%# Eval("dateCreated", "{0 :dd/MM/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblDateCreated" runat="server" Text='<%# Eval("dateCreated", "{0 :dd/MM/yyyy}") %>'></asp:Label>                    
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblCurrentDate" runat="server" Text='<%# DateTime.Now.ToString("dd/MM/yyyy") %>'></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="50" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Chức năng">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" EnableViewState="false" CommandName="Edit" CssClass="btn btn-sm btn-default"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" runat="server" EnableViewState="false" CommandName="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="btnUpdate" runat="server" EnableViewState="false" ValidationGroup="groupEdit" CommandName="Update" Text="Cập nhật" CssClass="btn btn-sm btn-success" />
                    <asp:LinkButton ID="btnCancel" runat="server" EnableViewState="false" CommandName="Cancel" Text="Hủy bỏ" CssClass="btn btn-sm btn-warning" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ValidationGroup="groupAddNew" EnableViewState="false" ID="btnAddNew" runat="server" OnClick="btnAddNew_Click" CssClass="btn btn-sm btn-primary"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</asp:LinkButton>
                </FooterTemplate>
                <HeaderStyle Width="190" />
            </asp:TemplateField>
        </Columns>

        <PagerStyle CssClass="pagination-ys" />


    </asp:GridView>


        </div>
    </div>

    



</asp:Content>
