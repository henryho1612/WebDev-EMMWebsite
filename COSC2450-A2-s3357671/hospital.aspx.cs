using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class hospital : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddHospitalButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddHospitalButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var hospitalName = NameTextBox.Text;
                    var hospitalAddress = AddressTextBox.Text;
                    var hospitalLicense = LicenseTextBox.Text;

                    var hospital = new Hospital() { hospitalName = hospitalName, address = hospitalAddress, license = hospitalLicense };
                    _dataContext.Hospitals.InsertOnSubmit(hospital);
                    _dataContext.SubmitChanges();
                    HospitalList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetHospitalButton"))
            {
                ResetInputField();
            }
        }

        protected void ResetInputField()
        {
            NameTextBox.Text = "";
            AddressTextBox.Text = "";
            LicenseTextBox.Text = "";
        }

        //Assisted By s3357678
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetHospital(string prefixText)
        {
            var dataContext = new DBDataContext();

            var result = (from n in dataContext.Hospitals
                          where n.hospitalName.ToString().ToLower().StartsWith(prefixText.ToLower())
                          select n.hospitalName.ToString())
                                 .Union(from n in dataContext.Hospitals
                                        where n.license.ToString().ToLower().StartsWith(prefixText.ToLower())
                                        select n.license.ToString())
                                        .Union(from n in dataContext.Hospitals
                                               where n.address.ToString().ToLower().StartsWith(prefixText.ToLower())
                                               select n.address.ToString());
            return result.ToArray();
        }

        protected void HospitalList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = e.RowIndex;
            Label lblId = HospitalList.Rows[index].FindControl("ViewId") as Label;
            var intId = long.Parse(lblId.Text);
            var elements = from element in _dataContext.Visits
                           where element.hospitalId == intId
                           select element;

            if (elements.Count() != 0)
            {
                _dataContext.Visits.DeleteAllOnSubmit(elements);
                _dataContext.SubmitChanges();
                return;
            }
        }

        protected void HospitalList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < HospitalList.Rows.Count; i++)
                {
                    HospitalList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    HospitalList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }
    }
}