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
    public partial class doctor : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Submit Add Form
        protected void AddDoctorButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddDoctorButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var name = NameTextBox.Text;
                    var gender = GenderRadioButtonList1.SelectedItem.Value;
                    var genderId = long.Parse(gender);
                    var dob = Convert.ToDateTime(DOBTextBox.Text);
                    var address = AddressTextBox.Text;
                    var license = LicenseTextBox.Text;

                    var doctor = new Doctor() { doctorName = name, genderId = genderId, dob = dob, address = address, license = license };
                    _dataContext.Doctors.InsertOnSubmit(doctor);
                    _dataContext.SubmitChanges();
                    DoctorsList.DataBind();

                    ResetInputField();

                    //Use For checking Data
                    //Debug.WriteLine("name: " + name);
                    //Debug.WriteLine("gender: " + gender);
                    //Debug.WriteLine("dob: " + dob);
                    //Debug.WriteLine("address: " + address);
                    //Debug.WriteLine("license: " + license);
                }
                else if (btnId.Equals("ResetDoctorButton"))
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
            LicenseTextBox.Text = "";
        }

        //Set value when radio button list is initted
        protected void GenderRadioButtonList_Init(object sender, EventArgs e)
        {
            GenderRadioButtonList1.SelectedIndex = 0;
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetDoctors(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Doctors
                          where element.doctorName.ToLower().StartsWith(prefixText)
                          select element.doctorName.ToString())
                         .Union(from element in dataContext.Doctors
                                where element.Gender.genderName.ToString().ToLower().StartsWith(prefixText)
                                select element.Gender.genderName.ToString())
                                .Union(from element in dataContext.Doctors
                                       where element.dob.ToString().ToLower().StartsWith(prefixText)
                                       select element.dob.ToString())
                                       .Union(from element in dataContext.Doctors
                                              where element.address.ToString().ToLower().StartsWith(prefixText)
                                              select element.address.ToString())
                                              .Union(from element in dataContext.Doctors
                                                     where element.license.ToString().ToLower().StartsWith(prefixText)
                                                     select element.license.ToString());

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = DoctorsList.EditIndex;
                var lblId = DoctorsList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtBName = DoctorsList.Rows[editedRowIndex].FindControl("EditName") as TextBox;
                var txtBGender = DoctorsList.Rows[editedRowIndex].FindControl("EditGender") as Label;
                var txtBDob = DoctorsList.Rows[editedRowIndex].FindControl("EditDOBTextBox") as TextBox;
                var txtBAddress = DoctorsList.Rows[editedRowIndex].FindControl("EditAddress") as TextBox;
                var txtBLicense = DoctorsList.Rows[editedRowIndex].FindControl("EditLicense") as TextBox;

                var id = long.Parse(lblId.Text);
                var name = txtBName.Text;
                var gender = (txtBGender.Text.Equals("Male")) ? 1 : 2;
                var dob = Convert.ToDateTime(txtBDob.Text);
                var address = txtBAddress.Text;
                var license = txtBLicense.Text;

                var doctor = new Doctor() { doctorId = id, doctorName = name, genderId = gender, dob = dob, address = address, license = license };
                _dataContext.Doctors.Attach(doctor);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, doctor);
                _dataContext.SubmitChanges();
                DoctorsList.EditIndex = -1;

                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("name: " + name);
                //Debug.WriteLine("gender: " + gender);
                //Debug.WriteLine("dob: " + dob);
                //Debug.WriteLine("address: " + address);
                //Debug.WriteLine("license: " + license);
            }
        }

        //Take care of the other tables that have it as a foreign key
        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = DoctorsList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var labOrders = from element in _dataContext.LabOrders
                            where element.doctorId == intId
                            select element;
            var prescriptions = from element in _dataContext.Prescriptions
                                where element.doctorId == intId
                                select element;
            var visits = from element in _dataContext.Visits
                         where element.doctorId == intId
                         select element;

            if (labOrders.Count() != 0)
            {
                var labOrderArray = labOrders.ToArray();
                for (var i = 0; i < labOrderArray.Count(); i++)
                {
                    var labOrderDetail = from element in _dataContext.LabOrderDetails
                                         where element.labOrderId == labOrderArray[i].labOrderId
                                         select element;
                    if (labOrderDetail.Count() != 0)
                    {
                        _dataContext.LabOrderDetails.DeleteAllOnSubmit(labOrderDetail);
                    }
                }
                _dataContext.LabOrders.DeleteAllOnSubmit(labOrders);
            }
            if (prescriptions.Count() != 0)
            {
                var prescriptArray = prescriptions.ToArray();
                for (var i = 0; i < prescriptArray.Count(); i++)
                {
                    var prescriptionDetail = from element in _dataContext.PrescriptionDetails
                                             where element.prescriptionId == prescriptArray[i].prescriptionId
                                             select element;
                    if (prescriptionDetail.Count() != 0)
                    {
                        _dataContext.PrescriptionDetails.DeleteAllOnSubmit(prescriptionDetail);
                    }
                }
                _dataContext.Prescriptions.DeleteAllOnSubmit(prescriptions);
            }
            if (visits.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(visits);
            }
            _dataContext.SubmitChanges();
        }

        //Control Role
        protected void DoctorsList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < DoctorsList.Rows.Count; i++)
                {
                    DoctorsList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    DoctorsList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}