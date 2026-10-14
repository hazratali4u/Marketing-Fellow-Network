using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    

public partial class Forms_RptStockReconcilation : System.Web.UI.Page
{
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        DrpPrincipal.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));       
        clsWebFormUtil.FillDropDownList(DrpPrincipal, m_dt, 0, 1);
    }
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 2, true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadDistributor();
            LoadPrincipal();
            LoadCategories();
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"]; 
            txtStartDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
            txtEndDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }

    private void LoadCategories()
    {
        LstCategory.Items.Clear();

        SkuHierarchyController sController = new SkuHierarchyController();
        DataTable dt = sController.SelectSKUCategories(int.Parse(DrpPrincipal.SelectedValue), false, int.Parse(this.Session["UserId"].ToString()));
        clsWebFormUtil.FillListBox(LstCategory, dt, 0, 3, false);
    }
    protected void btnPDF_Click(object sender, EventArgs e)
    {
        string Catagories_IDs = null;

        DocumentPrintController mController = new DocumentPrintController();
        SAMS.BusinessLayer.Reports.StockReConsilation CrpReport = new SAMS.BusinessLayer.Reports.StockReConsilation();
        for (int i = 0; i < LstCategory.Items.Count; i++)
        {
            if (LstCategory.Items[i].Selected == true)
            {
                Catagories_IDs += LstCategory.Items[i].Value.ToString() + ",";
            }
        }
        if (Catagories_IDs == null)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Plz Select AtLeast One Category.');", true);
            return;
        }
        DataSet ds = mController.SelectPrincipalStockReconcilation(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpPrincipal.SelectedValue.ToString()), DateTime.Parse(txtStartDate.Text), DateTime.Parse(txtEndDate.Text), int.Parse(Session["UserId"].ToString()), Catagories_IDs);
        CrpReport.SetDataSource(ds);
        CrpReport.Refresh();


        CrpReport.SetParameterValue("division", drpDistributor.SelectedItem.Text);
        CrpReport.SetParameterValue("fromdate", txtStartDate.Text);
        CrpReport.SetParameterValue("todate", txtEndDate.Text );
        Session.Add("CrpReport", CrpReport);
        Session.Add("ReportType", 0);  
        const string url = "'Default.aspx'";
        const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
        Type cstype = GetType();
        ClientScriptManager cs = Page.ClientScript;
        cs.RegisterStartupScript(cstype, "OpenWindow", script);            
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        string Catagories_IDs = null;
        DocumentPrintController mController = new DocumentPrintController();
        SAMS.BusinessLayer.Reports.StockReConsilation CrpReport = new SAMS.BusinessLayer.Reports.StockReConsilation();
        for (int i = 0; i < LstCategory.Items.Count; i++)
        {
            if (LstCategory.Items[i].Selected == true)
            {
                Catagories_IDs += LstCategory.Items[i].Value.ToString() + ",";
            }
        }
        if (Catagories_IDs == null)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Plz Select AtLeast One Category.');", true);
            return;
        }
        DataSet ds = mController.SelectPrincipalStockReconcilation(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpPrincipal.SelectedValue.ToString()), DateTime.Parse(txtStartDate.Text), DateTime.Parse(txtEndDate.Text), int.Parse(Session["UserId"].ToString()), Catagories_IDs);
        
        string path = SAMS.Common.Classes.Configuration.GetAppInstallationPath() + "\\StockReconciliation.xls";

        DataSetToExcel.exportToExcel(ds, path, "StockRegister");

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
    protected void DrpPrincipal_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        ChbAllCategory.Checked = false;
        LoadCategories();
    }
}
