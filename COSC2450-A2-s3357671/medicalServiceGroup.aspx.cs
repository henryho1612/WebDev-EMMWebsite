using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class medicalServiceGroup : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddMSGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddMSGroupButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var mSGroupName = NameTextBox.Text;

                    var mSGroup = new MedicalServiceGroup() { medicalServiceGroupName = mSGroupName };
                    _dataContext.MedicalServiceGroups.InsertOnSubmit(mSGroup);
                    _dataContext.SubmitChanges();
                    MSGroupList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetMSGroupButton"))
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
        public static string[] GetMedicalServiceGroup(string prefixText)
        {
            var dataContext = new DBDataContext();

            var result = (from n in dataContext.MedicalServiceGroups
                          where n.medicalServiceGroupName.ToString().ToLower().StartsWith(prefixText.ToLower())
                          select n.medicalServiceGroupName.ToString());
            return result.ToArray();
        }
    }
}