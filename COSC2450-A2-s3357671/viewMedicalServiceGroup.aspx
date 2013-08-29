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
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="medicalServiceGroupId" DataSourceID="LinqDataSource1" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated">
                    <EditItemTemplate>
                        ID:
                        <asp:Label ID="EditId" runat="server" Text='<%# Eval("medicalServiceGroupId") %>' />
                        <br />
                        Group Name:
                        <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("medicalServiceGroupName") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="update" OnClick="Button_Click" />
                        <asp:LinkButton ID="CancelBtn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                  <ItemTemplate>
                        ID:
                        <asp:Label ID="ViewId" runat="server" Text='<%# Eval("medicalServiceGroupId") %>' />
                        <br />
                        Group Name:
                        <asp:Label ID="ViewName" runat="server" Text='<%# Bind("medicalServiceGroupName") %>' />
                        <br />
                        <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteBtn" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');" />
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
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
