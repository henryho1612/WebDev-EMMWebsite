<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="COSC2450_A2_s3357671.Report" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>EMR - Rports</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%">
        <asp:TabPanel runat="server" HeaderText="TabPanel1" ID="TabPanel1">
            <ContentTemplate>
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="1202px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="1104px" />

                <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
<Report FileName="Report\Report3.rpt"></Report>
</CR:CrystalReportSource>

            
</ContentTemplate>
        
</asp:TabPanel>

        <asp:TabPanel runat="server" HeaderText="TabPanel2" ID="TabPanel2">
            <ContentTemplate>
                <CR:CrystalReportViewer ID="CrystalReportViewer2" runat="server" AutoDataBind="True" ReportSourceID="CrystalReportSource2"
                    ToolPanelView="None" ToolPanelWidth="200px" />
                <CR:CrystalReportSource ID="CrystalReportSource2" runat="server">
                    <Report FileName="Report\Report2.rpt"></Report>
                </CR:CrystalReportSource>
            
</ContentTemplate>
        
</asp:TabPanel>
    </asp:TabContainer>

</asp:Content>
