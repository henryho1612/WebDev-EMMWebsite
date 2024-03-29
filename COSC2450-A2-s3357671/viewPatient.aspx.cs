﻿using System;
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
    public partial class viewPatient : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Update Button Control
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                Label lblId = FormView1.FindControl("EditId") as Label;
                var id = long.Parse(lblId.Text);
                TextBox txtBoxName = FormView1.FindControl("EditName") as TextBox;
                var name = txtBoxName.Text;
                Label txtBoxGender = FormView1.FindControl("EditGender") as Label;
                var gender = (txtBoxGender.Text.Equals("Male")) ? 1 : 2;
                TextBox txtBoxDOB = FormView1.FindControl("EditDOB") as TextBox;
                var dob = Convert.ToDateTime(txtBoxDOB.Text);
                TextBox txtBoxAddress = FormView1.FindControl("EditAddress") as TextBox;
                var address = txtBoxAddress.Text;
              
                var patient = new Patient() { patientId = id, patientName = name, genderId = gender, dob = dob, address = address };
                _dataContext.Patients.Attach(patient);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, patient);
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
            Response.Redirect("~/patient.aspx");
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
        public static string[] GetPrescriptionList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Prescriptions
                          where element.prescriptionId.ToString().ToLower().StartsWith(prefixText)
                          select element.prescriptionId.ToString()).Distinct();
            return result.ToArray();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetLabOrderList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.LabOrders
                          where element.labOrderId.ToString().ToLower().StartsWith(prefixText)
                          select element.labOrderId.ToString()).Distinct();
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
            else if (type.Equals("prescription"))
            {
                var groupId = from element in _dataContext.Prescriptions
                              where element.prescriptionId.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.prescriptionId;
                return groupId.ToArray();
            }
            else if (type.Equals("laborder"))
            {
                var groupId = from element in _dataContext.LabOrders
                              where element.labOrderId.ToString().ToLower() == groupName.ToString().ToLower()
                              select element.labOrderId;
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
        protected void PrescriptionExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var prescriptions = from element in _dataContext.Prescriptions
                                select element.prescriptionId.ToString().ToLower();
            foreach (var prescription in prescriptions.ToArray())
            {
                if (prescription.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void LabOrderExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var labOrders = from element in _dataContext.LabOrders
                            select element.labOrderId.ToString().ToLower();
            foreach (var labOrder in labOrders.ToArray())
            {
                if (labOrder.ToString().ToLower().Equals(inputValue.ToLower()))
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

        protected void AddVisitButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddVisitButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var hospital = GetId(HospitalTxt.Text, "hospital")[0];
                    var doctor = GetId(DoctorTxt.Text, "doctor")[0];
                    var patient = GetId(PatientTxt.Text, "patient")[0];
                    var icd = GetId(ICDTxt.Text, "icd")[0];
                    //var prescription = GetId(PrescriptionTxt.Text, "prescription")[0];
                    //var labOrder = GetId(LabOrderTxt.Text, "laborder")[0];
                    var date = Convert.ToDateTime(visitedDate.Text);
                    var outcome = OutcomeTxt.Text;

                    //var visit = new Visit() { hospitalId = hospital, doctorId = doctor, patientId = patient, icdId = icd, prescriptionId = prescription, labOrderId = labOrder, dateVisit = date, outcome = outcome };
                    var visit = new Visit() { hospitalId = hospital, doctorId = doctor, patientId = patient, icdId = icd, dateVisit = date, outcome = outcome };
                    _dataContext.Visits.InsertOnSubmit(visit);
                    _dataContext.SubmitChanges();
                    VisitList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetVisitButton"))
            {
                ResetInputField();
            }
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(2000);
                var editedRowIndex = VisitList.EditIndex;
                var idTxt = VisitList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var hospitalTxt = VisitList.Rows[editedRowIndex].FindControl("EditHospital") as TextBox;
                var doctorTxt = VisitList.Rows[editedRowIndex].FindControl("EditDoctor") as TextBox;
                var patientTxt = VisitList.Rows[editedRowIndex].FindControl("EditPatient") as TextBox;
                var icdTxt = VisitList.Rows[editedRowIndex].FindControl("EditIcd") as TextBox;
                //var prescriptionTxt = VisitList.Rows[editedRowIndex].FindControl("EditPrescription") as TextBox;
                //var labOrderTxt = VisitList.Rows[editedRowIndex].FindControl("EditLabOrder") as TextBox;
                var dateTxt = VisitList.Rows[editedRowIndex].FindControl("EditDate") as TextBox;
                var outcomeTxt = VisitList.Rows[editedRowIndex].FindControl("EditOutcome") as TextBox;

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
                VisitList.EditIndex = -1;
            }
        }

        protected void ResetInputField()
        {
            HospitalTxt.Text = "";
            DoctorTxt.Text = "";
            PatientTxt.Text = "";
            ICDTxt.Text = "";
            //PrescriptionTxt.Text = "";
            //LabOrderTxt.Text = "";
            visitedDate.Text = "";
            OutcomeTxt.Text = "";
        }

        protected void VisitList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < VisitList.Rows.Count; i++)
                {
                    VisitList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    VisitList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel5.Visible = false;
                LblNotice.Visible = true;
            }
        }

        protected void PatientTxt_Load(object sender, EventArgs e)
        {
            var patientId = long.Parse(Request["ID"]);
            var patient = from element in _dataContext.Patients
                          where element.patientId == patientId
                          select element.patientName.ToString();
            PatientTxt.Text = patient.ToArray()[0];
        }
    }
}