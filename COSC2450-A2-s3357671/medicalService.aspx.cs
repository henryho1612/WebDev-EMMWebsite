using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

            }
        }
    }
}