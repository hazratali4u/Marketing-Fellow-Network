<%@ page language="C#" masterpagefile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile = "frmBrandAssignment.aspx.cs" inherits="Forms_frmBrandAssignment" title="SAMS :: Principal Assignment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">
  
    <div id="right_data">
        <table width="100%">
            <tr>
                
                <td>
                
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
<TABLE><TBODY><TR><TD style="WIDTH: 124px; HEIGHT: 17px">
<strong><asp:Label id="lblmsg" runat="server" Visible="False" Width="114px" ForeColor="Red"></asp:Label></strong></TD><TD>&nbsp; </TD><TD style="HEIGHT: 17px"></TD></TR>
    <TR><TD align="right">
    <strong><asp:Label id="Label5" runat="server" Width="52px" Text="User" CssClass="lblbox"></asp:Label></strong>
        &nbsp;&nbsp;
    </TD><TD style="HEIGHT: 10px"><asp:DropDownList id="ddRole" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="ddUser_SelectedIndexChanged"></asp:DropDownList></TD><TD style="HEIGHT: 10px"></TD></TR><TR><TD align=center colSpan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TD></TR><TR><TD colSpan=2><TABLE><TBODY><TR><TD style="WIDTH: 100px" rowSpan=4><asp:ListBox id="lstUnAssignBrand" runat="server" Width="200px" Height="200px" CssClass="DropList"></asp:ListBox>
    <div style="z-index: 101; left: 284px; width: 100px; position: absolute; top: 245px;
        height: 100px">
        <asp:Panel ID="Panel1" runat="server">
                    <asp:UpdateProgress id="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" Height="33px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                            Width="31px" />
</ProgressTemplate>

                    </asp:UpdateProgress>
        </asp:Panel>
    </div>
</TD><TD align=center style="width: 75px">
<asp:Button id="Button3" onclick="Button3_Click" runat="server" Width="30px" Font-Size="8pt" Text=">" CssClass="btn" /> </TD><TD style="WIDTH: 102px" rowSpan=4><asp:ListBox id="lstAssignBrand" runat="server" Width="200px" Height="200px" CssClass="DropList"></asp:ListBox></TD></TR><TR><TD align=center style="width: 75px">
<asp:Button id="Button1" onclick="Button1_Click" runat="server" Width="30px" Font-Size="8pt" Text=">>" CssClass="btn" /> </TD></TR><TR><TD align=center style="width: 75px">
<asp:Button id="Button2" onclick="Button2_Click" runat="server" Width="30px" Font-Size="8pt" Text="<<" CssClass="btn" /> </TD></TR><TR><TD align=center style="width: 75px">
<asp:Button id="Button4" onclick="Button4_Click" runat="server" Width="30px" Font-Size="8pt" Text="<" CssClass="btn" /> </TD></TR><TR><TD rowSpan=1></TD><TD style="WIDTH: 75px; HEIGHT: 24px"></TD><TD rowSpan=1></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>           
        </table>     
       
        </div>

</asp:Content>

