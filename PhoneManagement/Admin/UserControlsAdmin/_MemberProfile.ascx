<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="_MemberProfile.ascx.cs" Inherits="PhoneManagement.Admin.UserControlsAdmin._MemberProfile" %>


<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<!-- Modal -->
<div class="modal fade" id="MemberModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <asp:LinkButton ID="btnClose" runat="server" CssClass="close" OnClick="btnClose_Click">&times;</asp:LinkButton>
                <asp:Image ID="imgEditAvatar" runat="server" /><h4 class="modal-title">Member Profile</h4>
            </div>

            <asp:UpdatePanel ID="UpdatePanelBody" runat="server">
                <ContentTemplate>

                    <div class="modal-body">
                        <p class="text-center red_text"><b><%: Message %></b></p>
                        <div class="form-group">
                            <label class="control-label col-sm-3">Tên đăng nhập *</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtUsername" ReadOnly="true" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-3">Tên hiển thị *</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtDisplayName" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredValidDisplayName" runat="server" placeholder="Nhập Tên hiển thị." ControlToValidate="txtDisplayName" ErrorMessage="Vui lòng nhập tên hiển thị!" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-3">Mật khẩu cũ *</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtOldPassword" CssClass="form-control" TextMode="Password" runat="server" placeholder="Nhập Mật khẩu cũ." ValidationGroup="validProfile"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" placeholder="Nhập Mật khẩu cũ." ControlToValidate="txtOldPassword" ErrorMessage="Vui lòng nhập Mật khẩu cũ!" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-3"></label>
                            <div class="col-sm-9">
                                <asp:CheckBox ID="ckbChangePassword" OnCheckedChanged="ckbChangePassword_CheckedChanged" runat="server" AutoPostBack="True" />
                                Đổi mật khẩu
                            </div>
                        </div>

                        <asp:Panel ID="pnlPassword" Visible="false" runat="server">
                            <div class="form-group">
                                <label class="control-label col-sm-3">Mật khẩu mới *</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtNewPassword" CssClass="form-control" TextMode="Password" runat="server" placeholder="Nhập Mật khẩu mới."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Vui lòng nhập lại mật khẩu mới!" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="form-group">
                            <label class="control-label col-sm-3">Email *</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Nhập địa chỉ Email"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="reValidEmail" runat="server" ErrorMessage="Vui lòng nhập địa chị email hợp lệ!" ValidationGroup="validProfile" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" ErrorMessage="Vui lòng nhập địa chỉ email!" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-3">Điện thoại *</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server" placeholder="Nhập Số điện thoại"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Vui lòng nhập số điện thoại hợp lệ!" ValidationExpression="^0[\d]{9,12}" ControlToValidate="txtTelephone" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTelephone" ErrorMessage="Vui lòng nhập số điện thoại!" ValidationGroup="validProfile" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="clearfix"><hr /></div>
                    </div>
                    <%-- ./ Model-Body --%>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnUpdateProfile" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

            
            <div class="modal-footer">
                <div class="form-group">
                    <label class="control-label col-sm-3"></label>
                    <div class="col-sm-9 text-left">
                        <asp:Button ID="btnUpdateProfile" CssClass="btn btn-primary" runat="server" Text="Cập nhật thông tin cá nhân" ValidationGroup="validProfile" OnClick="btnUpdateProfile_Click" />
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
