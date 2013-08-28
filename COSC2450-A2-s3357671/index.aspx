<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="COSC2450_A2_s3357671.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Hospital</title>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#statsTable").hide();
            $("#statisticTitle").hover(function () {
                $("#statsTable").show("slow");
            }, function () {
                $("#statsTable").hide("slow");
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="aboutUsTitle" class="bodyTitle">About Us</h2>
    <p>Write later</p>

    <h2 id="statisticTitle" class="bodyTitle">Statistic</h2>
    <table id="statsTable">
        <tr>
            <th class="firstStatsTableRow">Categories</th>
            <th class="firstStatsTableRow">Data</th>
        </tr>
        <tr>
            <td><label id="lblUser">Total number of users</label></td>
            <td><asp:Label runat="server" ID="LblUserData" /></td>
        </tr>
        <tr>
            <td><label id="lblHospital">Total number of hospitals</label></td>
            <td><asp:Label runat="server" ID="LblHospitalData" /></td>
        </tr>
        <tr>
            <td><label id="lblDoctor">Total number of doctors</label></td>
            <td><asp:Label runat="server" ID="LblDoctorData" /></td>
        </tr>
        <tr>
            <td><label id="lblPatient">Total number of patients</label></td>
            <td><asp:Label runat="server" ID="LblPatientData" /></td>
        </tr>
        <tr>
            <td><label id="lblVisit">Total number of visits</label></td>
            <td><asp:Label runat="server" ID="LblVisitData" /></td>
        </tr>
        <tr>
            <td><label id="lblIcd">Total number of icd</label></td>
            <td><asp:Label runat="server" ID="LblIcdData" /></td>
        </tr>
        <tr>
            <td><label id="lblPrescription">Total number of prescription</label></td>
            <td><asp:Label runat="server" ID="LblPrescriptionData" /></td>
        </tr>
        <tr>
            <td><label id="lblLabOrder">Total number of lab orders</label></td>
            <td><asp:Label runat="server" ID="LblLabOrderData" /></td>
        </tr>
        <tr>
            <td><label id="lblDrug">Total number of drugs</label></td>
            <td><asp:Label runat="server" ID="LblDrugData" /></td>
        </tr>
        <tr>
            <td><label id="lblMedicalService">Total number of medical services</label></td>
            <td><asp:Label runat="server" ID="LblMedicalServiceData" /></td>
        </tr>
        <tr>
            <th><label id="lblTotal">Total</label></th>
            <th><asp:Label runat="server" ID="LblTotalNumber" style="font-size:larger; color:red;"/></th>
        </tr>
    </table>
</asp:Content>
