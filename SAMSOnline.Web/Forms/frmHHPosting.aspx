<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmHHPosting.aspx.cs" Inherits="Forms_frmHHPosting"
    MasterPageFile="~/Forms/PageMaster.master" Title="SAMS :: SMS Order Posting" %>
<%@ Register Assembly="AjaxControlToolkit"   Namespace="AjaxControlToolkit"    TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <div id="right_data">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div>
                    <div>
                        <table style="width: 404px; height: 76px">
                            <tbody>
                                <tr>
                                    <td style="width: 32px">
                                    </td>
                                    <td style="width: 327px">
                                    </td>
                                    <td style="width: 327px">
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" Width="262px" ForeColor="Transparent"></asp:Label></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px; height: 32px">
                                        <strong>
                                            <asp:Label ID="lblSalesForce" runat="server" Width="100px" Height="18px" Text="Sales Force"
                                                CssClass="lblbox"></asp:Label></strong>
                                    </td>
                                    <td style="width: 327px; height: 32px" align="left">
                                        <asp:DropDownList ID="ddSalesForce" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddSalesForce_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 327px; height: 32px" align="left">
                                        &nbsp;
                                        <asp:Button CssClass="btn" ID="btnGetOrders" OnClick="btnGetOrders_Click1" runat="server"
                                            Text="Get Orders" />
                                    </td>
                                    <td style="height: 32px" align="left">
                                    </td>
                                </tr>
                               
                            </tbody>
                        </table>
                    </div>
                    <div id="DivGrid" runat="server" visible="false">
                        <table>
                            <tbody>
                                <tr>
                                    <td>
                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:CheckBox ID="chkSelectAll" runat="server" Visible="False" Width="99px" Text="Select All"
                                            AutoPostBack="True" OnCheckedChanged="chkSelectAll_CheckedChanged"></asp:CheckBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Panel2" runat="server" Height="250px" ScrollBars="Vertical" Width="100%">
                            <asp:GridView ID="GridSalesOrder" runat="server" Width="735px" Height="1px" ForeColor="SteelBlue"
                                CssClass="gridRow2" BorderStyle="Solid" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="Gray" HorizontalAlign="Center">
                                <PagerSettings PreviousPageText="Previous" Mode="NextPrevious" LastPageText="" FirstPageText=""
                                    NextPageText="Next"></PagerSettings>
                                <FooterStyle BackColor="White"></FooterStyle>
                                <Columns>
                                    <asp:TemplateField HeaderText="SaleOrder">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver" HorizontalAlign="Center">
                                        </ItemStyle>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChbSelect" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DOCUMENT_DATE" HeaderText="Order Date" HtmlEncode="False"
                                        DataFormatString="{0:dd-MM-yyyy}">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SALE_ORDER_ID" HeaderText="Order No">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SOLD_TO" HeaderText="CustomerId">
                                        <ItemStyle CssClass="HidePanel "></ItemStyle>
                                        <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="DISTRIBUTOR_ID">
                                        <ItemStyle CssClass="HidePanel "></ItemStyle>
                                        <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Customer Name">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="TOTAL_AMOUNT"
                                        HeaderText="Gross Amount">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="EXTRA_DISCOUNT_AMOUNT"
                                        HeaderText="Extra Disc">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="STANDARD_DISCOUNT_AMOUNT"
                                        HeaderText="Stand. Amount">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="GST_AMOUNT"
                                        HeaderText="GST Amount">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="TOTAL_NET_AMOUNT"
                                        HeaderText="Net Amount">
                                        <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle ForeColor="Black"></RowStyle>
                                <PagerStyle BackColor="Transparent"></PagerStyle>
                                <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                <AlternatingRowStyle BackColor="#F2F2F2" ForeColor="#333333" CssClass="GridAlternateRowStyle">
                                </AlternatingRowStyle>
                            </asp:GridView>
                        </asp:Panel>
                                    </td>
                                </tr>
                            </tbody>
                        </table>                        
                    </div>
                    <div class="container">
                        <table style="width: 404px">
                            <tbody>
                                <tr>
                                    <td style="width: 32px; height: 32px">
                                        <strong>
                                            <asp:Label ID="lblDate" runat="server" Height="18px" Text="Delivery Date"></asp:Label></strong>
                                    </td>
                                    <td style="width: 327px; height: 32px" align="left">
                                        <asp:TextBox ID="txtDate" runat="server" Enabled="false"></asp:TextBox>
                                        <asp:ImageButton ID="ImgBntToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" />
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" EnableViewState="False"
                                            Format="dd-MMM-yyyy" PopupButtonID="ImgBntToDate" TargetControlID="txtDate">
                                        </ajaxToolkit:CalendarExtender>
                                    </td>
                                    <td style="width: 327px; height: 32px" align="left">
                                        &nbsp;
                                        
                                    </td>
                                    <td style="height: 32px" align="left">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px; height: 19px">
                                        <strong>
                                            <asp:Label ID="Label2" runat="server" Width="81px" Height="18px" Text="Order Type"
                                                CssClass="lblbox"></asp:Label></strong>
                                    </td>
                                    <td style="width: 327px; height: 19px">
                                        <asp:DropDownList ID="DrpOrderType" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddSalesForce_SelectedIndexChanged">
                                            <asp:ListItem Value="214">Cash</asp:ListItem>
                                            <asp:ListItem Value="215">Credit</asp:ListItem>
                                            <asp:ListItem Value="216">Advance</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 327px; height: 19px">
                                        <strong>
                                            <asp:Label ID="Label3" runat="server" Width="262px" ForeColor="Transparent"></asp:Label></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px; height: 27px">
                                        <strong>
                                            <asp:Label ID="Label4" Width="100px" runat="server" Height="18px" Text="Delivery Man"
                                                CssClass="lblbox"></asp:Label></strong>
                                    </td>
                                    <td style="width: 327px; height: 27px" align="left">
                                        <asp:DropDownList ID="ddDilverMan" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 327px; height: 27px" align="left">
                                        &nbsp;
                                        <asp:Button CssClass="btn" ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Save"
                                            Enabled="False" />
                                    </td>
                                    <td style="height: 27px" align="left">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
