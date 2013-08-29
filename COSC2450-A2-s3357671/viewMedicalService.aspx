<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewMedicalService.aspx.cs" Inherits="COSC2450_A2_s3357671.viewMedicalService" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/MedicalService.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="MedicalServiceDetailTitle" class="bodyTitle">Service Detail</h2>
    <%--Display Hospital Detail--%>
    <div id="displayPanel">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div style="width: 100%; height: 20%; background-color: lightgrey; text-align: center;">
                    <img src="Images/loader.gif" alt="Loading" />
                    <br />
                    <h1>-----Loading----</h1>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="medicalServiceId" DataSourceID="LinqDataSource1" GridLines="Horizontal">
                    <EditItemTemplate>
                        medicalServiceId:
                        <asp:Label ID="medicalServiceIdLabel1" runat="server" Text='<%# Eval("medicalServiceId") %>' />
                        <br />
                        medicalServiceGroupId:
                        <asp:TextBox ID="medicalServiceGroupIdTextBox" runat="server" Text='<%# Bind("medicalServiceGroupId") %>' />
                        <br />
                        medicalServiceName:
                        <asp:TextBox ID="medicalServiceNameTextBox" runat="server" Text='<%# Bind("medicalServiceName") %>' />
                        <br />
                        price:
                        <asp:TextBox ID="priceTextBox" runat="server" Text='<%# Bind("price") %>' />
                        <br />
                        LabOrderDetails:
                        <asp:TextBox ID="LabOrderDetailsTextBox" runat="server" Text='<%# Bind("LabOrderDetails") %>' />
                        <br />
                        MedicalServiceGroup:
                        <asp:TextBox ID="MedicalServiceGroupTextBox" runat="server" Text='<%# Bind("MedicalServiceGroup") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <InsertItemTemplate>
                        medicalServiceGroupId:
                        <asp:TextBox ID="medicalServiceGroupIdTextBox" runat="server" Text='<%# Bind("medicalServiceGroupId") %>' />
                        <br />
                        medicalServiceName:
                        <asp:TextBox ID="medicalServiceNameTextBox" runat="server" Text='<%# Bind("medicalServiceName") %>' />
                        <br />
                        price:
                        <asp:TextBox ID="priceTextBox" runat="server" Text='<%# Bind("price") %>' />
                        <br />
                        LabOrderDetails:
                        <asp:TextBox ID="LabOrderDetailsTextBox" runat="server" Text='<%# Bind("LabOrderDetails") %>' />
                        <br />
                        MedicalServiceGroup:
                        <asp:TextBox ID="MedicalServiceGroupTextBox" runat="server" Text='<%# Bind("MedicalServiceGroup") %>' />
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        medicalServiceId:
                        <asp:Label ID="medicalServiceIdLabel" runat="server" Text='<%# Eval("medicalServiceId") %>' />
                        <br />
                        medicalServiceGroupId:
                        <asp:Label ID="medicalServiceGroupIdLabel" runat="server" Text='<%# Bind("medicalServiceGroupId") %>' />
                        <br />
                        medicalServiceName:
                        <asp:Label ID="medicalServiceNameLabel" runat="server" Text='<%# Bind("medicalServiceName") %>' />
                        <br />
                        price:
                        <asp:Label ID="priceLabel" runat="server" Text='<%# Bind("price") %>' />
                        <br />
                        LabOrderDetails:
                        <asp:Label ID="LabOrderDetailsLabel" runat="server" Text='<%# Bind("LabOrderDetails") %>' />
                        <br />
                        MedicalServiceGroup:
                        <asp:Label ID="MedicalServiceGroupLabel" runat="server" Text='<%# Bind("MedicalServiceGroup") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                </asp:FormView>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="MedicalServices" Where="medicalServiceId == @medicalServiceId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="medicalServiceId" QueryStringField="ID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
