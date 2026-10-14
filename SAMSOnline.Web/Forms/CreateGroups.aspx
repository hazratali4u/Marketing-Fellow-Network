<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateGroups.aspx.cs" Inherits="Groups_CreateGroups" MasterPageFile="~/Forms/PageMaster.master" Title="SAMS :: SKU Group" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">
    <div id="right_data">
        <table width="100%">
            <tr>
                <td >
                    <asp:UpdatePanel id="UpdatePanel3" runat="server">
                        <contenttemplate>
<TABLE style="WIDTH: 404px"><TBODY><TR><TD></TD><TD>
<strong> <asp:Label id="lblErrormsg" runat="server" Width="262px" ForeColor="Red"></asp:Label></strong></TD></TR><TR><TD style="WIDTH: 47px; HEIGHT: 32px" align=left>
<strong><asp:Label id="Label1" runat="server" Width="72px" Text="Group Name" CssClass="lblbox"></asp:Label></strong></TD><TD align=left><asp:TextBox id="txtGroupName" runat="server" Width="194px" CssClass="txtBox "></asp:TextBox> <BR /><asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Width="136px" ValidationGroup="vg" ErrorMessage="Enter Group Name" Display="Dynamic" ControlToValidate="txtGroupName"></asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 47px; HEIGHT: 22px" align=left>
<strong><asp:Label id="Label5" runat="server" Width="51px" Text="Principal" CssClass="lblbox"></asp:Label></strong>
</TD><TD align=left><asp:DropDownList id="ddPrincipal" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="ddPrincipal_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 47px; HEIGHT: 22px" align=left>
            <strong><asp:Label id="Label8" runat="server" Width="53px" Text="Division" CssClass="lblbox"></asp:Label></strong></TD><TD align=left><asp:DropDownList id="ddDivision" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="ddDivision_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 47px; HEIGHT: 23px" align=left>
            <strong><asp:Label id="Label11" runat="server" Width="52px" Text="Catagory" CssClass="lblbox"></asp:Label></strong></TD><TD align=left><asp:DropDownList id="ddCatagory" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="ddCatagory_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 47px; HEIGHT: 23px" align=left>
            <strong><asp:Label id="Label2" runat="server" Width="50px" Text="Brand" CssClass="lblbox"></asp:Label></strong></TD><TD align=left><asp:DropDownList id="ddBrand" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="ddBrand_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD></TR><TR><TD align=center colSpan=2>
            <strong><asp:Label id="Label4" runat="server" Width="117px" Text="SKU Collection" CssClass="lblbox"></asp:Label></strong> &nbsp; </TD></TR><TR><TD style="HEIGHT: 115px" colSpan=2><TABLE><TBODY><TR><TD style="WIDTH: 107px" rowSpan=4><asp:ListBox id="lstUnAssignSKU" runat="server" Width="200px" Height="150px" CssClass="DropList"></asp:ListBox></TD>
        <TD align="center">
                <asp:Button ID="Button3" runat="server" Font-Size="8pt" Text=">>" Width="30px" OnClick="Button3_Click" CssClass="btn" /></TD><TD style="WIDTH: 102px" rowSpan=4><asp:ListBox id="lstAssignSKU" runat="server" Width="200px" Height="150px" CssClass="DropList"></asp:ListBox></TD></TR><TR><TD align=center>
                <asp:Button id="Button1" onclick="Button1_Click" runat="server" Font-Size="8pt" Text=">" Width="30px" CssClass="btn" /> </TD></TR><TR><TD align=center>
                <asp:Button id="Button2" onclick="Button2_Click" runat="server" Font-Size="8pt" Text="<" Width="30px" CssClass="btn" /> </TD></TR><TR><TD>
                    <asp:Button ID="Button4" runat="server" Font-Size="8pt" OnClick="Button4_Click" Text="<<" Width="30px" CssClass="btn" /></TD></TR><TR><TD rowSpan=1><asp:CheckBox id="chIsActive" runat="server" Text="Is Active" CssClass="lblbox" Visible="False"></asp:CheckBox></TD><TD align=center>
                    <asp:Button id="btnSave" onclick="btnSave_Click" runat="server" Width="62px" Font-Size="8pt" Text="Save" ValidationGroup="vg" CssClass="btn" /> </TD><TD rowSpan=1></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</contenttemplate>
                    </asp:UpdatePanel></td>
            </tr>
            <tr>
                <td >
   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
<asp:Panel id="Panel1" runat="server" Width="600px" Height="200px" ScrollBars="Vertical" BackColor="#E0E0E0"><asp:GridView id="SKUGroup_Grid" runat="server" Width="578px" Height="1px" ForeColor="SteelBlue" CssClass="gridRow2" BackColor="White" OnPageIndexChanging="SKUGroup_Grid_PageIndexChanging" AutoGenerateColumns="False" BorderColor="White" HorizontalAlign="Center" OnRowEditing="SKUGroup_Grid_RowEditing">
<PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>

<RowStyle ForeColor="Black"></RowStyle>
<Columns>
<asp:BoundField DataField="SKU_GROUP_ID" HeaderText="Group Id">
    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
</asp:BoundField>
<asp:BoundField DataField="GROUP_NAME" HeaderText="Group Name">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:BoundField>
<asp:TemplateField HeaderText="SKU Name"><ItemTemplate>
<%--<asp:label ID="lblID" Text='<%# Bind("SKU_NAME") %>' runat="server"></asp:Label>--%><asp:ListBox id="listbox1" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"></asp:ListBox> 
</ItemTemplate>
    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
</asp:TemplateField>
<asp:CommandField ShowEditButton="True" HeaderText="Edit">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:CommandField>
</Columns>

<FooterStyle BackColor="White"></FooterStyle>

<PagerStyle BackColor="Transparent"></PagerStyle>

<HeaderStyle CssClass="tblhead" ForeColor="White"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
</asp:GridView> </asp:Panel> 
</ContentTemplate>
                    </asp:UpdatePanel></td>
            </tr>
        </table>
        </div>
</asp:Content>