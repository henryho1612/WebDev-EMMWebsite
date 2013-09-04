using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COSC2450_A2_s3357671
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void setDBLOGONforREPORT(ConnectionInfo myconnectioninfo)
        {
            //TableLogOnInfos mytableloginfos = new TableLogOnInfos();
            //mytableloginfos = CrystalReportViewer1.LogOnInfo;
            //foreach (TableLogOnInfo myTableLogOnInfo in mytableloginfos)
            //{
            //    myTableLogOnInfo.ConnectionInfo = myconnectioninfo;
            //}
        }
    }
}