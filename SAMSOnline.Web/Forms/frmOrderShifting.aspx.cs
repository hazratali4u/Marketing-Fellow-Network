using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMS.BusinessLayer.Classes;
using SAMS.Common.Classes;

public partial class Forms_frmOrderShifting : System.Web.UI.Page
{
    OrderEntryController OrderCtl = new OrderEntryController();
    bool flag = false;
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(this.drpDistributor, dt, 0, 2, true);
    }
    private void LoadDeliveryman()
    {
        if (drpDistributor.Items.Count > 0)
        {
            Distributor_UserController mDController = new Distributor_UserController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(this.Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(this.DrpDeliveryMan, m_dt, 0, 3, true);
            clsWebFormUtil.FillDropDownList(this.DrpDeliveryManTo, m_dt, 0, 3, true);
        }
        else
        {
            DrpDeliveryMan.Items.Clear();
            DrpDeliveryManTo.Items.Clear();
        }
    }
    private void LoadOrders()
    {
        OrderEntryController or = new OrderEntryController();
        DataTable dtOrder = or.SelectPendingOrder(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue,
            Constants.IntNullValue, Constants.IntNullValue, int.Parse(DrpDeliveryMan.SelectedValue.ToString()),
            Constants.Order_Pending_Id, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Convert.ToDateTime(txtToDate.Text),2);
        cblOrders.Items.Clear();
        if (dtOrder.Rows.Count > 0)
        {
            clsWebFormUtil.FillListBox(this.cblOrders, dtOrder, "SALE_ORDER_ID", "ORDERNO");
            cblOrders.Attributes.Add("onclick", string.Format("javascript:CheckBoxListSelect({0})", cblOrders.ClientID));
        }
        else
        {
            cblOrders.Items.Add(new ListItem("No Order found.", Constants.LongNullValue.ToString()));            
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtToDate.Text = DateTime.Parse(this.Session["CurrentWorkDate"].ToString()).AddDays(1).ToString("dd-MMM-yyyy");
            this.LoadDistributor();            
            this.LoadDeliveryman();
            this.LoadOrders();            
        }
    }
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadDeliveryman();
        this.LoadOrders();
    }
    protected void DrpDeliveryMan_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadOrders();
    }
    protected void btnShift_Click(object sender, EventArgs e)
    {       
        if (DrpDeliveryMan.SelectedValue == DrpDeliveryManTo.SelectedValue)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Orders can not be shifted to same Sale Force');", true);
            return;
        }
        else
        {
            flag = false;
            foreach (ListItem li in cblOrders.Items)
            {
                if (li.Selected)
                {
                    if (li.Value != Constants.LongNullValue.ToString())
                    {
                        flag = OrderCtl.ShiftOrder(Convert.ToInt64(li.Value), Convert.ToInt32(drpDistributor.SelectedValue), Convert.ToInt32(DrpDeliveryManTo.SelectedValue));
                    }
                    else
                    {
                        flag = true;
                    }
                }
            }
            if (flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Order(s) shifted successfully.');", true);
                this.LoadOrders();
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Forms/frmOrderShifting.aspx?LevelType=3&LevelID=" + Request.QueryString["LevelID"].ToString());
    }
    protected void btnGetOrder_Click(object sender, EventArgs e)
    {
        if(Convert.ToDateTime(txtToDate.Text) < Convert.ToDateTime(Session["CurrentWorkDate"]))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Date can not be less than Working Date.');", true);
            return;
        }
        this.LoadOrders();
    }
}