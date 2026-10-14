using System;
using System.Data;
using System.Web.UI;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;
    
public partial class Forms_frmOpeingCredit : System.Web.UI.Page
{
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(this.drpDistributor, dt, 0, 2, true);
    }
    private void LoadArea()
    {
        if (drpDistributor.Items.Count > 0)
        {
            DistributorAreaController mController = new DistributorAreaController();
            DataTable dt = mController.SelectDist_Area(Constants.LongNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, null, null);
            clsWebFormUtil.FillDropDownList(DrpRoute, dt, 0, 6, true);
        }
        else
        {
            DrpRoute.Items.Clear();
        }
    }
    private void LoadData()
    {
        if (drpDistributor.Items.Count > 0 && DrpRoute.Items.Count > 0)
        {
            CustomerDataController mController = new CustomerDataController();
            DataTable dt = mController.SelectPrincipalCustomer(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(DrpPrincipal.SelectedValue.ToString()));
            clsWebFormUtil.FillListBox(this.ListCustomer, dt, "CUSTOMER_DETAIL", "CUSTOMER_DETAIL", true);
            this.Session.Add("dt", dt);
        }
    }
    private void ClearAll()
    {
        txtChequeNo.Text = "";
        txtOutletCode.Text = "";
        txtAmount.Text = "";
        txtOutletName.Text = "";
        txtRemarks.Text = "";
        txtOutletCode.Focus();
    }
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(this.DrpPrincipal, m_dt, 0, 1, true);
    }  
    private void LoadDeliveryman()
    {
        if (drpDistributor.Items.Count > 0 && DrpRoute.Items.Count > 0)
        {
            Distributor_UserController mDController = new Distributor_UserController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), int.Parse(this.Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(this.DrpDeliveryMan, m_dt, 0, 3, true);
        }
        else
        {
            DrpDeliveryMan.Items.Clear();
        }
    }
    private void LoadOpeningCredit()
    {
        if (drpDistributor.Items.Count > 0)
        {
            CustomerDataController cdc = new CustomerDataController();
            DataTable dt = cdc.SelectOpeningCredit(int.Parse(drpDistributor.SelectedValue.ToString()));
            GrdOrder.DataSource = dt;
            GrdOrder.DataBind();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadPrincipal();
            this.LoadDistributor();
            this.LoadArea();
            this.LoadData();           
            this.LoadDeliveryman();
            this.LoadOpeningCredit();
            Button1.Attributes.Add("onclick", "return ValidateForm()");
        }
    }
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadArea();
        this.LoadData();
        this.LoadDeliveryman();
        this.LoadOpeningCredit();
    }
    protected void DrpRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
       this.LoadData();
       this.LoadDeliveryman(); 
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        OrderEntryController or = new OrderEntryController();
        DataTable dtCustomer = (DataTable)this.Session["dt"];
        DataRow[] foundRows = dtCustomer.Select("CUSTOMER_CODE  = '" + txtOutletCode.Text.Trim() + "'");
        if (foundRows.Length > 0)
        {
            or.OpeningCredit(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(foundRows[0]["TOWN_ID"].ToString()), int.Parse(DrpRoute.SelectedValue.ToString()),
            DateTime.Parse(txtFromdate.Text),int.Parse(DrpPrincipal.SelectedValue.ToString()), long.Parse(foundRows[0]["CUSTOMER_ID"].ToString()), long.Parse(foundRows[0]["CUSTOMER_ID"].ToString()),
            -1, int.Parse(DrpDeliveryMan.SelectedValue.ToString()), decimal.Parse(txtAmount.Text), int.Parse(this.Session["UserId"].ToString()));
            this.ClearAll();
            this.LoadOpeningCredit();
        }
        ScriptManager.GetCurrent(Page).SetFocus(txtOutletCode);   
       
    }
    protected void DrpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadData();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        this.ClearAll();
    }
}
