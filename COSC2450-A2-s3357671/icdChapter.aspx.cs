using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class icdChapter : System.Web.UI.Page
    {

        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
        }

        protected void AddICDChapterGroupButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            String btnId = btn.ID;

            if (btnId.Equals("AddICDChapterButton"))
            {
                if (IsValid)
                {
                    System.Threading.Thread.Sleep(3000);
                    var icdChapterName = NameTextBox.Text;

                    var icdChapter = new IcdChapter() { icdChapterName = icdChapterName };
                    _dataContext.IcdChapters.InsertOnSubmit(icdChapter);
                    _dataContext.SubmitChanges();
                    IcdChapterList.DataBind();

                    ResetInputField();
                }
            }
            else if (btnId.Equals("ResetICDChapterGroupButton"))
            {
                ResetInputField();
            }
        }

        protected void ResetInputField()
        {
            NameTextBox.Text = "";
        }
    }
}