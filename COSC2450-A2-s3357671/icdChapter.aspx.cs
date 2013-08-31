using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class icdChapter : System.Web.UI.Page
    {

        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddICDChapterGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddICDChapterButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var icdChapterName = NameTextBox.Text;

                    var icdChapter = new IcdChapter() { icdChapterName = icdChapterName };
                    _dataContext.IcdChapters.InsertOnSubmit(icdChapter);
                    _dataContext.SubmitChanges();
                    IcdChapterList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetICDChapterGroupButton"))
            {
                ResetInputField();
            }
        }

        protected void ResetInputField()
        {
            NameTextBox.Text = "";
        }

        //Assisted By s3357678
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetIcdChapters(string prefixText)
        {
            var dataContext = new DBDataContext();

            var result = (from n in dataContext.IcdChapters
                          where n.icdChapterName.ToString().ToLower().StartsWith(prefixText.ToLower())
                          select n.icdChapterName.ToString());
            return result.ToArray();
        }

        protected void IcdChapterList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var index = e.RowIndex;
            Label lblId = IcdChapterList.Rows[index].FindControl("ViewId") as Label;
            var longId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Icds
                           where element.icdChapterId == longId
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.Icds.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void IcdChapterList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < IcdChapterList.Rows.Count; i++)
                {
                    IcdChapterList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    IcdChapterList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}