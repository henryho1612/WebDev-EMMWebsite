using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class viewHospital : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lbl = HospitalFormView.FindControl("ViewId") as Label;
            var hospitalId = long.Parse(lbl.Text);
            var elements = from element in _dataContext.Visits
                           where element.hospitalId == hospitalId
                           select element;

            if (elements.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/hospital.aspx");
        }

        protected void HospitalFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/hospital.aspx");
        }
    }
}