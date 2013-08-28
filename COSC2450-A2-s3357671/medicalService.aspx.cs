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
                    var msGroupName = GroupNameTextBox.Text;
                    var msPrice = PriceTextBox.Text;

                    var ms = new MedicalService() { medicalServiceName = msName, medicalServiceGroupId = Convert.ToInt64(msGroupName), price = Convert.ToDecimal(msPrice) };
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

        //Assisted By s3357679
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetGroupIdList(string prefixText)
        {
            List<string> result = new List<string>();
            var dataContext = new DBDataContext();
            foreach (MedicalServiceGroup msGroup in dataContext.MedicalServiceGroups)
            {
                if (msGroup.medicalServiceGroupId.ToString().StartsWith(prefixText))
                {
                    result.Add(msGroup.medicalServiceGroupId.ToString());
                }
            }
            return result.ToArray();
        }

        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var longData = Convert.ToInt64(args.Value);
            var idList = from element in _dataContext.MedicalServiceGroups
                         select element.medicalServiceGroupId;
            if (idList.ToList().Contains(longData))
            {
                args.IsValid = true;
                return;
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
    }
}