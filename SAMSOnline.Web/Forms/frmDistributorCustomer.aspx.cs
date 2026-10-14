using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    

public partial class Forms_frmDistributorCustomer : System.Web.UI.Page
{
    private static long CustomerId;
    private static string StrCode;

    private void LoadGroup()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectGroup(1);
        drpPriceGroup.Items.Add(new clsListItems("Default", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(drpPriceGroup, dt, 0, 1, false);
    }
    private void LoadDistributor()
    {
        DistributorController mController = new DistributorController();
        DataTable dt = mController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));      
        clsWebFormUtil.FillDropDownList(DrpDistributor, dt, 0, 2, true);

    }
    protected void LoadTown()
    {
        if (DrpDistributor.Items.Count > 0)
        {
            GeoHierarchyController gController = new GeoHierarchyController();
            DataTable dt = gController.SelectGeoHierarchy(int.Parse(DrpDistributor.SelectedValue.ToString()));
            clsWebFormUtil.FillDropDownList(DrpTown, dt, 0, 1, true);
        }       
    }
    private void LoadArea()
    {
        if (DrpDistributor.Items.Count > 0 && DrpTown.Items.Count > 0)
        {
            DistributorAreaController mController = new DistributorAreaController();
            DataTable dt = mController.SelectDist_Area(Constants.LongNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(DrpDistributor.SelectedValue.ToString()), int.Parse(DrpTown.SelectedValue.ToString()), null, null);
            clsWebFormUtil.FillDropDownList(DrpRoute, dt, 0, 6, true);
        }
    }
    private void LoadRoute()
    {
        if (DrpDistributor.Items.Count > 0 && DrpTown.Items.Count > 0 && DrpRoute.Items.Count > 0)
        {
            DistributorRouteController gController = new DistributorRouteController();
            DataTable dt = gController.SelectDistributorRoute(Constants.LongNullValue,int.Parse(DrpDistributor.SelectedValue.ToString()),int.Parse(DrpTown.SelectedValue.ToString()),long.Parse(DrpRoute.SelectedValue.ToString()));               
            clsWebFormUtil.FillDropDownList(DrpMarket, dt, 0, 8, true);

        }
        else
        {
            DrpMarket.Items.Clear();   
        }
    }
    private void ClearAll()
    {
        txtCustomerName.Text = "";
        txtContactPerson.Text = "";
        txtAddress.Text = "";
        txtemail.Text = "";
        txtPhoneNo.Text = "";
        txtSeach.Text = "";
        txtIsRegister.Text = "";
        lblErrorMsg.Text = "";
        txtGST.Text = "0";
        txtTax.Text = "0";
        txtCnic.Text = "";
        SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];
        txtRegdate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");

        btnSave.Text = "Save";
        Grid_users.DataSource = null;

        Grid_users.DataBind();
        LoadPrincipal();
        foreach (ListItem li in cblPromotion.Items)
        {
            li.Selected = false;
        }
    }
    private void LoadCustomer()
    {
        if (DrpDistributor.Items.Count > 0 && DrpTown.Items.Count > 0 && DrpRoute.Items.Count > 0 && DrpMarket.Items.Count > 0 )
        {
            CustomerDataController mController = new CustomerDataController();
            DataTable  dt = mController.UspSelectCustomer(int.Parse(DrpDistributor.SelectedValue.ToString()), ddSearchType.SelectedValue.ToString(), txtSeach.Text);     
            Grid_users.DataSource = dt;
            Grid_users.DataBind();  
        }
    }
    private void LoadChannelType()
    {
        SLASHCodesController mController = new SLASHCodesController();
        DataTable dt = mController.SelectSlashCodes(Constants.IntNullValue, null, Constants.CustomerChannelType, null, Constants.IntNullValue, bool.Parse("True"));
        clsWebFormUtil.FillDropDownList(drpChannelType, dt, 0, 2, true);

    }
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        GrdCreditLimit.DataSource = m_dt;
        GrdCreditLimit.DataBind();
    }
    private void LoadBusinessType()
    {
        SLASHCodesController mController = new SLASHCodesController();
        DataTable dt = mController.SelectSlashCodes(Constants.IntNullValue, null, Constants.CustomerTypeBusiness, null, Constants.IntNullValue, bool.Parse("True"));
        clsWebFormUtil.FillDropDownList(DrpBusinessType, dt, 0, 2, true);

    }
    private void LoadVolumeType()
    {
        SLASHCodesController mController = new SLASHCodesController();
        DataTable dt = mController.SelectSlashCodes(Constants.IntNullValue, null, Constants.CustomerVolumeClassType, null, Constants.IntNullValue, bool.Parse("True"));
        clsWebFormUtil.FillListBox(cblPromotion, dt, 0, 2, true);

    }
    private void UpdateCustomerPrincipalCredit()
    {
        CustomerDataController mCustomer = new CustomerDataController();
        DataControl dc = new DataControl();
        mCustomer.UpdateCustomerCreditLimit(int.Parse(DrpDistributor.SelectedValue.ToString()), CustomerId, Constants.IntNullValue, Constants.DecimalNullValue);
        for (int i = 0; i < GrdCreditLimit.Rows.Count; i++)
        {
            TextBox txtCrLimit = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditLimit");
            TextBox txtCrDays = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditDays");
            if (decimal.Parse(dc.chkNull_0(txtCrLimit.Text)) > 0)
            {
                mCustomer.InsertCustomerCreditLimit(int.Parse(DrpDistributor.SelectedValue.ToString()), CustomerId, int.Parse(GrdCreditLimit.Rows[i].Cells[0].Text), decimal.Parse(txtCrLimit.Text),int.Parse(txtCrDays.Text));
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadGroup();
            this.LoadPrincipal();
            this.LoadDistributor();
            this.LoadTown();
            this.LoadArea();
            this.LoadRoute();
            this.LoadChannelType();
            this.LoadBusinessType();
            this.LoadVolumeType();
            btnSave.Attributes.Add("onclick", "return ValidateForm()");
            Button2.Attributes.Add("onclick", "return SearchRecord()");
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];     
            txtRegdate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ChbIsRegister.Checked)
        {
            if (string.IsNullOrEmpty(txtGST.Text) || string.IsNullOrEmpty(txtIsRegister.Text)) 
            {
                lblErrorMsg.Text = "Plz enter Register No OR GST !";
                return;
            }
        }
        else
        {
            lblErrorMsg.Text = "";
        }
        CustomerDataController mController = new CustomerDataController();

        DataTable dtPromtoionClass = new DataTable();
        dtPromtoionClass.Columns.Add("PROMOTION_CLASS_ID", typeof(int));

        foreach (ListItem li in cblPromotion.Items)
        {
            if (li.Selected)
            {
                DataRow dr = dtPromtoionClass.NewRow();
                dr["PROMOTION_CLASS_ID"] = li.Value;
                dtPromtoionClass.Rows.Add(dr);
            }
        }
        decimal tax = 0;

        try
        {
            tax = Convert.ToDecimal(txtTax.Text);
        }
        catch (Exception ex)
        {
            tax = 0;
        }
        if (btnSave.Text == "Save")
        {
            SETTINGS_TABLE_Controller mSettingsTableControl = new SETTINGS_TABLE_Controller();
            DataTable dtSettingsTable = mSettingsTableControl.Select_SETTINGS_TABLE("CUSTOMER", "CUSTOMER_ID", int.Parse(DrpDistributor.SelectedValue.ToString()));

            if (dtSettingsTable.Rows.Count > 0)
            {
                CustomerId = long.Parse(dtSettingsTable.Rows[0]["Value"].ToString()) + 1;
                if (CustomerId.ToString().Length == 1)
                {
                    StrCode = "OT0000" + CustomerId.ToString();
                }
                else if (CustomerId.ToString().Length == 2)
                {
                    StrCode = "OT000" + CustomerId.ToString();
                }
                else if (CustomerId.ToString().Length == 3)
                {
                    StrCode = "OT00" + CustomerId.ToString();
                }
                else if (CustomerId.ToString().Length == 4)
                {
                    StrCode = "OT0" + CustomerId.ToString();
                }
                else if (CustomerId.ToString().Length == 5)
                {
                    StrCode = "OT" + CustomerId.ToString();
                }
                
                mController.InsertCustomer(CustomerId, ChbIsRegister.Checked,decimal.Parse(txtGST.Text), chkIsActive.Checked,
                int.Parse(drpChannelType.SelectedValue.ToString()), 1,
                int.Parse(DrpBusinessType.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), int.Parse(DrpMarket.SelectedValue.ToString()),
                int.Parse(DrpTown.SelectedValue.ToString()), int.Parse(DrpDistributor.SelectedValue.ToString()), txtIsRegister.Text, txtContactPerson.Text,
                txtPhoneNo.Text, txtemail.Text, StrCode, txtCustomerName.Text, txtAddress.Text, DateTime.Parse(txtRegdate.Text)
                ,Convert.ToInt32(drpPriceGroup.SelectedValue),tax, dtPromtoionClass,txtCnic.Text);
            }
        }
        else
        {
            mController.UpdateCustomer(CustomerId, ChbIsRegister.Checked, decimal.Parse(txtGST.Text), chkIsActive.Checked,
            int.Parse(drpChannelType.SelectedValue.ToString()), 1,
            int.Parse(DrpBusinessType.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), int.Parse(DrpMarket.SelectedValue.ToString()),
            int.Parse(DrpTown.SelectedValue.ToString()), int.Parse(DrpDistributor.SelectedValue.ToString()), txtIsRegister.Text, txtContactPerson.Text,
            txtPhoneNo.Text, txtemail.Text, null, txtCustomerName.Text, txtAddress.Text, DateTime.Parse(txtRegdate.Text),Convert.ToInt32(drpPriceGroup.SelectedValue),tax, dtPromtoionClass,txtCnic.Text);
        }
        UpdateCustomerPrincipalCredit();
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Record Update');", true); 
        ClearAll();
     }
    protected void DrpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadTown();
        LoadArea();
        LoadRoute();
    }
    protected void DrpTown_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadArea();
        LoadRoute();
    }
    protected void DrpRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadRoute();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        LoadCustomer(); 
    }
    protected void Grid_users_RowEditing(object sender, GridViewEditEventArgs e)
    {
         
        CustomerId = int.Parse(Grid_users.Rows[e.NewEditIndex].Cells[0].Text);
        DrpDistributor.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[1].Text;
        DrpBusinessType.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[2].Text;
        drpChannelType.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[4].Text;
        LoadTown();  
        DrpTown.SelectedValue =  Grid_users.Rows[e.NewEditIndex].Cells[5].Text;
        LoadArea();
        DrpRoute.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[6].Text;
        LoadRoute();
        DrpMarket.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[7].Text;
        txtCustomerName.Text = Grid_users.Rows[e.NewEditIndex].Cells[9].Text.Replace("amp;", "");
        txtContactPerson.Text = Grid_users.Rows[e.NewEditIndex].Cells[10].Text.Replace("&nbsp;", "");
        txtPhoneNo.Text = Grid_users.Rows[e.NewEditIndex].Cells[11].Text.Replace("&nbsp;", "");
        txtemail.Text = Grid_users.Rows[e.NewEditIndex].Cells[12].Text.Replace("&nbsp;", "");
        txtAddress.Text = Grid_users.Rows[e.NewEditIndex].Cells[13].Text.Replace("&nbsp;", "");
        txtIsRegister.Text = Grid_users.Rows[e.NewEditIndex].Cells[14].Text.Replace("&nbsp;", "");
        txtCnic.Text = Grid_users.Rows[e.NewEditIndex].Cells[24].Text.Replace("&nbsp;", "");
        if (Grid_users.Rows[e.NewEditIndex].Cells[14].Text.Trim() == "&nbsp;")
        {
            txtIsRegister.Text = "";
            ChbIsRegister.Checked = false;
            lblGST.Visible = false;
            txtGST.Visible = false;
            lblTax.Visible = false;
            txtTax.Visible = false;
            txtGST.Text = "0";
        }
        else
        {
            ChbIsRegister.Checked = true;
            lblGST.Visible = true;
            txtGST.Visible = true;
            lblTax.Visible = true;
            txtTax.Visible = true;
            txtGST.Text = Grid_users.Rows[e.NewEditIndex].Cells[21].Text;
            txtTax.Text = Grid_users.Rows[e.NewEditIndex].Cells[23].Text;
           
            txtIsRegister.Text = Grid_users.Rows[e.NewEditIndex].Cells[14].Text;
        }
        chkIsActive.Checked = bool.Parse(Grid_users.Rows[e.NewEditIndex].Cells[19].Text);

        txtRegdate.Text = Grid_users.Rows[e.NewEditIndex].Cells[20].Text.Replace("&nbsp;","");
        if (txtRegdate.Text == "")
        {
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];
            txtRegdate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
        CustomerDataController mCustomer = new CustomerDataController();
        for (int i = 0; i < GrdCreditLimit.Rows.Count; i++)
        {
            DataTable dtCLimit = mCustomer.SelectCustomerCreditLimit(int.Parse(DrpDistributor.SelectedValue.ToString()), CustomerId, int.Parse(GrdCreditLimit.Rows[i].Cells[0].Text));
            if (dtCLimit.Rows.Count > 0)
            {
                TextBox txtCLimit = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditLimit");
                TextBox txtCRDays = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditDays");

                txtCLimit.Text = dtCLimit.Rows[0]["CREDITLIMIT_VALUE"].ToString();
                txtCRDays.Text = dtCLimit.Rows[0]["CREDIT_DAYS"].ToString();
            }
            else
            {
                TextBox txtCLimit = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditLimit");
                TextBox txtCRDays = (TextBox)GrdCreditLimit.Rows[i].FindControl("txtCreditDays");

                txtCLimit.Text = "0";
                txtCRDays.Text = "0";
            }
        }
        if (Grid_users.Rows[e.NewEditIndex].Cells[22].Text.Replace("&nbsp;", "").Length > 0)
        {
            drpPriceGroup.SelectedValue = Grid_users.Rows[e.NewEditIndex].Cells[22].Text.Replace("&nbsp;", "");
        }
        else
        {
            drpPriceGroup.SelectedValue = Constants.IntNullValue.ToString();
        }
        btnSave.Text = "Update";
        this.LoadPromotionClass(long.Parse(Grid_users.Rows[e.NewEditIndex].Cells[0].Text), Convert.ToInt32(DrpDistributor.SelectedValue));
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ClearAll(); 
    }
    protected void Grid_users_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Grid_users.PageIndex = e.NewPageIndex;
        LoadCustomer(); 
    }
    protected void ChbIsRegister_CheckedChanged(object sender, EventArgs e)
    {
        if (ChbIsRegister.Checked)
        {
            txtIsRegister.Text = "";
            txtIsRegister.Enabled = true;
            lblGST.Visible = true;
            txtGST.Visible = true;
            lblTax.Visible = true;
            txtTax.Visible = true;
            txtGST.Text = "0";
            txtTax.Text = "0";
        }
        else
        {
            txtIsRegister.Text = "";
            lblGST.Visible = false;
            txtGST.Visible = false;
            lblTax.Visible = false;
            txtTax.Visible = false;
            txtGST.Text = "0";
            txtTax.Text = "0";
            txtIsRegister.Enabled = false;
        }
    }

    private void LoadPromotionClass(long CustomerID, int DistributorID)
    {
        CustomerDataController mController = new CustomerDataController();
        DataTable dt = mController.GetCustomerPromotionClass(DistributorID, CustomerID, Constants.IntNullValue);

        foreach (ListItem li in cblPromotion.Items)
        {
            li.Selected = false;
        }

        foreach (DataRow dr in dt.Rows)
        {
            foreach (ListItem li in cblPromotion.Items)
            {
                if (dr["PROMOTION_CLASS_ID"].ToString() == li.Value)
                {
                    li.Selected = true;
                }
            }
        }

    }
}