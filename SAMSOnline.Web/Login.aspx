<%@ Page Title="" Language="C#" MasterPageFile="~/LoginMaster.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="_Login" %>


<asp:Content ID="Content2" ContentPlaceHolderID="cpChild" runat="Server">
    <div id="right_data">
        <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        <div id="main">
            <div id="boxbody">
                <div id="Products_select" style="padding-bottom: 17px;">
                    Please enter login & password to proceed.
                 </div>
                 <div>
                    <asp:TextBox ID="txtLogin" runat="server" Text="Login" onfocus="if(this.value=='Login'){this.value='';}"
                        onblur="if(this.value=='' || this.value==null) this.value='Login'"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtPassword" runat="server" Text="........." TextMode="Password"
                        onfocus="if(this.value=='.........'){this.value='';}" onblur="if(this.value=='' || this.value==null) this.value='.........'"></asp:TextBox>
                </div>
                <div>
                    <asp:Button ID="btnSignIn" runat="server" CssClass="tb_signin" OnClick="btnSignIn_Click" />
                </div>
                <div>
                    <br />
                    <br />
                    *This is a secure server. Your activity will be monitored.
                </div>
            </div>
        </div>
    </div>
</asp:Content>
