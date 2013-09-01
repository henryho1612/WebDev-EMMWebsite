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
    public partial class drug : System.Web.UI.Page
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
            var drugGroups = from element in _dataContext.DrugGroups
                             select element.drugGroupName.ToString().ToLower();
            foreach (var group in drugGroups.ToArray())
            {
                if (group.ToString().ToLower().Equals(inputValue.ToLower()))
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
        protected void AddDrugButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddDrugButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var drugName = NameTextBox.Text;
                    var drugGroup = GroupNameTextBox.Text;
                    var groupId = GetGroupId(drugGroup)[0];
                    var drugGenName = GenNameTextBox.Text; ;
                    var unit = UnitTextBox.Text;
                    var price = decimal.Parse(PriceTextBox.Text);

                    var drug = new Drug () { drugName = drugName, drugGroupId = groupId, drugGenericName = drugGenName, unit = unit, price = price };
                    _dataContext.Drugs.InsertOnSubmit(drug);
                    _dataContext.SubmitChanges();
                    DrugsList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetDrugButton"))
            {
                ResetInputField();
            }
        }

        //Reset all textBox field
        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            GroupNameTextBox.Text = "";
            GenNameTextBox.Text = "";
            UnitTextBox.Text = "";
            PriceTextBox.Text = "";
        }

        //Assisted By s3357678
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

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.DrugGroups
                          where element.drugGroupName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.drugGroupId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetDrug(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.Drugs
                          where element.drugName.ToLower().StartsWith(prefixText)
                          select element.drugName.ToString())
                         .Union(from element in dataContext.Drugs
                                where element.DrugGroup.drugGroupName.ToString().ToLower().StartsWith(prefixText)
                                select element.DrugGroup.drugGroupName.ToString())
                                .Union(from element in dataContext.Drugs
                                       where element.drugGenericName.ToString().ToLower().StartsWith(prefixText)
                                       select element.drugGenericName.ToString())
                                       .Union(from element in dataContext.Drugs
                                              where element.unit.ToString().ToLower().StartsWith(prefixText)
                                              select element.unit.ToString())
                                              .Union(from element in dataContext.Drugs
                                                     where element.price.ToString().ToLower().StartsWith(prefixText)
                                                     select element.price.ToString());

            return result.ToArray();
        }

        //Control Update Process
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = DrugsList.EditIndex;
                var lblId = DrugsList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbGroupId = DrugsList.Rows[editedRowIndex].FindControl("EditGroupId") as TextBox;
                var txtbName = DrugsList.Rows[editedRowIndex].FindControl("EditName") as TextBox;
                var txtGenName = DrugsList.Rows[editedRowIndex].FindControl("EditGenericName") as TextBox;
                var txtUnit = DrugsList.Rows[editedRowIndex].FindControl("EditUnit") as TextBox;
                var txtPrice = DrugsList.Rows[editedRowIndex].FindControl("EditPrice") as TextBox;

                var id = long.Parse(lblId.Text);
                var groupId = GetGroupId(txtbGroupId.Text)[0];
                var name = txtbName.Text;
                var genName = txtGenName.Text;
                var unit = txtUnit.Text;
                var price = decimal.Parse(txtPrice.Text);

                var drug = new Drug() { drugId = id, drugGroupId = groupId, drugName = name, drugGenericName = genName, unit = unit, price = price };
                _dataContext.Drugs.Attach(drug);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, drug);
                _dataContext.SubmitChanges();
                DrugsList.EditIndex = -1;
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
            Label lblId = DrugsList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.PrescriptionDetails
                           where element.drugId == intId
                           select element;

            if (elements.Count() != 0)
            {
                _dataContext.PrescriptionDetails.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        //Control Role
        protected void DrugsList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < DrugsList.Rows.Count; i++)
                {
                    DrugsList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    DrugsList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}