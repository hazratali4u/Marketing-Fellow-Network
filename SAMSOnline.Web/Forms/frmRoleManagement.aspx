<%@ page language="C#" masterpagefile="~/Forms/PageMaster.master" autoeventwireup="true"  CodeFile = "frmRoleManagement.aspx.cs" inherits="frmRoleManagement" title="SAMS :: Role Management" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">

    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
<TABLE><TBODY><TR><TD style="WIDTH: 82px; HEIGHT: 17px">
<strong><asp:Label id="lblmsg" runat="server" Visible="False" Width="114px" ForeColor="Red"></asp:Label></strong></TD><TD>&nbsp; </TD><TD style="HEIGHT: 17px"></TD></TR><TR><TD>
<strong><asp:Label id="Label1" runat="server" Width="107px" Text="Role Description" CssClass="lblbox"></asp:Label></strong></TD><TD><asp:DropDownList id="ddRole" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="ddRole_SelectedIndexChanged"></asp:DropDownList> <asp:TextBox id="TextBox1" runat="server" Visible="False" Width="200px" CssClass="txtBox " Enabled="False"></asp:TextBox>&nbsp;&nbsp;<asp:Button id="btnNew" onclick="btnNew_Click" runat="server" Width="55px" Font-Size="8pt" Text="New" CssClass="btn" /></TD><TD>
  </TD></TR><TR><TD>
<strong><asp:Label id="Label11" runat="server" Width="112px" Text="Module 1st Layer" CssClass="lblbox"></asp:Label></strong></TD><TD><asp:DropDownList id="DrpModule1stLayer" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpModule1stLayer_SelectedIndexChanged"></asp:DropDownList></TD></TR><TR><TD style="HEIGHT: 24px">
<strong><asp:Label id="Label2" runat="server" Width="112px" Text="Module 2nd Layer" CssClass="lblbox"></asp:Label></strong></TD><TD><asp:DropDownList id="DrpModule2ndLayer" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpModule2ndLayer_SelectedIndexChanged"></asp:DropDownList></TD></TR><TR><TD style="HEIGHT: 16px">
<strong><asp:Label id="Label3" runat="server" Width="112px" Text="Module 3rd Layer" CssClass="lblbox"></asp:Label></strong></TD><TD><asp:DropDownList id="DrpModule3rdLayer" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpModule3rdLayer_SelectedIndexChanged"></asp:DropDownList></TD></TR><TR>
    <TD style="HEIGHT: 16px">&nbsp;</TD>
    <td>
        &nbsp;</td>
    </TR><TR><TD colSpan=2 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>
        <asp:Label ID="Label4" runat="server" CssClass="lblbox" 
            Text="Module Assignment" Width="142px"></asp:Label>
        </strong>&nbsp; </TD></TR>
    <tr>
        <td colspan="2" style="HEIGHT: 182px">
            <table>
                <tbody>
                    <tr>
                        <td style="width: 150px">
                            <asp:ListBox ID="lstUnAssignModule" runat="server" CssClass="DropList" 
                                Height="200px" Width="200px"></asp:ListBox>
                        </td>
                        
                        <td style="width:50px" align="center" valign="middle">
                        <asp:Button ID="Button1" runat="server" CssClass="btn" Font-Size="8pt" 
                                onclick="Button1_Click" Text="&gt;" Width="30px" />
                                <br />
                                <br />
                                <asp:Button ID="Button2" runat="server" CssClass="btn" Font-Size="8pt" 
                                onclick="Button2_Click" Text="&lt;" Width="30px" />
                        </td>

                        <td style="width: 150px">
                            <asp:ListBox ID="lstAssignModule" runat="server" CssClass="DropList" 
                                Height="200px" Width="200px"></asp:ListBox>
                        </td>
                    </tr>                  
                    
                </tbody>
            </table>
        </td>
    </tr>
    </TBODY></TABLE>
</ContentTemplate>
                    </asp:UpdatePanel>
                </td>
               
            </tr>
            <tr>
                <td colspan="3">
                    <asp:UpdateProgress id="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                            Data saving in Progress……..
</ProgressTemplate>

                    </asp:UpdateProgress></td>
            </tr>
        </table>      
       
        </div>

</asp:Content>

