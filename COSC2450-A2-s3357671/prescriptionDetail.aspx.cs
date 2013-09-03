using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class prescriptionDetail : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        //Validate input service group name
        //Add Option - Validate existence of a drug
        protected void ExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var drugs = from element in _dataContext.Drugs
                        select element.drugName.ToString().ToLower();
            foreach (var drug in drugs.ToArray())
            {
                if (drug.ToString().ToLower().Equals(inputValue.ToLower()))
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetDrugList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.Drugs
                         where element.drugName.ToString().ToLower().StartsWith(prefixText)
                         select element.drugName.ToString();
            return result.ToArray();
        }

        //Submit Add Form
        protected void AddPrescriptionDetailButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddPrescriptionDetailButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var presId = long.Parse(PresIdDropDown.SelectedItem.Text);
                    var drug = GetDrugID(DrugTextBox.Text)[0];
                    //Rememeber
                    var quantity = Convert.ToInt32(QuantityTextBox.Text);
                    var dose = Convert.ToInt32(DPDTextBox.Text);
                    var instruction = InstructionTextBox.Text;

                    var prescriptionDetail = new PrescriptionDetail() { prescriptionId = presId, drugId = drug, quantity = quantity, dosePerDay = dose, specialInstruction = instruction };
                    _dataContext.PrescriptionDetails.InsertOnSubmit(prescriptionDetail);
                    _dataContext.SubmitChanges();
                    PrescriptionDetailList.DataBind();

                    //Use for testing
                    //Debug.WriteLine("presID: " + presId);
                    //Debug.WriteLine("presID: " + drug);
                    //Debug.WriteLine("presID: " + quantity);
                    //Debug.WriteLine("presID: " + dose);
                    //Debug.WriteLine("presID: " + instruction);

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetPrescriptionDetailButton"))
            {
                ResetInputField();
            }
        }

        //Reset all textBox field
        protected void ResetInputField()
        {
            PresIdDropDown.SelectedIndex = -1;
            DrugTextBox.Text = "";
            QuantityTextBox.Text = "";
            DPDTextBox.Text = "";
            InstructionTextBox.Text = "";
        }

        protected long[] GetDrugID(string drugName)
        {
            var groupId = from element in _dataContext.Drugs
                          where element.drugName.ToString().ToLower() == drugName.ToString().ToLower()
                          select element.drugId;
            return groupId.ToArray();
        }

        //For Search
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetPrescriptionDetails(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = (from element in dataContext.PrescriptionDetails
                          where element.prescriptionId.ToString().ToLower().StartsWith(prefixText)
                          select element.prescriptionId.ToString())
                          .Union(from element in dataContext.PrescriptionDetails
                                 where element.Drug.drugName.ToString().ToLower().StartsWith(prefixText)
                                 select element.Drug.drugName.ToString())
                                  .Union(from element in dataContext.PrescriptionDetails
                                         where element.specialInstruction.ToString().ToLower().StartsWith(prefixText)
                                         select element.specialInstruction.ToString());

            return result.ToArray();
        }

        //Control Role
        protected void PrescriptionDetailList_PreRender(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Users"))
            {
                for (var i = 0; i < PrescriptionList.Rows.Count; i++)
                {
                    PrescriptionDetailList.Rows[i].FindControl("DeleteBtn").Visible = false;
                    PrescriptionDetailList.Rows[i].FindControl("EditBtn").Visible = false;
                }
                UpdatePanel2.Visible = false;
                LblNotice.Visible = true;
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                System.Threading.Thread.Sleep(3000);
                var editedRowIndex = PrescriptionDetailList.EditIndex;
                var lblId = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditId") as Label;
                var txtbPID = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditPID") as TextBox;
                var txtbDName = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditDName") as TextBox;
                var txtbQuantity = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditQuantity") as TextBox;
                var txtbDPD = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditDPD") as TextBox;
                var txtDescription = PrescriptionDetailList.Rows[editedRowIndex].FindControl("EditInstruction") as TextBox;

                var id = long.Parse(lblId.Text);
                var pid = long.Parse(txtbPID.Text);
                var drug = GetDrugID(txtbDName.Text)[0];
                var quantity = Convert.ToInt32(txtbQuantity.Text);
                var dpd = Convert.ToInt32(txtbDPD.Text);
                var instruction = txtDescription.Text;

                var prescriptionDetails = new PrescriptionDetail() {prescriptionDetailId = id, prescriptionId = pid, drugId = drug, quantity = quantity, dosePerDay = dpd, specialInstruction = instruction };
                _dataContext.PrescriptionDetails.Attach(prescriptionDetails);
                _dataContext.Refresh(RefreshMode.KeepCurrentValues, prescriptionDetails);
                _dataContext.SubmitChanges();
                PrescriptionDetailList.EditIndex = -1;

                //Use For Debug passed value
                //Debug.WriteLine("id: " + id);
                //Debug.WriteLine("DName: " + doctorId);
                //Debug.WriteLine("Date: " + date);
            }
        }

        protected void InsertExistenceCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var inputValue = args.Value.ToString();
            var pids = from element in _dataContext.Prescriptions
                       select element.prescriptionId;

            foreach (var pid in pids.ToArray())
            {
                if (pid.ToString().ToLower().Equals(inputValue.ToString().ToLower())) 
                {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        //Assisted By s3357678
        //Add Option - Auto Complete
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static string[] GetPrescriptionList(string prefixText)
        {
            var dataContext = new DBDataContext();
            var result = from element in dataContext.Prescriptions
                         where element.prescriptionId.ToString().StartsWith(prefixText)
                         select element.prescriptionId.ToString();
            return result.ToArray();
        }

    }
}