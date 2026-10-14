using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    

public partial class Forms_frmPurchaseEntry : System.Web.UI.Page
{
    readonly SKUPriceDetailController _pController = new SKUPriceDetailController();
    readonly DataControl _dc = new DataControl();
    private static int _rowNo;
    private static int _privouseQty, _freePrivousQty;
    DataTable _purchaseSku;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadPrincipal();
            LoadDistributor();
            LoadSkuDetail();
            CreatTable();
            GetDocumentNo();
            btnSave.Attributes.Add("onclick", "return ValidateForm();");
            SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];

            txtStartDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }
    private void CreatTable()
    {
        _purchaseSku = new DataTable();
        _purchaseSku.Columns.Add("PURCHASE_DETAIL_ID", typeof(long));
        _purchaseSku.Columns.Add("SKU_ID", typeof(int));
        _purchaseSku.Columns.Add("SKU_Code", typeof(string));
        _purchaseSku.Columns.Add("SKU_Name", typeof(string));
        _purchaseSku.Columns.Add("BATCH_NO", typeof(string));
        _purchaseSku.Columns.Add("PRICE", typeof(decimal));
        _purchaseSku.Columns.Add("Quantity", typeof(int));
        _purchaseSku.Columns.Add("FREE_SKU", typeof(int));
        _purchaseSku.Columns.Add("AMOUNT", typeof(decimal));
        _purchaseSku.Columns.Add("EXPIRY_DATE", typeof(DateTime));
        Session.Add("PurchaseSKU", _purchaseSku);  
    
    }
    private void GetDocumentNo()
    {
        drpDocumentNo.Items.Clear();   
        DateTime MWorkDate = System.DateTime.Now;
        PurchaseController mPurchase = new PurchaseController();
        DataTable dt = mPurchase.SelectPurchaseDocumentNo(int.Parse(DrpDocumentType.SelectedValue.ToString()),Constants.IntNullValue,Constants.LongNullValue,int.Parse(Session["UserId"].ToString()),0);
        drpDocumentNo.Items.Add(new clsListItems("New", Constants.LongNullValue.ToString()));          
        clsWebFormUtil.FillDropDownList(drpDocumentNo, dt, 0, 0);
    }
    private void LoadPrincipal()
    {
        DataTable m_dt = _pController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(drpPrincipal, m_dt, 0, 1,true);
    }
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 2,true);
    }
    private void LoadToDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(DrpTransferFor, dt, 0, 2, true);
    }
    private void ClearAll()
    {
        txtskuCode.Text = "";
        txtskuName.Text = "";
        txtQuantity.Text = "";
        txtFreeSKU.Text = "0";
        txtBatchNo.Text = "N/A";
        txtskuCode.Enabled = true;
        btnSave.Text = "Add Sku";
        _privouseQty = 0;
        _freePrivousQty = 0;
        SAMS.Common.Classes.Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];

        txtStartDate.Text = SAMS.Common.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
    }
    private void LoadGird()
    {
        int TotalValue = 0;
        _purchaseSku = (DataTable)Session["PurchaseSKU"];
        if (DrpDocumentType.SelectedIndex == 0)
        {
            GrdPurchase.Columns[6].Visible = true;
        }
        else
        {
            GrdPurchase.Columns[6].Visible = false ;
        }
         
        GrdPurchase.DataSource = _purchaseSku;
        GrdPurchase.DataBind();
        foreach (DataRow dr in _purchaseSku.Rows)
        {
            TotalValue += int.Parse(dr["Quantity"].ToString());

        }
        txtTotalQuantity.Text = TotalValue.ToString(); 
    }
    private void DisAbaleOption(bool IsDisable)
    {
        if (IsDisable == true)
        {
            DrpDocumentType.Enabled = false;
            drpPrincipal.Enabled = false;
            drpDistributor.Enabled = false;
            drpDocumentNo.Enabled = false;
            
        }
        else
        {
            
            DrpDocumentType.Enabled = true;
            drpPrincipal.Enabled = true;
            drpDistributor.Enabled = true;
            drpDocumentNo.Enabled = true;
            drpDocumentNo.SelectedIndex = 0;
        }
    }
    private int CheckStockStatus(int skuId)
    {
        if (DrpDocumentType.SelectedIndex == 0 || DrpDocumentType.SelectedIndex == 3)
        {
            return -1;
        }
        else
        {
            PurchaseController mController = new PurchaseController();
            DataTable dt = mController.SelectSKUClosingStock(int.Parse(drpDistributor.SelectedValue.ToString()), skuId,txtBatchNo.Text);
            if (dt.Rows.Count > 0)
            {
                if (int.Parse(dt.Rows[0][0].ToString()) + _privouseQty + _freePrivousQty >= int.Parse(txtQuantity.Text))
                {
                    return -1;
                }
                else
                {
                    return int.Parse(dt.Rows[0][0].ToString()) + _privouseQty + _freePrivousQty;
                }
            }
        }
              
        return 0; 
    }
    private bool CalculatePurchase(DateTime mWorkDate)
    {
        decimal mTotalAmount = 0;
           
        PurchaseController mController = new PurchaseController();
        DataTable  dtPurchaseDetail = (DataTable)Session["PurchaseSKU"];
        foreach (DataRow dr in dtPurchaseDetail.Rows)
        {
            mTotalAmount += decimal.Parse(dr["AMOUNT"].ToString());
                    
        }
        if (DrpDocumentType.SelectedIndex == 0)
        {
            if (drpDocumentNo.SelectedValue.ToString() == Constants.LongNullValue.ToString())
            {
                bool mResult = mController.InsertPurchaseDocument2(int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()), mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()),int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
            else
            {
                bool mResult = mController.UpdatePurchaseDocument2(int.Parse(drpDocumentNo.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()), mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
        }
        else if (DrpDocumentType.SelectedIndex == 1) 
        {
            if (drpDocumentNo.SelectedValue.ToString() == Constants.LongNullValue.ToString())
            {
                bool mResult = mController.InsertPurchaseDocument2(int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(DrpTransferFor.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
            else
            {
                bool mResult = mController.UpdatePurchaseDocument2(int.Parse(drpDocumentNo.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(DrpTransferFor.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
        }
        else if (DrpDocumentType.SelectedIndex == 2)
        {
            if (drpDocumentNo.SelectedValue.ToString() == Constants.LongNullValue.ToString())
            {
                bool mResult = mController.InsertPurchaseDocument2(int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpPrincipal.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
            else
            {
                bool mResult = mController.UpdatePurchaseDocument2(int.Parse(drpDocumentNo.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpPrincipal.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
        }
        else if (DrpDocumentType.SelectedIndex == 3)
        {
            if (drpDocumentNo.SelectedValue.ToString() == Constants.LongNullValue.ToString())
            {
                bool mResult = mController.InsertPurchaseDocument2(int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpTransferFor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
            else
            {
                bool mResult = mController.UpdatePurchaseDocument2(int.Parse(drpDocumentNo.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue.ToString())
                , mWorkDate, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpTransferFor.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
                return mResult;
            }
        }
        else
        {
            if (drpDocumentNo.SelectedValue == Constants.LongNullValue.ToString())
            {
                bool mResult = mController.InsertPurchaseDocument2(int.Parse(drpDistributor.SelectedValue), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue)
                , mWorkDate, int.Parse(drpDistributor.SelectedValue), int.Parse(drpPrincipal.SelectedValue.ToString())
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue));
                return mResult;
            }
            else
            {
                bool mResult = mController.UpdatePurchaseDocument2(int.Parse(drpDocumentNo.SelectedValue), int.Parse(drpDistributor.SelectedValue), txtDocumentNo.Text, int.Parse(DrpDocumentType.SelectedValue)
                , mWorkDate, int.Parse(drpDistributor.SelectedValue), int.Parse(drpPrincipal.SelectedValue)
                , mTotalAmount, false, dtPurchaseDetail, 0, txtBuiltyNo.Text, int.Parse(Session["UserId"].ToString()), int.Parse(drpPrincipal.SelectedValue));
                return mResult;
            }
        }
    }
    private void LoadSkuDetail()
    {
        if (drpPrincipal.Items.Count > 0)
        {
            DataTable Dtsku_Price = _pController.SelectDataPrice(int.Parse(drpPrincipal.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 1, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
            clsWebFormUtil.FillListBox(lstCode, Dtsku_Price, 9, 9, true);
            Session.Add("Dtsku_Price", Dtsku_Price);
        }
    }
    private void LoadDocumentDetail()
    {
            DateTime MWorkDate = System.DateTime.Now;
            PurchaseController mPurchase = new PurchaseController();
            DataTable dt = mPurchase.SelectPurchaseDocumentNo(Constants.IntNullValue,Constants.IntNullValue,long.Parse(drpDocumentNo.SelectedValue.ToString()),Constants.IntNullValue,Constants.IntNullValue);
            if (dt.Rows.Count > 0)
            {
                if (DrpDocumentType.SelectedIndex == 0 || DrpDocumentType.SelectedIndex == 4)
                {
                    drpDistributor.SelectedValue = dt.Rows[0]["SOLD_TO"].ToString();
                    drpPrincipal.SelectedValue = dt.Rows[0]["SOLD_FROM"].ToString();
                    txtDocumentNo.Text = dt.Rows[0][2].ToString();
                    txtBuiltyNo.Text = dt.Rows[0]["BUILTY_NO"].ToString();
                }
                else if (DrpDocumentType.SelectedIndex == 1)
                {
                    drpDistributor.SelectedValue = dt.Rows[0]["SOLD_FROM"].ToString();
                    DrpTransferFor.SelectedValue = dt.Rows[0]["SOLD_TO"].ToString();
                    txtDocumentNo.Text = dt.Rows[0][2].ToString();
                    txtBuiltyNo.Text = dt.Rows[0]["BUILTY_NO"].ToString();
                }
                else if (DrpDocumentType.SelectedIndex == 2)
                {
                    drpPrincipal.SelectedValue = dt.Rows[0]["SOLD_TO"].ToString();
                    drpDistributor.SelectedValue = dt.Rows[0]["SOLD_FROM"].ToString();
                    txtDocumentNo.Text = dt.Rows[0][2].ToString();
                    txtBuiltyNo.Text = dt.Rows[0]["BUILTY_NO"].ToString();
                }
                else
                {
                    DrpTransferFor.SelectedValue = dt.Rows[0]["SOLD_FROM"].ToString();
                    drpDistributor.SelectedValue = dt.Rows[0]["SOLD_TO"].ToString();
                    txtDocumentNo.Text = dt.Rows[0][2].ToString();
                    txtBuiltyNo.Text = dt.Rows[0]["BUILTY_NO"].ToString();
                }
                _purchaseSku = mPurchase.SelectPurchaseDetail(Constants.IntNullValue, long.Parse(dt.Rows[0][0].ToString()));
                Session.Add("PurchaseSKU", _purchaseSku);
                LoadGird();

            }
    }
    private bool CheckDublicateSku()
    {
        DataControl dc = new DataControl();
        DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
        _purchaseSku = (DataTable)Session["PurchaseSKU"];
        DataRow[] foundRows = _purchaseSku.Select("SKU_CODE  = '" + txtskuCode.Text + "'");
        if (foundRows.Length == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
   
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
        _purchaseSku = (DataTable)Session["PurchaseSKU"];
        DataRow[] foundRows = Dtsku_Price.Select("SKU_CODE  = '" + txtskuCode.Text + "'");
        if (foundRows.Length > 0)
        {
            decimal mStdDiscount = decimal.Parse(_dc.chkNull_0(foundRows[0]["DISTRIBUTOR_DISCOUNT"].ToString()));
            decimal mGSTRate = decimal.Parse(_dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString()));
            int CurrentStock  = CheckStockStatus(int.Parse(_dc.chkNull_0(foundRows[0]["SKU_ID"].ToString())));
           
                if (btnSave.Text == "Add Sku")
                {
                    if (CheckDublicateSku())
                    {
                        if (CurrentStock == -1)
                        {
                            DataRow dr = _purchaseSku.NewRow();
                            dr["SKU_ID"] = foundRows[0]["SKU_ID"];
                            dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
                            dr["SKU_Name"] = foundRows[0]["SKU_NAME"];
                            dr["BATCH_NO"] = txtBatchNo.Text;
                            dr["FREE_SKU"] = int.Parse(_dc.chkNull_0(txtFreeSKU.Text));
                            dr["PRICE"] = foundRows[0]["TRADE_PRICE"];
                            dr["Quantity"] = int.Parse(_dc.chkNull_0(txtQuantity.Text));
                            dr["AMOUNT"] = decimal.Parse(foundRows[0]["TRADE_PRICE"].ToString()) * decimal.Parse(_dc.chkNull_0(txtQuantity.Text));
                        dr["EXPIRY_DATE"] = Constants.DateNullValue;
                        if (DrpDocumentType.SelectedIndex == 0)
                        {
                            dr["EXPIRY_DATE"] = DateTime.Parse(txtStartDate.Text);
                        }
                        _purchaseSku.Rows.Add(dr);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('  " + txtskuCode.Text + " Current closing Stock is " + CurrentStock.ToString() + "');", true);
                            txtskuName.Text = foundRows[0]["SKU_NAME"].ToString();
                            return;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('  " + txtskuCode.Text + " Already Exists ');", true);
                        txtskuName.Text = foundRows[0]["SKU_NAME"].ToString();
                        return;
                    }
                }
                else if (btnSave.Text == "Update Sku")
                {
                    if (CurrentStock == -1)
                    {
                        DataRow dr = _purchaseSku.Rows[_rowNo];
                        dr["SKU_ID"] = foundRows[0]["SKU_ID"];
                        dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
                        dr["SKU_Name"] = foundRows[0]["SKU_NAME"];
                        dr["BATCH_NO"] = txtBatchNo.Text;
                        dr["PRICE"] = foundRows[0]["TRADE_PRICE"];
                        dr["Quantity"] = int.Parse(txtQuantity.Text);
                        dr["FREE_SKU"] = int.Parse(_dc.chkNull_0(txtFreeSKU.Text));
                        dr["AMOUNT"] = decimal.Parse(foundRows[0]["TRADE_PRICE"].ToString()) * decimal.Parse(_dc.chkNull_0(txtQuantity.Text));
                    dr["EXPIRY_DATE"] = Constants.DateNullValue;
                    if (DrpDocumentType.SelectedIndex == 0)
                    {
                        dr["EXPIRY_DATE"] = DateTime.Parse(txtStartDate.Text);
                    }
                }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('  " + txtskuCode.Text + "Current closing Stock is " + CurrentStock.ToString() + "');", true); 
                        txtskuName.Text = foundRows[0]["SKU_NAME"].ToString();
                        return; 
                    }
                  
                }
                
                Session.Add("PurchaseSKU", _purchaseSku);
                ClearAll();
                LoadGird();
                DisAbaleOption(true);
                ScriptManager.GetCurrent(Page).SetFocus(txtskuCode);
                   
            }
            
        
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Wrong SKU Select');", true); 
 
        }
         
                
     }
    protected void GrdPurchase_RowEditing(object sender, GridViewEditEventArgs e)
    {
        _rowNo = e.NewEditIndex;
        txtskuCode.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[1].Text;
        txtskuName.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[2].Text;
        txtQuantity.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text;
        _privouseQty = int.Parse(GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text);
        _freePrivousQty = int.Parse(GrdPurchase.Rows[e.NewEditIndex].Cells[4].Text);
        txtFreeSKU.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[4].Text;
        txtBatchNo.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[5].Text;
      
        if (DrpDocumentType.SelectedIndex == 0)
        {
            txtStartDate.Text= Convert.ToDateTime(GrdPurchase.Rows[e.NewEditIndex].Cells[6].Text).ToString("dd-MMM-yyyy");
        }
        txtskuCode.Enabled = false;
        txtQuantity.Focus();  
        btnSave.Text = "Update Sku"; 
      
    }
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        _purchaseSku = (DataTable)Session["PurchaseSKU"];
        if (_purchaseSku.Rows.Count > 0)
        {
            _purchaseSku.Rows.RemoveAt(e.RowIndex);     
            Session.Add("PurchaseSKU", _purchaseSku);
            LoadGird(); 
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Configuration.SystemCurrentDateTime = (DateTime)Session["CurrentWorkDate"];     
        if (DrpDocumentType.SelectedIndex == 2 || DrpDocumentType.SelectedIndex == 3)
        {
            if (drpDistributor.SelectedValue == DrpTransferFor.SelectedValue)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert(' Transfer to Location must be different ');", true); 
                return; 
            }
        }
        _purchaseSku = (DataTable)Session["PurchaseSKU"];
        if (_purchaseSku.Rows.Count > 0)
        {
               var mDayClose = new SAMSUserController();
               DataTable dt = mDayClose.SelectMaxDayClose(Constants.IntNullValue,int.Parse(drpDistributor.SelectedValue));
               if (dt.Rows.Count > 0)
               {
                   if (CalculatePurchase(DateTime.Parse(dt.Rows[0]["CLOSING_DATE"].ToString())))
                   {
                       _purchaseSku = (DataTable)Session["PurchaseSKU"];
                       _purchaseSku.Rows.Clear();
                       Session.Add("PurchaseSKU", _purchaseSku);
                       LoadGird();
                       GetDocumentNo();
                       drpDistributor.Enabled = true;
                       drpPrincipal.Enabled = true;
                       DrpDocumentType.Enabled = true;
                       ClearAll();
                       txtBuiltyNo.Text = "";
                       txtDocumentNo.Text = ""; 
                       txtDocumentNo.Text = "";
                       DisAbaleOption(false);
                   }
               }
               else
               {
                   ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Wrong Location');", true);  
               }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert(' At least one SKU must enter');", true);  
            
        }

    }
    protected void DrpDocumentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DrpDocumentType.SelectedIndex == 0)
        {
            lbltoLocation.Text = "Principal";
            lblfromLocation.Text = "Purchase For";
            drpDistributor.Enabled = true;
            drpPrincipal.Enabled = true;
            DrpTransferFor.Visible = false;
            Label4.Visible = false;
            GetDocumentNo();
            lblexpiryDate.Visible = true;
            txtStartDate.Visible =  true;
            ibtnStartDate.Visible = true;
            lblexirytemp.Visible=false;
        }
        else if (DrpDocumentType.SelectedIndex == 1)
        {
            lblfromLocation.Text = "Transfer From";
            drpDistributor.Enabled = true;
            drpPrincipal.Enabled = true;
            LoadToDistributor();
            DrpTransferFor.Visible = true;
            Label4.Visible = true;
            Label4.Text = "Transfer To";
            GetDocumentNo();
            lblexpiryDate.Visible = false;
            txtStartDate.Visible =  false;
            ibtnStartDate.Visible = false;
            lblexirytemp.Visible = true;
        }
        else if (DrpDocumentType.SelectedIndex == 2)
        {
            lbltoLocation.Text = "Principal";
            lblfromLocation.Text = "Return From";
            drpDistributor.Enabled = true;
            drpPrincipal.Enabled = true;
            DrpTransferFor.Visible = false;
            Label4.Visible = false;
            GetDocumentNo();
            lblexpiryDate.Visible = false;
            txtStartDate.Visible = false;
            ibtnStartDate.Visible = false;
            lblexirytemp.Visible = true;
        }
        else if (DrpDocumentType.SelectedIndex == 3)
        {
            lblfromLocation.Text = "Transfer to";
            drpDistributor.Enabled = true;
            drpPrincipal.Enabled = true;
            LoadToDistributor();
            DrpTransferFor.Visible = true;
            Label4.Visible = true;
            Label4.Text = "Transfer From";
            GetDocumentNo();
            lblexpiryDate.Visible = false;
            txtStartDate.Visible = false;
            ibtnStartDate.Visible = false;
            lblexirytemp.Visible = true;
        }
        else
        {
            lbltoLocation.Text = "Principal";
            lblfromLocation.Text = "Location";
            drpDistributor.Enabled = true;
            drpPrincipal.Enabled = true;
            DrpTransferFor.Visible = false;
            Label4.Visible = false;
            GetDocumentNo();
            lblexpiryDate.Visible = false;
            txtStartDate.Visible = false;
            ibtnStartDate.Visible = false;
            lblexirytemp.Visible = true;

        }


    }
    protected void drpDocumentNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpDocumentNo.SelectedValue.ToString() == Constants.LongNullValue.ToString())
        {
            CreatTable(); 
            Session.Add("PurchaseSKU", _purchaseSku);
            LoadGird();
            ClearAll(); 
            drpPrincipal.Enabled = true;
            drpDistributor.Enabled = true;
            DrpDocumentType.Enabled = true;            
        }
        else 
        {
            txtBuiltyNo.Text = "";
            txtDocumentNo.Text = ""; 
            drpPrincipal.Enabled = false;
            drpDistributor.Enabled = false;
            DrpDocumentType.Enabled = false;
            LoadDocumentDetail();
            LoadSkuDetail(); 
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

            DisAbaleOption(false);    
            CreatTable(); 
            LoadGird();
            ClearAll(); 
            txtDocumentNo.Text = ""; 
            txtBuiltyNo.Text = "";
            txtDocumentNo.Text = ""; 
         
    }
    protected void drpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSkuDetail(); 
    }
    protected void ChbBatchNo_CheckedChanged(object sender, EventArgs e)
    {
        if (ChbBatchNo.Checked == true)
        {
            lblBatchNo.Enabled = true;
            txtBatchNo.Enabled = true;
        }
        else
        {
            txtBatchNo.Text = "N/A"; 
            lblBatchNo.Enabled = false;
            txtBatchNo.Enabled = false;
        }
    }
    protected void ChbFreeSKU_CheckedChanged(object sender, EventArgs e)
    {
        if (ChbFreeSKU.Checked == true)
        {
            lblFreeSKU.Enabled = true;
            txtFreeSKU.Enabled = true;
        }
        else
        {
            txtFreeSKU.Text = "0";
            lblFreeSKU.Enabled = false;
            txtFreeSKU.Enabled = false;
        }
    }
    protected void DrpTransferFor_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
