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
    public partial class prescription : System.Web.UI.Page
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
        protected void AddPrescriptionGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddPrescriptionButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var doctorName = NameTextBox.Text;
                    var doctorId = GetGroupId(doctorName)[0];
                    var dateVisited = Convert.ToDateTime(VisitedDateTextBox.Text);

                    var prescription = new Prescription() { doctorId = doctorId, dateWritten = dateVisited };
                    _dataContext.Prescriptions.InsertOnSubmit(prescription);
                    _dataContext.SubmitChanges();
                    PrescriptionList.DataBind();

                    //USe for Testing
                    //Debug.WriteLine("Doctor Name: " + doctorId);
                    //Debug.WriteLine("Date Visisted: " + dateVisited);

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetPrescriptionGroupButton"))
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
        public static string[] GetPrescriptions(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Prescriptions
                          where element.Doctor.doctorName.ToLower().StartsWith(prefixText)
                          select element.Doctor.doctorName.ToString()).Distinct();

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = PrescriptionList.EditIndex;
                var lblId = PrescriptionList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbDName = PrescriptionList.Rows[editedRowIndex].FindControl("EditDName") as TextBox;
                var txtbDate = PrescriptionList.Rows[editedRowIndex].FindControl("EditDate") as TextBox;

                var id = long.Parse(lblId.Text);
                var doctorId = GetGroupId(txtbDName.Text)[0];
                var date = Convert.ToDateTime(txtbDate.Text);

                var prescription = new Prescription() { prescriptionId = id, doctorId = doctorId, dateWritten = date };
                _dataContext.Prescriptions.Attach(prescription);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, prescription);
                _dataContext.SubmitChanges();
                PrescriptionList.EditIndex = -1;

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
            Label lblId = PrescriptionList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var prescriptionDetails = from element in _dataContext.PrescriptionDetails
                                      where element.prescriptionId == intId
                                      select element;
            var visits = from element in _dataContext.Visits
                         where element.prescriptionId == intId
                         select element;

            if (prescriptionDetails.Count() != 0)
            {   
                _dataContext.PrescriptionDetails.DeleteAllOnSubmit(prescriptionDetails);
            }
            else if (visits.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(visits);
            }
            _dataContext.SubmitChanges();
        }

        //Control Role
        protected void PrescriptionList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < PrescriptionList.Rows.Count; i++)
                {
                    PrescriptionList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    PrescriptionList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}