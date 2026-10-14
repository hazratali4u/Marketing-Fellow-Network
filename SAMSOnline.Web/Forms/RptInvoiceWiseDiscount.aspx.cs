using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.BusinessLayer.Reports;
using SAMS.Common.Classes;
using CrystalDecisions.CrystalReports.Engine;

public partial class Forms_RptInvoiceWiseDiscount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDistributor();
            LoadPrincipal();
          
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];
            txtStartDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
            txtEndDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }
    private void LoadPrincipal()
    {
        DrpPrincipal.Items.Clear();
          SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        DrpPrincipal.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(DrpPrincipal, m_dt, 0, 1,false);
    }
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 2);
    }
  
  



    protected void Button2_Click(object sender, EventArgs e)
    {
        ShowReport(0);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ShowReport(1);
    }


    protected void ShowReport(int type)
    {
        DocumentPrintController DPrint = new DocumentPrintController();
        DataSet ds = null;
        DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));


        DataControl dc = new DataControl();
        ds = DPrint.SelectInvoiceWiseDiscount(int.Parse(DrpReportType.SelectedValue), int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpPrincipal.SelectedValue.ToString()),
            DateTime.Parse(txtStartDate.Text + " 00:00:00"), DateTime.Parse(txtEndDate.Text + " 23:59:59"), int.Parse(Session["UserId"].ToString()));
        var CrpReport = new ReportDocument();
        if (DrpReportType.SelectedValue == "0")
        {
            CrpReport = new CrpInvoiceWiseDiscount();
        }        else
        {
            CrpReport = new CrpInvoiceWisefreeSku();
        }
        CrpReport.SetDataSource(ds);
        CrpReport.Refresh();

        CrpReport.SetParameterValue("Distributor_Name", drpDistributor.SelectedItem.Text);
        CrpReport.SetParameterValue("FROM_DATE", DateTime.Parse(txtStartDate.Text));
        CrpReport.SetParameterValue("TO_DATE", DateTime.Parse(txtEndDate.Text));
        CrpReport.SetParameterValue("Principal", DrpPrincipal.SelectedItem.Text);

        Session.Add("CrpReport", CrpReport);
        Session.Add("ReportType", type);
        string url = "'Default.aspx'";
        string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
        Type cstype = GetType();
        ClientScriptManager cs = Page.ClientScript;
        cs.RegisterStartupScript(cstype, "OpenWindow", script);
    }
}