using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class viewMedicalService : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetGroupNameList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.MedicalServiceGroups
                         where element.medicalServiceGroupName.ToString().ToLower().StartsWith(prefixText)
                         select element.medicalServiceGroupName.ToString();
            return result.ToArray();
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var serviceGroup = from element in _dataContext.MedicalServiceGroups
                               select element.medicalServiceGroupName.ToString().ToLower();
            foreach (var groupName in serviceGroup.ToArray())
            {
                if (groupName.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                Label lblId = FormView1.FindControl("EditId") as Label;
                var id = long.Parse(lblId.Text);
                TextBox txtBoxGroupId = FormView1.FindControl("EditGroupName") as TextBox;
                var groupId = GetGroupId(txtBoxGroupId.Text)[0];
                TextBox txtBoxServiceName = FormView1.FindControl("EditServiceName") as TextBox;
                var name = txtBoxServiceName.Text;
                TextBox txtBoxPrice = FormView1.FindControl("EditPrice") as TextBox;
                var price = decimal.Parse(txtBoxPrice.Text); 

                var medicalService = new MedicalService() { medicalServiceId = id, medicalServiceGroupId = groupId, medicalServiceName = name, price = price };
                _dataContext.MedicalServices.Attach(medicalService);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, medicalService);
                _dataContext.SubmitChanges();
                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("groupId: " + groupId);
                //Debug.WriteLine("Name: " + name);
                //Debug.WriteLine("price: " + price);
            }
        }

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.MedicalServiceGroups
                          where element.medicalServiceGroupName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.medicalServiceGroupId;
            return groupId.ToArray();
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/medicalService.aspx");
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var id = long.Parse(lblId.Text);
            var elements = from element in _dataContext.LabOrderDetails
                           where element.medicalServiceId == id
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.LabOrderDetails.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/medicalService.aspx");
        }

        protected void FormView1_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                FormView1.FindControl("EditButton").Visible = false;
                FormView1.FindControl("DeleteButton").Visible = false;
            }
        }

        protected void BackButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/medicalService.aspx");
        }
    }
}