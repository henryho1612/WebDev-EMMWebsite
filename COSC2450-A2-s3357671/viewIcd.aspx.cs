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
    public partial class viewIcd : System.Web.UI.Page
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
            var result = from element in dataContext.IcdChapters
                         where element.icdChapterName.ToString().ToLower().StartsWith(prefixText)
                         select element.icdChapterName.ToString();
            return result.ToArray();
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var icd = from element in _dataContext.IcdChapters
                      select element.icdChapterName.ToString().ToLower();
            foreach (var groupName in icd.ToArray())
            {
                if (groupName.ToString().ToLower().Equals(inputValue.ToLower()))
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
                TextBox txtBoxGroupId = FormView1.FindControl("EditChapterName") as TextBox;
                var groupId = GetGroupId(txtBoxGroupId.Text)[0];
                TextBox txtBoxIcdName = FormView1.FindControl("EditName") as TextBox;
                var name = txtBoxIcdName.Text;
                TextBox txtBoxCode = FormView1.FindControl("EditCode") as TextBox;
                var code = txtBoxCode.Text;

                var icd = new Icd() { icdId = id, icdChapterId = groupId, icdName = name, icdCode = code };
                _dataContext.Icds.Attach(icd);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, icd);
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
            var chapterId = from element in _dataContext.IcdChapters
                            where element.icdChapterName.ToString().ToLower() == groupName.ToString().ToLower()
                            select element.icdChapterId;
            return chapterId.ToArray();
        }

        //ItemDeleted Event Control
        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/icd.aspx");
        }

        //ItemDeleting Event Control
        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var id = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Visits
                           where element.icdId == id
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //ItemUpdated Event Control
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/icd.aspx");
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
            Response.Redirect("~/icd.aspx");
        }
    }
}