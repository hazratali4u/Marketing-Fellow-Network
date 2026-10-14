<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmOrderEntry.aspx.cs" Inherits="Forms_frmOrderEntry" Title="SAMS :: Order/Invoice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">

        function ValidateValue(inputtxt) {
            var decimal = /^[0-9]+(\.[0-9]+)+$/;
            var int = /^[0-9]/;
            var completevalue = inputtxt.value;
            var splitvalues = completevalue.split(".");
            // check for decimal points ans if greater then 1 point stop and turn default values
            if (splitvalues[2] != null) {
                document.getElementById('<%=numTxtTotalHalfScheme.ClientID%>').value = '0.0000';
                return;
            }
            if (inputtxt.value.match(decimal) || inputtxt.value.match(int)) {
                return true;
            }
            else {
                document.getElementById('<%=numTxtTotalHalfScheme.ClientID%>').value = '0.0000';
                this.focus();
            }
        }

        function ValidateForm() {
            var str;
            str = document.getElementById('<%=txtskuName.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Select SKU Name');
                return false;
            }
            str = document.getElementById('<%=txtQuantity.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Enter Quantity');
                return false;
            }

            return true;
        }
        function SearcSKUList(e) {
            var l = document.getElementById('<%= lstCode.ClientID %>');
            var tb = document.getElementById('<%= txtskuCode.ClientID %>');
            if (e.keyCode == 27) {
                document.getElementById("<%= numTxtTotalHalfScheme.ClientID %>").focus();
            }
            else {
                if (tb.value == "") {
                    ClearSelection(l);
                }
                else {
                    for (var i = 0; i < l.options.length; i++) {
                        if (l.options[i].value.toLowerCase().match(tb.value.toLowerCase())) {
                            l.options[i].selected = true;
                            return false;
                        }
                        else {
                            ClearSelection(l);
                        }
                    }
                }
            }
        }
        function SearchList() {
            var l = document.getElementById('<%= ListCustomer.ClientID %>');
            var tb = document.getElementById('<%= txtOutletCode.ClientID %>');
            if (tb.value == "") {
                ClearSelection(l);
            }
            else {
                for (var i = 0; i < l.options.length; i++) {
                    if (l.options[i].value.toLowerCase().match(tb.value.toLowerCase())) {
                        l.options[i].selected = true;
                        return false;
                    }
                    else {
                        ClearSelection(l);
                    }
                }
            }
        }
        function SearchedCode() {
            var str
            var stroption
            var code;
            str = document.getElementById("<%= ListCustomer.ClientID %>").value;            
            stroption = document.getElementById("<%= txtOutletCode.ClientID %>").value;            
            if (str.length > 0) {
                code = str.substring(str.indexOf('| ') + 2)
                code = code.substring(0, code.indexOf('|') - 1);
                document.getElementById("<%= txtOutletCode.ClientID %>").value = 'OT' + code;
                document.getElementById("<%= txtOutletName.ClientID %>").value = str.substring(0, str.indexOf('|'));                
                document.getElementById("<%= Panel1.ClientID %>").className = "hiddencol";

            }
            else if (stroption.length == 0) {
                document.getElementById("<%= Panel1.ClientID %>").className = "Displaycol";
                document.getElementById("<%= ListCustomer.ClientID %>").focus();
            }
            ClearSelection(document.getElementById('<%= ListCustomer.ClientID %>'));

        }
        function SearchSKUCode() {
            var str = document.getElementById("<%= lstCode.ClientID %>").value;
            var stroption = document.getElementById("<%= txtskuCode.ClientID %>").value;

            if (str.length > 0) {
                document.getElementById("<%= txtskuCode.ClientID %>").value = str.substring(0, str.indexOf('-'));
                document.getElementById("<%= txtskuName.ClientID %>").value = str.substring(str.indexOf('-') + 1, str.indexOf(':'));
                document.getElementById("<%= txtUnitRate.ClientID %>").value = str.substring(str.indexOf(':') + 1);
                document.getElementById("<%= Panel3.ClientID %>").className = "hiddencol";

            }
            else if (stroption.length == 0) {
                document.getElementById("<%= Panel3.ClientID %>").className = "Displaycol";
                document.getElementById("<%= lstCode.ClientID %>").focus();
            }
            ClearSelection(document.getElementById('<%= lstCode.ClientID %>'));

        }
        function SelectSkuCode(e) {
            var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
            if (key == 13) {
                e.preventDefault();
                var str = document.getElementById("<%= lstCode.ClientID %>").value;

                document.getElementById("<%= txtskuCode.ClientID %>").value = str.substring(0, str.indexOf('-'));
                document.getElementById("<%= txtskuName.ClientID %>").value = str.substring(str.indexOf('-') + 1, str.indexOf(':'));
                document.getElementById("<%= txtUnitRate.ClientID %>").value = str.substring(str.indexOf(':') + 1);
                document.getElementById("<%= Panel3.ClientID %>").className = "hiddencol";                
                document.getElementById("<%= txtQuantity.ClientID %>").focus();
            }
        }
        function SelectCode(e) {
            var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
            if (key == 13) {
                e.preventDefault();
                var str = document.getElementById("<%= ListCustomer.ClientID %>").value;
                var customerdetail = document.getElementById("<%= ListCustomer.ClientID %>").value.split(' | ');

                document.getElementById("<%= txtOutletCode.ClientID %>").value = 'OT' + customerdetail[1];
                document.getElementById("<%= txtOutletName.ClientID %>").value = customerdetail[0];
                document.getElementById("<%= hfPriceGroup.ClientID %>").value = customerdetail[3];
                document.getElementById("<%= Panel1.ClientID %>").className = "hiddencol";
                document.getElementById("<%=btnDummy.ClientID %>").click();
                document.getElementById("<%= txtskuCode.ClientID %>").focus();
            }
        }
        function ClearSelection(lb) {
            lb.selectedIndex = -1;
        }
 
    </script>
        <script type="text/javascript" language="javascript">
   Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
   function BeginRequestHandler(sender, args) {
       var oControl = args.get_postBackElement();
       if (oControl.value == "Save Order" 
           || oControl.value == "Save Invoice"
           || oControl.value == "Sale Return"
           || oControl.value == "Calculate"
           || oControl.value == "Add Sku") {
           oControl.value = "Wait...";
           oControl.disabled = true;
       }       
   }
</script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <div style="z-index: 101; left: 700px; width: 100px; position: absolute; top: 291px;
                        height: 100px">
                        &nbsp;<asp:Panel ID="Panel21" runat="server">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                        Width="23px" />
                                    Wait Update
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </asp:Panel>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div style="left: 120px; position: absolute; top: 150px;">
                                <asp:Panel ID="Panel1" runat="server" Width="327px" Height="237px" BorderWidth="1px"
                                    BorderStyle="Inset" BorderColor="White" BackColor="Silver" CssClass="hiddencol">
                                    <table style="border-right: #ffffff thin groove; border-top: #ffffff thin groove;
                                        border-left: #ffffff thin groove; width: 99%; border-bottom: #ffffff thin groove">
                                        <tbody>
                                            <tr>
                                                <td style="border-bottom: black thin solid" align="left" colspan="2">
                                                    &nbsp;<strong>Select Customer from List Press Enter</strong>
                                                </td>
                                                <td style="border-bottom: black thin solid" valign="top" align="right">
                                                    <asp:Button AccessKey="S" ID="Button4" runat="server" Width="21px" Height="16px"
                                                        Font-Size="8pt" Text="X" BorderWidth="1px" BorderStyle="Groove"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <asp:ListBox ID="ListCustomer" onkeydown="SelectCode(event)" runat="server" Width="99%"
                                        Height="89%"></asp:ListBox>
                                        <div style="visibility:hidden;">
                                        <asp:Button AccessKey="A" ID="btnDummy" OnClick="btnDummy_Click" runat="server" Width="100px"
                                            Font-Size="8pt" Text="Dummy" ValidationGroup="vg" CssClass="btn"></asp:Button>
                                        </div>
                                </asp:Panel>
                                <div style="left: -100px; position: absolute; top: 70px; height: 248px;">
                                    <asp:Panel ID="Panel3" runat="server" Width="327px" Height="237px" BorderWidth="1px"
                                        BorderStyle="Inset" BorderColor="White" BackColor="Silver" CssClass="hiddencol">
                                        <table style="border-right: #ffffff thin groove; border-top: #ffffff thin groove;
                                            border-left: #ffffff thin groove; width: 99%; border-bottom: #ffffff thin groove">
                                            <tbody>
                                                <tr>
                                                    <td style="border-bottom: black thin solid" align="left" colspan="2">
                                                        &nbsp;<strong>Select SKU from List Press Enter</strong>
                                                    </td>
                                                    <td style="border-bottom: black thin solid" valign="top" align="right">
                                                        <asp:Button ID="Button5" runat="server" AccessKey="S" BorderStyle="Groove" BorderWidth="1px"
                                                            Font-Size="8pt" Height="16px" Text="X" Width="21px" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <asp:ListBox ID="lstCode" onkeydown="SelectSkuCode(event)" runat="server" Width="99%"
                                            Height="89%" SelectionMode="Multiple"></asp:ListBox>
                                    </asp:Panel>
                                    &nbsp;
                                </div>
                            </div>
                            <table>
                                <tr>
                                    <td align="left" valign="top">
                                        <strong>
                                            <label>Transaction No</label></strong>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="drpDocumentNo" runat="server" AutoPostBack="True" CssClass="DropList"
                                            OnSelectedIndexChanged="drpDocumentNo_SelectedIndexChanged" Width="231px">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" colspan="1" valign="top">
                                        <strong>
                                            <asp:Label ID="lblManualTransactionNo" runat="server" Text="Manual Transaction No" ></asp:Label>
                                        </strong>
                                        <asp:TextBox ID="txtManualInvoiceNo" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        <strong>
                                            <label>Transaction Type</label></strong>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:RadioButtonList ID="RblPayMode" runat="server" Height="1px" RepeatDirection="Horizontal"
                                            Width="190px">
                                        </asp:RadioButtonList>
                                    </td>
                                    <td align="left" colspan="1" valign="top">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        <strong>
                                            <label>Route/Saleman</label></strong>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:TextBox ID="txtprincipal" runat="server" CssClass="txtBox " onkeyup="SearchList()"
                                            ReadOnly="True" Width="277px"></asp:TextBox>
                                    </td>
                                    <td align="left" colspan="1" valign="top">
                                        <asp:TextBox ID="txtDeliveryMan" runat="server" CssClass="txtBox " onkeyup="SearchList()"
                                            ReadOnly="True" Width="180px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 23px">
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" CssClass="lblbox" Text="Customer" Width="74px"></asp:Label></strong>
                                    </td>
                                    <td align="left" style="height: 23px">
                                        <asp:TextBox ID="txtOutletCode" runat="server" CssClass="txtBox " onkeydown="SearchList()"
                                            Width="76px"></asp:TextBox>
                                    </td>
                                    <td align="left" style="height: 23px">
                                        <asp:TextBox ID="txtOutletName" runat="server" CssClass="txtBox " onfocus="SearchedCode()"
                                            Width="192px"></asp:TextBox>
                                            <asp:HiddenField ID="hfPriceGroup" runat="server" Value="Default" />
                                    </td>
                                    <td align="left" style="height: 23px">
                                        <asp:TextBox ID="txtDiscountType" runat="server" CssClass="txtBox " onkeyup="SearchList()"
                                            ReadOnly="True" Width="180px">Manual Discount</asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                    </td>
                                    <td align="left" colspan="1" valign="top">
                                    </td>
                                </tr>
                            </table>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Panel5" runat="server" DefaultButton="btnSave">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td style="height: 16px" class="tblhead">
                                                <label style="color: White">
                                                    SKU Code</label>
                                            </td>
                                            <td style="height: 16px" class="tblhead">
                                                <label style="color: White">
                                                    SKU Name</label>
                                            </td>
                                            <td style="height: 16px" class="tblhead">
                                                <label style="color: White">
                                                    Quantity</label>
                                            </td>
                                            <td style="height: 16px" class="tblhead">
                                                <label style="color: White">
                                                    Unit Price</label>
                                            </td>
                                            <td style="height: 16px" align="center" class="tblhead">
                                                <label style="color: White">
                                                    Disc(%)</label>
                                            </td>
                                            <td style="height: 16px" class="tblhead">
                                                <label style="color: White">
                                                    Amount</label>
                                            </td>
                                            <td style="height: 16px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtskuCode" onkeydown="SearcSKUList(event)" runat="server" Width="78px"
                                                    CssClass="txtBox"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtskuName" runat="server" Width="191px" Font-Bold="True" CssClass="txtBox"
                                                    Enabled="False"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQuantity" onfocus="SearchSKUCode()" runat="server" Width="65px"
                                                    CssClass="txtBox "></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUnitRate" runat="server" Width="66px" CssClass="txtBox" Enabled="False"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtBatchNo" runat="server" Visible="false"></asp:TextBox>
                                                <asp:TextBox ID="txtDiscount" runat="server" Width="62px" CssClass="txtBox "></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender runat="server" TargetControlID="txtDiscount"
                                                    ValidChars=".0123456789">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TextBox1" onfocus="SearchSKUCode()" runat="server" Width="72px"
                                                    CssClass="txtBoxnNum" Enabled="False"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button AccessKey="A" ID="btnSave" OnClick="btnSave_Click" runat="server" Width="100px"
                                                    Font-Size="8pt" Text="Add Sku" ValidationGroup="vg" CssClass="btn"></asp:Button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="7">
                                                <asp:Panel ID="Panel2" runat="server" Width="680px" Height="130px" ScrollBars="Vertical"
                                                    BorderColor="Silver" BorderStyle="Groove" BorderWidth="1px">
                                                    <asp:GridView ID="GrdPurchase" Width="100%" runat="server" ForeColor="SteelBlue"
                                                        CssClass="gridRow2" BackColor="White" HorizontalAlign="Center" AutoGenerateColumns="False"
                                                        BorderColor="White" ShowHeader="False" OnRowDeleting="GrdPurchase_RowDeleting"
                                                        OnRowEditing="GrdPurchase_RowEditing">
                                                        <RowStyle ForeColor="Black"></RowStyle>
                                                        <Columns>
                                                            <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_CODE" HeaderText="SKU Code">
                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                    Width="75px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_NAME" HeaderText="SKU Name">
                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                    Width="204px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="QUANTITY_UNIT" HeaderText="Quantity">
                                                                <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                    Width="68px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="UNIT_PRICE" HeaderText="PRICE" DataFormatString="{0:F2}">
                                                                <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                    Width="70px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="STANDARD_DISCOUNT" HeaderText="Batch No" DataFormatString="{0:F2}">
                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}">
                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right"
                                                                    Width="80px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="QUANTITY_CTN" HeaderText="QUANTITY_CTN">
                                                                <HeaderStyle CssClass="hiddencol" />
                                                                <ItemStyle CssClass="hiddencol" />
                                                            </asp:BoundField>
                                                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" Width="30px" HorizontalAlign="Center">
                                                                </ItemStyle>
                                                            </asp:CommandField>
                                                            <asp:TemplateField HeaderText="Delete">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                        CommandName="Delete"></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle BorderColor="Silver" HorizontalAlign="Center" BorderWidth="1px" BorderStyle="Solid"
                                                                    Width="45px"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                                                        <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333">
                                                        </AlternatingRowStyle>
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td style="height: 226px">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td valign="top" align="left" colspan="2" rowspan="6">
                                            <strong>
                                                <asp:Label ID="Label10" runat="server" Width="60px" Text="Free SKU" CssClass="lblbox"></asp:Label></strong><asp:Panel
                                                    ID="Panel4" runat="server" Width="350px" Height="100px" BorderColor="Silver"
                                                    BorderStyle="Groove" BorderWidth="1px">
                                                    <asp:GridView ID="GrdFreeSKU" runat="server" Width="100%" ForeColor="Silver" CssClass="gridRow2"
                                                        BorderColor="White" BackColor="White" AutoGenerateColumns="False" HorizontalAlign="Center">
                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                            PreviousPageText="Previous"></PagerSettings>
                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                                                        </RowStyle>
                                                        <Columns>
                                                            <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_Code" HeaderText="SKU Code">
                                                                <ItemStyle Width="80px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_Name" HeaderText="SKU Name">
                                                                <ItemStyle Width="200px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Quantity" HeaderText="Qty">
                                                                <ItemStyle Width="50px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                        <HeaderStyle BackColor="Silver" BorderColor="Black" BorderWidth="1px" BorderStyle="Solid"
                                                            ForeColor="Black"></HeaderStyle>
                                                    </asp:GridView>
                                                </asp:Panel>
                                        </td>
                                        <td style="height: 20px" align="left">
                                        </td>
                                        <td style="height: 20px; width:135px" align="left">
                                            <strong>
                                                <label>Gross Sale</label></strong>
                                        </td>
                                        <td style="width: 7px; height: 20px">
                                            <asp:TextBox ID="txtGrossAmount" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <%--<strong >
                                                <label>Principal Discount</label></strong>--%>
                                        </td>
                                        <td style="width: 7px">
                                            <%--<asp:TextBox ID="numtxtTotalExtraDiscnt" runat="server" Width="150px" ForeColor="Black"
                                                Font-Bold="True" CssClass="txtBoxnNum" ReadOnly="True">0.00</asp:TextBox>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 18px" align="left">
                                        </td>
                                        <td style="height: 18px" align="left">
                                            <strong>
                                                <label>Distributor Discount</label></strong>
                                        </td>
                                        <td style="width: 7px; height: 18px">
                                            <asp:TextBox ID="numTxtTotalStndrdDiscnt" runat="server" Width="150px" ForeColor="Black"
                                                Font-Bold="True" CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td style="height: 18px" align="left">
                                        </td>
                                        <td style="height: 18px" align="left">
                                            <strong>
                                                <asp:Label ID="lblHalfScheme" runat="server" Width="110px" Text="Half Scheme" Visible="false"></asp:Label></strong>
                                        </td>
                                        <td style="width: 7px; height: 18px">
                                            <asp:TextBox onblur="ValidateValue(this)" ID="numTxtTotalHalfScheme" runat="server"
                                                Width="150px" Visible="false" ForeColor="Black" Font-Bold="True" CssClass="txtBoxnNum"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 20px" valign="top">
                                        </td>
                                        <td style="width: 1px; height: 20px" align="left">
                                            <strong>
                                                <asp:Label ID="Label81" runat="server" Width="93px" Text="GST Amount" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 7px; height: 20px" align="right">
                                            <asp:TextBox ID="numTxtTotalGST" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 20px" valign="top">
                                        </td>
                                        <td style="width: 1px; height: 20px" align="left">
                                            <strong>
                                                <asp:Label ID="Label91" runat="server" Width="105px" Text="Net Amount" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 7px; height: 20px" align="right">
                                            <asp:TextBox ID="numTxtTotlAmnt" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="2">
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td style="width: 100px; height: 21px">
                                                            <asp:Button AccessKey="C" ID="btnCalculate" TabIndex="100" OnClick="btnCalculate_Click"
                                                                runat="server" Width="100px" Font-Size="8pt" Text="Calculate" Enabled="False"
                                                                CssClass="btn"></asp:Button>
                                                        </td>
                                                        <td style="width: 100px; height: 21px">
                                                            <asp:Button AccessKey="S" ID="btnSaveOrder" TabIndex="101" OnClick="btnSaveOrder_Click"
                                                                runat="server" Width="110px" Font-Size="8pt" Text="Save Order" Enabled="False"
                                                                CssClass="btn"></asp:Button>
                                                        </td>
                                                        <td style="width: 100px; height: 21px">
                                                            <asp:Button AccessKey="H" ID="btnCancel" TabIndex="102" OnClick="Button2_Click" runat="server"
                                                                Width="110px" Font-Size="8pt" Text="Home" CssClass="btn"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td style="width: 1px" valign="top" align="left">
                                            &nbsp; &nbsp; &nbsp;&nbsp;
                                        </td>
                                        <td style="width: 1px" align="left">
                                            <strong>
                                                <asp:Label ID="Label5" runat="server" Width="105px" Text="Cash Received" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 7px" align="right">
                                            <asp:TextBox ID="txtCashReceived" runat="server" Width="150px" ForeColor="Black"
                                                Font-Bold="True" CssClass="txtBoxnNum" Enabled="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                TargetControlID="numTxtTotalHalfScheme" ValidChars="0123456789.">
                            </ajaxToolkit:FilteredTextBoxExtender>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
