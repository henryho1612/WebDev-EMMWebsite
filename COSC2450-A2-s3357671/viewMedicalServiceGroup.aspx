<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewMedicalServiceGroup.aspx.cs" Inherits="COSC2450_A2_s3357671.viewMedicalServiceGroup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/MedicalServiceGroup.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="hospitalDetailTitle" class="bodyTitle">Hospital Detail</h2>
    <%--Display Hospital Detail--%>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div id="displayPanel">
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
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="medicalServiceGroupId" DataSourceID="LinqDataSource1">
                    <EditItemTemplate>
                        medicalServiceGroupId:
                        <asp:Label ID="medicalServiceGroupIdLabel1" runat="server" Text='<%# Eval("medicalServiceGroupId") %>' />
                        <br />
                        medicalServiceGroupName:
                        <asp:TextBox ID="medicalServiceGroupNameTextBox" runat="server" Text='<%# Bind("medicalServiceGroupName") %>' />
                        <br />
                        MedicalServices:
                        <asp:TextBox ID="MedicalServicesTextBox" runat="server" Text='<%# Bind("MedicalServices") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        medicalServiceGroupName:
                        <asp:TextBox ID="medicalServiceGroupNameTextBox" runat="server" Text='<%# Bind("medicalServiceGroupName") %>' />
                        <br />
                        MedicalServices:
                        <asp:TextBox ID="MedicalServicesTextBox" runat="server" Text='<%# Bind("MedicalServices") %>' />
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        medicalServiceGroupId:
                        <asp:Label ID="medicalServiceGroupIdLabel" runat="server" Text='<%# Eval("medicalServiceGroupId") %>' />
                        <br />
                        medicalServiceGroupName:
                        <asp:Label ID="medicalServiceGroupNameLabel" runat="server" Text='<%# Bind("medicalServiceGroupName") %>' />
                        <br />
                        MedicalServices:
                        <asp:Label ID="MedicalServicesLabel" runat="server" Text='<%# Bind("MedicalServices") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                    </ItemTemplate>
                </asp:FormView>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="MedicalServiceGroups" Where="medicalServiceGroupId == @medicalServiceGroupId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="medicalServiceGroupId" QueryStringField="ID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
