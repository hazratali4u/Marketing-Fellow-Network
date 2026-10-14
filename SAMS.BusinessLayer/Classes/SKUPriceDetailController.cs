using System;
using SAMS.DatabaseLayer.Classes;
using SAMS.DataAccessLayer.Classes;
using SAMS.Common.Classes;
using System.Data;

namespace SAMS.BusinessLayer.Classes
{
   public class SKUPriceDetailController
    {
       public bool InsertSKUPriceDetail(int p_CUSTOMER_ID ,int p_SKUNAME_ID ,decimal p_TRADE_PRICE ,decimal p_RETAIL_PRICE ,decimal p_PURCHASE_PRICE)
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               spInsertSKU_PRICE_DETAIL ObjInsert = new spInsertSKU_PRICE_DETAIL();
               ObjInsert.Connection = mConnection;
               ObjInsert.CUSTOMER_ID = p_CUSTOMER_ID;
               ObjInsert.SKUNAME_ID = p_SKUNAME_ID;
               ObjInsert.TRADE_PRICE = p_TRADE_PRICE;
               ObjInsert.RETAIL_PRICE = p_RETAIL_PRICE;
               ObjInsert.PURCHASE_PRICE = p_PURCHASE_PRICE;
              
              
               bool Bvalue = ObjInsert.ExecuteQuery();
               return Bvalue;

           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return false;

           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public DataTable SelectDataPrice(int p_Principal_Id, int p_Division_ID, int p_Category_ID, int p_Brand_id, int p_Var_Id, int p_User_Id,int p_sku_id,int p_Type_id,DateTime p_ClosedDate)
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               UspSelectSKUPriceList  ObjSelect = new UspSelectSKUPriceList();
               ObjSelect.Connection = mConnection;
               ObjSelect.COMPANY_ID = p_Principal_Id;
               ObjSelect.DIVISION_ID = p_Division_ID;
               ObjSelect.CATEGORY_ID = p_Category_ID;
               ObjSelect.BRAND_ID = p_Brand_id;
               ObjSelect.VAR_ID = p_Var_Id;
               ObjSelect.SKU_ID = p_sku_id;
               ObjSelect.TYPEID = p_Type_id;
               ObjSelect.USER_ID = p_User_Id;
               ObjSelect.DAYCLOSED = p_ClosedDate; 
               DataTable dt = ObjSelect.ExecuteTable();
               return dt;

           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return null;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public DataTable SelectData(int p_SKU_PRICEDETAIL_ID,int p_CUSTOMER_ID ,int p_SKUNAME_ID ,decimal p_TRADE_PRICE ,decimal p_RETAIL_PRICE ,decimal p_PURCHASE_PRICE)
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               spSelectSKU_PRICE_DETAIL ObjSelect = new spSelectSKU_PRICE_DETAIL();
               ObjSelect.Connection = mConnection;
               ObjSelect.SKU_PRICEDETAIL_ID= p_SKU_PRICEDETAIL_ID;
               ObjSelect.CUSTOMER_ID = p_CUSTOMER_ID;
               ObjSelect.SKUNAME_ID = p_SKUNAME_ID;
               ObjSelect.TRADE_PRICE = p_TRADE_PRICE;
               ObjSelect.RETAIL_PRICE = p_RETAIL_PRICE;
               ObjSelect.PURCHASE_PRICE = p_PURCHASE_PRICE;
               DataTable dt = ObjSelect.ExecuteTable();
               return dt;

           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return null;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public bool UpdateSKUPriceDetail(int p_SKU_PRICEDETAIL_ID,int p_CUSTOMER_ID, int p_SKUNAME_ID, decimal p_TRADE_PRICE, decimal p_RETAIL_PRICE, decimal p_PURCHASE_PRICE)
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               spUpdateSKU_PRICE_DETAIL ObjUpdate = new spUpdateSKU_PRICE_DETAIL();
               ObjUpdate.Connection = mConnection;

               ObjUpdate.SKU_PRICEDETAIL_ID = p_SKU_PRICEDETAIL_ID;
               ObjUpdate.CUSTOMER_ID = p_CUSTOMER_ID;
               ObjUpdate.SKUNAME_ID = p_SKUNAME_ID;
               ObjUpdate.TRADE_PRICE = p_TRADE_PRICE;
               ObjUpdate.RETAIL_PRICE = p_RETAIL_PRICE;
               ObjUpdate.PURCHASE_PRICE = p_PURCHASE_PRICE;

               bool Bvalue = ObjUpdate.ExecuteQuery();
               return Bvalue;
           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return false;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public DataTable GetCustomerSKU(int p_DISTRIBUTOR_ID, long p_CUSTOMER_ID, DateTime p_DocumentDate, int p_Principal_ID)
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               uspGetCustomerWiseSKUs ObjSelect = new uspGetCustomerWiseSKUs();
               ObjSelect.Connection = mConnection;
               ObjSelect.DISTRIBUTOR_ID = p_DISTRIBUTOR_ID;
               ObjSelect.CUSTOMER_ID = p_CUSTOMER_ID;
               ObjSelect.DocumentDate = p_DocumentDate;
               ObjSelect.Principal_ID = p_Principal_ID;
               DataTable dt = ObjSelect.ExecuteTable();
               return dt;

           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return null;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public DataTable LoadGrid()
       {
           IDbConnection mConnection = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();

               UspSKU_PRICE_DETAIL_GridData ObjSelect = new UspSKU_PRICE_DETAIL_GridData(); 
               ObjSelect.Connection = mConnection;
               DataTable dt = ObjSelect.ExecuteTable();
               return dt;
           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               return null;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
       public bool Add_CustomerWisePrice(DataTable dtOrderDetail, int p_UserId, DateTime p_DocumentDate, string p_groupName, DateTime p_DATE_EFFECTED, bool p_IsActive)
       {
           IDbConnection mConnection = null;
           IDbTransaction mTransaction = null;
           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();
               mTransaction = ProviderFactory.GetTransaction(mConnection);
               spInsert_CUST_PRICE_GROUP_MASTER mISom = new spInsert_CUST_PRICE_GROUP_MASTER();
               mISom.Connection = mConnection;
               mISom.Transaction = mTransaction;
               mISom.TIME_STAMP = p_DocumentDate;
               mISom.GROUP_NAME = p_groupName;
               mISom.DATE_EFFECTED = p_DATE_EFFECTED;
               mISom.GROUP_DESCRIPTION = "";
               mISom.is_Deleted = p_IsActive;
               mISom.USER_ID = 1;
               if (dtOrderDetail.Rows.Count > 0)
               {
                   mISom.GROUP_NAME = p_groupName;
                   mISom.TIME_STAMP = p_DocumentDate;
                   mISom.GROUP_DESCRIPTION = "";
                   mISom.USER_ID = p_UserId;
                   mISom.ExecuteQuery();
                   spInsert_CUST_PRICE_GROUP_DETAIL mSaleOrderDetail = new spInsert_CUST_PRICE_GROUP_DETAIL();
                   mSaleOrderDetail.Connection = mConnection;
                   mSaleOrderDetail.Transaction = mTransaction;
                   foreach (DataRow dr in dtOrderDetail.Rows)
                   {
                       mSaleOrderDetail.CUST_WISE_GROUP_MASTER_ID = Convert.ToInt32(mISom.CUST_WISE_GROUP_MASTER_ID);
                       mSaleOrderDetail.SKU_CODE_ID = int.Parse(dr["SKU_ID"].ToString());
                       mSaleOrderDetail.SKU_PRICE = decimal.Parse(dr["UNIT_PRICE"].ToString());
                       mSaleOrderDetail.SKU_ARTICAL_NO = int.Parse(dr["SKU_ARTICAL_NO"].ToString());
                       mSaleOrderDetail.GST_RATE = decimal.Parse(dr["GST_RATE"].ToString());
                       mSaleOrderDetail.DATE_EFFECTED = DateTime.Parse(dr["DATE_EFFECTED"].ToString());
                       mSaleOrderDetail.ExecuteQuery();
                   }
                   mTransaction.Commit();
                   return true;
               }
           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               mTransaction.Rollback();
               return false;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
           return true;
       }
       public bool Update_CustomerWisePrice(DataTable dtOrderDetail, int p_UserId, DateTime p_DocumentDate, string p_groupName, int GroupMasterId, DateTime p_DATE_EFFECTED, bool p_IsActive)
       {

           IDbConnection mConnection = null;
           IDbTransaction mTransaction = null;

           try
           {
               mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
               mConnection.Open();
               mTransaction = ProviderFactory.GetTransaction(mConnection);

               //spInsert_CUST_PRICE_GROUP_MASTER mISom = new spInsert_CUST_PRICE_GROUP_MASTER();
               spUPDATE_CUST_PRICE_GROUP_MASTER mISom = new spUPDATE_CUST_PRICE_GROUP_MASTER();
               mISom.Connection = mConnection;
               mISom.Transaction = mTransaction;
               mISom.GROUP_NAME = p_groupName;
               mISom.TIME_STAMP = p_DocumentDate;
               mISom.GROUP_DESCRIPTION = "";
               mISom.USER_ID = p_UserId;
               mISom.DATE_EFFECTED = DateTime.Now;
               mISom.CUST_WISE_GROUP_MASTER_ID = GroupMasterId;
               mISom.IS_DELETED = p_IsActive;
               mISom.ExecuteQuery();
               if (dtOrderDetail.Rows.Count > 0)
               {
                   spInsert_CUST_PRICE_GROUP_DETAIL mSaleOrderDetail = new spInsert_CUST_PRICE_GROUP_DETAIL();
                   mSaleOrderDetail.Connection = mConnection;
                   mSaleOrderDetail.Transaction = mTransaction;
                   foreach (DataRow dr in dtOrderDetail.Rows)
                   {
                       mSaleOrderDetail.CUST_WISE_GROUP_MASTER_ID = Convert.ToInt32(mISom.CUST_WISE_GROUP_MASTER_ID);
                       mSaleOrderDetail.SKU_CODE_ID = int.Parse(dr["SKU_ID"].ToString());
                       mSaleOrderDetail.SKU_PRICE = decimal.Parse(dr["UNIT_PRICE"].ToString());
                       mSaleOrderDetail.SKU_ARTICAL_NO = int.Parse(dr["SKU_ARTICAL_NO"].ToString());
                       if (dr["GST_RATE"].ToString() == "")
                       {
                           dr["GST_RATE"] = "0";
                       }
                       if (dr["DATE_EFFECTED"].ToString() == "")
                       {
                           dr["DATE_EFFECTED"] = DateTime.Now;
                       }
                       mSaleOrderDetail.GST_RATE = decimal.Parse(dr["GST_RATE"].ToString());
                       mSaleOrderDetail.DATE_EFFECTED = Convert.ToDateTime(dr["DATE_EFFECTED"]);
                       mSaleOrderDetail.ExecuteQuery();
                   }
               }
               mTransaction.Commit();
               return true;
           }
           catch (Exception exp)
           {
               ExceptionPublisher.PublishException(exp);
               mTransaction.Rollback();
               return false;
           }
           finally
           {
               if (mConnection != null && mConnection.State == ConnectionState.Open)
               {
                   mConnection.Close();
               }
           }
       }
   }
}