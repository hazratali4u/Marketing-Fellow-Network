<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptCustomerInvoiceReport.aspx.cs" Inherits="Forms_RptCustomerInvoiceReport"
    Title="SAMS :: Customer Invoice Wise Sales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {

            return true;
        }

    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left" colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="width:90px;">
                                        <strong>Principal</strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" CssClass="DropList">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>Location</strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="drpDistributor" runat="server" CssClass="DropList" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            From Date</strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="txtBox" MaxLength="10" onkeyup="BlockStartDateKeyPress()"
                                            Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibtnStartDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            To Date</strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="txtBox " MaxLength="10" onkeyup="BlockEndDateKeyPress()"
                                            Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibnEndDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:RadioButtonList ID="RblCustomer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RblCustomer_SelectedIndexChanged">
                                            <asp:ListItem Selected="True">Show All Customer</asp:ListItem>
                                            <asp:ListItem>Individulal Customer</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:CheckBox ID="chkRegister" runat="server" Text="Is Registered Customer" Width="174px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <%@ register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
                                        <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibtnStartDate"
                                            TargetControlID="txtStartDate">
                                        </cc1:CalendarExtender>
                                        <cc1:CalendarExtender ID="CEEndDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibnEndDate"
                                            TargetControlID="txtEndDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                            </table>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table style="border-right: silver thin inset; border-top: silver thin inset; border-left: silver thin inset;
                                width: 95%; border-bottom: silver thin inset; background-color: silver">
                                <tbody>
                                    <tr>
                                        <td align="left" style="height: 21px">
                                            <strong>
                                                <asp:Label ID="Label10" runat="server" Text="Select Searching Type" Width="150px"></asp:Label></strong>
                                        </td>
                                        <td align="left" style="width: 170px; height: 21px">
                                            <asp:DropDownList ID="ddSearchType" runat="server" CssClass="DropList" Width="195px">
                                                <asp:ListItem Value="CUSTOMER_NAME">Customer Name</asp:ListItem>
                                                <asp:ListItem Value="ADDRESS">Address</asp:ListItem>
                                                <asp:ListItem Value="Distributor_NAME">Location</asp:ListItem>
                                                <asp:ListItem Value="AREA_NAME">Route Name</asp:ListItem>
                                                <asp:ListItem Value="SLASH_DESC">Channel Type</asp:ListItem>
                                                <asp:ListItem Value="CUSTOMER_CODE">Customer Code</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                           <strong>&nbsp;Value</strong> 
                                        </td>
                                        <td align="left" style="width: 224px; height: 21px">
                                            <asp:TextBox ID="txtSeach" runat="server" CssClass="txtBox " Width="200px"></asp:TextBox>
                                        </td>
                                        <td align="left" style="height: 21px" width="250">
                                            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Filter" CssClass="btn" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <asp:Panel ID="Panel2" runat="server" Height="169px" ScrollBars="Vertical" Width="95%">
                                <asp:GridView ID="Grid_users" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    BorderColor="White" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center"
                                    Width="100%">
                                   
                                    <RowStyle ForeColor="Black" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ChbCustomer" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="4%" HorizontalAlign="Center"/>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CUSTOMER_ID" HeaderText="CUSTOMER_ID">
                                            <HeaderStyle CssClass="hiddencol" />
                                            <ItemStyle CssClass="hiddencol" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Distributor_id" HeaderText="Distributor_id">
                                            <HeaderStyle CssClass="hiddencol" />
                                            <ItemStyle CssClass="hiddencol" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CUSTOMER_CODE" HeaderText="Code">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="5%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Name">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="15%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Distributor_Name" HeaderText="Location">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AREA_NAME" HeaderText="Route">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ADDRESS" HeaderText="Address">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="25%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ChannelType" HeaderText="Channel Type">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10%"/>
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="White" />
                                    <PagerStyle BackColor="Transparent" />
                                    <HeaderStyle CssClass="tblhead" />
                                    <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333" />
                                </asp:GridView>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="BtnViewPdf" runat="server" OnClick="BtnViewPdf_Click" Text="View PDF"
                        CssClass="btn" />
                    <asp:Button ID="btnViewExcel" runat="server" Text="View Excel" CssClass="btn" OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
