<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmOpeingCredit.aspx.cs" Inherits="Forms_frmOpeingCredit" Title="SAMS :: Opening Credit" %>
<%@ Register Assembly="AjaxControlToolkit"   Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
   
      <script language="JavaScript" type="text/javascript">
    
    function ValidateForm()
    {
        var str;
        str  =  document.getElementById("<%= txtOutletCode.ClientID %>").value;
        if(str == null || str.length == 0)
		{
			alert('Must enter Outlet Code');
			return false;
		}
		str  =  document.getElementById("<%= txtOutletName.ClientID %>").value;
        if(str == null || str.length == 0)
		{
			alert('Must enter Outlet Code');
			return false;
		}
		str  =  document.getElementById("<%= txtAmount.ClientID %>").value;
		if(str == null || str.length == 0)
		{
			alert('Must Enter Amount');
			return false;
		}
		str  =  document.getElementById("<%= txtFromdate.ClientID %>").value;
		if(str == null || str.length <= 1)
		{
			alert('Must Enter Invoice Date');
			return false;
		}
		str  =  document.getElementById("<%= txtChequeNo.ClientID %>").value;
		if(str == null || str.length <= 1)
		{
			alert('Must Enter Invoice No');
			return false;
		}
    }
 function SearchList()
 {
     var l =  document.getElementById('<%= ListCustomer.ClientID %>');
     var tb = document.getElementById('<%= txtOutletCode.ClientID %>');
        
            if(tb.value == "")
            {
                ClearSelection(l);
            }
            else
            {
                for (var i=0; i < l.options.length; i++)
                {
                    if (l.options[i].value.toLowerCase().match(tb.value.toLowerCase()))
                    {
                        l.options[i].selected = true;
                        return false;
                    }
                    else
                    {
                        ClearSelection(l);
                    }
                }
           }
 }
 function SearchedCode()
 {
    var code;
    var str  = document.getElementById("<%= ListCustomer.ClientID %>").value;
    var stroption  = document.getElementById("<%= txtOutletCode.ClientID %>").value;
     if(str.length > 0)
     {      
        code =  str.substring(str.indexOf('| ') + 2);
        code = code.substring(0,code.indexOf('|')-1);
        document.getElementById("<%= txtOutletCode.ClientID %>").value =  'OT' + code;
        document.getElementById("<%= txtOutletName.ClientID %>").value =  str.substring(0,str.indexOf('|'));
                
     }
     ClearSelection(document.getElementById('<%= ListCustomer.ClientID %>'));
    
 }
 function SelectCode(e)
 {
      if(e.keyCode == 13)
      {
        var code ;
        var str  = document.getElementById("<%= ListCustomer.ClientID %>").value;
        code =  str.substring(str.indexOf('| ') + 2);
        code = code.substring(0,code.indexOf('|')-1);
        document.getElementById("<%= txtOutletCode.ClientID %>").value =  'OT' + code;
        document.getElementById("<%= txtOutletName.ClientID %>").value =  str.substring(0,str.indexOf('|'));
        document.getElementById("<%= txtChequeNo.ClientID %>").focus();
      }
 }
 function ClearSelection(lb)
 {
    lb.selectedIndex = -1;
 } 
  </script>
    <script type="text/javascript" language="javascript">
   Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
   function BeginRequestHandler(sender, args) {
       var oControl = args.get_postBackElement();
       if (oControl.value == "Save") {
           oControl.value = "Wait...";
           oControl.disabled = true;
       }       
   }
</script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel id="UpdatePanel2" runat="server" RenderMode="Inline">
                        <contenttemplate>
<TABLE><TBODY><TR><TD align=left colSpan=2>
<strong> <asp:Label id="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong> </TD>
    <td align="left" colspan="1" style="width: 201px">
    </td>
    <td align="left" colspan="1">
    </td>
</TR>
    <tr>
        <td align="left">
            <strong><asp:Label ID="Label8" runat="server" CssClass="lblbox" Text="Principal" Width="89px"></asp:Label></strong></td>
        <td align="left">
            <asp:DropDownList id="DrpPrincipal" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpPrincipal_SelectedIndexChanged">
            </asp:DropDownList></td>
        <td align="left" style="width: 201px">
        </td>
        <td align="left">
        <asp:DropDownList id="DrpRoute" runat="server" Width="250px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged"></asp:DropDownList></td>
    </tr>
    <TR><TD align=left>
            <strong><asp:Label id="lblfromLocation" runat="server" Width="94px" Text="Distributor" CssClass="lblbox"></asp:Label></strong></TD><TD align=left>
            <asp:DropDownList id="drpDistributor" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD>
    <td align="left" style="width: 201px">
        <strong><asp:Label id="lblDocumentNo" runat="server" Width="32px" Text="" CssClass="lblbox"></asp:Label></strong></td>
    <td align="left" rowspan="10">
        <asp:ListBox id="ListCustomer" onkeyup="SelectCode(event)" runat="server" Width="250px" Height="210px" CssClass="DropList"></asp:ListBox></td>
</TR>
    <tr>
        <td align="left">
    <strong><asp:Label ID="Label2" runat="server" CssClass="lblbox" Text="Sale Force" Width="89px"></asp:Label></strong></td>
        <td style="height: 13px">
            <asp:DropDownList id="DrpDeliveryMan" runat="server" Width="200px" CssClass="DropList">
    </asp:DropDownList></td>
        <td align="left" style="height: 13px">
        </td>
    </tr>
    <tr>
        <td align="left">
    <strong><asp:Label ID="Label1" runat="server" CssClass="lblbox" Text="Bill Date" Width="89px"></asp:Label></strong></td>
        <td>
    <asp:TextBox ID="txtFromdate" runat="server" CssClass="txtBox" onkeyup="BlockFromDateKeyPress()"
        Style="text-align: justify" Width="192px" MaxLength="1"></asp:TextBox></td>
        <td align="left">
        <asp:ImageButton ID="ImgBntFromCalc" runat="server" CausesValidation="False" ImageUrl="~/App_Themes/Granite/Images/date.gif" /></td>
    </tr>
    <tr>
        <td align="left" valign="bottom">
            <strong><asp:Label id="Label4" runat="server" Width="94px" Text="Customer Code" CssClass="lblbox"></asp:Label></strong></td>
        <td align="left" valign="bottom">
            <strong><asp:Label id="Label3" runat="server" Width="94px" Text="Customer Name" CssClass="lblbox"></asp:Label></strong></td>
        <td align="left" valign="bottom">
        </td>
    </tr>
    <TR><TD align=left valign="top"><asp:TextBox id="txtOutletCode" onkeyup="SearchList()" runat="server" Width="112px" CssClass="txtBox "></asp:TextBox></TD><TD vAlign=top><asp:TextBox id="txtOutletName" runat="server" Width="193px" ForeColor="Black" Font-Bold="True" CssClass="txtBox " Enabled="False"></asp:TextBox></TD>
        <td valign="top">
        </td>
    </TR><TR><TD align=left>
    <strong><asp:Label id="Label5" runat="server" Width="94px" Text="Invoice No" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 201px" vAlign=top align=left>
    <strong><asp:Label id="Label6" runat="server" Width="74px" Text="Amount" CssClass="lblbox"></asp:Label></strong> </TD>
        <td align="left" valign="top">
        </td>
    </TR><TR><TD align=left valign="top"><asp:TextBox id="txtChequeNo" onfocus="SearchedCode()" runat="server" Width="112px" CssClass="txtBox"></asp:TextBox></TD><TD vAlign=top align=left><asp:TextBox id="txtAmount" runat="server" Width="118px" CssClass="txtBox "></asp:TextBox></TD>
        <td align="left" valign="top">
            &nbsp;</td>
    </TR>
    <tr>
        <td align="left" valign="top">
            <strong><asp:Label ID="Label9" runat="server" CssClass="lblbox" Text="Remarks" Width="73px"></asp:Label></strong></td>
        <td align="left" valign="top">
        </td>
        <td align="left" valign="top">
        </td>
    </tr>
    <tr>
        <td align="left" colspan="2" valign="top" style="height: 22px">
            <asp:TextBox ID="txtRemarks" runat="server" CssClass="txtBox " Width="239px"></asp:TextBox></td>
        <td align="left" valign="top" style="height: 22px">
        </td>
    </tr>
    <tr>
        <td align="left" colspan="2">
            </td>
        <td align="left" colspan="1">
        </td>
    </tr>
    <TR><TD style="HEIGHT: 36px" align=left>
    <asp:Button accessKey="S" id="Button1" onclick="Button1_Click" runat="server" Width="119px" Font-Size="8pt" Text="Save" CssClass="btn" /> </TD><TD style="WIDTH: 201px; HEIGHT: 36px" vAlign=middle align=left>
    <asp:Button accessKey="C" id="Button2" runat="server" Width="120px" Font-Size="8pt" Text="Cancel" OnClick="Button2_Click" CssClass="btn" /> </TD>
        <td align="left" style="width: 201px; height: 36px" valign="middle">
        </td>
        <td align="left" style="width: 201px; height: 36px" valign="middle">
        </td>
    </TR></TBODY></TABLE><ajaxToolkit:FilteredTextBoxExtender id="FilteredTextBoxExtender1" runat="server" FilterType="Custom" ValidChars ="0123456789."  TargetControlID="txtAmount"></ajaxToolkit:FilteredTextBoxExtender> 
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd-MMM-yyyy"
                                PopupButtonID="ImgBntFromCalc" TargetControlID="txtFromdate">
                            </ajaxToolkit:CalendarExtender>
                            &nbsp;
</contenttemplate>
                        <triggers>
<asp:AsyncPostBackTrigger ControlID="DrpRoute" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
</triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table style="border-right: silver thin inset; border-top: silver thin inset; border-left: silver thin inset;
                    width: 650px; border-bottom: silver thin inset">
                    <tbody>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel12" runat="server" Height="200px" ScrollBars="Vertical" Width="750px">
                                    <asp:GridView ID="GrdOrder" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="White" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center"
                                        Width="728px">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <RowStyle ForeColor="Black" />
                                        <Columns>
                                            <asp:BoundField DataField="CUSTOMER_ID" HeaderText="CUSTOMER_ID">
                                                <HeaderStyle CssClass="hiddencol" />
                                                <ItemStyle CssClass="hiddencol" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PRINCIPAL_ID" HeaderText="PRINCIPAL_ID">
                                                <HeaderStyle CssClass="hiddencol" />
                                                <ItemStyle CssClass="hiddencol" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SKU_HIE_NAME" HeaderText="Principal">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Customer">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DOCUMENT_DATE" HeaderText="Invoice Date">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SALE_INVOICE_ID" HeaderText="Invoice No">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CURRENT_CREDIT_AMOUNT" HeaderText="Credit Amount">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" />
                                        <PagerStyle BackColor="Transparent" />
                                        <HeaderStyle CssClass="tblhead" />
                                        <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333" />
                                    </asp:GridView>
                                </asp:Panel>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>





