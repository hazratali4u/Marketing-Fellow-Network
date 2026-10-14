<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptPhysicalStockTaking.aspx.cs" Inherits="Forms_RptPhysicalStockTaking"
    Title="SAMS :: Physical Stock Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">

        function SelectAll() {
            var chkBoxList = document.getElementById('<%= LstCategory.ClientID %>');
            var chkBox = document.getElementById('<%= ChbAllCategory.ClientID %>');
            if (chkBox.checked == true) {
                var chkBoxCount = chkBoxList.getElementsByTagName("input");

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                }
            }
            else {
                var chkBoxCount = chkBoxList.getElementsByTagName("input");

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                }
            }
        }

        function UnCheckSelectAll() {
            var chkBox = document.getElementById('<%= ChbAllCategory.ClientID %>');
            var chkBoxList = document.getElementById('<%= LstCategory.ClientID %>');
            var chkBoxCount = chkBoxList.getElementsByTagName("input");
            var count = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == false) {
                    count += 1;
                }
            }
            if (count > 0) {
                chkBox.checked = false;
            }
            else {
                chkBox.checked = true;
            }
        }
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table cellpadding="5" cellspacing="5">
                                <tbody>
                                    <tr>
                                        <td align="left" >
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" CssClass="lblbox" Text="Report Type" Width="78px"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <asp:RadioButtonList ID="RblType" runat="server"
                                            AutoPostBack="True" OnSelectedIndexChanged="RblType_SelectedIndexChanged"
                                                RepeatDirection="Horizontal" Width="250px">
                                                <asp:ListItem Selected="True">SKU Wise</asp:ListItem>
                                                <asp:ListItem>Value Wise</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="48px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DrpLocation" runat="server" Width="210px" CssClass="DropList"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="61px" Text="Principal"></asp:Label>
                                            </strong>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpPrincipal" runat="server" Width="210px"
                                                AutoPostBack="True" OnSelectedIndexChanged="drpPrincipal_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChbAllCategory" onclick="SelectAll()" runat="server" Text="Category">
                                            </asp:CheckBox>
                                            <br />
                                            <asp:Panel ID="pnlCategory" runat="server" Width="302px" Height="150px" ScrollBars="Vertical"
                                                BorderWidth="1px" BorderStyle="Groove">
                                                <asp:CheckBoxList ID="LstCategory" onclick="UnCheckSelectAll()" runat="server" Font-Bold="false">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="59px" Text="Date" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFromDate" runat="server" Width="153px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" EnableViewState="False"
                                Format="dd-MMM-yyyy" PopupButtonID="ImgBntFromCalc" TargetControlID="txtFromDate">
                            </cc1:CalendarExtender>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="Button2" runat="server" Text="View PDF" CssClass="btn" OnClick="Button2_Click" />
                    <asp:Button ID="Button1" runat="server" Text="View Excel" CssClass="btn" OnClick="Button1_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
