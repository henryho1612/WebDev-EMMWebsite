using System;
using System.Collections.Generic;
using System.Linq;
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

            if (btnId.Equals("AddHospitalButton")) {
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
    }
}