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
    public partial class viewVisit : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetHospitalList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Hospitals
                          where element.hospitalName.ToString().ToLower().StartsWith(prefixText)
                          select element.hospitalName.ToString()).Distinct();
            return result.ToArray();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetDoctorList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Doctors
                          where element.doctorName.ToString().ToLower().StartsWith(prefixText)
                          select element.doctorName.ToString()).Distinct();
            return result.ToArray();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetPatientList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Patients
                          where element.patientName.ToString().ToLower().StartsWith(prefixText)
                          select element.patientName.ToString()).Distinct();
            return result.ToArray();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetICDList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Icds
                          where element.icdName.ToString().ToLower().StartsWith(prefixText)
                          select element.icdName.ToString()).Distinct();
            return result.ToArray();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetOutcomeList(string prefixText)
        {
            string[] outcomes = { "CURED", "DECREASED", "INCREASED", "UNCHANGED", "DIED" };
            return outcomes;
        }

        //Add Option - Get Group Id
        protected long[] GetId(string groupName, string type)
        {
            if (type.Equals("hospital"))
            {
                var groupId = from element in _dataContext.Hospitals
                              where element.hospitalName.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.hospitalId;
                return groupId.ToArray();
            }
            else if (type.Equals("doctor"))
            {
                var groupId = from element in _dataContext.Doctors
                              where element.doctorName.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.doctorId;
                return groupId.ToArray();
            }
            else if (type.Equals("patient"))
            {
                var groupId = from element in _dataContext.Patients
                              where element.patientName.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.patientId;
                return groupId.ToArray();
            }
            else if (type.Equals("icd"))
            {
                var groupId = from element in _dataContext.Icds
                              where element.icdName.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.icdId;
                return groupId.ToArray();
            }

            return null;
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void HospitalExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var hospitals = from element in _dataContext.Hospitals
                            select element.hospitalName.ToString().ToLower();
            foreach (var hospital in hospitals.ToArray())
            {
                if (hospital.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void DoctorExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
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

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void PatientExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var patients = from element in _dataContext.Patients
                           select element.patientName.ToString().ToLower();
            foreach (var patient in patients.ToArray())
            {
                if (patient.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ICDExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var icds = from element in _dataContext.Icds
                       select element.icdName.ToString().ToLower();
            foreach (var icd in icds.ToArray())
            {
                if (icd.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void OutcomeExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            string[] outcomes = { "CURED", "DECREASED", "INCREASED", "UNCHANGED", "DIED" };
            foreach (var outcome in outcomes)
            {
                if (outcome.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Update Button Control
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var idTxt = FormView1.FindControl("EditId") as Label;
                var hospitalTxt = FormView1.FindControl("EditHospital") as TextBox;
                var doctorTxt = FormView1.FindControl("EditDoctor") as TextBox;
                var patientTxt = FormView1.FindControl("EditPatient") as TextBox;
                var icdTxt = FormView1.FindControl("EditIcd") as TextBox;
                //var prescriptionTxt = FormView1.FindControl("EditPrescription") as TextBox;
                //var labOrderTxt = FormView1.FindControl("EditLabOrder") as TextBox;
                var dateTxt = FormView1.FindControl("EditDate") as TextBox;
                var outcomeTxt = FormView1.FindControl("EditOutcome") as TextBox;

                var id = long.Parse(idTxt.Text);
                var hospital = GetId(hospitalTxt.Text, "hospital")[0];
                var doctor = GetId(doctorTxt.Text, "doctor")[0];
                var patient = GetId(patientTxt.Text, "patient")[0];
                var icd = GetId(icdTxt.Text, "icd")[0];
                //var prescription = GetId(prescriptionTxt.Text, "prescription")[0];
                //var labOrder = GetId(labOrderTxt.Text, "laborder")[0];
                var date = Convert.ToDateTime(dateTxt.Text);
                var outcome = outcomeTxt.Text;

                var visit = new Visit() { visitId = id, hospitalId = hospital, doctorId = doctor, patientId = patient, icdId = icd, dateVisit = date, outcome = outcome };
                _dataContext.Visits.Attach(visit);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, visit);
                _dataContext.SubmitChanges();
                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("groupId: " + groupId);
                //Debug.WriteLine("Name: " + name);
                //Debug.WriteLine("price: " + price);
            }
        }

        //ItemDeleted Event Control
        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/patient.aspx");
        }

        //ItemDeleting Event Control
        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
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

        //ItemUpdated Event Control
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/patient.aspx");
        }

        //Role Control
        protected void FormView1_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                FormView1.FindControl("EditButton").Visible = false;
                FormView1.FindControl("DeleteButton").Visible = false;
            }
        }

        //Back Button Control
        protected void BackButton_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }
}