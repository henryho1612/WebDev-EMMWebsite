using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.Linq;

namespace COSC2450_A2_s3357671
{
    public partial class icd : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var icdChapters = from element in _dataContext.IcdChapters
                               select element.icdChapterName.ToString().ToLower();
            foreach (var chapter in icdChapters.ToArray())
            {
                if (chapter.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
            //int editIndex = MedicalServiceList.EditIndex;
            //TextBox textBox = MedicalServiceList.Rows[editIndex].FindControl("EditGroupId") as TextBox;
            //var inputStringData = textBox.Text;
            //var inputIntData = Convert.ToInt64(inputStringData);
            //var idList = from element in _dataContext.MedicalServiceGroups
            //             select element.medicalServiceGroupId;
            //foreach (var id in idList.ToArray())
            //{
            //    if (id == inputIntData)
            //    {
            //        args.IsValid = true;
            //        return;
            //    }
            //}
            //args.IsValid = false;
        }

        //Submit Add Form
        protected void AddIcdButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddIcdButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var icdName = NameTextBox.Text;
                    var chapter = GroupNameTextBox.Text;
                    var chapterId = GetGroupId(chapter)[0];
                    var codeName = CodeTextBox.Text;

                    var icd = new Icd() { icdName = icdName, icdChapterId = chapterId, icdCode = codeName};
                    _dataContext.Icds.InsertOnSubmit(icd);
                    _dataContext.SubmitChanges();
                    IcdList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetIcdButton"))
            {
                ResetInputField();
            }
        }

        //Reset all textBox field
        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            GroupNameTextBox.Text = "";
            CodeTextBox.Text = "";
        }

        //Assisted By s3357678
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

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.IcdChapters
                          where element.icdChapterName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.icdChapterId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetIcd(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Icds
                          where element.icdName.ToLower().StartsWith(prefixText)
                          select element.icdName.ToString())
                         .Union(from element in dataContext.Icds
                                where element.IcdChapter.icdChapterName.ToString().ToLower().StartsWith(prefixText)
                                select element.IcdChapter.icdChapterName.ToString())
                                .Union(from element in dataContext.Icds
                                       where element.icdCode.ToString().ToLower().StartsWith(prefixText)
                                       select element.icdCode.ToString());

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = IcdList.EditIndex;
                var lblId = IcdList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbGroupId = IcdList.Rows[editedRowIndex].FindControl("EditChapterId") as TextBox;
                var txtbName = IcdList.Rows[editedRowIndex].FindControl("EditName") as TextBox;
                var txtbCode = IcdList.Rows[editedRowIndex].FindControl("EditCode") as TextBox;

                var id = long.Parse(lblId.Text);
                var groupId = GetGroupId(txtbGroupId.Text)[0];
                var name = txtbName.Text;
                var codeName = txtbCode.Text;

                var icd = new Icd() { icdId = id, icdChapterId = groupId, icdName = name, icdCode = codeName};
                _dataContext.Icds.Attach(icd);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, icd);
                _dataContext.SubmitChanges();
                IcdList.EditIndex = -1;
                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("groupId: " + groupdId);
                //Debug.WriteLine("Name: " + name);
                //Debug.WriteLine("price: " + price);
            }
        }

        //Take care of the other tables that have it as a foreign key
        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = IcdList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Visits
                           where element.icdId == intId
                           select element;

            if (elements.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //Control Role
        protected void IcdList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < IcdList.Rows.Count; i++)
                {
                    IcdList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    IcdList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}