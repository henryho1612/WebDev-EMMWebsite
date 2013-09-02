using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class viewLabOrder : System.Web.UI.Page
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

        //Update Button Control
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                Label lblId = FormView1.FindControl("EditId") as Label;
                var id = long.Parse(lblId.Text);
                TextBox txtBoxDName = FormView1.FindControl("EditDName") as TextBox;
                var doctorId = GetGroupId(txtBoxDName.Text)[0];
                TextBox txtBoxDate = FormView1.FindControl("EditDate") as TextBox;
                var date = Convert.ToDateTime(txtBoxDate.Text);

                //var icd = new Icd() { icdId = id, icdChapterId = groupId, icdName = name, icdCode = code };
                //_dataContext.Icds.Attach(icd);
                //_dataContext.Refresh(RefreshMode.KeepCurrentValues, icd);
                //_dataContext.SubmitChanges();

                //Use For Debug passed value
                Debug.WriteLine("id: " + id);
                Debug.WriteLine("DName: " + doctorId);
                Debug.WriteLine("Date: " + date);
            }
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

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.Doctors
                          where element.doctorName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.doctorId;
            return groupId.ToArray();
        }

        //ItemDeleted Event Control
        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/labOrder.aspx");
        }

        //ItemDeleting Event Control
        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var id = long.Parse(lblId.Text);
            var labOrderDetails = from element in _dataContext.LabOrderDetails
                                  where element.labOrderId == id
                                  select element;
            var visits = from element in _dataContext.Visits
                         where element.labOrderId == id
                         select element;

            if (labOrderDetails.Count() != 0 || visits.Count() != 0)
            {
                _dataContext.LabOrderDetails.DeleteAllOnSubmit(labOrderDetails);
                _dataContext.Visits.DeleteAllOnSubmit(visits);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //ItemUpdated Event Control
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/labOrder.aspx");
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
            Response.Redirect("~/labOrder.aspx");
        }
    }
}