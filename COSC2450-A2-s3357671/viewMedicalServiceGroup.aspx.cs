using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class viewMedicalServiceGroup : System.Web.UI.Page
    {

        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/medicalServiceGroup.aspx");
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var longId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.MedicalServices
                           where element.medicalServiceGroupId == longId
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.MedicalServices.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/medicalServiceGroup.aspx");
        }

        protected void FormView1_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                FormView1.FindControl("EditBtn").Visible = false;
                FormView1.FindControl("DeleteBtn").Visible = false;
            }
        }

        protected void BackButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/medicalServiceGroup.aspx");
        }
    }
}