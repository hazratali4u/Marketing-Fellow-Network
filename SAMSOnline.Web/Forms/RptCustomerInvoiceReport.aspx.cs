using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    

public partial class Forms_RptCustomerInvoiceReport : System.Web.UI.Page
{
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(this.DrpPrincipal, m_dt, 0, 1);
    }
    private void LoadDistributor()
    {
        drpDistributor.Items.Clear();
   
        if (RblCustomer.SelectedIndex == 1)
        {
            DistributorController DController = new DistributorController();
            DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
            drpDistributor.Items.Add(new ListItem("All", "0"));
            clsWebFormUtil.FillDropDownList(this.drpDistributor, dt, 0, 2);
        }
        else
        {
            DistributorController DController = new DistributorController();
            DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(this.drpDistributor, dt, 0, 2);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadPrincipal();
            this.LoadDistributor();
            this.txtStartDate.Text = System.DateTime.Today.ToString("dd-MMM-yyyy");
            this.txtEndDate.Text = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        CustomerDataController mController = new CustomerDataController();
        DataTable dt = mController.RptSelectCustomer(int.Parse(this.Session["UserId"].ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), ddSearchType.SelectedValue.ToString(), txtSeach.Text, chkRegister.Checked);
        this.Grid_users.DataSource = dt;
        this.Grid_users.DataBind();
    }
    protected void BtnViewPdf_Click(object sender, EventArgs e)
    {
        string CustomerId = "0";
        string DistributorId = "0";

        DocumentPrintController DPrint = new DocumentPrintController();

        DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));

        if (RblCustomer.SelectedIndex == 0)
        {
            DocumentPrintController mDocumentPrntControl = new DocumentPrintController();
            DataSet ds = mDocumentPrntControl.SelectBillCustomerDetail(int.Parse(DrpPrincipal.SelectedValue.ToString()), CustomerId,drpDistributor.SelectedValue.ToString()
                , DateTime.Parse(this.txtStartDate.Text + " 00:00:00"), DateTime.Parse(this.txtEndDate.Text + " 23:59:59"),0, chkRegister.Checked);
            SAMS.BusinessLayer.Reports.CrpBillCustomerWiseReport CrpReport = new SAMS.BusinessLayer.Reports.CrpBillCustomerWiseReport();
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("PRINCIPAL", DrpPrincipal.SelectedItem.Text);
            CrpReport.SetParameterValue("FROM_DATE", txtStartDate.Text);
            CrpReport.SetParameterValue("TO_DATE", txtEndDate.Text);
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());

            this.Session.Add("CrpReport", CrpReport);
            this.Session.Add("ReportType", 0);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        else
        {
            
            foreach (GridViewRow dr in Grid_users.Rows)
            {
                CheckBox chbSelect = (CheckBox)(dr.Cells[0].FindControl("ChbCustomer"));
                if (chbSelect.Checked)
                {
                    CustomerId = CustomerId + "," + dr.Cells[1].Text;
                    DistributorId = DistributorId + "," + dr.Cells[2].Text;
                }
            }
            
            DocumentPrintController mDocumentPrntControl = new DocumentPrintController();
            DataSet ds = mDocumentPrntControl.SelectBillCustomerDetail(int.Parse(DrpPrincipal.SelectedValue.ToString()), CustomerId, DistributorId
                , DateTime.Parse(this.txtStartDate.Text + " 00:00:00"), DateTime.Parse(this.txtEndDate.Text + " 23:59:59"),1,chkRegister.Checked);
            SAMS.BusinessLayer.Reports.CrpBillCustomerWiseReport CrpReport = new SAMS.BusinessLayer.Reports.CrpBillCustomerWiseReport();
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("PRINCIPAL", DrpPrincipal.SelectedItem.Text);
            CrpReport.SetParameterValue("FROM_DATE", txtStartDate.Text);
            CrpReport.SetParameterValue("TO_DATE", txtEndDate.Text);
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());

            this.Session.Add("CrpReport", CrpReport);
            this.Session.Add("ReportType", 0);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
    }
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        string CustomerId = "0";
        string DistributorId = "0";
        DataSet ds;
        foreach (GridViewRow dr in Grid_users.Rows)
        {
            CheckBox chbSelect = (CheckBox)(dr.Cells[0].FindControl("ChbCustomer"));
            if (chbSelect.Checked)
            {
                CustomerId = CustomerId + "," + dr.Cells[1].Text;
                DistributorId = DistributorId + "," + dr.Cells[2].Text;
            }
        }

        DataSetToExcel dsexcel = new DataSetToExcel();

        DocumentPrintController mController = new DocumentPrintController();
        if (RblCustomer.SelectedIndex == 0)
        {
            ds = mController.SelectBillCustomerDetail(int.Parse(DrpPrincipal.SelectedValue.ToString()), CustomerId, drpDistributor.SelectedValue.ToString()
                , DateTime.Parse(this.txtStartDate.Text + " 00:00:00"), DateTime.Parse(this.txtEndDate.Text + " 23:59:59"), 0, chkRegister.Checked);
        }
        else
        {
            ds = mController.SelectBillCustomerDetail(int.Parse(DrpPrincipal.SelectedValue.ToString()), CustomerId, DistributorId
                , DateTime.Parse(this.txtStartDate.Text), DateTime.Parse(this.txtEndDate.Text), 1, chkRegister.Checked);
        }
        string path = SAMS.Common.Classes.Configuration.GetAppInstallationPath() + "\\CustomerBillWiseSale.xls";

        DataSetToExcel.exportToExcel(ds, path, "RptBillCustomerReport");

        System.IO.FileInfo file = new System.IO.FileInfo(path);

        if (file.Exists)
        {

            Response.Clear();

            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

            Response.AddHeader("Content-Length", file.Length.ToString());

            Response.ContentType = "application/octet-stream";

            Response.WriteFile(file.FullName);

            Response.End();

        }

        else
        {

            Response.Write("This file does not exist.");

        }
    }
    protected void RblCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadDistributor();
    }
}
