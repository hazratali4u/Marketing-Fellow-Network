
<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmOrderShifting.aspx.cs" Inherits="Forms_frmOrderShifting" Title="SAMS :: Order Shifting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript" language="javascript">
        function HeaderClick(CheckBox) {
            var TargetBaseControl = document.getElementById('<%= this.cblOrders.ClientID %>');
            var TargetChildControl = "cbAll";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var n = 0; n < Inputs.length; ++n)
                if (Inputs[n].type == 'checkbox')
                    if (!Inputs[n].disabled) {
                        Inputs[n].checked = CheckBox.checked;
                    }
        }

        function CheckBoxListSelect(cbControl) {
            var chkBoxCount = cbControl.getElementsByTagName("input");
            var cbAll = document.getElementById('<%= this.cbAll.ClientID %>');
            var ListCount = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked) {
                    ListCount++;
                }
            }
            if (ListCount > 0 && ListCount < chkBoxCount.length) {
                cbAll.checked = false;
            }
            else {
                cbAll.checked = true;
            }
        }   
</script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <div style="z-index: 101; left: 484px; width: 100px; position: absolute; top: 236px;
                        height: 100px">
                        <asp:Panel ID="Panel2" runat="server">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                <ProgressTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                        Width="27px" />
                                    Wait Update.......
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </asp:Panel>
                    </div>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table cellpadding="3">                                
                                <tr>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lbltoLocation" runat="server" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                    </td>
                                    <td style="height: 25px; width: 238px;" align="left">
                                        <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label5" runat="server" Text="Sale Force(From)"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="height: 25px; width: 238px;" align="left">
                                        <asp:DropDownList ID="DrpDeliveryMan" runat="server" Width="200px" 
                                            AutoPostBack="True" 
                                            onselectedindexchanged="DrpDeliveryMan_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <strong>
                                            <asp:Label ID="Label2" runat="server" Text="Working Date"></asp:Label>
                                        </strong>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="txtBox" MaxLength="10" Width="150px"></asp:TextBox><asp:ImageButton
                                            ID="ImgBntToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" />
                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" EnableViewState="False"
                                            Format="dd-MMM-yyyy" PopupButtonID="ImgBntToDate" TargetControlID="txtToDate">
                                        </cc1:CalendarExtender>
                                        <br />
                                        <br />
                                        <asp:Button ID="btnGetOrder" OnClick="btnGetOrder_Click" runat="server" 
                                            Font-Size="8pt" Text="Get Orders" CssClass="btn" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:CheckBox ID="cbAll" runat="server" Text="All Orders" onclick="javascript:HeaderClick(this);"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:Panel ID="pnlOrders" runat="server" Height="200" Width="350" ScrollBars="Vertical" style="border: thin solid #000000">
                                            <asp:CheckBoxList ID="cblOrders" runat="server" RepeatDirection="Vertical"></asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" Text="Sale Force(To)"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="height: 25px; width: 238px;" align="left">
                                        <asp:DropDownList ID="DrpDeliveryManTo" runat="server" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">                                        
                                    </td>
                                    <td style="height: 25px; width: 238px;" align="left">
                                        <asp:Button ID="btnShift" OnClick="btnShift_Click" runat="server" Width="100px"
                                            Font-Size="8pt" Text="Shift" CssClass="btn" />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Width="100px"
                                            Font-Size="8pt" Text="Cancel" CssClass="btn" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                </td>
            </tr>
        </table>        
    </div>
</asp:Content>
