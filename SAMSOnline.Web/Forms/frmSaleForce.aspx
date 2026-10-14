<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmSaleForce.aspx.cs" Inherits="Forms_frmSaleForce" Title="SAMS :: Employee Information" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {
            var str;
            str = document.getElementById('<%=txtUserName.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter User Name');
                return false;
            }
            str = document.getElementById('<%=txtNICNo.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter NIC No');
                return false;
            }
            str = document.getElementById('<%=txtLoginId.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Login Id');
                return false;
            }
            str = document.getElementById('<%=txtpassword.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Password');
                return false;
            }
            str = document.getElementById('<%=txtMobileNo.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Mobile No');
                return false;
            }
            str = document.getElementById('<%=txtAddress2.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Address');
                return false;
            }
            return true;
        }

    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td style="width: 143px" align="left">
                                        </td>
                                        <td style="width: 175px">
                                            <strong>
                                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px">
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px; height: 15px" align="left">
                                            <strong>
                                                Base Location</strong>
                                        </td>
                                        <td style="width: 175px; height: 15px">
                                            <asp:DropDownList ID="ddDistributorId" runat="server" Width="205px" CssClass="DropList"
                                                OnSelectedIndexChanged="ddDistributorId_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 15px">
                                            &nbsp; &nbsp;
                                        </td>
                                        <td style="height: 15px; width:100px " align="left">
                                            <strong>
                                                Name</strong>
                                        </td>
                                        <td style="height: 15px">
                                            <asp:TextBox ID="txtUserName" runat="server" Width="200px" CssClass="txtBox"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px; height: 12px" align="left">
                                            <strong>
                                                Designation</strong>
                                        </td>
                                        <td style="width: 175px; height: 12px">
                                            <asp:DropDownList ID="ddDesignation" runat="server" Width="205px" CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 12px">
                                        </td>
                                        <td style="height: 12px" align="left">
                                            <strong>
                                               N.I.C No</strong>
                                        </td>
                                        <td style="height: 12px">
                                            <asp:TextBox ID="txtNICNo" runat="server" Width="200px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px; height: 22px" align="left">
                                            <strong>
                                                Mobile No</strong>
                                        </td>
                                        <td style="width: 175px; height: 22px">
                                            <asp:TextBox ID="txtMobileNo" runat="server" Width="198px" CssClass="txtBox "></asp:TextBox>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" Mask="99999999999"
                                                MaskType="Date" TargetControlID="txtMobileNo">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                        <td style="width: 1px; height: 22px">
                                        </td>
                                        <td style="height: 22px" align="left">
                                            <strong>
                                                Phone No</strong>
                                        </td>
                                        <td style="height: 22px">
                                            <asp:TextBox ID="txtPhoneNo" runat="server" Width="200px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px" valign="top" align="left">
                                            <strong>
                                               Email Address</strong>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="txtEmail" runat="server" Width="514px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 143px" valign="top">
                                            <strong>
                                                Parmanent Address</strong>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="txtAddress2" runat="server" Width="514px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 143px" valign="top">
                                            <strong>
                                                Present Address</strong>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="txtAddress1" runat="server" Width="514px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px" valign="top" align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="82px" Text="Login Id" CssClass="lblbox"
                                                    Visible="False"></asp:Label></strong>
                                        </td>
                                        <td style="width: 175px">
                                            <asp:TextBox ID="txtLoginId" runat="server" Width="200px" CssClass="txtBox " Visible="False"></asp:TextBox>
                                        </td>
                                        <td style="width: 1px">
                                        </td>
                                        <td valign="top" align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="69px" Text="Password" CssClass="lblbox"
                                                    Visible="False"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtpassword" runat="server" Width="200px" CssClass="txtBox " Visible="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 143px; height: 21px" align="left">
                                        </td>
                                        <td style="width: 175px; height: 21px">
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Width="82px" Font-Size="8pt"
                                                Text="Save" ValidationGroup="vg" CssClass="btn" />
                                            <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Width="73px" Font-Size="8pt"
                                                Text="Cancel" CssClass="btn" />
                                        </td>
                                        <td style="width: 1px; height: 21px">
                                        </td>
                                        <td style="height: 21px">
                                            <asp:CheckBox ID="chkIsActive" runat="server" Width="93px" Text="IsActive" Checked="True">
                                            </asp:CheckBox>
                                        </td>
                                        <td style="height: 21px">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel2" runat="server" Height="250px" ScrollBars="Vertical" Width="99%" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                    <asp:GridView ID="Grid_users" runat="server" Width="100%" ForeColor="SteelBlue" CssClass="gridRow2"
                        BorderColor="White" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White"
                        OnRowEditing="Grid_users_RowEditing" PageSize="15">
                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                            PreviousPageText="Previous"></PagerSettings>
                        <RowStyle ForeColor="Black"></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="USER_ID" HeaderText="User Id">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="USER_CODE" HeaderText="Code">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="7%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="USER_NAME" HeaderText="Name">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="15%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="NIC_NO" HeaderText="NIC No">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="10%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="PHONE" HeaderText="Phone No">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="10%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="MOBILE" HeaderText="Mobile">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="10%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="EMAIL" HeaderText="Email">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol">
                                </ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ADDRESS1" HeaderText="Present Address">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="28%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ADDRESS2" HeaderText="Permanent Address">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol">
                                </ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="SLASH_DESC" HeaderText="Designation">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="10%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol">
                                </ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="USER_TYPE_ID" HeaderText="USERTYPE_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="COMPANY_ID" HeaderText="COMPANY_ID">
                                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                <ItemStyle CssClass="hiddencol"></ItemStyle>
                            </asp:BoundField>
                            <asp:CommandField ShowEditButton="True">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Center" Width="5%"></ItemStyle>
                            </asp:CommandField>
                        </Columns>
                        <FooterStyle BackColor="White"></FooterStyle>
                        <PagerStyle BackColor="Transparent"></PagerStyle>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="tblhead" ForeColor="White" BorderColor="#38560D">
                        </HeaderStyle>
                        <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333">
                        </AlternatingRowStyle>
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
