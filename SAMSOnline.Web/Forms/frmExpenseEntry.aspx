<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmExpenseEntry.aspx.cs" Inherits="Forms_frmExpenseEntry" Title="SAMS :: Petty Expense Entry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">    
      <script language="JavaScript" type="text/javascript">
    
    function ValidateForm()
    {
        var str;
        str  =  document.getElementById("<%= txtAmount.ClientID %>").value;
        if(str == null || str.length == 0)
		{
			alert('Must enter Amount');
			return false;
		}
		
    }
  </script>
    <script type="text/javascript" language="javascript">
   Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
   function BeginRequestHandler(sender, args) {
       var oControl = args.get_postBackElement();
       if (oControl.value == "Save"
           || oControl.value == "Add") {
           oControl.value = "Wait...";
           oControl.disabled = true;
       }       
   }
</script>
    <div id="right_data">
    <div style="z-index: 101; left: 377px; width: 100px; position: absolute; top: 137px;
                        height: 83px">
                        &nbsp;<asp:Panel ID="Panel21" runat="server">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel3">
                                <ProgressTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                        Width="23px" />
                                    Wait Update
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </asp:Panel>
                    </div>
        <table width="100%">
            <tr>                
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom"
                                 TargetControlID="txtAmount" ValidChars="0123456789.">
                            </cc1:FilteredTextBoxExtender>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAddNew">
                            <table>
                                <tr>
                                    <td style="height: 20px;" align="left">
            <strong> <asp:Label id="Label2" runat="server" Width="65px" Text="Voucher No" CssClass="lblbox"></asp:Label></strong></td>
                                    <td style="width: 100px">
            <asp:DropDownList id="DrpVoucherNo" runat="server" Width="250px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpVoucherNo_SelectedIndexChanged"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 20px">
                                        <strong><asp:Label ID="lblfromLocation" runat="server" CssClass="lblbox" Text="Location"
                                            Width="65px"></asp:Label></strong></td>
                                    <td style="width: 100px"><asp:DropDownList id="drpDistributor" runat="server" Width="250px" CssClass="DropList">
                                    </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td style="height: 20px;" align="left">
            <strong><asp:Label ID="Label8" runat="server" CssClass="lblbox" Text="Principal" Width="68px"></asp:Label></strong></td>
                                    <td style="width: 100px">
            <asp:DropDownList id="DrpPrincipal" runat="server" Width="250px" CssClass="DropList">
            </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 20px">
                                        <strong><asp:Label ID="Label3" runat="server" CssClass="lblbox" Text="Account Type" Width="82px"></asp:Label></strong></td>
                                    <td style="width: 100px">
                                        <asp:DropDownList id="DrpMasterHead" runat="server" Width="250px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpMasterHead_SelectedIndexChanged">
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 20px">
            <strong><asp:Label id="Label1" runat="server" Width="82px" Text="Account Head" CssClass="lblbox"></asp:Label></strong></td>
                                    <td style="width: 100px">
            <asp:DropDownList id="DrpAccountHead" runat="server" Width="250px" CssClass="DropList">
</asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 20px">
            <strong><asp:Label ID="Label9" runat="server" CssClass="lblbox" Text="Remarks" Width="71px"></asp:Label></strong></td>
                                    <td align="left" style="height: 20px">
            <asp:TextBox ID="txtRemarks" runat="server" CssClass="txtBox " Width="243px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 20px">
            <strong><asp:Label id="Label6" runat="server" Width="63px" Text="Amount" CssClass="lblbox"></asp:Label></strong></td>
                                    <td align="left" style="height: 20px">
            <asp:TextBox id="txtAmount" runat="server" Width="107px" CssClass="txtBox "></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px" align="left">
            </td>
                                    <td align="left" colspan="1" style="height: 20px">
            <asp:Button CssClass="btn" ID="btnAddNew" runat="server" AccessKey="S" Font-Size="8pt" OnClick="btnAddNew_Click"
                Text="Add" Width="95px" /></td>
                                </tr>
                            </table>
                            </asp:Panel>
                            &nbsp;&nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <strong><asp:Label ID="lblRowId" runat="server" Text="Label" Visible="False"></asp:Label></strong>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table width="100%">
        <tr>
            <td>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                                <asp:Panel ID="Panel12" runat="server" Height="136px" ScrollBars="Vertical" Width="620px" BorderColor="Gray" BorderStyle="Groove" BorderWidth="1px">
                                   <asp:GridView ID="GrdOrder" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="White" CaptionAlign="Left" CssClass="gridRow2" ForeColor="SteelBlue"
                                        HorizontalAlign="Center" OnRowDeleting="GrdOrder_RowDeleting"
                                        OnRowEditing="GrdOrder_RowEditing" Width="600px">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <RowStyle ForeColor="Black" />
                                        <Columns>
                                            <asp:BoundField DataField="Account_Head_Id" HeaderText="Account Head Id">
                                                <FooterStyle CssClass="hiddencol" />
                                                <HeaderStyle CssClass="hiddencol" />
                                                <ItemStyle CssClass="hiddencol" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Account_Name" HeaderText="Account Head">
                                                <FooterStyle CssClass="hiddencol" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                                                <FooterStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="debit" DataFormatString="{0:F2}" FooterText="Total" HeaderText="Amount">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:CommandField HeaderText="Edit" ShowEditButton="True">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="47px" />
                                            </asp:CommandField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                        Text="Delete"></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="46px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="White" />
                                        <PagerStyle BackColor="Transparent" />
                                        <HeaderStyle  CssClass="tblhead" />
                                        <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333" />
                                    </asp:GridView> 
                                </asp:Panel>
                <asp:Button CssClass="btn" ID="btnSave" runat="server" Font-Size="8pt" OnClick="btnSave_Click" Text="Save"
                    Width="117px" />
                <strong><asp:Label ID="Label61" runat="server" CssClass="lblbox" Text="Amount" Width="63px"></asp:Label></strong>
                <asp:TextBox ID="txtMainCash" runat="server" CssClass="txtBox " ReadOnly="True"></asp:TextBox>&nbsp;
                                
            </ContentTemplate>
        </asp:UpdatePanel>
             </td>        
        </tr>
    </table>
    </div>
    
   
</asp:Content>
