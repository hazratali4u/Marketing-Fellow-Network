<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmSKUHierarchyData.aspx.cs" Inherits="frmSKUHierarchyData" Title="SAMS :: SKU Hierarchy" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <div id="right_data">
        <table>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <cc1:TabContainer ID="TabContainer1" runat="server" Height="400px" Width="650px"
                                    ActiveTabIndex="2">
                                    <cc1:TabPanel ID="TabPanel1" runat="server">
                                        <HeaderTemplate>
                                            Principal
                                        </HeaderTemplate>
                                        <ContentTemplate>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 82px">
                                                    </td>
                                                    <td style="width: 100px">
                                                    </td>
                                                    <td style="width: 100px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 82px">
                                                    </td>
                                                    <td style="width: 100px">
                                                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                            <ContentTemplate>
                                                                <table width="100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                            <td style="width: 49px">
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <strong>
                                                                                    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong><br />
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                                <br />
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                            <td style="width: 49px; height: 28px">
                                                                                <strong>
                                                                                    <asp:Label ID="Label1" runat="server" Width="98px" Text="Principal Code" 
                                                                                    Height="16px"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:TextBox ID="txtPrincipalCode" runat="server" Width="200px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                            <td style="width: 49px; height: 29px">
                                                                                <strong>
                                                                                    <asp:Label ID="Label2" runat="server" Width="103px" Text="Principal Name"></asp:Label>
                                                                                </strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                                <asp:TextBox ID="txtPrincipalName" runat="server" Width="200px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px;" >
                                                                            </td>
                                                                            <td align="left" style="width: 49px; ">
                                                                            </td>
                                                                            <td style="width: 100px;">
                                                                                <asp:CheckBox ID="ChIsMunalDiscount" runat="server" Text="Is Manual Dicount" Width="190px" />
                                                                            </td>
                                                                            <td >
                                                                            </td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td style="width: 100px;">
                                                                            </td>
                                                                            <td align="left" style="width: 49px;">
                                                                            </td>
                                                                            <td style="width: 100px;">
                                                                                <asp:CheckBox ID="chbIsActive" runat="server" Text="Is Active" Width="190px" />
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                            <td style="width: 49px; height: 37px" align="right">
                                                                                &nbsp;
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px">
                                                                                <asp:Button ID="btnSavePrincipal" OnClick="btnSavePrincipal_Click" runat="server"
                                                                                    Width="85px" Font-Size="8pt" Text="New" CssClass="btn" />
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel6">
                                                            <ProgressTemplate>
                                                                <asp:ImageButton ID="ImageButton1" runat="server" Width="33px" Height="31px" ImageUrl="~/App_Themes/Granite/Images/image003.gif">
                                                                </asp:ImageButton>
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </td>
                                                    <td style="width: 100px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Panel ID="Panel1" runat="server" Height="150px" ScrollBars="Vertical" Width="100%" BorderWidth="1px">
                                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="GrdPrincipal" runat="server" Width="100%" Font-Size="9pt" ForeColor="SteelBlue"
                                                                        CssClass="gridRow2" BorderColor="White" BackColor="White" HorizontalAlign="Center"
                                                                        AutoGenerateColumns="False" OnRowEditing="GrdPrincipal_RowEditing" OnRowDeleting="GrdPrincipal_RowDeleting"
                                                                        OnPageIndexChanging="GrdPrincipal_PageIndexChanging">
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                            PreviousPageText="Previous"></PagerSettings>
                                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                                                                        </RowStyle>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="SKU_HIE_ID" HeaderText="Id" Visible="False">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_CODE" HeaderText="Code">
                                                                                <HeaderStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Left">
                                                                                </HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_NAME" HeaderText="Name">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                               <asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                            </asp:BoundField>
                                                                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:CommandField>
                                                                          <%--  <asp:TemplateField HeaderText="Delete">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                                        Text="Delete"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:TemplateField>--%>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                                                                        <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </cc1:TabPanel>
                                    <cc1:TabPanel ID="TabPanel2" runat="server">
                                        <HeaderTemplate>
                                            Division
                                        </HeaderTemplate>
                                        <ContentTemplate>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 100px;">
                                                    </td>
                                                    <td align="center">
                                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>
                                                                <table width="100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                            <td style="height: 8px" align="left" colspan="2">
                                                                                <strong>
                                                                                    <asp:Label ID="lblErrorMsgDivsion" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong><br />
                                                                            </td>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 159px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 23px">
                                                                            </td>
                                                                            <td style="width: 159px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label3" runat="server" Width="100px" Text="Principal" 
                                                                                    Height="16px"></asp:Label>
                                                                                </strong>&nbsp;
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:DropDownList ID="dddivisonPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="dddivisonPrincipal_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px; height: 23px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                            <td style="width: 159px; height: 28px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label12" runat="server" Width="114px" Text="Division Code"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:TextBox ID="txtDivisionCode" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                            <td style="width: 159px; height: 29px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label21" runat="server" Width="115px" Text="Division Name"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                                <asp:TextBox ID="txtDivisionName" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                            <td style="width: 159px; height: 37px" align="right">
                                                                                &nbsp;
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px" align="left">
                                                                                <asp:Button ID="btnSaveDivison" OnClick="btnSaveDivison_Click" runat="server" Width="85px"
                                                                                    Font-Size="8pt" Text="New" CssClass="btn" />
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                            <ProgressTemplate>
                                                                <asp:Image ID="Image2" runat="server" Width="30px" Height="28px" ImageUrl="~/App_Themes/Granite/Images/image003.gif">
                                                                </asp:Image>&nbsp; Loading .........
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </td>
                                                    <td style="width: 100px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        <asp:Panel ID="Panel2" runat="server" Height="200px" ScrollBars="Vertical" Width="100%" BorderWidth="1px">
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="GrdDivision" runat="server" Width="100%" Font-Size="9pt" ForeColor="SteelBlue"
                                                                        CssClass="gridRow2" BorderColor="White" BackColor="White" HorizontalAlign="Center"
                                                                        AutoGenerateColumns="False" OnRowEditing="GrdDivision_RowEditing" OnRowDeleting="GrdDivision_RowDeleting"
                                                                        OnPageIndexChanging="GrdDivision_PageIndexChanging">
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                            PreviousPageText="Previous"></PagerSettings>
                                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                                                                        </RowStyle>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="SKU_HIE_ID" HeaderText="Id" Visible="False">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_CODE" HeaderText="Code">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_NAME" HeaderText="Name">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:CommandField>
                                                                            <asp:TemplateField HeaderText="Delete">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                                        Text="Delete"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                                                                        <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            &nbsp;
                                        </ContentTemplate>
                                    </cc1:TabPanel>
                                    <cc1:TabPanel ID="TabPanel3" runat="server">
                                        <HeaderTemplate>
                                            Category
                                        </HeaderTemplate>
                                        <ContentTemplate>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 100px">
                                                    </td>
                                                    <td align="center" style="width: 100px">
                                                        <asp:UpdatePanel ID="UpdatePanel21" runat="server">
                                                            <ContentTemplate>
                                                                <table width="100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 16px">
                                                                            </td>
                                                                            <td style="height: 16px" align="left" colspan="2">
                                                                                <br />
                                                                                <strong>
                                                                                    <asp:Label ID="lblErrorMsgCategory" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 16px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 69px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                            <td style="width: 100px; height: 8px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 21px">
                                                                            </td>
                                                                            <td align="left" style="width: 69px; height: 21px">
                                                                                <strong>
                                                                                    <asp:Label ID="Label5" runat="server" Text="Principal" Width="80px"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:DropDownList ID="DrpCategoryPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="DrpCategoryPrincipal_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px; height: 21px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 21px">
                                                                            </td>
                                                                            <td style="width: 69px; height: 21px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label4" runat="server" Width="91px" Text="Division" 
                                                                                    Height="16px"></asp:Label>
                                                                                </strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:DropDownList ID="ddCategoryDivision" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="ddCategoryDivision_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px; height: 21px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                            <td style="width: 69px; height: 28px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label121" runat="server" Width="99px" Text="Category Code" 
                                                                                    Height="16px"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:TextBox ID="txtCategoryCode" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                            <td style="width: 69px; height: 29px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label211" runat="server" Width="102px" Text="Category Name"></asp:Label>
                                                                                </strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                                <asp:TextBox ID="txtCategoryName" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                            <td style="width: 69px; height: 37px" align="right">
                                                                                &nbsp;
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px" align="left">
                                                                                <asp:Button ID="btnSaveCategory" OnClick="btnSaveCategory_Click" runat="server" Width="85px"
                                                                                    Font-Size="8pt" Text="New" CssClass="btn" />
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="UpdatePanel21">
                                                            <ProgressTemplate>
                                                                <asp:Image ID="Image3" runat="server" Width="30px" Height="28px" ImageUrl="~/App_Themes/Granite/Images/image003.gif">
                                                                </asp:Image>&nbsp; Loading .........
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </td>
                                                    <td style="width: 100px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        <asp:Panel ID="Panel3" runat="server" Height="200px" ScrollBars="Vertical" Width="100%" BorderWidth="1px">
                                                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="GrdCategory" runat="server" Width="100%" Font-Size="9pt" ForeColor="SteelBlue"
                                                                        CssClass="gridRow2" BorderColor="White" BackColor="White" HorizontalAlign="Center"
                                                                        AutoGenerateColumns="False" OnRowEditing="GrdCategory_RowEditing" OnRowDeleting="GrdCategory_RowDeleting"
                                                                        OnPageIndexChanging="GrdCategory_PageIndexChanging">
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                            PreviousPageText="Previous"></PagerSettings>
                                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                                                                        </RowStyle>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="SKU_HIE_ID" HeaderText="Id" Visible="False">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_CODE" HeaderText="Code">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_NAME" HeaderText="Name">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:CommandField>
                                                                            <asp:TemplateField HeaderText="Delete">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                                        Text="Delete"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                                                                        <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            &nbsp;&nbsp;
                                        </ContentTemplate>
                                    </cc1:TabPanel>
                                    <cc1:TabPanel ID="TabPanel4" runat="server">
                                        <HeaderTemplate>
                                            Brand
                                        </HeaderTemplate>
                                        <ContentTemplate>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 100px">
                                                    </td>
                                                    <td align="center" style="width: 100px">
                                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                            <ContentTemplate>
                                                                <table width="100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <strong>
                                                                                    <asp:Label ID="lblErrorMsgBrand" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong><br />
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 25px;" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label6" runat="server" Text="Principal" Width="80px"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                                <asp:DropDownList ID="DrpBrandPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="DrpBrandPrincipal_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="left" style="height: 21px">
                                                                                <strong>
                                                                                    <asp:Label ID="Label10" runat="server" Text="Division" Width="64px"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="height: 25px">
                                                                                <asp:DropDownList ID="DrpBrandDivision" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="DrpBrandDivision_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px; height: 21px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 25px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label9" runat="server" Width="80px" Text="Category"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:DropDownList ID="ddBrandCategory" runat="server" Width="200px" CssClass="DropList"
                                                                                    AutoPostBack="True" OnSelectedIndexChanged="ddBrandCategory_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 28px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label7" runat="server" Width="90px" Text="Brand Code"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                                <asp:TextBox ID="txtBrandCode" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 28px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 29px" align="left">
                                                                                <strong>
                                                                                    <asp:Label ID="Label8" runat="server" Width="90px" Text="Brand Name"></asp:Label></strong>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                                <asp:TextBox ID="txtBrandName" runat="server" Width="194px" Enabled="False" CssClass="txtBox "></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 100px; height: 29px">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px" align="left">
                                                                                <asp:Button ID="btnSaveBrand" OnClick="btnSaveBrand_Click" runat="server" Width="85px"
                                                                                    Font-Size="8pt" Text="New" AccessKey="B" CssClass="btn" />
                                                                            </td>
                                                                            <td style="width: 100px; height: 37px">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
                                                            <ProgressTemplate>
                                                                <asp:Image ID="Image4" runat="server" Width="24px" Height="23px" ImageUrl="~/App_Themes/Granite/Images/image003.gif">
                                                                </asp:Image>&nbsp; Loading.....
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </td>
                                                    <td style="width: 100px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        &nbsp;<asp:Panel ID="Panel4" runat="server" Height="150px" ScrollBars="Vertical"
                                                            Width="100%" BorderWidth="1px">
                                                            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="GrdBrand" runat="server" Width="100%" Font-Size="9pt" ForeColor="SteelBlue"
                                                                        CssClass="gridRow2" BorderColor="White" BackColor="White" HorizontalAlign="Center"
                                                                        AutoGenerateColumns="False" OnRowEditing="GrdBrand_RowEditing" OnRowDeleting="GrdBrand_RowDeleting"
                                                                        OnPageIndexChanging="GrdBrand_PageIndexChanging">
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                            PreviousPageText="Previous"></PagerSettings>
                                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                                                                        </RowStyle>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="SKU_HIE_ID" HeaderText="Id" Visible="False">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_CODE" HeaderText="Code">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SKU_HIE_NAME" HeaderText="Name">
                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                                </ItemStyle>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:CommandField>
                                                                            <asp:TemplateField HeaderText="Delete">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                                        Text="Delete"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White"></FooterStyle>
                                                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                                                        <HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>
                                                                        <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </cc1:TabPanel>
                                </cc1:TabContainer>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
