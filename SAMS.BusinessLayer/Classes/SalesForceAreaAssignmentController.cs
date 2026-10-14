using System;
using System.Data;
using SAMS.Common.Classes;
using SAMS.DataAccessLayer.Classes;
using SAMS.DatabaseLayer.Classes;

namespace SAMS.BusinessLayer.Classes
{
	/// <summary>
	/// Summary description for SalesForceAreaAssignment.
	/// </summary>
	public class SalesForceAreaAssignmentController
	{
		public SalesForceAreaAssignmentController()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		#region Methods

		public DataTable SelectSalesForceAreaAssignment(long p_AREA_ASSIGNMENT_ID,long p_AREA_ID,long p_ROUTE_ID,
														bool p_IS_ACTIVE,DateTime p_TIME_STAMP,DateTime p_LASTUPDATE_DATE,
														int p_SALES_FORCE_TYPE,int p_SALES_FORCE_ID)
		{
			IDbConnection mConnection = null;
			try
			{
				mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
				mConnection.Open();
				uspSelectSALES_FORCE_AREA_ASSIGNMENT mSF = new uspSelectSALES_FORCE_AREA_ASSIGNMENT();
					
				mSF.Connection = mConnection;
                
				mSF.AREA_ASSIGNMENT_ID = p_AREA_ASSIGNMENT_ID;
				mSF.IS_ACTIVE = p_IS_ACTIVE;
				mSF.AREA_ID = p_AREA_ID;
				mSF.ROUTE_ID = p_ROUTE_ID;
				mSF.SALES_FORCE_ID = p_SALES_FORCE_ID;
				mSF.SALES_FORCE_TYPE = p_SALES_FORCE_TYPE;
				mSF.TIME_STAMP = p_TIME_STAMP ;
				mSF.LASTUPDATE_DATE = p_LASTUPDATE_DATE ;
				
				
				

				DataTable dt = mSF.ExecuteTable();
				return dt;
				
			}
			catch(Exception exp)
			{
				ExceptionPublisher.PublishException(exp);				
				return null;
			}
			finally
			{
				if(mConnection != null && mConnection.State == ConnectionState.Open)
				{
					mConnection.Close();
				}
			}
		}


		public bool DeleteSalesForceArea(DataTable dt)
		{
			IDbConnection mConnection = null;
			IDbTransaction mTransaction = null;
			try
			{
				mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
				mConnection.Open();

				mTransaction = ProviderFactory.GetTransaction(mConnection);

				spDeleteSALES_FORCE_AREA_ASSIGNMENT spDelSFA = new spDeleteSALES_FORCE_AREA_ASSIGNMENT();
				spDelSFA.Connection = mConnection;
				spDelSFA.Transaction = mTransaction;

				foreach(DataRow dr in dt.Rows)
				{
					spDelSFA.AREA_ASSIGNMENT_ID = long.Parse(dr["AREA_ASSIGNMENT_ID"].ToString());
					spDelSFA.ExecuteQuery();
				}
				mTransaction.Commit();
				return true;
			}
			catch(Exception ex)
			{
				ExceptionPublisher.PublishException(ex);
				mTransaction.Rollback();
				return false;
			}
			finally
			{
				if(mConnection != null && mConnection.State == ConnectionState.Open)
				{
					mConnection.Close();
				}
                
				
            }
				
		}

		public bool InsertSalesForceAreaAssignment(long p_AREA_ID,long p_ROUTE_ID,
												bool p_IS_ACTIVE,DateTime p_TIME_STAMP,DateTime p_LASTUPDATE_DATE,
												int p_SALES_FORCE_TYPE,int p_SALES_FORCE_ID)
		{
			IDbConnection mConnection = null;
			try
			{
				mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
				mConnection.Open();
				spInsertSALES_FORCE_AREA_ASSIGNMENT mSF = new spInsertSALES_FORCE_AREA_ASSIGNMENT();
					
				mSF.Connection = mConnection;
                
				mSF.IS_ACTIVE = p_IS_ACTIVE;
				mSF.AREA_ID = p_AREA_ID;
				mSF.ROUTE_ID = p_ROUTE_ID;
				mSF.SALES_FORCE_ID = p_SALES_FORCE_ID;
				mSF.SALES_FORCE_TYPE = p_SALES_FORCE_TYPE;
				mSF.TIME_STAMP = p_TIME_STAMP ;
				mSF.LASTUPDATE_DATE = p_LASTUPDATE_DATE ;
				
				
				bool b;

				b = mSF.ExecuteQuery();
				return true;
				
			}
			catch(Exception exp)
			{
				ExceptionPublisher.PublishException(exp);				
				return false;
			}
			finally
			{
				if(mConnection != null && mConnection.State == ConnectionState.Open)
				{
					mConnection.Close();
				}
			}

		}

		public DataTable SelectUnassignedRoutes(int dist_id,long area_id,int sales_force_id)
		{
			IDbConnection mConnection = null;
			try
			{
				mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
				mConnection.Open();
				uspSelectUnassignedRoutes mSF = new uspSelectUnassignedRoutes();
					
				mSF.Connection = mConnection;
                
				mSF.distributor_id = dist_id ;
				mSF.area_id = area_id;
				mSF.sales_force_id = sales_force_id;
				DataTable b;

				b = mSF.ExecuteTable();
				
				return b;
			}
			catch(Exception exp)
			{
				ExceptionPublisher.PublishException(exp);				
				return null;
			}
			finally
			{
				if(mConnection != null && mConnection.State == ConnectionState.Open)
				{
					mConnection.Close();
				}
			}
		}

		#endregion
        public DataSet GetDMReturnStatement(int p_Distributor_ID, int p_Principal_Id, int p_DELIVERYMAN_ID, DateTime p_FromDate, DateTime p_To_Date, int p_UserId)

        {
            IDbConnection mConnection = null;
            try
            {
                mConnection = ProviderFactory.GetConnection(Configuration.ConnectionString, EnumProviders.SQLClient);
                mConnection.Open();
                uspGetDMReturnStatement ObjPrint = new uspGetDMReturnStatement();
                SAMS.BusinessLayer.Reports.dsSalesPurchaseRegister ds = new SAMS.BusinessLayer.Reports.dsSalesPurchaseRegister();
                ObjPrint.Connection = mConnection;
                ObjPrint.DISTRIBUTOR_ID = p_Distributor_ID;
                ObjPrint.PRINCIPAL_ID = p_Principal_Id;
                ObjPrint.FROM_DATE = p_FromDate;
                ObjPrint.TO_DATE = p_To_Date;
                ObjPrint.USER_ID = p_UserId;
                ObjPrint.DELIVERYMAN_ID = p_DELIVERYMAN_ID;
                ObjPrint.TYPE_ID = 1;

                DataTable dt= ObjPrint.ExecuteTable();

                foreach (DataRow dr in dt.Rows)
                {
                    ds.Tables["uspGetDMReturnStatement"].ImportRow(dr);
                }

               

                uspGetDMReturnStatement ObjPrint3 = new uspGetDMReturnStatement();

                ObjPrint3.Connection = mConnection;
                ObjPrint3.DISTRIBUTOR_ID = p_Distributor_ID;
                ObjPrint3.PRINCIPAL_ID = p_Principal_Id;
                ObjPrint3.FROM_DATE = p_FromDate;
                ObjPrint3.TO_DATE = p_To_Date;
                ObjPrint3.USER_ID = p_UserId;
                ObjPrint3.DELIVERYMAN_ID = p_DELIVERYMAN_ID;
                ObjPrint3.TYPE_ID = 2;

                DataTable dt3 = ObjPrint3.ExecuteTable();

                foreach (DataRow dr in dt3.Rows)
                {
                    ds.Tables["uspGetDMCashRealize"].ImportRow(dr);
                }

                uspGetDMReturnStatement ObjPrint2 = new uspGetDMReturnStatement();

                ObjPrint2.Connection = mConnection;
                ObjPrint2.DISTRIBUTOR_ID = p_Distributor_ID;
                ObjPrint2.PRINCIPAL_ID = p_Principal_Id;
                ObjPrint2.FROM_DATE = p_FromDate;
                ObjPrint2.TO_DATE = p_To_Date;
                ObjPrint2.USER_ID = p_UserId;
                ObjPrint2.DELIVERYMAN_ID = p_DELIVERYMAN_ID;
                ObjPrint2.TYPE_ID = 3;

                DataTable dt2 = ObjPrint2.ExecuteTable();

                foreach (DataRow dr in dt2.Rows)
                {
                    ds.Tables["uspGetDMCreditSale"].ImportRow(dr);


                }
                return ds;
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

	}
}
