using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class labOrder : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Validate input service group name
        //Add Option - Validate existence of a doctor
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var doctors = from element in _dataContext.Doctors
                              select element.doctorName.ToString().ToLower();
            foreach (var doctor in doctors.ToArray())
            {
                if (doctor.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
            //int editIndex = MedicalServiceList.EditIndex;
            //TextBox textBox = MedicalServiceList.Rows[editIndex].FindControl("EditGroupId") as TextBox;
            //var inputStringData = textBox.Text;
            //var inputIntData = Convert.ToInt64(inputStringData);
            //var idList = from element in _dataContext.MedicalServiceGroups
            //             select element.medicalServiceGroupId;
            //foreach (var id in idList.ToArray())
            //{
            //    if (id == inputIntData)
            //    {
            //        args.IsValid = true;
            //        return;
            //    }
            //}
            //args.IsValid = false;
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetGroupNameList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.Doctors
                         where element.doctorName.ToString().ToLower().StartsWith(prefixText)
                         select element.doctorName.ToString();
            return result.ToArray();
        }

        //Submit Add Form
        protected void AddLabOrderGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddLabOrderButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var doctorName = NameTextBox.Text;
                    var doctorId = GetGroupId(doctorName)[0];
                    var dateVisited = Convert.ToDateTime(VisitedDateTextBox.Text);

                    var labOrder = new LabOrder() { doctorId = doctorId, dateVisit = dateVisited };
                    _dataContext.LabOrders.InsertOnSubmit(labOrder);
                    _dataContext.SubmitChanges();
                    LabOrderList.DataBind();

                    //USe for Testing
                    //Debug.WriteLine("Doctor Name: " + doctorId);
                    //Debug.WriteLine("Date Visisted: " + dateVisited);

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetLabOrderGroupButton"))
            {
                ResetInputField();
            }
        }

        //Reset all textBox field
        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            VisitedDateTextBox.Text = "";
        }

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.Doctors
                          where element.doctorName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.doctorId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetLabOrders(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.LabOrders
                          where element.Doctor.doctorName.ToLower().StartsWith(prefixText)
                          select element.Doctor.doctorName.ToString());

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = LabOrderList.EditIndex;
                var lblId = LabOrderList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbDName = LabOrderList.Rows[editedRowIndex].FindControl("EditDName") as TextBox;
                var txtbDate = LabOrderList.Rows[editedRowIndex].FindControl("EditDate") as TextBox;

                var id = long.Parse(lblId.Text);
                var doctorId = GetGroupId(txtbDName.Text)[0];
                var date = Convert.ToDateTime(txtbDate.Text);

                var labOrder = new LabOrder() { labOrderId = id, doctorId = doctorId, dateVisit = date };
                _dataContext.LabOrders.Attach(labOrder);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, labOrder);
                _dataContext.SubmitChanges();
                LabOrderList.EditIndex = -1;

                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("DName: " + doctorId);
                //Debug.WriteLine("Date: " + date);
            }
        }

        //Take care of the other tables that have it as a foreign key
        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = LabOrderList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var labOrderDetails = from element in _dataContext.LabOrderDetails
                                  where element.labOrderId == intId
                                  select element;
            var visits = from element in _dataContext.Visits
                           where element.labOrderId == intId
                           select element;

            if (labOrderDetails.Count() != 0 || visits.Count() != 0)
            {
                _dataContext.LabOrderDetails.DeleteAllOnSubmit(labOrderDetails);
                _dataContext.Visits.DeleteAllOnSubmit(visits);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //Control Role
        protected void LabOrderList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < LabOrderList.Rows.Count; i++)
                {
                    LabOrderList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    LabOrderList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}