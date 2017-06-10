<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcMemberForm.ascx.cs" Inherits="PhoneManagement.Admin.UserControlsAdmin.UcMemberForm" %>

<asp:LinkButton runat="server" CssClass="btn btn-default btn-sm" ID="btnBack" OnClick="btnBack_Click"><i class="fa fa-arrow-left" aria-hidden="true"></i> Quay lại</asp:LinkButton>

<asp:Panel ID="pnlMemberAddNew" DefaultButton="btnAdd" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-3">Tên đăng nhập *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" placeholder="Nhập tên đăng nhập."></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfValidUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Vui lòng nhập tên đăng nhập!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Tên hiển thị *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtDisplayName" CssClass="form-control" runat="server" placeholder="Nhập tên hiển thị."></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredValidDisplayName" runat="server" ControlToValidate="txtDisplayName" ErrorMessage="Vui lòng nhập tên hiển thị!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Mật khẩu *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" runat="server" placeholder="Nhập mật khẩu." ValidationGroup="groupAddNew"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPassword" ErrorMessage="Vui lòng nhập mật khẩu tối thiểu phải đủ 6 ký tự!" ValidationExpression="^[\w]{6,}" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword" ErrorMessage="Vui lòng nhập mật khẩu!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Nhập lại mật khẩu *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtRePassword" CssClass="form-control" TextMode="Password" runat="server" placeholder="Nhập lại mật khẩu."></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtRePassword" ErrorMessage="Vui lòng nhập lại đúng mật khẩu!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRePassword" ErrorMessage="Vui lòng nhập lại mật khẩu!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Email *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Nhập địa chỉ email."></asp:TextBox>
            <asp:RegularExpressionValidator ID="reValidEmail" runat="server" ErrorMessage="Vui lòng nhập địa chị email hợp lệ!" ValidationGroup="groupAddNew" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" ErrorMessage="Vui lòng nhập địa chỉ email!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Điện thoại *</label>
        <div class="col-sm-7">
            <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server" placeholder="Nhập số điện thoại."></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Vui lòng nhập số điện thoại hợp lệ!" ValidationExpression="^0[\d]{9,12}" ControlToValidate="txtTelephone" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTelephone" ErrorMessage="Vui lòng nhập số điện thoại!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-3">Ảnh đại diện</label>
        <div class="col-sm-7">
            <asp:FileUpload ID="fuUrlAvatar" CssClass="form-control" runat="server" />
            <asp:Label ID="errUrlAvatar" Visible="False" runat="server" Font-Bold="True" ForeColor="Red">Vui lòng chọn định dạng file ảnh hợp lệ!</asp:Label>
            <br />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-offset-3 col-sm-9">
            <asp:Button ID="btnAdd" EnableViewState="false" CssClass="btn btn-primary" runat="server" ValidationGroup="groupAddNew" Text="Thêm mới" OnClick="btnAdd_Click" />
            <asp:Button ID="btnCancel" EnableViewState="false" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click" />
        </div>
    </div>
</asp:Panel>
