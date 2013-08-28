﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="medicalService.aspx.cs" Inherits="COSC2450_A2_s3357671.medicalService" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Medical Service</title>

    <link rel="stylesheet" href="/StyleSheet/MedicalService.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e) {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
    <%--Normal Javascript--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#addPanel").hide();
            $("#searchPanel").hide();
            $("#msgListPanel").hide();

            $("#addTitle").click(function () {
                $("#addPanel").slideToggle("slow");
            });
            $("#searchTitle").click(function () {
                $("#searchPanel").slideToggle("slow");
            });
            $("#medicalServiceGroupTitle").click(function () {
                $("#msgListPanel").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    
    <h2 id="addTitle" class="bodyTitle">Add A Medical Service</h2>
    <%--Add Medical Service Panel--%>
    <div id="addPanel">
        <asp:UpdateProgress ID="updateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
            <ProgressTemplate>
                <div style="width:100%; height: 100%; background-color:lightgrey; text-align:center;">
                    <img src="Images/loader.gif" alt="Loading" />
                    <br />
                    <h1>-----Loading----</h1>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table>
                    <tr class="addOptionLabel">
                        <th><label id="lblName" class="addOption">Medical Service Name: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="NameTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="NameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th><label id="lblGroupId" class="addOption">Medical Service Group Id: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="GroupNameTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="GroupNameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="GroupNameAutoCompleteExtender" TargetControlID="GroupNameTextBox" ServiceMethod="GetGroupIdList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching ="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:RegularExpressionValidator runat="server" ID="GroupIdRegularExpressionValidator" ValidationGroup="insert" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="GroupNameTextBox" ForeColor="Red" ValidationExpression="\d{1,19}" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="GroupNameTextBox" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th><label id="lblPrice" class="addOption">Service Price: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="PriceTextBox" ToolTip="0.00 -> 1000000.00"/><span class="requiredField" >*</span>
                            <asp:RequiredFieldValidator runat="server" ID="PriceRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="PriceTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="PriceRegularExpressionValidator" ValidationGroup="insert" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="PriceTextBox" ForeColor="Red" ValidationExpression="\d{0,18}\.\d{2}" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:RangeValidator runat="server" ID="PriceRangeValidator" ValidationGroup="insert" ErrorMessage="Invalid Range!" ControlToValidate="PriceTextBox" ForeColor="Red" MinimumValue="0" MaximumValue="1000000" Type="Double" Display="Dynamic"></asp:RangeValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddMSButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddMSButton_Click"/>
                            <asp:Button runat="server" ID="ResetMSButton" CausesValidation="false" Text="Reset" OnClick="AddMSButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <h2 id="searchTitle" class="bodyTitle">Search A Medical Service</h2>
    <%--Search Medical Service Panel--%>
    <div id="searchPanel">
        Chua Lam
    </div>

    <h2 id="medicalServiceGroupTitle" class="bodyTitle">List of Medical Services Groups</h2>
    <div id="msgListPanel">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:GridView ID="MedicalServiceGroupList" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="medicalServiceGroupId" DataSourceID="MSGDataSource1" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="medicalServiceGroupId" HeaderText="Group Id" InsertVisible="False" ReadOnly="True" SortExpression="medicalServiceGroupId" />
                        <asp:BoundField DataField="medicalServiceGroupName" HeaderText="Group Name" SortExpression="medicalServiceGroupName" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                
                <asp:LinqDataSource ID="MSGDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="MedicalServiceGroups">
                </asp:LinqDataSource>
                
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--List All Medical Services--%>
    <h2 id="medicalServiceTitle" class="bodyTitle">List of Medical Services</h2>
    <%--List All Medical Services--%>
    <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div style="width:100%; height: 100%; background-color:lightgrey; text-align:center;">
                    <img src="Images/loader.gif" alt="Loading" />
                    <br />
                    <h1>-----Loading----</h1>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    <div id="listPanel">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="MedicalServiceList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="medicalServiceId" DataSourceID="MedicalServiceDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="medicalServiceId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("medicalServiceId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("medicalServiceId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Group Id" SortExpression="medicalServiceGroupId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditGroupId" runat="server" Text='<%# Bind("medicalServiceGroupId") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="GroupIdRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty" ControlToValidate="EditGroupId" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="GroupIdRegularExpressionValidator" ValidationGroup="update" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="EditGroupId" ForeColor="Red" ValidationExpression="\d{1,19}" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:CustomValidator runat="server" ID="UpdateExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditGroupId" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewGroupId" runat="server" Text='<%# Bind("medicalServiceGroupId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medical Service Name" SortExpression="medicalServiceName">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("medicalServiceName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewName" runat="server" Text='<%# Bind("medicalServiceName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price" SortExpression="price">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditPrice" runat="server" Text='<%# Bind("price") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="PriceRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPrice" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="PriceRegularExpressionValidator" ValidationGroup="update" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="EditPrice" ForeColor="Red" ValidationExpression="\d{0,18}\.\d{2}" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RangeValidator runat="server" ID="PriceRangeValidator" ValidationGroup="update" ErrorMessage="Invalid Range!" ControlToValidate="EditPrice" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000000.00" Display="Dynamic"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewPrice" runat="server" Text='<%# Bind("price") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="update" OnClick="Button_Click" OnClientClick="return confirm('Are all information correct?');"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="CancelBtn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="DeleteBtn" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:LinqDataSource ID="MedicalServiceDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="MedicalServices">
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
