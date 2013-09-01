<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewDrug.aspx.cs" Inherits="COSC2450_A2_s3357671.viewDrug" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/DrugGroup.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="drugGroupDetailTitle" class="bodyTitle">Drug Group Detail</h2>
    <%--Display Drug Group Detail--%>
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
                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="drugId" DataSourceID="LinqDataSource1" GridLines="Horizontal" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated" OnPreRender="FormView1_PreRender">
                    <EditItemTemplate>
                        ID:
                        <asp:Label ID="EditId" runat="server" Text='<%# Eval("drugId") %>' />
                        <br />
                        Group Name:
                        <asp:TextBox ID="EditGroupId" runat="server" Text='<%# Bind("DrugGroup.drugGroupName") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="EditChapterNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditGroupId" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="IcdChapterAutoCompleteExtender" TargetControlID="EditGroupId" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="UpdateServiceExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditGroupId" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        Drug Name:
                        <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("drugName") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Generic Name:
                        <asp:TextBox ID="EditGenName" runat="server" Text='<%# Bind("drugGenericName") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="EditGenNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditGenName" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Unit:
                        <asp:TextBox ID="EditUnit" runat="server" Text='<%# Bind("unit") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="EditUnitRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditUnit" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Price:
                        <asp:TextBox ID="EditPrice" runat="server" Text='<%# Bind("price") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="PriceRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPrice" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="PriceRegularExpressionValidator" ValidationGroup="update" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="EditPrice" ForeColor="Red" ValidationExpression="\d{0,18}\.\d{2}" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:RangeValidator runat="server" ID="PriceRangeValidator" ValidationGroup="update" ErrorMessage="Invalid Range!" ControlToValidate="EditPrice" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000000.00" Type="Currency" Display="Dynamic"></asp:RangeValidator>
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="update" CommandName="Update" Text="Update" OnClick="UpdateButton_Click" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <ItemTemplate>
                        ID:
                        <asp:Label ID="ViewId" runat="server" Text='<%# Eval("drugId") %>' />
                        <br />
                        Group ID:
                        <asp:Label ID="ViewGroupId" runat="server" Text='<%# Bind("DrugGroup.drugGroupName") %>' />
                        <br />
                        Drug Name:
                        <asp:Label ID="ViewName" runat="server" Text='<%# Bind("drugName") %>' />
                        <br />
                        Generic Name:
                        <asp:Label ID="ViewGenName" runat="server" Text='<%# Bind("drugGenericName") %>' />
                        <br />
                        Unit:
                        <asp:Label ID="ViewUnit" runat="server" Text='<%# Bind("unit") %>' />
                        <br />
                        Price:
                        <asp:Label ID="ViewPrice" runat="server" Text='<%# Bind("price") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                        <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                </asp:FormView>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Drugs" Where="drugId == @drugId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="drugId" QueryStringField="ID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
