using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class index : System.Web.UI.Page
    {
        private DBDataContext _dataContext;
        private int total = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
            SetLblValue();
        }

        private void SetLblValue()
        {
            LblUserData.Text = CollectStatistic("User").ToString();
            LblHospitalData.Text = CollectStatistic("Hopital").ToString();
            LblDoctorData.Text = CollectStatistic("Doctor").ToString();
            LblPatientData.Text = CollectStatistic("Patient").ToString();
            LblVisitData.Text = CollectStatistic("Visit").ToString();
            LblIcdData.Text = CollectStatistic("ICD").ToString();
            LblPrescriptionData.Text = CollectStatistic("Prescription").ToString();
            LblLabOrderData.Text = CollectStatistic("Lab Order").ToString();
            LblDrugData.Text = CollectStatistic("Drug").ToString();
            LblMedicalServiceData.Text = CollectStatistic("Medical Service").ToString();
            LblTotalNumber.Text = total.ToString();
        }

        private int CollectStatistic(String type)
        {
            var amount = 0;
            if (type.Equals("User"))
            {
                var elements = from element in _dataContext.Users
                               select element.userId;
                amount = elements.Count();
            }
            else if (type.Equals("Hopital"))
            {
                var elements = from element in _dataContext.Hospitals
                               select element.hospitalId;
                amount = elements.Count();
            }
            else if (type.Equals("Doctor"))
            {
                var elements = from element in _dataContext.Doctors
                               select element.doctorId;
                amount = elements.Count();
            }
            else if (type.Equals("Patient"))
            {
                var elements = from element in _dataContext.Patients
                               select element.patientId;
                amount = elements.Count();
            }
            else if (type.Equals("Visit"))
            {
                var elements = from element in _dataContext.Visits
                               select element.visitId;
                amount = elements.Count();
            }
            else if (type.Equals("ICD"))
            {
                var elements = from element in _dataContext.Icds
                               select element.icdId;
                amount = elements.Count();
            }
            else if (type.Equals("Prescription"))
            {
                var elements = from element in _dataContext.Prescriptions
                               select element.prescriptionId;
                amount = elements.Count();
            }
            else if (type.Equals("Lab Order"))
            {
                var elements = from element in _dataContext.LabOrders
                               select element.labOrderId;
                amount = elements.Count();
            }
            else if (type.Equals("Drug"))
            {
                var elements = from element in _dataContext.Drugs
                               select element.drugId;
                amount = elements.Count();
            }
            else if (type.Equals("Medical Service"))
            {
                var elements = from element in _dataContext.MedicalServices
                               select element.medicalServiceId;
                amount = elements.Count();
            }
            total += amount;

            return amount;
        }
    }
}