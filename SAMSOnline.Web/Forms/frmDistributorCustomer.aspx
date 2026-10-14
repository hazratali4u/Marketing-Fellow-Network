<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmDistributorCustomer.aspx.cs" Inherits="Forms_frmDistributorCustomer"
    Title="SAMS ::  New Customer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript" src="../JSLibrary/jquery-1.6.1.min.js"></script>
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {
            var str;
            str = document.getElementById('<%=txtCustomerName.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Customer Name');
                return false;
            }
            str = document.getElementById('<%=txtContactPerson.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Contact Person Name');
                return false;
            }
            str = document.getElementById('<%=txtAddress.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Address');
                return false;
            }

            str = document.getElementById('<%=txtPhoneNo.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Phone No');
                return false;
            }
            str = document.getElementById('<%=txtRegdate.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Register Date');
                return false;
            }
            return true;
        }
        function SearchRecord() {
            var str;
            str = document.getElementById('<%=txtSeach.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Key Word for Searching');
                return false;
            }
            return true;
        }

        function pageLoad() {
          
            debugger;
            var $checkBoxAll = $('[id$="cbAllPromotion"]'); // assign main checkbox into a variable
            var $ChkBoxlst = $("table.checkboxlst input:checkbox"); // assign all checkboxes in to a variable
            $checkBoxAll.click(function () { // trigger click event when main checkbox will be clicked
                $ChkBoxlst
                .attr('checked', $checkBoxAll // attr() method checks all checkboxes
                .is(':checked'));
            });
            $ChkBoxlst.click( // trigger an event click
            function (e) {
                if (!$(this)[0].checked) { // check if all checkboxes is checked
                    $checkBoxAll.attr("checked", false); // un check the all checkbxes using attr() method, passing false as a second parameter
                }
            });

        }
      
    </script>
    <div id="right_data">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table width="100%" cellspacing="10px">
                    <tr>
                        <td colspan="5">
                            <strong>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblLocation" runat="server" Text="Location"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="DrpDistributor" runat="server" Width="205px" 
                                OnSelectedIndexChanged="DrpDistributor_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblTown" runat="server" Width="56px" Text="Town"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="DrpTown" runat="server" Width="205px"
                                OnSelectedIndexChanged="DrpTown_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 30%">

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblRoute" runat="server" Text="Route"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="DrpRoute" runat="server" Width="205px"
                                OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblMarket" runat="server" Text="Market"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="DrpMarket" runat="server" Width="206px">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 30%">

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblChannel" runat="server" Text="Channel Type"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="drpChannelType" runat="server" Width="205px">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblBusiness" runat="server" Text="Business Type"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="DrpBusinessType" runat="server" Width="206px">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 30%">

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtCustomerName" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            <asp:CheckBox ID="ChbIsRegister" runat="server" Text="Is Register" 
                                OnCheckedChanged="ChbIsRegister_CheckedChanged" AutoPostBack="True"></asp:CheckBox>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtIsRegister" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                        </td>
                        <td style="width: 25%">
                            <strong>
                                <asp:Label ID="lblGST" runat="server" Text="GST" Visible="false"></asp:Label>
                            </strong>
                            <asp:TextBox ID="txtGST" runat="server" Width="50px" Text="0"
                                Visible="false"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                TargetControlID="txtGST" ValidChars="0123456789.">
                            </ajaxToolkit:FilteredTextBoxExtender>
                            <strong>
                                <asp:Label ID="lblTax" runat="server" Text="Fur. Tax" Visible="false"></asp:Label>
                            </strong>
                            <asp:TextBox ID="txtTax" runat="server" Width="50px" Visible="false"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="ftbTax" runat="server"
                                TargetControlID="txtTax" ValidChars="0123456789.">
                            </ajaxToolkit:FilteredTextBoxExtender>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtAddress" runat="server" Width="200px" MaxLength="255"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblRegisterDate" runat="server" Text="Register Date"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtRegdate" runat="server" Width="200px" ReadOnly="True"></asp:TextBox>
                        </td>
                        <td style="width: 30%">
                         
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 12%">
                            <strong>
                                <asp:Label ID="lblContact" runat="server" Text="Contact Person"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtContactPerson" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblPhone" runat="server" Text="Phone No"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtPhoneNo" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 28%">
                         
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 12%">
                            <strong>
                                <asp:Label ID="lblNTN" runat="server" Text="NTN"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtemail" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblPrice" runat="server" Text="Price Group"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="drpPriceGroup" runat="server" Width="206px">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 28%">
                         
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 12%">
                            <strong>
                                <asp:Label ID="Label1" runat="server" Text="CNIC"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtCnic" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            
                        </td>
                        <td style="width: 25%">
                          
                        </td>
                        <td style="width: 28%">
                         
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="width: 12%">
                            <strong>
                                <asp:Label ID="lblPromotion" runat="server" Text="Promotion Class"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 25%">
                            <strong>
                                <asp:CheckBox ID="cbAllPromotion" runat="server" Text="Promotion Class" BorderColor="Silver" BorderWidth="1" />
                            </strong>
                            <asp:Panel ID="pnlPromotion" runat="server" Width="90%" Height="110px" ScrollBars="Vertical"
                                BorderStyle="Groove" BorderWidth="1px">
                                <asp:CheckBoxList ID="cblPromotion" runat="server" Width="100%" CssClass="checkboxlst">
                                </asp:CheckBoxList>
                            </asp:Panel>
                        </td>
                        <td style="width: 10%">
                            <strong>
                                <asp:Label ID="lblCredit" runat="server" Text="Credit Limit"></asp:Label>
                            </strong>
                        </td>
                        <td style="width: 30%">
                            <asp:Panel ID="Panel1" runat="server" Width="100%" Height="115px" ScrollBars="Vertical"
                                                BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                                                <asp:GridView ID="GrdCreditLimit" runat="server" Width="100%" ForeColor="Silver"
                                                    CssClass="gridRow2" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="White">
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                        PreviousPageText="Previous"></PagerSettings>
                                                    <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black"></RowStyle>
                                                    <Columns>
                                                        <asp:BoundField DataField="Company_Id" HeaderText="Company_Id">
                                                            <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                                            <ItemStyle CssClass="hiddencol"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Company_Name" HeaderText="Principal">
                                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Credit Limit">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtCreditLimit" runat="server" Width="83px" CssClass="txtBox"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="100px"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Credit Days">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtCreditDays" runat="server" CssClass="txtBox " Width="49px"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White"></FooterStyle>
                                                    <PagerStyle BackColor="Transparent"></PagerStyle>
                                                    <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                                </asp:GridView>
                                            </asp:Panel>
                        </td>
                        <td style="width: 23%"></td>
                    </tr>
                    <tr>
                        <td style="width: 12%">
                            
                        </td>
                        <td style="width: 25%">
                            <asp:CheckBox ID="chkIsActive" runat="server" Width="93px" Text="IsActive" Checked="True"></asp:CheckBox>
                        </td>
                        <td style="width: 10%">
                            
                        </td>
                        <td style="width: 30%">
                            
                        </td>
                        <td style="width: 23%"></td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td>

                            <table>
                                <tbody>
                                    <tr>
                                        <td style="width: 143px" align="left"></td>
                                        <td style="width: 175px">
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Width="80px" Font-Size="8pt"
                                                Text="Save" ValidationGroup="vg" CssClass="btn" />&nbsp;
                                            <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Width="80px" Font-Size="8pt"
                                                Text="Cancel" CssClass="btn" />
                                        </td>
                                        <td style="width: 1px"></td>
                                        <td></td>
                                        <td style="width: 219px"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div style="z-index: 101; left: 790px; width: 100px; position: absolute; top: 250px; height: 100px">
                                &nbsp;<asp:Panel ID="Panel21" runat="server">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                                        <ProgressTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                                Width="23px" />
                                            Wait Update
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </asp:Panel>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table style="border-right: silver thin inset; border-top: silver thin inset; border-left: silver thin inset; width: 100%; border-bottom: silver thin inset; background-color: silver">
                    <tbody>
                        <tr>
                            <td style="height: 21px" align="left">
                                <strong>
                                    <asp:Label ID="Label10" runat="server" Width="153px" Text="Select Searching Type"></asp:Label></strong>
                            </td>
                            <td style="width: 170px; height: 21px" align="left">
                                <asp:DropDownList ID="ddSearchType" runat="server" Width="200px" CssClass="DropList">
                                    <asp:ListItem Value="CUSTOMER_CODE">Customer Code</asp:ListItem>
                                    <asp:ListItem Value="CUSTOMER_NAME">Customer Name</asp:ListItem>
                                    <asp:ListItem Value="CONTACT_PERSON">Contact Person</asp:ListItem>
                                    <asp:ListItem Value="CONTACT_NUMBER">Contact Number</asp:ListItem>
                                    <asp:ListItem Value="ADDRESS">Address</asp:ListItem>
                                    <asp:ListItem Value="EMAIL_ADDRESS">Email Address</asp:ListItem>
                                    <asp:ListItem Value="GEO_NAME">Town Name</asp:ListItem>
                                    <asp:ListItem Value="AREA_NAME">Route Name</asp:ListItem>
                                    <asp:ListItem Value="ROUTE_NAME">Market Name</asp:ListItem>
                                    <asp:ListItem Value="SLASH_DESC">Channel Type</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="width: 224px; height: 21px" align="left">
                                <asp:TextBox ID="txtSeach" runat="server" Width="200px" CssClass="txtBox "></asp:TextBox>
                            </td>
                            <td style="height: 21px" align="left" width="250">
                                <asp:Button ID="Button2" OnClick="Button2_Click" runat="server" Width="85px" Font-Size="8pt"
                                    Text="Filter" CssClass="btn" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:Panel ID="Panel2" runat="server" Height="200px" ScrollBars="Vertical" Width="100%">
                    <asp:GridView ID="Grid_users" runat="server" Width="99%" ForeColor="SteelBlue" CssClass="gridRow2"
                        OnRowEditing="Grid_users_RowEditing" BorderColor="White" BackColor="White" AutoGenerateColumns="False"
                        HorizontalAlign="Center">
                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                            PreviousPageText="Previous"></PagerSettings>
                        <RowStyle ForeColor="Black"></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="CUSTOMER_ID" HeaderText="Customer Id">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="DISTRIBUTOR_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="BUSINESS_TYPE_ID" HeaderText="BUSINESS_TYPE_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="PROMOTION_CLASS" HeaderText="PROMOTION_CLASS">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CHANNEL_TYPE_ID" HeaderText="CHANNEL_TYPE_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="TOWN_ID" HeaderText="TOWN_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="AREA_ID" HeaderText="AREA_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ROUTE_ID" HeaderText="ROUTE_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CUSTOMER_CODE" HeaderText="Code">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Name">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CONTACT_PERSON" HeaderText="Contact Person">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CONTACT_NUMBER" HeaderText="Contact Number">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="EMAIL_ADDRESS" HeaderText="Email">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ADDRESS" HeaderText="ADDRESS">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="GST_NUMBER" HeaderText="Gst No">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ChannelType" HeaderText="Channel Type">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="GEO_NAME" HeaderText="Town">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="AREA_NAME" HeaderText="Route">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ROUTE_NAME" HeaderText="Market">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="REGDATE">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="GST">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="PRICE_GROUP">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="FURTHER_TAX">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                              <asp:BoundField DataField="CNIC">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:CommandField>
                        </Columns>
                        <FooterStyle BackColor="White"></FooterStyle>
                        <PagerStyle BackColor="Transparent"></PagerStyle>
                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                        <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333"></AlternatingRowStyle>
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>