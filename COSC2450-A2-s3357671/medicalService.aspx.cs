using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace COSC2450_A2_s3357671
{
    public partial class medicalService : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddMSButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddMSButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var msName = NameTextBox.Text;
                    var groupName = GroupNameTextBox.Text;
                    var groupId = GetGroupId(groupName)[0];
                    var msPrice = PriceTextBox.Text;

                    var ms = new MedicalService() { medicalServiceName = msName, medicalServiceGroupId = groupId, price = Convert.ToDecimal(msPrice) };
                    _dataContext.MedicalServices.InsertOnSubmit(ms);
                    _dataContext.SubmitChanges();
                    MedicalServiceList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetMSButton"))
            {
                ResetInputField();
            }
        }

        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            GroupNameTextBox.Text = "";
            PriceTextBox.Text = "";
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetGroupNameList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.MedicalServiceGroups
                         where element.medicalServiceGroupName.ToString().ToLower().StartsWith(prefixText)
                         select element.medicalServiceGroupName.ToString();
            return result.ToArray();
        }

        //Add Option - Get Group Id
        protected long[] GetGroupId(string groupName)
        {
            var groupId = from element in _dataContext.MedicalServiceGroups
                          where element.medicalServiceGroupName.ToString().ToLower() == groupName.ToString().ToLower()
                          select element.medicalServiceGroupId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetMedicalService(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.MedicalServices
                          where element.medicalServiceName.ToLower().StartsWith(prefixText)
                          select element.medicalServiceName.ToString())
                         .Union(from element in dataContext.MedicalServices
                                where element.MedicalServiceGroup.medicalServiceGroupName.ToString().ToLower().StartsWith(prefixText)
                                select element.MedicalServiceGroup.medicalServiceGroupName.ToString());

            return result.ToArray();
        }

        //Validate input service group name
        //Add Option - Validate existence of group naem
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var serviceGroup = from element in _dataContext.MedicalServiceGroups
                               select element.medicalServiceGroupName.ToString().ToLower();
            foreach (var groupName in serviceGroup.ToArray())
            {
                if (groupName.ToString().ToLower().Equals(inputValue.ToLower()))
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

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = MedicalServiceList.EditIndex;
                var lblId = MedicalServiceList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbGroupId = MedicalServiceList.Rows[editedRowIndex].FindControl("EditGroupId") as TextBox;
                var txtbName = MedicalServiceList.Rows[editedRowIndex].FindControl("EditName") as TextBox;
                var txtbPrice = MedicalServiceList.Rows[editedRowIndex].FindControl("editPrice") as TextBox;

                var id = long.Parse(lblId.Text);
                var groupdId = GetGroupId(txtbGroupId.Text)[0];
                var name = txtbName.Text;
                var price = decimal.Parse(txtbPrice.Text);

                var medicalService = new MedicalService() { medicalServiceId = id, medicalServiceGroupId = groupdId, medicalServiceName = name, price = price };
                _dataContext.MedicalServices.Attach(medicalService);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, medicalService);
                _dataContext.SubmitChanges();
                MedicalServiceList.EditIndex = -1;
                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("groupId: " + groupdId);
                //Debug.WriteLine("Name: " + name);
                //Debug.WriteLine("price: " + price);
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = GridView1.Rows[index].FindControl("Viewid") as Label;
            var intId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.LabOrderDetails
                           where element.medicalServiceId == intId
                           select element;

            if (elements.Count() != 0)
            {
                _dataContext.LabOrderDetails.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void MedicalServiceList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < MedicalServiceList.Rows.Count; i++)
                {
                    MedicalServiceList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    MedicalServiceList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}