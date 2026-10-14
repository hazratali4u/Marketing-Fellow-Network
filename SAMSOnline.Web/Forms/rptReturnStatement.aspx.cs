using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    
using SAMS.BusinessLayer.Reports;
using CrystalDecisions.CrystalReports.Engine;

/// <summary>
/// Form For Sale Person DSR Report
/// </summary>
public partial class Forms_rptReturnStatement : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.LoadDistributor();
            this.LoadDeliveryman();
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];
            txtStartDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
            txtEndDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }
    
    /// <summary>
    /// Loads Locations To Location Combo
    /// </summary>
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 2, true);
    }

    /// <summary>
    /// Shows Sale Person DSR in PDF
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        ShowReport(0);
    }

    /// <summary>
    /// Shows Sale Person DSR in Excel
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        ShowReport(1);
    }

    /// <summary>
    /// Gets Sale Person DSR And Shows Either in Excel or PDF
    /// </summary>
    /// <param name="p_ReportType">Type</param>
    private void ShowReport(int p_ReprotType)
    {
        DocumentPrintController DPrint = new DocumentPrintController();
        SalesForceAreaAssignmentController RptSaleCtl = new SalesForceAreaAssignmentController();
        DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));
        DataSet ds = null;
        DataControl dc = new DataControl();
        ds = RptSaleCtl.GetDMReturnStatement(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue,Convert.ToInt32(ddlDeliveryMan.SelectedValue),
            DateTime.Parse(txtStartDate.Text + " 00:00:00"), DateTime.Parse(txtEndDate.Text + " 23:59:59"), int.Parse(Session["UserId"].ToString()));
        SAMS.BusinessLayer.Reports.CrpReturnStatement CrpReport = new SAMS.BusinessLayer.Reports.CrpReturnStatement();

        ReportDocument subReport = CrpReport.OpenSubreport("DMCreditSale");
        ReportDocument subReport2 = CrpReport.OpenSubreport("DMCashRealize");

        CrpReport.SetDataSource(ds);

        subReport.SetDataSource(ds);
        subReport2.SetDataSource(ds);

        CrpReport.Refresh();
        CrpReport.SetParameterValue("Distributor_Name", drpDistributor.SelectedItem.Text);
        CrpReport.SetParameterValue("DM", ddlDeliveryMan.SelectedItem.Text);
        CrpReport.SetParameterValue("FROM_DATE", DateTime.Parse(txtStartDate.Text));
        CrpReport.SetParameterValue("TO_DATE", DateTime.Parse(txtEndDate.Text));
        CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
        Session.Add("CrpReport", CrpReport);
        Session.Add("ReportType", p_ReprotType);
        const string url = "'Default.aspx'";
        const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
        Type cstype = GetType();
        ClientScriptManager cs = Page.ClientScript;
        cs.RegisterStartupScript(cstype, "OpenWindow", script);
    }

    private void LoadDeliveryman()
    {
        ddlDeliveryMan.Items.Clear();

        Distributor_UserController mDController = new Distributor_UserController();
        
        DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(Session["CompanyId"].ToString()));
        ddlDeliveryMan.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(ddlDeliveryMan, m_dt, 0, 3);
    }

    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadDeliveryman();
    }
}