using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class viewHospital : System.Web.UI.Page
    {
        private DBDataContext _dataContext;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataContext = new DBDataContext();
            RetrieveHospitalDetail();
        }

        protected void RetrieveHospitalDetail()
        {
            var id = long.Parse(Request.QueryString["Id"]);
            var detailInfo = from element in _dataContext.Hospitals
                             where element.hospitalId == id
                             select element;

        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {

        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {

        }
    }
}