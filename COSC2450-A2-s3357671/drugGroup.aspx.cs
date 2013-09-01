using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class drugGroup : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddDGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddDGroupButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var groupName = NameTextBox.Text;

                    var drugGroup = new DrugGroup() { drugGroupName = groupName};
                    _dataContext.DrugGroups.InsertOnSubmit(drugGroup);
                    _dataContext.SubmitChanges();
                    DrugGroupList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetDGroupButton"))
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
        public static string[] GetDrugGroups(string prefixText)
        {
            var dataContext = new DBDataContext();

            var result = (from n in dataContext.DrugGroups
                          where n.drugGroupName.ToString().ToLower().StartsWith(prefixText.ToLower())
                          select n.drugGroupName.ToString());
            return result.ToArray();
        }

        protected void DrugGroupList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var index = e.RowIndex;
            Label lblId = DrugGroupList.Rows[index].FindControl("ViewId") as Label;
            var longId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Drugs
                           where element.drugGroupId == longId
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.Drugs.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void DrugGroupList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < DrugGroupList.Rows.Count; i++)
                {
                    DrugGroupList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    DrugGroupList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}