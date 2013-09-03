﻿using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class viewDoctor : System.Web.UI.Page
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
                TextBox txtBoxLicense = FormView1.FindControl("EditLicense") as TextBox;
                var license = txtBoxLicense.Text;

                var doctor = new Doctor() { doctorId = id, doctorName = name, genderId = gender, dob = dob, address = address, license = license };
                _dataContext.Doctors.Attach(doctor);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, doctor);
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
            Response.Redirect("~/doctor.aspx");
        }

        //ItemDeleting Event Control
        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
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
            else if (prescriptions.Count() != 0)
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
            else if (visits.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(visits);
            }
            _dataContext.SubmitChanges();
        }

        //ItemUpdated Event Control
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/doctor.aspx");
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
            Response.Redirect("~/doctor.aspx");
        }
    }
}