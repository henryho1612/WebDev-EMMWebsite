using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class viewIcdChapter : System.Web.UI.Page
    {

        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/icdChapter.aspx");
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var longId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Icds
                           where element.icdChapterId == longId
                           select element;
            if (elements.Count() != 0)
            {
                var icdChapterArray = elements.ToArray();
                for (var i = 0; i < icdChapterArray.Count(); i++)
                {
                    var visit = from element in _dataContext.Visits
                                where element.icdId == icdChapterArray[i].icdId
                                select element;
                    if (visit.Count() != 0)
                    {
                        _dataContext.Visits.DeleteAllOnSubmit(visit);
                    }
                }
                _dataContext.Icds.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/icdChapter.aspx");
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
            Response.Redirect("~/icdChapter.aspx");
        }
    }
}