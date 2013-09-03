using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class viewDrugGroup : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/drugGroup.aspx");
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var longId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Drugs
                           where element.drugGroupId == longId
                           select element;
            if (elements.Count() != 0)
            {
                var drugArray = elements.ToArray();
                for (var i = 0; i < drugArray.Count(); i++)
                {
                    var prescriptionDetail = from element in _dataContext.PrescriptionDetails
                                             where element.drugId == drugArray[i].drugId
                                             select element;
                    if (prescriptionDetail.Count() != 0)
                    {
                        _dataContext.PrescriptionDetails.DeleteAllOnSubmit(prescriptionDetail);
                    }
                }
                _dataContext.Drugs.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/drugGroup.aspx");
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
            Response.Redirect("~/drugGroup.aspx");
        }
    }
}