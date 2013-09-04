<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewLabOrderDetail.aspx.cs" Inherits="COSC2450_A2_s3357671.viewLabOrderDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="labOrderDetailId" DataSourceID="LinqDataSource1" GridLines="Horizontal">
                <EditItemTemplate>
                    ID:
                    <asp:Label ID="labOrderDetailIdLabel1" runat="server" Text='<%# Eval("labOrderDetailId") %>' />
                    <br />
                    Lab order:
                    <asp:TextBox ID="labOrderIdTextBox" runat="server" Text='<%# Bind("labOrderId") %>' />
                    <br />
                    Medical Service:
                    <asp:TextBox ID="medicalServiceIdTextBox" runat="server" Text='<%# Bind("MedicalService.medicalServiceName") %>' />
                    <br />
                    Result:
                    <asp:TextBox ID="labResultTextBox" runat="server" Text='<%# Bind("labResult") %>' />
                    <br />
                </EditItemTemplate>
                <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <ItemTemplate>
                    ID:
                    <asp:Label ID="labOrderDetailIdLabel" runat="server" Text='<%# Eval("labOrderDetailId") %>' />
                    <br />
                    Lab Order Id:
                    <asp:Label ID="labOrderIdLabel" runat="server" Text='<%# Bind("labOrderId") %>' />
                    <br />
                    Medical Service :
                    <asp:Label ID="medicalServiceIdLabel" runat="server" Text='<%# Bind("MedicalService.medicalServiceName") %>' />
                    <br />
                    Result
                    <asp:Label ID="labResultLabel" runat="server" Text='<%# Bind("labResult") %>' />
                    <br />
                    <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                </ItemTemplate>
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
            </asp:FormView>
            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="LabOrderDetails" Where="labOrderDetailId == @labOrderDetailId">
                <WhereParameters>
                    <asp:QueryStringParameter Name="labOrderDetailId" QueryStringField="ID" Type="Int64" />
                </WhereParameters>
            </asp:LinqDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
