<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmDistributorArea.aspx.cs" Inherits="Forms_frmDistributorArea" Title="SAMS :: Town Hierarchy" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">

 <div class="container" style="background-color: white">
        
    <script language="JavaScript" type="text/javascript">
        function ValidateArea()
	    {
			var str;
			str = document.getElementById('<%=txtAreaName.ClientID%>').value;
			if(str == null || str.length == 0)
			{
				alert('Must Enter Route Name');
				return false;
			}
	        return true;	 
	    }
	    function ValidateRoute()
	    {
			var str;
			str = document.getElementById('<%=txtMarketName.ClientID%>').value;
			if(str == null || str.length == 0)
			{
				alert('Must Enter Market Name');
				return false;
			}
	        return true;	 
	    }
    </script>
    
     <div id="right_data">
         <table>            
             <tr>                 
                 <td>
         <table width="100%">
             <tr>
                 <td >
                     <cc1:TabContainer ID="TabContainer1" runat="server"  Height="375px"
                         Width="650px" ActiveTabIndex="0">
                         <cc1:TabPanel ID="TabPanel1" runat="server">
                                <HeaderTemplate>
                                    Route&nbsp;
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td style="width: 100px">
                                             <asp:UpdatePanel id="UpdatePanel6" runat="server">
                                                 <contenttemplate>
<TABLE width="100%">
                                                         <TBODY>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px">
                                                                 </TD>
                                                                 <TD colSpan=2>
                                                                     <strong><asp:Label id="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong>
                                                                     <BR />
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px; HEIGHT: 28px">
                                                                     <strong><asp:Label id="Label4" runat="server" Width="62px" Text="Location"></asp:Label></strong>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                     <asp:DropDownList id="drpDistributor" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px; HEIGHT: 28px">
                                                                     <strong><asp:Label id="Label3" runat="server" Width="62px" Text="Town"></asp:Label></strong>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                     <asp:DropDownList id="drpTown" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="drpTown_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 28px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 29px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px; HEIGHT: 29px">
                                                                     <strong><asp:Label id="Label2" runat="server" Width="65px" Text="Name"></asp:Label></strong>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 29px">
                                                                     <asp:TextBox id="txtAreaName" runat="server" Width="192px" CssClass="txtBox "></asp:TextBox>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 29px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px; HEIGHT: 37px" align=right>
                                                                     &nbsp;</TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                     <asp:CheckBox id="ChIsActive" runat="server" Text="Is Active" Checked="True">
                                                                     </asp:CheckBox>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                 </TD>
                                                             </TR>
                                                             <TR>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                 </TD>
                                                                 <TD style="WIDTH: 49px; HEIGHT: 37px" align=right>
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                     <asp:Button id="btnSaveRoute" onclick="btnSaveRoute_Click" runat="server" Width="85px" Font-Size="8pt" Text="Save" CssClass="btn" />
                                                                 </TD>
                                                                 <TD style="WIDTH: 100px; HEIGHT: 37px">
                                                                 </TD>
                                                             </TR>
                                                         </TBODY>
                                                     </TABLE>
</contenttemplate>
                                             </asp:UpdatePanel></td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             <asp:UpdatePanel id="UpdatePanel5" runat="server">
                                                 <contenttemplate>
                                                     <asp:Panel ID="Panel1" runat="server" Height="150px" HorizontalAlign="Left" ScrollBars="Vertical"
                                                         Width="100%">
<asp:GridView id="grdAreaData" runat="server" Width="90%" Font-Size="9pt" ForeColor="SteelBlue" CssClass="gridRow2" AutoGenerateColumns="False" HorizontalAlign="Center" BackColor="White" BorderColor="White" OnRowEditing="grdAreaData_RowEditing" OnPageIndexChanging="grdAreaData_PageIndexChanging">
<PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>

<RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black"></RowStyle>
<Columns>
<asp:BoundField DataField="AREA_ID" HeaderText="Area Id">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="Distributor">
<HeaderStyle CssClass="hiddencol" HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TOWN_ID" HeaderText="Town Id">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Distributor" HeaderText="Distributor">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="Town" HeaderText="Town">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="AREA_CODE" HeaderText="Route Code">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="AREA_NAME" HeaderText="Route Name">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:CommandField ShowEditButton="True" HeaderText="Edit">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:CommandField>
</Columns>

<FooterStyle BackColor="White"></FooterStyle>

<PagerStyle BackColor="Transparent"></PagerStyle>

<HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
</asp:GridView>
                                                     </asp:Panel>
</contenttemplate>
                                             </asp:UpdatePanel>
                                             &nbsp;
                                         </td>
                                     </tr>
                                 </table>
                             </ContentTemplate>
                         </cc1:TabPanel>
                         <cc1:TabPanel ID="TabPanel2" runat="server">
                             <HeaderTemplate>
                                 Market&nbsp;
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="center" style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                 <ContentTemplate>
<TABLE width="100%"><TBODY><TR><TD style="WIDTH: 100px; HEIGHT: 8px"></TD><TD style="HEIGHT: 8px" align=left colSpan=2>
<strong><asp:Label id="lblErrorMsgDivsion" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></strong><BR /></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 16px"></TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left>
<strong><asp:Label id="Label1" runat="server" Width="64px" Text="Location"></asp:Label></strong></TD><TD style="HEIGHT: 16px" align=left><asp:DropDownList id="drpMDistributor" runat="server" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="drpMDistributor_SelectedIndexChanged" CssClass="DropList"></asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 16px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px"></TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left>
<strong><asp:Label id="Label5" runat="server" Width="42px" Text="Town"></asp:Label></strong></TD><TD align=left><asp:DropDownList id="DrpMTown" runat="server" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="DrpMTown_SelectedIndexChanged" CssClass="DropList"></asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px"></TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left>
<strong><asp:Label id="Label6" runat="server" Width="42px" Text="Route"></asp:Label></strong></TD><TD align=left><asp:DropDownList id="DrpRoute" runat="server" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged" CssClass="DropList"></asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px"></TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left>
<strong><asp:Label id="Label21" runat="server" Width="43px" Text="Name"></asp:Label></strong></TD><TD align=left><asp:TextBox id="txtMarketName" runat="server" Width="194px" CssClass="txtBox "></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 37px"></TD><TD align=right></TD><TD align=left><asp:CheckBox id="chMarkeIsActive" runat="server" Text="Is Active" Checked="True"></asp:CheckBox></TD><TD style="WIDTH: 100px; HEIGHT: 37px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 37px"></TD><TD align=right>&nbsp;</TD><TD align=left>
<asp:Button id="btnSaveMarket" onclick="btnSaveMarket_Click" runat="server" Width="85px" Font-Size="8pt" Text="Save" CssClass="btn" /> </TD><TD style="WIDTH: 100px; HEIGHT: 37px"></TD></TR></TBODY></TABLE>
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             <asp:UpdatePanel id="UpdatePanel1" runat="server">
                                                 <contenttemplate>
                                                  <asp:Panel ID="Panel2" runat="server" Height="130px" HorizontalAlign="Left" ScrollBars="Vertical"
                                                         Width="100%">
<asp:GridView id="grdRouteData" runat="server" Width="100%" Font-Size="9pt" ForeColor="SteelBlue" CssClass="gridRow2" OnPageIndexChanging="grdRouteData_PageIndexChanging" OnRowEditing="grdRouteData_RowEditing" BorderColor="White" BackColor="White" HorizontalAlign="Center" AutoGenerateColumns="False" AllowPaging="True">
<PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>

<RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black"></RowStyle>
<Columns>
<asp:BoundField DataField="ROUTE_ID" HeaderText="ROUTE_ID">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="Distributor Id">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="AREA_ID" HeaderText="Area Id">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TOWN_ID" HeaderText="Town Id">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" CssClass="hiddencol"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Distributor" HeaderText="Distributor">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="Town" HeaderText="Town">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="AREA_NAME" HeaderText="Route">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="Route_CODE" HeaderText="Market Code">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="Route_NAME" HeaderText="Market Name">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:CommandField ShowEditButton="True" HeaderText="Edit">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:CommandField>
</Columns>

<FooterStyle BackColor="White"></FooterStyle>

<PagerStyle BackColor="Transparent"></PagerStyle>

<HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
</asp:GridView>
</asp:Panel>
</contenttemplate>
                                             </asp:UpdatePanel></td>
                                     </tr>
                                 </table>
                                 <br />
                                 &nbsp;
                             </ContentTemplate>
                         </cc1:TabPanel>
                     </cc1:TabContainer></td>
             </tr>
         </table>
                 </td>
                 
             </tr>
             
         </table>
     </div>
</asp:Content>