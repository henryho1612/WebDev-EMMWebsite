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
    public partial class viewDrug : System.Web.UI.Page
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
            var result = from element in dataContext.DrugGroups
                         where element.drugGroupName.ToString().ToLower().StartsWith(prefixText)
                         select element.drugGroupName.ToString();
            return result.ToArray();
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var groups = from element in _dataContext.DrugGroups
                      select element.drugGroupName.ToString().ToLower();
            foreach (var groupName in groups.ToArray())
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
                TextBox txtBoxGroupId = FormView1.FindControl("EditGroupId") as TextBox;
                var groupId = GetGroupId(txtBoxGroupId.Text)[0];
                TextBox txtBoxIcdName = FormView1.FindControl("EditName") as TextBox;
                var name = txtBoxIcdName.Text;
                TextBox txtBoxGenName = FormView1.FindControl("EditGenName") as TextBox;
                var genName = txtBoxGenName.Text;
                TextBox txtBoxUnit = FormView1.FindControl("EditUnit") as TextBox;
                var unit = txtBoxUnit.Text;
                TextBox txtBoxPrice = FormView1.FindControl("EditPrice") as TextBox;
                var price = decimal.Parse(txtBoxPrice.Text);

                var drug = new Drug() { drugId = id, drugName = name, drugGroupId = groupId, drugGenericName = genName, unit = unit, price = price };
                _dataContext.Drugs.Attach(drug);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, drug);
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
            var chapterId = from element in _dataContext.DrugGroups
                            where element.drugGroupName.ToString().ToLower() == groupName.ToString().ToLower()
                            select element.drugGroupId;
            return chapterId.ToArray();
        }

        //ItemDeleted Event Control
        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("~/drug.aspx");
        }

        //ItemDeleting Event Control
        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            Label lblId = FormView1.FindControl("ViewId") as Label;
            var id = long.Parse(lblId.Text);
            var elements = from element in _dataContext.PrescriptionDetails
                           where element.drugId == id
                           select element;
            if (elements.Count() != 0)
            {
                _dataContext.PrescriptionDetails.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //ItemUpdated Event Control
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("~/drug.aspx");
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
            Response.Redirect("~/drug.aspx");
        }
    }
}