<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewPrescriptionDetail.aspx.cs" Inherits="COSC2450_A2_s3357671.viewPrescriptionDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="prescriptionDetailId" DataSourceID="LinqDataSource1" GridLines="Horizontal">
                <EditItemTemplate>
                    ID:
                    <asp:Label ID="prescriptionDetailIdLabel1" runat="server" Text='<%# Eval("prescriptionDetailId") %>' />
                    <br />
                    Prescription ID:
                    <asp:TextBox ID="prescriptionIdTextBox" runat="server" Text='<%# Bind("prescriptionId") %>' />
                    <br />
                    Drug Name:
                    <asp:TextBox ID="drugIdTextBox" runat="server" Text='<%# Bind("Drug.drugName") %>' />
                    <br />
                    Quantiy:
                    <asp:TextBox ID="quantityTextBox" runat="server" Text='<%# Bind("quantity") %>' />
                    <br />
                    Dose Per Day:
                    <asp:TextBox ID="dosePerDayTextBox" runat="server" Text='<%# Bind("dosePerDay") %>' />
                    <br />
                    Instruction:
                    <asp:TextBox ID="specialInstructionTextBox" runat="server" Text='<%# Bind("specialInstruction") %>' />
                    <br />
                </EditItemTemplate>
                <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <ItemTemplate>
                    ID:
                    <asp:Label ID="prescriptionDetailIdLabel" runat="server" Text='<%# Eval("prescriptionDetailId") %>' />
                    <br />
                    Prescription ID:
                    <asp:Label ID="prescriptionIdLabel" runat="server" Text='<%# Bind("prescriptionId") %>' />
                    <br />
                    Drug Name:
                    <asp:Label ID="drugIdLabel" runat="server" Text='<%# Bind("Drug.drugName") %>' />
                    <br />
                    Quantity:
                    <asp:Label ID="quantityLabel" runat="server" Text='<%# Bind("quantity") %>' />
                    <br />
                    Dose Per Day:
                    <asp:Label ID="dosePerDayLabel" runat="server" Text='<%# Bind("dosePerDay") %>' />
                    <br />
                    Instruction:
                    <asp:Label ID="specialInstructionLabel" runat="server" Text='<%# Bind("specialInstruction") %>' />
                    <br />
                    <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                </ItemTemplate>
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
            </asp:FormView>
            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="PrescriptionDetails" Where="prescriptionDetailId == @prescriptionDetailId">
                <WhereParameters>
                    <asp:QueryStringParameter Name="prescriptionDetailId" QueryStringField="ID" Type="Int64" />
                </WhereParameters>
            </asp:LinqDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
