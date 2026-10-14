using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;    

public partial class Forms_frmOrderEntry : System.Web.UI.Page
{
    DataTable PurchaseSKU;
    DataTable dtFreeSKU;
    private static int mCustomerTypeId;
    private static DataTable mCustomerVolClass;
    private int mTownId;
    private bool mIsReg;
    private decimal mGst;

    private static int RowId;
    private static int UnitType;
    CustomerDataController CustCtl = new CustomerDataController();

    private void LoadPendingOrder()
    {
        OrderEntryController or = new OrderEntryController();
        drpDocumentNo.Items.Clear();
        DataTable dtOrder = or.SelectPendingOrder(int.Parse(Session["DistributorId"].ToString()),int.Parse(Session["AreaId"].ToString()) , int.Parse(Session["PrincipalId"].ToString()), int.Parse(Session["OrderBookerId"].ToString()) , int.Parse(Session["DeliveryManId"].ToString()), Constants.Order_Pending_Id, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()),Convert.ToDateTime(Session["OrderDate"].ToString()),1);
        drpDocumentNo.Items.Add(new clsListItems("New",Constants.LongNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(drpDocumentNo, dtOrder, "SALE_ORDER_ID", "ORDERNO");
        Session.Add("dtOrder", dtOrder);  
    }
    
    private void CreatTable()
    {
        PurchaseSKU = new DataTable();
        PurchaseSKU.Columns.Add("SALE_ORDER_DETAIL_ID", typeof(long));
        PurchaseSKU.Columns.Add("DistributorId", typeof(int));
        PurchaseSKU.Columns.Add("SALE_ORDER_ID", typeof(int));
        PurchaseSKU.Columns.Add("SKU_ID", typeof(int));
        PurchaseSKU.Columns.Add("SKU_Code", typeof(string));
        PurchaseSKU.Columns.Add("SKU_Name", typeof(string));
        PurchaseSKU.Columns.Add("BATCH_NO", typeof(string));
        PurchaseSKU.Columns.Add("DISCOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("UNIT_PRICE", typeof(decimal));
        PurchaseSKU.Columns.Add("QUANTITY_UNIT", typeof(int));
        PurchaseSKU.Columns.Add("AMOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("STANDARD_DISCOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("STANDARD_DISCOUNT_PER", typeof(decimal));
        PurchaseSKU.Columns.Add("EXTRA_DISCOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("GST_RATE", typeof(decimal));
        PurchaseSKU.Columns.Add("GST_AMOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("TST_AMOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("GST_RATE_TP", typeof(decimal)); 
        PurchaseSKU.Columns.Add("NET_AMOUNT", typeof(decimal));
        PurchaseSKU.Columns.Add("QUANTITY_CTN", typeof(decimal));
        PurchaseSKU.Columns.Add("IS_DELETED", typeof(bool));     
        Session.Add("PurchaseSKU", PurchaseSKU);  
    
    }
    
    private void CreateFreeSKU()
    {
        dtFreeSKU = new DataTable();
        dtFreeSKU.Columns.Add("SKU_ID", typeof(int));
        dtFreeSKU.Columns.Add("SKU_Code", typeof(string));
        dtFreeSKU.Columns.Add("SKU_Name", typeof(string));
        dtFreeSKU.Columns.Add("UNIT_PRICE", typeof(decimal));
        dtFreeSKU.Columns.Add("Quantity", typeof(int));
        dtFreeSKU.Columns.Add("AMOUNT", typeof(decimal));
        dtFreeSKU.Columns.Add("GST_RATE", typeof(decimal));
        dtFreeSKU.Columns.Add("GST_AMOUNT", typeof(decimal));
        dtFreeSKU.Columns.Add("TST_AMOUNT", typeof(decimal));
        dtFreeSKU.Columns.Add("PROMOTION_ID", typeof(int));
        dtFreeSKU.Columns.Add("BASKET_ID", typeof(int));
        dtFreeSKU.Columns.Add("BASKET_DETAIL_ID", typeof(int));
        dtFreeSKU.Columns.Add("PROMOTION_OFFER_ID", typeof(int));
        Session.Add("dtFreeSKU", dtFreeSKU);  
    }
    
    private void EnableDisableController(bool CValue)
    {
         
        if (CValue == true)
        {
            if (decimal.Parse(txtGrossAmount.Text) > 0)
            {
               
                txtOutletCode.Enabled = true;
                txtOutletName.Enabled = true;
                
            }
        }
        else
        {
            
            txtOutletCode.Enabled = false;
            txtOutletName.Enabled = false;
           
        }
    }
    
    private void LoadCustomerData()
    {
        if (int.Parse(Session["DistributorId"].ToString()) > 0 && long.Parse(Session["AreaId"].ToString()) > 0)
        {
            ListCustomer.Items.Clear();
            CustomerDataController mController = new CustomerDataController();
            DataTable dtCustomer = mController.SelectPrincipalCustomer(int.Parse(Session["DistributorId"].ToString()), int.Parse(Session["AreaId"].ToString()), Constants.IntNullValue, int.Parse(Session["PrincipalId"].ToString()));
            clsWebFormUtil.FillListBox(ListCustomer, dtCustomer, "CUSTOMER_DETAIL", "CUSTOMER_DETAIL", true);
            Session.Add("dtCustomer", dtCustomer);
        }
        else
        {
            ListCustomer.Items.Clear();
        }
    }
    
    private void ClearAll()
    {
        txtskuCode.Text = "";
        txtskuName.Text = "";
        txtUnitRate.Text = "";
        txtQuantity.Text = "";
        txtBatchNo.Text = "";
        txtDiscount.Text = "";
        txtskuCode.Enabled = true; 
        btnSave.Text = "Add Sku";
        btnSaveOrder.Enabled = false;
        btnCalculate.Enabled = true;
    }
    
    private void LoadSKUDetail()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        if (int.Parse(Session["PrincipalId"].ToString()) > 0)
        {
            if (hfPriceGroup.Value.Trim() == "Default")
            {
                DataTable Dtsku_Price = PController.SelectDataPrice(int.Parse(Session["PrincipalId"].ToString()), Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["DistributorId"].ToString()), int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 1, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
                clsWebFormUtil.FillListBox(lstCode, Dtsku_Price, 10, 10, true);
                Session.Add("Dtsku_Price", Dtsku_Price);
            }
            else
            {
                if (FindCustomer(0))
                {
                    DataTable Dtsku_Price = PController.GetCustomerSKU(int.Parse(Session["DistributorId"].ToString()), Convert.ToInt64(Session["CUSTOMER_ID"]), DateTime.Parse(Session["CurrentWorkDate"].ToString()), int.Parse(Session["PrincipalId"].ToString()));
                    clsWebFormUtil.FillListBox(lstCode, Dtsku_Price, 10, 10, true);
                    Session.Add("Dtsku_Price", Dtsku_Price);
                }
            }
        }
        txtskuCode.Focus();
    }
    
    private void LoadGird()
    {
        PurchaseSKU = (DataTable)Session["PurchaseSKU"];
        GrdPurchase.DataSource = PurchaseSKU;
        GrdPurchase.DataBind();
    }
    
    private void LoadFreeGrid()
    {
        dtFreeSKU = (DataTable)Session["dtFreeSKU"];
        GrdFreeSKU.DataSource = dtFreeSKU;
        GrdFreeSKU.DataBind();
    }
    
    private int FreeSKUExist(DataTable dt,int Sku_id)
    {
        for(int i = 0;i<dt.Rows.Count;i++)
        {
            if (int.Parse(dt.Rows[i]["SKU_ID"].ToString()) == Sku_id)
            {
                return i;
            }
            
        }
        return -1; 
    }
    
    private void LoadPromotion()
    {
        if (int.Parse(Session["PrincipalId"].ToString()) > 0)
        {
            SKUPriceDetailController PController = new SKUPriceDetailController();
            DataTable dt = PController.SelectDataPrice(int.Parse(Session["PrincipalId"].ToString()), Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["OrderDate"].ToString()));
            if (bool.Parse(dt.Rows[0]["Is_ManualDiscount"].ToString()) == false)
            {
                OrderEntryController orderController = new OrderEntryController();
                PromotionCollections_Controller Arpc = orderController.LoadSchemes(int.Parse(Session["DistributorId"].ToString()), int.Parse(Session["PrincipalId"].ToString()), Convert.ToDateTime(Session["OrderDate"]));
                Session.Add("Arpc", Arpc);
                txtDiscountType.Text = "Auto Discount";
                //ChbDiscount.Checked = true;
                txtDiscount.Enabled = false;
            }
            else
            {
                txtDiscountType.Text = "Manual Discount";

                OrderEntryController orderController = new OrderEntryController();
                PromotionCollections_Controller Arpc = orderController.LoadSchemes(int.Parse(Session["DistributorId"].ToString()), int.Parse(Session["PrincipalId"].ToString()), Convert.ToDateTime(Session["OrderDate"]));
                Session.Add("Arpc", Arpc);
               
                txtDiscount.Enabled = true;
            }
        }
         
    }

    private bool CheckRegCustomer()//For Register or Non-register Customer GST Calculation
    {
        DataTable dtCustomer = (DataTable)Session["dtCustomer"];
        DataRow[] foundRows = dtCustomer.Select("CUSTOMER_CODE  = '" + txtOutletCode.Text.Trim() + "'");
        if (foundRows.Length > 0)
        {
            mIsReg = bool.Parse(foundRows[0]["IS_GST_REGISTERED"].ToString());          
            if (mIsReg)
            {
                mGst = decimal.Parse(foundRows[0]["GST"].ToString());
                return false;
            }
            
        }
        return true; 
    }
    
    private bool FindCustomer(int intType)
    {
        DataTable dtCustomer = (DataTable)Session["dtCustomer"];
        DataRow[] foundRows = dtCustomer.Select("CUSTOMER_CODE  = '" + txtOutletCode.Text.Trim() + "'");
        if (foundRows.Length > 0)
        {
            Session.Add("CUSTOMER_ID", long.Parse(foundRows[0]["CUSTOMER_ID"].ToString()));
            mCustomerTypeId = int.Parse(foundRows[0]["CHANNEL_TYPE_ID"].ToString());
            mTownId = int.Parse(foundRows[0]["TOWN_ID"].ToString());
            if (intType == 1)
            {
                mCustomerVolClass = CustCtl.GetCustomerPromotionClass(Convert.ToInt32(Session["DistributorId"]), long.Parse(foundRows[0]["CUSTOMER_ID"].ToString()), Constants.IntNullValue);
            }
            return true;
        }
        return false; 
    }
    
    private void ClearMasterALL()
    {
        EnableDisableController(true);
        Session.Remove("PurchaseSKU");
        Session.Remove("dtFreeSKU");
        CreatTable();
        CreateFreeSKU();
        txtOutletCode.Text = "";
        txtOutletName.Text = "";
        txtManualInvoiceNo.Text = "";
        txtOutletCode.Focus();
        LoadGird();
        LoadFreeGrid();
        txtGrossAmount.Text = "";
        numTxtTotalStndrdDiscnt.Text = "";
        numTxtTotalHalfScheme.Text = "0.0000";
        numTxtTotalGST.Text = "";
        numTxtTotlAmnt.Text = "";
        RowId = 0; 
        mCustomerTypeId = 0;
        drpDocumentNo.SelectedIndex = 0;
        txtCashReceived.Text = ""; 
    }
    
    private void ExistenOrderDetail(long OrderId)
    {
        OrderEntryController ord = new OrderEntryController();
        PurchaseSKU = ord.SelectOrderDetail(int.Parse(Session["DistributorId"].ToString()), OrderId);
        dtFreeSKU = ord.SelectOrderPromotion(int.Parse(Session["DistributorId"].ToString()), OrderId);       
        Session.Add("PurchaseSKU", PurchaseSKU);
        Session.Add("dtFreeSKU", dtFreeSKU);  
        LoadGird();
        LoadFreeGrid(); 
 
    }
    
    private bool CheckDublicateSKU()
    {
        DataControl dc = new DataControl();
        DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
        PurchaseSKU = (DataTable)Session["PurchaseSKU"];
        DataRow[] foundRows = PurchaseSKU.Select("SKU_CODE  = '" + txtskuCode.Text + "'");
        if (foundRows.Length == 0)
        {
            return true;
        }
        else
        {
            return false; 
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {             
            int OrderNo = (int)Session["OrderNo"];
            UnitType = (int)Session["UnitType"];
            txtprincipal.Text = Session["Route"].ToString();
            txtDeliveryMan.Text = Session["SaleMan"].ToString();
            Session.Remove("Route");
            Session.Remove("SaleMan");
            if (OrderNo == -2)
            {
                drpDocumentNo.Enabled = false;
                RblPayMode.Items.Add(new ListItem("Sale Return", "10"));
                btnSaveOrder.Text = "Sale Return";
                lblManualTransactionNo.Visible = false;
                txtManualInvoiceNo.Visible = false;
            }
            else
            {
                RblPayMode.Items.Add(new ListItem("Cash", "214"));
                RblPayMode.Items.Add(new ListItem("Credit", "215"));
                btnSaveOrder.Text = "Save Order";
                drpDocumentNo.Enabled = true;  
            }
            RblPayMode.SelectedIndex = 0;   
            LoadCustomerData();
            LoadSKUDetail();
            CreatTable();
            LoadPromotion();
            CreateFreeSKU();
            LoadFreeGrid();
            LoadPendingOrder(); 
            ScriptManager.GetCurrent(Page).SetFocus(txtOutletCode);
            btnSave.Attributes.Add("onclick", "return ValidateForm();");
            
        }
    }
    
    protected void Button2_Click(object sender, EventArgs e)
    {
        Session.Remove("CUSTOMER_ID");
        Session.Remove("PrincipalId");
        Session.Remove("AreaId");
        Session.Remove("OrderBookerId");
        Session.Remove("DeliveryManId");
        Response.Redirect("~/Forms/frmOrderEntryStep1.aspx?Status=" + false + "&LevelType=3&LevelID=" + Request.QueryString["LevelID"].ToString());
        
    }
    
    protected void DrpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSKUDetail();
    }
    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataControl dc = new DataControl();
        DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
        PurchaseSKU = (DataTable)Session["PurchaseSKU"];
        DataRow[] foundRows = Dtsku_Price.Select("SKU_CODE  = '" + txtskuCode.Text + "'");

        decimal Discount = decimal.Parse(dc.chkNull_0(txtDiscount.Text));

        decimal mTradePrice = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString()));

        int mPackSize = int.Parse(dc.chkNull_0(foundRows[0]["UNITS_IN_CASE"].ToString()));

        if (btnSave.Text == "Add Sku")
        {
            if (CheckDublicateSKU())
            {
                DataRow dr = PurchaseSKU.NewRow();
                dr["SKU_ID"] = foundRows[0]["SKU_ID"];
                dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
                dr["SKU_Name"] = foundRows[0]["SKU_NAME"];

                if (UnitType == 0)
                {

                    dr["QUANTITY_UNIT"] = int.Parse(dc.chkNull_0(txtQuantity.Text));
                   
                    dr["QUANTITY_CTN"] = 0;

                }
                else
                {
                    dr["QUANTITY_UNIT"] = int.Parse(dc.chkNull_0(txtQuantity.Text)) * mPackSize;
                    dr["QUANTITY_CTN"] = int.Parse(dc.chkNull_0(txtQuantity.Text));
                }
                dr["UNIT_PRICE"] = mTradePrice.ToString();

                Discount = (mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString()) * (Discount / 100));
                //dr["DISCOUNT"] = Discount; 
                if (CheckRegCustomer())//Modify by Hasan for Register or Non-register Customer
                {
                    if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                    {
                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());//- Discount;
                        dr["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                        dr["TST_AMOUNT"] = 0;
                        dr["BATCH_NO"] = "T";

                    }
                    else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                    {
                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                        dr["TST_AMOUNT"] = decimal.Parse(foundRows[0]["GST_RATE_TP"].ToString()) * decimal.Parse(dr["QUANTITY_UNIT"].ToString());

                        dr["GST_RATE"] = 0;
                        dr["BATCH_NO"] = "R";

                    }
                    else
                    {


                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());//- Discount;

                        dr["GST_RATE"] = 0;
                        dr["TST_AMOUNT"] = 0;

                        dr["BATCH_NO"] = "E";
                    }
                }
                else
                {
                    if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                    {
                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                        dr["GST_RATE"] = mGst;// foundRows[0]["GST_RATE_TP"];
                        dr["GST_AMOUNT"] = decimal.Parse(dr["AMOUNT"].ToString()) * mGst / 100;
                        dr["TST_AMOUNT"] = 0;
                        dr["BATCH_NO"] = "T";
                    }
                    else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                    {
                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                        dr["TST_AMOUNT"] = 0;// decimal.Parse(foundRows[0]["GST_RATE_TP"].ToString()) * decimal.Parse(dr["QUANTITY_UNIT"].ToString());
                        dr["GST_RATE"] = 0;
                        dr["BATCH_NO"] = "R";

                    }
                    else
                    {


                        dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;

                        dr["GST_RATE"] = 0;
                        dr["TST_AMOUNT"] = 0;

                        dr["BATCH_NO"] = "E";
                    }
                }


                dr["STANDARD_DISCOUNT"] = Discount;
                dr["EXTRA_DISCOUNT"] = 0;
                dr["GST_AMOUNT"] = 0;
                dr["NET_AMOUNT"] = 0;
                PurchaseSKU.Rows.Add(dr);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('SKU Already Exists');", true);
            }
        }
        else
        {
            DataRow dr = PurchaseSKU.Rows[RowId];
            dr["SKU_ID"] = foundRows[0]["SKU_ID"];
            dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
            dr["SKU_Name"] = foundRows[0]["SKU_NAME"];
            dr["BATCH_NO"] = txtBatchNo.Text;
           // dr["DISCOUNT"] = decimal.Parse(dc.chkNull_0(txtDiscount.Text));

            if (UnitType == 0)
            {
                dr["QUANTITY_UNIT"] = int.Parse(dc.chkNull_0(txtQuantity.Text));
            }
            else
            {
                dr["QUANTITY_UNIT"] = int.Parse(dc.chkNull_0(txtQuantity.Text)) * mPackSize;
            }
            Discount = (mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString()) * (Discount / 100));
            
            dr["UNIT_PRICE"] = mTradePrice.ToString();
            dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());
            if (CheckRegCustomer())
            {
                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                {
                    dr["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["BATCH_NO"] = "T";

                }
                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                {
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["GST_RATE"] = 0;

                    dr["TST_AMOUNT"] = decimal.Parse(foundRows[0]["GST_RATE_TP"].ToString()) * decimal.Parse(dr["QUANTITY_UNIT"].ToString());

                    dr["BATCH_NO"] = "R";

                }
                else
                {
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["GST_RATE"] = 0;
                    dr["TST_AMOUNT"] = 0;
                    dr["BATCH_NO"] = "E";
                }
            }
            else
            {
                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                {
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["GST_RATE"] = mGst;// foundRows[0]["GST_RATE_TP"];
                    dr["GST_AMOUNT"] = decimal.Parse(dr["AMOUNT"].ToString()) * mGst / 100;
                    dr["TST_AMOUNT"] = 0;
                    dr["BATCH_NO"] = "T";
                }
                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                {
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["GST_RATE"] = 0;

                    dr["TST_AMOUNT"] = 0;// decimal.Parse(foundRows[0]["GST_RATE_TP"].ToString()) * decimal.Parse(dr["QUANTITY_UNIT"].ToString());

                    dr["BATCH_NO"] = "R";

                }
                else
                {
                    dr["AMOUNT"] = mTradePrice * decimal.Parse(dr["QUANTITY_UNIT"].ToString());// - Discount;
                    dr["GST_RATE"] = 0;
                    dr["TST_AMOUNT"] = 0;
                    dr["BATCH_NO"] = "E";
                }
               
            }
            dr["STANDARD_DISCOUNT"] = Discount;
            dr["EXTRA_DISCOUNT"] = 0;
            dr["GST_AMOUNT"] = 0;
            
            dr["NET_AMOUNT"] = 0;
            dr["STANDARD_DISCOUNT_PER"] = 0;
        }

        Session.Add("PurchaseSKU", PurchaseSKU);
        EnableDisableController(false);
        LoadGird();
        ClearAll();
        ScriptManager.GetCurrent(Page).SetFocus(txtskuCode);

        decimal ObjGrossSales = 0;
        decimal ObjTaxableAmount = 0;
        foreach (DataRow dr in PurchaseSKU.Rows)
        {
            ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
            if (dr["BATCH_NO"].ToString() == "T")
            {
                ObjTaxableAmount = decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
            }

        }
        txtGrossAmount.Text = Convert.ToString(Math.Round(ObjGrossSales, 2));
    }
    
    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        //Session.Add("btnSave",btnSaveOrder.Text);
        //if ((btnSaveOrder.Text == "Save Invoice")&&(Session["btnSave"]!="Add Sku"))
        //{
        
        if (FindCustomer(1))
        {
            decimal ObjGrossSales = 0;
            decimal ObjStandardDiscount = 0;
            decimal ObjExtraDiscount = 0;
            decimal ObjTotalGST = 0;
            decimal ObjTotalTST = 0;
            decimal ObjFreeGSTAmount = 0;
            decimal ObjFreeTST = 0;
            decimal ObjFreeGrossAmt = 0;

            DataControl dc = new DataControl();
            OrderEntryController or = new OrderEntryController();
            DataTable dt = (DataTable)Session["PurchaseSKU"];
            if (txtDiscountType.Text == "Auto Discount")
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dr["STANDARD_DISCOUNT"] = 0;
                    dr["STANDARD_DISCOUNT_PER"] = 0;
                    dr["EXTRA_DISCOUNT"] = 0;
                }
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dr["STANDARD_DISCOUNT_PER"] = 0;                   
                }
            }
            PromotionCollections_Controller Arpc = (PromotionCollections_Controller)Session["Arpc"];
            CreateFreeSKU();
            LoadFreeGrid();

            if (dt.Rows.Count > 0 && txtOutletCode.Text.Length > 0)
            {
                if ((txtDiscountType.Text == "Auto Discount") || (txtDiscountType.Text == "Manual Discount"))
                {
                    if (mCustomerVolClass.Rows.Count > 0)
                    {
                        ArrayList ARlistOffer = or.GetPromotionOffers(Arpc, mCustomerVolClass, mCustomerTypeId, dt, false);
                        for (int i = 0; i < ARlistOffer.Count; i++)
                        {
                            PromoOffers_Collection pofferCol = (PromoOffers_Collection)ARlistOffer[i];
                            if (pofferCol.SKU_ID > 0)
                            {
                                #region slab on SKU

                                foreach (DataRow dr in dt.Rows)
                                {
                                    if (int.Parse(dr["SKU_ID"].ToString()) == pofferCol.SKU_ID)
                                    {

                                        if (pofferCol.Is_And == true)
                                        {
                                            if ((pofferCol.Offer_Value > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["EXTRA_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString())) + pofferCol.Offer_Value;


                                            }
                                            if ((pofferCol.Discount > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["EXTRA_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString())) + (decimal.Parse(pofferCol.Discount.ToString()) / 100) * (decimal.Parse(dr["AMOUNT"].ToString()));
                                            }
                                        }
                                        else
                                        {
                                            if ((pofferCol.Offer_Value > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                //dr["STANDARD_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString())) + pofferCol.Offer_Value;
                                            }
                                            if ((pofferCol.Discount > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["STANDARD_DISCOUNT_PER"] = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT_PER"].ToString())) + (decimal.Parse(pofferCol.Discount.ToString()) / 100);
                                            }
                                        }
                                        if (pofferCol.Free_SKU_ID > 0)
                                        {
                                            DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
                                            DataRow[] foundRows = Dtsku_Price.Select("SKU_ID  = '" + pofferCol.Free_SKU_ID.ToString() + "'");
                                            int RowId = FreeSKUExist(dtFreeSKU, pofferCol.Free_SKU_ID);
                                            if (foundRows.Length > 0)
                                            {
                                                if (RowId < 0)
                                                {
                                                    DataRow dr1 = dtFreeSKU.NewRow();
                                                    dr1["SKU_ID"] = foundRows[0]["SKU_ID"];
                                                    dr1["SKU_Code"] = foundRows[0]["SKU_CODE"];
                                                    dr1["SKU_Name"] = foundRows[0]["SKU_NAME"];

                                                    if (CheckRegCustomer())
                                                    {
                                                        if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                        {

                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["GST_AMOUNT"] = (decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) / 100) * decimal.Parse(dr1["AMOUNT"].ToString());
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                        else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["TST_AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());

                                                            dr1["GST_AMOUNT"] = 0;
                                                        }
                                                        else
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["GST_AMOUNT"] = 0;
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = mGst;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["GST_AMOUNT"] = decimal.Parse(dr1["AMOUNT"].ToString()) * mGst / 100;
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                        else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["TST_AMOUNT"] = 0;// decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());

                                                            dr1["GST_AMOUNT"] = 0;
                                                        }
                                                        else
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                            dr1["GST_AMOUNT"] = 0;
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                    }
                                                    dr1["PROMOTION_ID"] = pofferCol.Promotion_ID.ToString();
                                                    dr1["BASKET_ID"] = pofferCol.Basket_ID.ToString();
                                                    dr1["BASKET_DETAIL_ID"] = pofferCol.BasketDetail_ID.ToString();
                                                    dr1["PROMOTION_OFFER_ID"] = pofferCol.PromoOffer_ID.ToString();
                                                    ObjFreeGrossAmt += decimal.Parse(dr1["AMOUNT"].ToString());
                                                    ObjFreeGSTAmount += decimal.Parse(dc.chkNull_0(dr1["GST_AMOUNT"].ToString()));
                                                    ObjFreeTST += decimal.Parse(dc.chkNull_0(dr1["TST_AMOUNT"].ToString()));
                                                    dtFreeSKU.Rows.Add(dr1);
                                                }
                                                else
                                                {
                                                    DataRow dr1 = dtFreeSKU.Rows[RowId];
                                                    ObjFreeGrossAmt = ObjFreeGrossAmt - decimal.Parse(dr1["AMOUNT"].ToString());
                                                    ObjFreeGSTAmount = ObjFreeGSTAmount - decimal.Parse(dr1["GST_AMOUNT"].ToString());
                                                    dr1["SKU_ID"] = foundRows[0]["SKU_ID"];
                                                    dr1["SKU_Code"] = foundRows[0]["SKU_CODE"];
                                                    dr1["SKU_Name"] = foundRows[0]["SKU_NAME"];
                                                    // dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity; commnet by safdar .. as already updated  in if /else statement 
                                                    if (CheckRegCustomer())
                                                    {
                                                        if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                        {

                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            // dr1["Quantity"] =  pofferCol.Quantity.ToString();
                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["GST_AMOUNT"] = (decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) / 100) * decimal.Parse(dr1["AMOUNT"].ToString());
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                        else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];

                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["TST_AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["GST_AMOUNT"] = 0;
                                                        }
                                                        else
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];

                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                        {

                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];

                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = mGst;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["GST_AMOUNT"] = decimal.Parse(dr1["AMOUNT"].ToString()) * mGst / 100;
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                        else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];

                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["TST_AMOUNT"] = 0;// decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["GST_AMOUNT"] = 0;
                                                        }
                                                        else
                                                        {
                                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                            // dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                                            dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                            dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(dr1["Quantity"].ToString());
                                                            dr1["TST_AMOUNT"] = 0;
                                                        }
                                                    }
                                                    dr1["PROMOTION_ID"] = pofferCol.Promotion_ID.ToString();
                                                    dr1["BASKET_ID"] = pofferCol.Basket_ID.ToString();
                                                    dr1["BASKET_DETAIL_ID"] = pofferCol.BasketDetail_ID.ToString();
                                                    dr1["PROMOTION_OFFER_ID"] = pofferCol.PromoOffer_ID.ToString();
                                                    ObjFreeGrossAmt += decimal.Parse(dr1["AMOUNT"].ToString());
                                                    ObjFreeGSTAmount += decimal.Parse(dc.chkNull_0(dr1["GST_AMOUNT"].ToString()));
                                                    ObjFreeTST += decimal.Parse(dc.chkNull_0(dr1["TST_AMOUNT"].ToString()));
                                                }

                                            }
                                        }
                                        Session.Add("dtFreeSKU", dtFreeSKU);
                                        LoadFreeGrid();
                                    }
                                }
                                #endregion
                            }
                            else
                            {
                                #region slab on SKU Group

                                #region Free SKU
                                if (pofferCol.Free_SKU_ID > 0)
                                {
                                    DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
                                    DataRow[] foundRows = Dtsku_Price.Select("SKU_ID  = '" + pofferCol.Free_SKU_ID.ToString() + "'");
                                    int RowId = FreeSKUExist(dtFreeSKU, pofferCol.Free_SKU_ID);
                                    if (foundRows.Length > 0)
                                    {
                                        if (RowId < 0)
                                        {
                                            DataRow dr1 = dtFreeSKU.NewRow();
                                            dr1["SKU_ID"] = foundRows[0]["SKU_ID"];
                                            dr1["SKU_Code"] = foundRows[0]["SKU_CODE"];
                                            dr1["SKU_Name"] = foundRows[0]["SKU_NAME"];
                                            dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                            dr1["Quantity"] = pofferCol.Quantity.ToString();
                                            if (CheckRegCustomer())
                                            {
                                                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                {

                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = (decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) / 100) * decimal.Parse(dr1["AMOUNT"].ToString());
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["TST_AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                }
                                                else
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                            }
                                            else
                                            {
                                                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                    dr1["GST_RATE"] = mGst;// foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = decimal.Parse(dr1["AMOUNT"].ToString()) * mGst / 100;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                    dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["TST_AMOUNT"] = 0;//decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());

                                                    dr1["GST_AMOUNT"] = 0;
                                                }
                                                else
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["Quantity"] = pofferCol.Quantity.ToString();
                                                    dr1["GST_RATE"] = 0;// foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                            }
                                            dr1["PROMOTION_ID"] = pofferCol.Promotion_ID.ToString();
                                            dr1["BASKET_ID"] = pofferCol.Basket_ID.ToString();
                                            dr1["BASKET_DETAIL_ID"] = pofferCol.BasketDetail_ID.ToString();
                                            dr1["PROMOTION_OFFER_ID"] = pofferCol.PromoOffer_ID.ToString();
                                            ObjFreeGrossAmt += decimal.Parse(dr1["AMOUNT"].ToString());
                                            ObjFreeGSTAmount += decimal.Parse(dc.chkNull_0(dr1["GST_AMOUNT"].ToString()));
                                            ObjFreeTST += decimal.Parse(dc.chkNull_0(dr1["TST_AMOUNT"].ToString()));
                                            dtFreeSKU.Rows.Add(dr1);
                                        }
                                        else
                                        {

                                            DataRow dr1 = dtFreeSKU.Rows[RowId];
                                            ObjFreeGrossAmt = ObjFreeGrossAmt - decimal.Parse(dr1["AMOUNT"].ToString());
                                            ObjFreeGSTAmount = ObjFreeGSTAmount - decimal.Parse(dr1["GST_AMOUNT"].ToString());
                                            dr1["SKU_ID"] = foundRows[0]["SKU_ID"];
                                            dr1["SKU_Code"] = foundRows[0]["SKU_CODE"];
                                            dr1["SKU_Name"] = foundRows[0]["SKU_NAME"];
                                            dr1["Quantity"] = int.Parse(dr1["Quantity"].ToString()) + pofferCol.Quantity;
                                            if (CheckRegCustomer())
                                            {

                                                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = (decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) / 100) * decimal.Parse(dr1["AMOUNT"].ToString());
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["TST_AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                }
                                                else
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                            }
                                            else
                                            {

                                                if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                                                {

                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = mGst; // foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = decimal.Parse(dr1["AMOUNT"].ToString()) * mGst / 100;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                                else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = 0;//foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["TST_AMOUNT"] = 0;//decimal.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                }
                                                else
                                                {
                                                    dr1["UNIT_PRICE"] = foundRows[0]["TRADE_PRICE"];
                                                    dr1["GST_RATE"] = 0;//foundRows[0]["GST_RATE_TP"];
                                                    dr1["AMOUNT"] = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString())) * decimal.Parse(pofferCol.Quantity.ToString());
                                                    dr1["GST_AMOUNT"] = 0;
                                                    dr1["TST_AMOUNT"] = 0;
                                                }
                                            }
                                            dr1["PROMOTION_ID"] = pofferCol.Promotion_ID.ToString();
                                            dr1["BASKET_ID"] = pofferCol.Basket_ID.ToString();
                                            dr1["BASKET_DETAIL_ID"] = pofferCol.BasketDetail_ID.ToString();
                                            dr1["PROMOTION_OFFER_ID"] = pofferCol.PromoOffer_ID.ToString();
                                            ObjFreeGrossAmt += decimal.Parse(dr1["AMOUNT"].ToString());
                                            ObjFreeGSTAmount += decimal.Parse(dc.chkNull_0(dr1["GST_AMOUNT"].ToString()));
                                            ObjFreeTST += decimal.Parse(dc.chkNull_0(dr1["TST_AMOUNT"].ToString()));
                                        }
                                        Session.Add("dtFreeSKU", dtFreeSKU);
                                        LoadFreeGrid();

                                    }
                                }
                                #endregion


                                foreach (DataRow dr in dt.Rows)
                                {
                                    if (or.ExistsInGroup(Constants.IntNullValue, pofferCol.Group_ID, int.Parse(dr["SKU_ID"].ToString())))
                                    {
                                        if (pofferCol.Is_And == true)
                                        {
                                            if ((pofferCol.Offer_Value > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["EXTRA_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString())) + pofferCol.Offer_Value;
                                            }
                                            if ((pofferCol.Discount > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["EXTRA_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString())) + ((decimal.Parse(pofferCol.Discount.ToString())) / 100) * (decimal.Parse(dr["AMOUNT"].ToString()) - decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString())));
                                            }
                                        }
                                        else
                                        {
                                            if ((pofferCol.Offer_Value > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                //dr["STANDARD_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString())) + pofferCol.Offer_Value;
                                            }
                                            if ((pofferCol.Discount > 0) && (txtDiscountType.Text == "Auto Discount"))
                                            {
                                                dr["STANDARD_DISCOUNT_PER"] = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT_PER"].ToString())) + (decimal.Parse(pofferCol.Discount.ToString()) / 100);
                                            }
                                        }
                                    }
                                }
                                #endregion
                            }
                        }
                        #region Recalulate Products
                        if (txtDiscountType.Text == "Auto Discount")
                        {
                            foreach (DataRow dr in dt.Rows)
                            {
                                dr["STANDARD_DISCOUNT"] = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT_PER"].ToString())) * (decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString())));
                                ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                                ObjStandardDiscount += decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
                                ObjExtraDiscount += decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));

                                #region GST Calculation

                                decimal TempAmount = decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                                decimal TempDiscount = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
                                decimal TempExtraDisAmt = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));
                                dr["GST_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) * decimal.Parse(dc.chkNull_0(dr["GST_RATE"].ToString())) / 100;
                                dr["NET_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) + decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString())) + decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));
                                ObjTotalGST += decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString()));
                                ObjTotalTST += decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));


                                #endregion
                            }
                        }

                        #endregion
                    }
                }
                else
                {
                    #region Reversecalulate Products

                    //decimal ObjGrossSales = 0;
                    decimal ObjTaxableAmount = 0;

                    foreach (DataRow dr in dt.Rows)
                    {
                        ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));

                        if (dr["BATCH_NO"].ToString() == "T")
                        {
                            ObjTaxableAmount += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        }
                    }

                    ObjGrossSales = 0;
                    foreach (DataRow dr in dt.Rows)
                    {

                        decimal TempAmount = 0;
                        decimal TempDiscount = 0;
                        decimal TempExtraDisAmt = 0;
                        #region GST Calculation

                        TempAmount = decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        TempDiscount = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
                        TempExtraDisAmt = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));

                        dr["GST_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) * decimal.Parse(dc.chkNull_0(dr["GST_RATE"].ToString())) / 100;
                        dr["NET_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) + decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString())) + decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));

                        ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        ObjTotalGST += decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString()));
                        ObjTotalTST += decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));


                        #endregion
                    }
                    #endregion
                }

                #region Set Total Values
                if((txtDiscountType.Text == "Manual Discount"))
                {
                    #region Reversecalulate Products

                    //decimal ObjGrossSales = 0;
                    decimal ObjTaxableAmount = 0;

                    foreach (DataRow dr in dt.Rows)
                    {
                        ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));

                        if (dr["BATCH_NO"].ToString() == "T")
                        {
                            ObjTaxableAmount += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        }
                    }


                    ObjGrossSales = 0;

                    foreach (DataRow dr in dt.Rows)
                    {

                        decimal TempAmount = 0;
                        decimal TempDiscount = 0;
                        decimal TempExtraDisAmt = 0;
                        
                        #region GST Calculation

                        TempAmount = decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        TempDiscount = decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
                        TempExtraDisAmt = decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));

                        dr["GST_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) * decimal.Parse(dc.chkNull_0(dr["GST_RATE"].ToString())) / 100;
                        dr["NET_AMOUNT"] = (TempAmount - TempDiscount - TempExtraDisAmt) + decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString())) + decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));

                        ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
                        ObjTotalGST += decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString()));
                        ObjTotalTST += decimal.Parse(dc.chkNull_0(dr["TST_AMOUNT"].ToString()));
                        ObjStandardDiscount += decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
                        ObjExtraDiscount += decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));
                        #endregion
                    }                    
                    #endregion
                }

                txtGrossAmount.Text = Convert.ToString(Math.Round(ObjGrossSales, 2));
                numTxtTotalStndrdDiscnt.Text = Convert.ToString(Math.Round(ObjStandardDiscount, 2));
                numTxtTotalGST.Text = Convert.ToString(Math.Round(ObjTotalGST + ObjFreeGSTAmount + ObjTotalTST + ObjFreeTST , 2));
                numTxtTotlAmnt.Text = Convert.ToString(Math.Round(ObjGrossSales - ObjExtraDiscount - ObjStandardDiscount + ObjTotalGST + ObjFreeGSTAmount + ObjTotalTST + ObjFreeTST, 2));
                numTxtTotalHalfScheme.Text = Convert.ToString(Math.Round(ObjTotalTST + ObjFreeTST, 2));
               
                #endregion

                btnSaveOrder.Enabled = true;
                if (RblPayMode.SelectedIndex == 1)
                {
                    txtCashReceived.Enabled = true;
                    ScriptManager.GetCurrent(Page).SetFocus(txtCashReceived);
                }
                else
                {
                    txtCashReceived.Enabled = false;
                }
            }
        }
    }
    
    protected void btnSaveOrder_Click(object sender, EventArgs e)
    {
        if (FindCustomer(0))
        {
            DataControl DC = new DataControl();
            PurchaseSKU = (DataTable)Session["PurchaseSKU"];
            dtFreeSKU = (DataTable)Session["dtFreeSKU"];
            OrderEntryController mOrderController = new OrderEntryController();
            
            if (btnSaveOrder.Text == "Save Order")
            {
                if (int.Parse(RblPayMode.SelectedValue.ToString()) == Constants.Credit_Order_Id || int.Parse(RblPayMode.SelectedValue.ToString()) == Constants.Advance_PaymentOrder_id)
                {
                    CustomerDataController CDC = new CustomerDataController();
                    DataTable dt = CDC.SelectCustomerCreditBalance(long.Parse(Session["CUSTOMER_ID"].ToString()), int.Parse(Session["PrincipalId"].ToString()), int.Parse(Session["DistributorId"].ToString()));
                    decimal NetCashSale = decimal.Parse(numTxtTotlAmnt.Text) - decimal.Parse(DC.chkNull_0(txtCashReceived.Text));
                    if (decimal.Parse(DC.chkNull_0(dt.Rows[0][0].ToString())) <= NetCashSale)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Customer Credit Limit/Advance Amount is " + DC.chkNull_0(dt.Rows[0][0].ToString()) + "');", true);
                        return;
                    }

                }
                foreach (DataRow dr in PurchaseSKU.Rows)
                {
                    DataTable dtstock = mOrderController.GetOrderClosingStock(Convert.ToInt32(Session["DistributorId"]), Convert.ToInt32(dr["SKU_ID"]));
                    if (dtstock.Rows.Count > 0)
                    {
                        if (int.Parse(dtstock.Rows[0][0].ToString()) < int.Parse(dr["QUANTITY_UNIT"].ToString()))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + dr["SKU_Code"].ToString() + " Current Stock is " + dtstock.Rows[0][0].ToString() + "');", true);
                            return;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert(' + " + dr["SKU_Code"].ToString() + "No Stock Found');", true);
                        return;
                    }
                }

                bool IsValidInsert = mOrderController.Add_Order(int.Parse(Session["DistributorId"].ToString()), mTownId, (long)Session["AreaId"], int.Parse(Session["PrincipalId"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), int.Parse(Session["OrderBookerId"].ToString()), int.Parse(Session["DeliveryManId"].ToString()), int.Parse(RblPayMode.SelectedValue.ToString()),
                decimal.Parse(DC.chkNull_0(txtGrossAmount.Text)), 0, decimal.Parse(DC.chkNull_0(numTxtTotalStndrdDiscnt.Text)),decimal.Parse(DC.chkNull_0(numTxtTotalGST.Text)), decimal.Parse(DC.chkNull_0(numTxtTotlAmnt.Text)),0, Constants.Order_Pending_Id, PurchaseSKU, dtFreeSKU, int.Parse(Session["UserId"].ToString()),DateTime.Parse(Session["OrderDate"].ToString()),0,0,Convert.ToDecimal(numTxtTotalHalfScheme.Text),txtManualInvoiceNo.Text);
                if (IsValidInsert)
                {
                    LoadPendingOrder();
                    ClearMasterALL();
                    ScriptManager.GetCurrent(Page).SetFocus(txtOutletCode);
                }
            }
            else if (btnSaveOrder.Text == "Save Invoice")
            {
                if (Convert.ToDateTime(Session["CurrentWorkDate"]) >= Convert.ToDateTime(Session["OrderDate"].ToString()))
                {

                    if (int.Parse(RblPayMode.SelectedValue.ToString()) == Constants.Credit_Order_Id || int.Parse(RblPayMode.SelectedValue.ToString()) == Constants.Advance_PaymentOrder_id)
                    {
                        CustomerDataController CDC = new CustomerDataController();
                        DataTable dt = CDC.SelectCustomerCreditBalance(long.Parse(Session["CUSTOMER_ID"].ToString()), int.Parse(Session["PrincipalId"].ToString()), int.Parse(Session["DistributorId"].ToString()));
                        decimal NetCashSale = decimal.Parse(numTxtTotlAmnt.Text) - decimal.Parse(DC.chkNull_0(txtCashReceived.Text));
                        if (decimal.Parse(DC.chkNull_0(dt.Rows[0][0].ToString())) <= NetCashSale)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Customer Credit Limit/Advance Amount is " + DC.chkNull_0(dt.Rows[0][0].ToString()) + "');", true);
                            return;
                        }

                    }
                    foreach (DataRow dr in PurchaseSKU.Rows)
                    {
                        PurchaseController mController = new PurchaseController();//txtBatchNo.Text
                        DataTable dtstock = mController.SelectSKUClosingStock(int.Parse(Session["DistributorId"].ToString()), int.Parse(dr["SKU_ID"].ToString()), txtBatchNo.Text);
                        if (dtstock.Rows.Count > 0)
                        {
                            if (int.Parse(dtstock.Rows[0][0].ToString()) < int.Parse(dr["QUANTITY_UNIT"].ToString()))
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + dr["SKU_Code"].ToString() + " Current Stock is " + dtstock.Rows[0][0].ToString() + "');", true);
                                return;
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert(' + " + dr["SKU_Code"].ToString() + "No Stock Found');", true);
                            return;
                        }
                    }
                    bool IsValidInsert = mOrderController.Add_Invoice(int.Parse(Session["DistributorId"].ToString()), mTownId, long.Parse(Session["AreaId"].ToString()), int.Parse(Session["PrincipalId"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), int.Parse(Session["OrderBookerId"].ToString()), int.Parse(Session["DeliveryManId"].ToString()), long.Parse(drpDocumentNo.SelectedValue.ToString()),
                    decimal.Parse(DC.chkNull_0(txtGrossAmount.Text)), 0, decimal.Parse(DC.chkNull_0(numTxtTotalStndrdDiscnt.Text)), decimal.Parse(DC.chkNull_0(numTxtTotalGST.Text)), decimal.Parse(DC.chkNull_0(numTxtTotlAmnt.Text)), 0, int.Parse(RblPayMode.SelectedValue.ToString()),
                    PurchaseSKU, dtFreeSKU, int.Parse(Session["UserId"].ToString()), decimal.Parse(DC.chkNull_0(txtCashReceived.Text)), DateTime.Parse(Session["CurrentWorkDate"].ToString()), 0, 0, Convert.ToDecimal(numTxtTotalHalfScheme.Text),txtManualInvoiceNo.Text);
                    if (IsValidInsert)
                    {
                        if (drpDocumentNo.Enabled == true)
                        {
                            btnSaveOrder.Text = "Save Order";
                        }
                        LoadPendingOrder();
                        ClearMasterALL();
                        ScriptManager.GetCurrent(Page).SetFocus(txtOutletCode);
                    }
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Order Date Can not be greater than current working date');", true);
                }
            }
            else if (btnSaveOrder.Text == "Sale Return")
            {

                bool IsValidInsert = mOrderController.Add_SaleReturn(int.Parse(Session["DistributorId"].ToString()), mTownId, (long)Session["AreaId"], int.Parse(Session["PrincipalId"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), long.Parse(Session["CUSTOMER_ID"].ToString()), int.Parse(Session["OrderBookerId"].ToString()), int.Parse(Session["DeliveryManId"].ToString()), long.Parse(drpDocumentNo.SelectedValue.ToString()),
                decimal.Parse(DC.chkNull_0(txtGrossAmount.Text)), 0, decimal.Parse(DC.chkNull_0(numTxtTotalStndrdDiscnt.Text)), decimal.Parse(DC.chkNull_0(numTxtTotalGST.Text)), decimal.Parse(DC.chkNull_0(numTxtTotlAmnt.Text)),0,int.Parse(RblPayMode.SelectedValue.ToString()), PurchaseSKU, dtFreeSKU, int.Parse(Session["UserId"].ToString()), DateTime.Parse(Session["CurrentWorkDate"].ToString()),0, RblPayMode.SelectedIndex);
                if (IsValidInsert)
                {
                    ClearMasterALL();
                    ScriptManager.GetCurrent(Page).SetFocus(txtOutletCode);
                }
            }
         }

      }
    
    protected void drpDocumentNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (long.Parse(drpDocumentNo.SelectedValue.ToString()) != Constants.LongNullValue)
        {

            DataTable dt = (DataTable)Session["dtOrder"];
            DataRow[] foundRows = dt.Select("SALE_ORDER_ID  = '" + drpDocumentNo.SelectedValue + "'");
            if (foundRows.Length > 0)
            {
                txtGrossAmount.Text = foundRows[0]["TOTAL_AMOUNT"].ToString();
                numTxtTotalStndrdDiscnt.Text = foundRows[0]["STANDARD_DISCOUNT_AMOUNT"].ToString();
                numTxtTotalHalfScheme.Text = foundRows[0]["HALF_SCHEME"].ToString();
                numTxtTotalGST.Text = foundRows[0]["GST_AMOUNT"].ToString();
                numTxtTotlAmnt.Text = foundRows[0]["TOTAL_NET_AMOUNT"].ToString();
                txtOutletCode.Text = foundRows[0]["CUSTOMER_CODE"].ToString();
                txtOutletName.Text = foundRows[0]["CUSTOMER_NAME"].ToString();
                txtManualInvoiceNo.Text = foundRows[0]["MANUL_NO"].ToString();
                Session.Add("CUSTOMER_ID", long.Parse(foundRows[0]["CUSTOMER_ID"].ToString()));
                ExistenOrderDetail(long.Parse(drpDocumentNo.SelectedValue.ToString()));
                EnableDisableController(false);
                btnSaveOrder.Text = "Save Invoice";
                txtCashReceived.Enabled  = true;  
                ClearAll();
                ScriptManager.GetCurrent(Page).SetFocus(txtskuCode);
            }

        }
        else
        {
           
            CreateFreeSKU();
            CreatTable();
            LoadGird();
            LoadFreeGrid();
            ClearMasterALL();
            btnSaveOrder.Text = "Save Order";
            
        }
    }
    
    protected void GrdPurchase_RowEditing(object sender, GridViewEditEventArgs e)
    {
        RowId = e.NewEditIndex; 
        txtskuCode.Text   = GrdPurchase.Rows[e.NewEditIndex].Cells[1].Text;
        txtskuName.Text   = GrdPurchase.Rows[e.NewEditIndex].Cells[2].Text;
        txtQuantity.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text;
        txtUnitRate.Text   = GrdPurchase.Rows[e.NewEditIndex].Cells[4].Text;

        if (txtDiscountType.Text == "Auto Discount")
        {
            txtBatchNo.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[5].Text;
        }
        else
        {
            txtDiscount.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[5].Text;

            decimal discount = decimal.Parse(txtDiscount.Text) * 100 / (decimal.Parse(txtUnitRate.Text) * decimal.Parse(txtQuantity.Text));
            txtDiscount.Text = String.Format("{0:0.00}", discount);
        }

        if (UnitType == 0)
        {
            txtQuantity.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text;
        }
        else
        {
            txtQuantity.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[7].Text;
        }
        txtskuCode.Enabled = false;
        btnSave.Text = "Update SKU"; 

    }
    
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataControl dc = new DataControl();
        PurchaseSKU = (DataTable)Session["PurchaseSKU"];
        PurchaseSKU.Rows.RemoveAt(e.RowIndex);
        
        decimal ObjGrossSales = 0;
        decimal StdDiscount = 0;
        decimal ExtraDiscount = 0;
        decimal GSTAmount = 0;
        decimal TSTAmount = 0;
        decimal NetAmount = 0;

        foreach (DataRow dr in PurchaseSKU.Rows)
        {
            ObjGrossSales += decimal.Parse(dc.chkNull_0(dr["AMOUNT"].ToString()));
            StdDiscount += decimal.Parse(dc.chkNull_0(dr["STANDARD_DISCOUNT"].ToString()));
            ExtraDiscount += decimal.Parse(dc.chkNull_0(dr["EXTRA_DISCOUNT"].ToString()));
            GSTAmount += decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString()));
            TSTAmount += decimal.Parse(dc.chkNull_0(dr["GST_AMOUNT"].ToString()));
            NetAmount += decimal.Parse(dc.chkNull_0(dr["NET_AMOUNT"].ToString()));
        }

        txtGrossAmount.Text = Convert.ToString(Math.Round(ObjGrossSales, 2));
        numTxtTotalStndrdDiscnt.Text = Convert.ToString(Math.Round(StdDiscount, 2));
        //numtxtTotalExtraDiscnt.Text = Convert.ToString(Math.Round(ExtraDiscount, 2));
        numTxtTotalGST.Text = Convert.ToString(Math.Round(GSTAmount, 2));
        numTxtTotalHalfScheme.Text = Convert.ToString(Math.Round(TSTAmount, 2));
        numTxtTotlAmnt.Text = Convert.ToString(Math.Round(NetAmount, 2));

        Session.Add("PurchaseSKU", PurchaseSKU);
        LoadGird();
        ClearAll();
      
   }

    protected void btnDummy_Click(object sender, EventArgs e)
    {
        this.LoadSKUDetail();
    }
}