using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class labOrderDetail : System.Web.UI.Page
    {
private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Validate input service group name
        //Add Option - Validate existence of a drug
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var medicalServices = from element in _dataContext.MedicalServices
                        select element.medicalServiceName.ToString().ToLower();
            foreach (var medicalService in medicalServices.ToArray())
            {
                if (medicalService.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetMSNameList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.MedicalServices
                         where element.medicalServiceName.ToString().ToLower().StartsWith(prefixText)
                         select element.medicalServiceName.ToString();
            return result.ToArray();
        }

        //Submit Add Form
        protected void AddLabOrderDetailButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddLabOrderDetailButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var labOrderId = long.Parse(LabIdDropDown.SelectedItem.Text);
                    var msId = GetMedicalServiceID(MSTextBox.Text)[0];
                    var result = ResultTextBox.Text;

                    var labOrderDetail = new LabOrderDetail() { labOrderId = labOrderId, medicalServiceId = msId, labResult = result };
                    _dataContext.LabOrderDetails.InsertOnSubmit(labOrderDetail);
                    _dataContext.SubmitChanges();
                    LabOrderDetailList.DataBind();

                    //Use for testing
                    //Debug.WriteLine("presID: " + presId);
                    //Debug.WriteLine("presID: " + drug);
                    //Debug.WriteLine("presID: " + quantity);
                    //Debug.WriteLine("presID: " + dose);
                    //Debug.WriteLine("presID: " + instruction);

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetLabOrderDetailButton"))
            {
                ResetInputField();
            }
        }

        //Reset all textBox field
        protected void ResetInputField()
        {
            LabIdDropDown.SelectedIndex = -1;
            MSTextBox.Text = "";
            ResultTextBox.Text = "";
        }

        protected long[] GetMedicalServiceID(string medicalService)
        {
            var groupId = from element in _dataContext.MedicalServices
                          where element.medicalServiceName.ToString().ToLower() == medicalService.ToString().ToLower()
                          select element.medicalServiceId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetLabOrderDetails(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.LabOrderDetails
                          where element.MedicalService.medicalServiceName.ToString().ToLower().StartsWith(prefixText)
                          select element.MedicalService.medicalServiceName.ToString())
                          .Union(from element in dataContext.LabOrderDetails
                                 where element.labResult.ToString().ToLower().StartsWith(prefixText)
                                 select element.labResult.ToString());

            return result.ToArray();
        }

        //Control Role
        protected void LabOrdeDetailList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < LabOrderDetailList.Rows.Count; i++)
                {
                    LabOrderDetailList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    LabOrderDetailList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = LabOrderDetailList.EditIndex;
                var lblId = LabOrderDetailList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbLabOrder = LabOrderDetailList.Rows[editedRowIndex].FindControl("EditLabOrder") as TextBox;
                var txtbMedicalService = LabOrderDetailList.Rows[editedRowIndex].FindControl("EditMSName") as TextBox;
                var txtbResult = LabOrderDetailList.Rows[editedRowIndex].FindControl("EditResult") as TextBox;
                
                var id = long.Parse(lblId.Text);
                var labOrder = long.Parse(txtbLabOrder.Text);
                var medicalService = GetMedicalServiceID(txtbMedicalService.Text)[0];
                var result = txtbResult.Text;

                var labOrderDetails = new LabOrderDetail() {labOrderDetailId = id, labOrderId = labOrder, medicalServiceId = medicalService, labResult = result };
                _dataContext.LabOrderDetails.Attach(labOrderDetails);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, labOrderDetails);
                _dataContext.SubmitChanges();
                LabOrderDetailList.EditIndex = -1;

                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("DName: " + doctorId);
                //Debug.WriteLine("Date: " + date);
            }
        }

        protected void InsertExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var labOrders = from element in _dataContext.LabOrders
                       select element.labOrderId;

            foreach (var labOrder in labOrders.ToArray())
            {
                if (labOrder.ToString().ToLower().Equals(inputValue.ToString().ToLower())) 
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetLabOrderList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.LabOrders
                         where element.labOrderId.ToString().StartsWith(prefixText)
                         select element.labOrderId.ToString();
            return result.ToArray();
        }

        protected void LabOrderDetailList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < LabOrderDetailList.Rows.Count; i++)
                {
                    LabOrderDetailList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    LabOrderDetailList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}