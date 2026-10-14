<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="RptCreditAging.aspx.cs" Inherits="Forms_RptCreditAging" Title="SAMS :: Credit Aging Report" %>

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
                                    <td align="left"></td>
                                    <td align="left">
                                     </td>
                                    <td align="left"></td>
                                    <td style="height: 25px" align="left">
                                        <asp:RadioButtonList ID="rblReportBehaviour" runat="server" RepeatDirection="Horizontal"
                                            AutoPostBack="true" OnSelectedIndexChanged="rblReportBehaviour_SelectedIndexChanged">
                                            <asp:ListItem Text="Detail" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Summary" Value="2"  Selected="True"></asp:ListItem>
                                        </asp:RadioButtonList>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lbltoLocation" runat="server" Text="Location"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left"></td>
                                    <td style="height: 25px" align="left">
                                        <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" 
                                            AutoPostBack="true" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged">
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label6" runat="server" CssClass="lblbox" Text="Principal" Width="78px"></asp:Label></strong></td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" CssClass="DropList">
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblCustomer" runat="server" Text="Customer" Visible="false"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="ddlCustomer" runat="server" Width="200px" Visible="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblSortBy" runat="server" Text="Sort By" Visible="false"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="ddlSortBy" runat="server" Width="200px" Visible="false">
                                            <asp:ListItem Value="1" Text="Customer"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Amount"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Days"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Invoice Date"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblOrderBy" runat="server" Text="Order By" Visible="false"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="ddlOrderBy" runat="server" Width="200px" Visible="false">
                                            <asp:ListItem Value="1" Text="Ascending"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Descending"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblDate" runat="server" Height="13px" Text="Up to" Width="70px"></asp:Label></strong></td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <asp:TextBox ID="txtDocmentDate" runat="server" CssClass="txtBox" MaxLength="10"
                                            onkeyup="BlockStartDateKeyPress()" Width="150px"></asp:TextBox><asp:ImageButton ID="ibtnStartDate"
                                                runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" Width="16px" /></td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblReportType" runat="server" CssClass="lblbox" Text="Report Type" Width="94px"></asp:Label></strong></td>
                                    <td align="left"></td>
                                    <td align="left" style="height: 25px">
                                        <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
                                        <asp:RadioButtonList ID="rblReportType" runat="server" Width="137px">
                                            <asp:ListItem Selected="True" Value="0">Principal Wise</asp:ListItem>
                                            <asp:ListItem Value="1">Customer Wise</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                </tr>
                            </table>
                            <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibtnStartDate"
                                TargetControlID="txtDocmentDate">
                            </cc1:CalendarExtender>
                        </ContentTemplate>
                    </asp:UpdatePanel>                    
                    <asp:Button ID="btnViewPDF" runat="server" Text="View PDF" CssClass="btn" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" Text="View Excel" CssClass="btn" OnClick="btnViewExcel_Click" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

