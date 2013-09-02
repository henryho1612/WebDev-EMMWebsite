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
    public partial class patient : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Submit Add Form
        protected void AddPatientButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddPatientButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var name = NameTextBox.Text;
                    var gender = GenderRadioButtonList1.SelectedItem.Value;
                    var genderId = long.Parse(gender);
                    var dob = Convert.ToDateTime(DOBTextBox.Text);
                    var address = AddressTextBox.Text;
                    
                    var patient = new Patient() { patientName = name, genderId = genderId, dob = dob, address = address };
                    _dataContext.Patients.InsertOnSubmit(patient);
                    _dataContext.SubmitChanges();
                    PatientsList.DataBind();

                    ResetInputField();

                    //Use For checking Data
                    //Debug.WriteLine("name: " + name);
                    //Debug.WriteLine("gender: " + gender);
                    //Debug.WriteLine("dob: " + dob);
                    //Debug.WriteLine("address: " + address);
                }
                else if (btnId.Equals("ResetPatientButton"))
                {
                    ResetInputField();
                }
            }
        }

        //Reset Input Field
        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            GenderRadioButtonList1.SelectedIndex = 0;
            DOBTextBox.Text = "";
            AddressTextBox.Text = "";
        }

        //Set value when radio button list is initted
        protected void GenderRadioButtonList_Init(object sender, EventArgs e)
        {
            GenderRadioButtonList1.SelectedIndex = 0;
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetPatients(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Patients
                          where element.patientName.ToLower().StartsWith(prefixText)
                          select element.patientName.ToString())
                         .Union(from element in dataContext.Patients
                                where element.Gender.genderName.ToString().ToLower().StartsWith(prefixText)
                                select element.Gender.genderName.ToString())
                                .Union(from element in dataContext.Patients
                                       where element.dob.ToString().ToLower().StartsWith(prefixText)
                                       select element.dob.ToString())
                                       .Union(from element in dataContext.Patients
                                              where element.address.ToString().ToLower().StartsWith(prefixText)
                                              select element.address.ToString());

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = PatientsList.EditIndex;
                var lblId = PatientsList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtBName = PatientsList.Rows[editedRowIndex].FindControl("EditName") as TextBox;
                var txtBGender = PatientsList.Rows[editedRowIndex].FindControl("EditGender") as Label;
                var txtBDob = PatientsList.Rows[editedRowIndex].FindControl("EditDOBTextBox") as TextBox;
                var txtBAddress = PatientsList.Rows[editedRowIndex].FindControl("EditAddress") as TextBox;

                var id = long.Parse(lblId.Text);
                var name = txtBName.Text;
                var gender = (txtBGender.Text.Equals("Male")) ? 1 : 2;
                var dob = Convert.ToDateTime(txtBDob.Text);
                var address = txtBAddress.Text;

                var patient = new Patient() { patientId = id, patientName = name, genderId = gender, dob = dob, address = address };
                _dataContext.Patients.Attach(patient);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, patient);
                _dataContext.SubmitChanges();
                PatientsList.EditIndex = -1;

                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("name: " + name);
                //Debug.WriteLine("gender: " + gender);
                //Debug.WriteLine("dob: " + dob);
                //Debug.WriteLine("address: " + address);
            }
        }

        //Take care of the other tables that have it as a foreign key
        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = PatientsList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var visit = from element in _dataContext.Visits
                        where element.patientId == intId
                        select element;

            if (visit.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(visit);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //Control Role
        protected void PatientsList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < PatientsList.Rows.Count; i++)
                {
                    PatientsList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    PatientsList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}