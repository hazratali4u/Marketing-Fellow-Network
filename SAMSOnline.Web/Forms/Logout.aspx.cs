using System;

public partial class Forms_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Web.Security.FormsAuthentication.SignOut();
        this.Session.Abandon();
        Response.Redirect("../Login.aspx");
    }
}