using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;

public partial class Forms_RptCreditAging : System.Web.UI.Page
{
    private void LoadAssingned()
    {
        drpDistributor.Items.Clear();
        SAMSUserController mUserController = new SAMSUserController();
        DataTable dt = mUserController.SelectUserAssignment(int.Parse(this.Session["UserId"].ToString()), 2, 1, int.Parse(this.Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 1);
    }
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        DrpPrincipal.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(this.DrpPrincipal, m_dt, 0, 1);
    }
    private void LoadCustomer()
    {
        if (drpDistributor.Items.Count > 0)
        {
            ddlCustomer.Items.Clear();
            CustomerDataController mController = new CustomerDataController();
            DataTable dtCredit = mController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpPrincipal.SelectedValue.ToString()), Constants.LongNullValue, Constants.IntNullValue);
            ddlCustomer.Items.Add(new ListItem("All", Constants.LongNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(this.ddlCustomer, dtCredit, 0, 1);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadAssingned();
            this.LoadPrincipal();
            this.LoadCustomer();
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)this.Session["CurrentWorkDate"];
            txtDocmentDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
            rblReportBehaviour_SelectedIndexChanged(null, null);
        }
    }
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        ShowReport(0);
    }
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        ShowReport(1);
    }
    protected void rblReportBehaviour_SelectedIndexChanged(object sender, EventArgs e)
    {
        rblReportType.Visible = true;
        lblReportType.Visible = true;
        lblDate.Text = "Up to";
        lblCustomer.Visible = false;
        ddlCustomer.Visible = false;
        lblSortBy.Visible = false;
        ddlSortBy.Visible = false;
        lblOrderBy.Visible = false;
        ddlOrderBy.Visible = false;
        if (rblReportBehaviour.SelectedValue == "2")
        {
            rblReportType.Visible = false;
            lblReportType.Visible = false;
            lblDate.Text = "As On Date";
            lblCustomer.Visible = true;
            ddlCustomer.Visible = true;
            lblSortBy.Visible = true;
            ddlSortBy.Visible = true;
            lblOrderBy.Visible = true;
            ddlOrderBy.Visible = true;
        }
    }
    private void ShowReport(int pType)
    {
        if (rblReportBehaviour.SelectedValue == "1")
        {
            DocumentPrintController mDocumentPrntControl = new DocumentPrintController();            
            DataSet ds = mDocumentPrntControl.GetCreditAgingReport(2, int.Parse(DrpPrincipal.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(this.Session["UserId"].ToString()), rblReportType.SelectedIndex, DateTime.Parse(txtDocmentDate.Text + " 23:59:59"));
            SAMS.BusinessLayer.Reports.CrpCreditAgingReport CrpReport = new SAMS.BusinessLayer.Reports.CrpCreditAgingReport();
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();
            CrpReport.SetParameterValue("UptoDate", txtDocmentDate.Text);
            CrpReport.SetParameterValue("Principal", DrpPrincipal.SelectedItem.Text);

            this.Session.Add("CrpReport", CrpReport);
            this.Session.Add("ReportType", pType);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        else
        {
            DocumentPrintController mDocumentPrntControl = new DocumentPrintController();
            DataTable dt = mDocumentPrntControl.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));
            if (dt.Rows.Count > 0)
            {
                DataSet ds = mDocumentPrntControl.GetCreditAgingSummary(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpPrincipal.SelectedValue.ToString()), Convert.ToInt64(ddlCustomer.SelectedValue), DateTime.Parse(txtDocmentDate.Text + " 23:59:59")
                    , Convert.ToInt32(ddlSortBy.SelectedValue),Convert.ToInt32(ddlOrderBy.SelectedValue));
                SAMS.BusinessLayer.Reports.CrpCreditAgingSummary CrpReport = new SAMS.BusinessLayer.Reports.CrpCreditAgingSummary();
                CrpReport.SetDataSource(ds);
                CrpReport.Refresh();

                CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
                CrpReport.SetParameterValue("Location", drpDistributor.SelectedItem.Text);
                CrpReport.SetParameterValue("Principal", DrpPrincipal.SelectedItem.Text);
                CrpReport.SetParameterValue("Customer", ddlCustomer.SelectedItem.Text);
                CrpReport.SetParameterValue("Date_To", txtDocmentDate.Text);
                this.Session.Add("CrpReport", CrpReport);
                this.Session.Add("ReportType", pType);
                string url = "'Default.aspx'";
                string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
                Type cstype = this.GetType();
                ClientScriptManager cs = Page.ClientScript;
                cs.RegisterStartupScript(cstype, "OpenWindow", script);
            }
        }
    }
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadCustomer();
    }
}