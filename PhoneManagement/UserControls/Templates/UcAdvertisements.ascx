<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcAdvertisements.ascx.cs" Inherits="PhoneManagement.UserControls.Templates.UcAdvertisements" EnableViewState="false" %>
<%@ OutputCache Duration="3600" VaryByParam="none" %>

<!-- Slider -->
<div class="container margin_top10" id="banner">
    <div class="row">
        <div class="col-lg-8">
            <asp:Repeater ID="rptSlideShow" runat="server">
                <ItemTemplate>
                    <div class="mySlides">
                        <img src='<%# Eval("picture", "public/upload/advertisements/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' width="100%" height="300" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <% for (int i = 0; i < dt.Rows.Count; i++)
               { %>
            <span class="dot"></span>
            <% } %>

            <a class="prev">
                &#8249;
            </a>

            <a class="next">
                &#8250;
            </a>
        </div>
        <div class="col-lg-4 sub_banner">
            <asp:Repeater ID="rptBannerTopRight" runat="server">
                <ItemTemplate>
                    <img src='<%# Eval("picture", "public/upload/advertisements/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' width="100%" height="150" />
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
    <!-- end row -->
</div>
<!-- End Slider -->
