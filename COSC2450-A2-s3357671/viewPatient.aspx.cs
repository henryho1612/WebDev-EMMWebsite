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
    }
}