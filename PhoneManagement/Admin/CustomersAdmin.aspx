<%@ Page Title="Quản lý khách hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CustomersAdmin.aspx.cs" Inherits="PhoneManagement.Admin.CustomersAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Label ID="Label1" runat="server" CssClass="lead"><i class="fa fa-users"></i> Quản lý khách hàng</asp:Label>
    <hr />
    <asp:GridView ID="gvCustomersList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover"
        PageSize="7" ShowFooter="True" OnPageIndexChanging="gvCustomersList_PageIndexChanging" OnRowDeleting="gvCustomersList_RowDeleting"
        OnRowCancelingEdit="gvCustomersList_RowCancelingEdit" OnRowEditing="gvCustomersList_RowEditing" OnRowUpdating="gvCustomersList_RowUpdating" OnRowDataBound="gvCustomersList_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="30px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Họ và Tên">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditName" CssClass="form-control" runat="server" Text='<%# Eval("name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEditName" runat="server" ValidationGroup="groupEdit" ErrorMessage="Vui lòng nhập tên Khách hàng" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên Khách hàng" ControlToValidate="txtEditName" Display="Dynamic"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox CssClass="form-control" ID="txtAddName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateName" runat="server" ErrorMessage="Vui lòng nhập tên Khách hàng" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên Khách hàng" ControlToValidate="txtAddName" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                </FooterTemplate>
                <HeaderStyle Width="200px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Giới tính">
                <ItemTemplate>
                    <asp:Label ID="lblGender" runat="server" Text='<%# Convert.ToInt32(Eval("gender")) == 1 ? "Nam" : "Nữ" %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="hdfEditGender" Value='<%# Eval("gender") %>' runat="server" />
                    <asp:DropDownList ID="ddlEditGender" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Nam" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Nữ" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ddlAddGender" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Nam" Value="1" Selected="True" ></asp:ListItem>
                        <asp:ListItem Text="Nữ" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Địa chỉ Email">
                <ItemTemplate>
                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditEmail" CssClass="form-control" runat="server" Text='<%# Eval("email") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegEditEmail" runat="server" ErrorMessage="Vui lòng nhập địa chỉ Email hợp lệ!" Font-Bold="true" ForeColor="Red" ControlToValidate="txtEditEmail" Display="Dynamic" ValidationGroup="groupEdit" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox CssClass="form-control" ID="txtAddEmail" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegAddEmail" runat="server" ErrorMessage="Vui lòng nhập địa chỉ Email hợp lệ!" Font-Bold="true" ForeColor="Red" ControlToValidate="txtAddEmail" Display="Dynamic" ValidationGroup="groupAddNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Số điện thoại">
                <ItemTemplate>
                    <asp:Label ID="lblTelephone" runat="server" Text='<%# Eval("telephone") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditTelephone" CssClass="form-control" runat="server" Text='<%# Eval("telephone") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEditTelephone" runat="server" ValidationGroup="groupEdit" ErrorMessage="Vui lòng nhập số điện thoại!" Font-Bold="True" ForeColor="Red" ToolTip="Nhập số điện thoại" ControlToValidate="txtEditTelephone" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEditTelephone" ErrorMessage="Vui lòng nhập số điện thoại hợp lệ!" Font-Bold="True" ForeColor="Red" ValidationExpression="^0[\d]{9,12}" ValidationGroup="groupEdit"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox CssClass="form-control" ID="txtAddTelephone" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateTelephone" runat="server" ErrorMessage="Vui lòng nhập số điện thoại" Font-Bold="True" ForeColor="Red" ToolTip="Nhập tên số điện thoại" ControlToValidate="txtAddTelephone" Display="Dynamic" ValidationGroup="groupAddNew"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAddTelephone" ErrorMessage="Vui lòng nhập số điện thoại hợp lệ!" Font-Bold="True" ForeColor="Red" ValidationExpression="^0[\d]{9,12}" ValidationGroup="groupAddNew" Display="Dynamic"></asp:RegularExpressionValidator>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Chức năng">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Chỉnh sửa" CssClass="btn btn-sm btn-default" />
                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Xóa" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="btnUpdate" runat="server" ValidationGroup="groupEdit" CommandName="Update" Text="Cập nhật" CssClass="btn btn-sm btn-success" />
                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Hủy bỏ" CssClass="btn btn-sm btn-warning" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ValidationGroup="groupAddNew" ID="btnAddNew" runat="server" OnClick="btnAddNew_Click" Text="Thêm mới" CssClass="btn btn-sm btn-primary" />
                </FooterTemplate>
                <HeaderStyle Width="180px" />
            </asp:TemplateField>
        </Columns>
        

        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Privious" />
        <PagerStyle CssClass="pagination-ys" />


    </asp:GridView>


</asp:Content>
