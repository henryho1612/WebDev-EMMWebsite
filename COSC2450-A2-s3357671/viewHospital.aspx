﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewHospital.aspx.cs" Inherits="COSC2450_A2_s3357671.viewHospital" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/Hospital.css" />
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
                <asp:FormView ID="HospitalFormView" runat="server" DataKeyNames="hospitalId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnItemUpdated="HospitalFormView_ItemUpdated" Height="146px" Width="303px" OnPreRender="HospitalFormView_PreRender">
                    <EditItemTemplate>
                        <span class="formView">ID:</span>
                        <asp:Label ID="EditId" runat="server" Text='<%# Eval("hospitalId") %>' />
                        <br />
                        <span class="formView">Hospital Name:</span>
                        <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("hospitalName") %>' Height="16px" Width="119px" />
                        <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <span class="formView">Address:</span>
                        <asp:TextBox ID="EditAddress" runat="server" Text='<%# Bind("address") %>' Height="16px" Style="margin-bottom: 0px" Width="120px" />
                        <asp:RequiredFieldValidator runat="server" ID="EditAddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <span class="formView">License:</span><asp:TextBox ID="EditLicense" runat="server" Text='<%# Bind("license") %>' Height="16px" Width="120px" />
                        <asp:RequiredFieldValidator runat="server" ID="EditRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLicense" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="update" OnClick="Button_Click" />
                        <asp:LinkButton ID="CancelBtn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <ItemTemplate>
                        <span class="formView">Id:</span>
                        <asp:Label ID="ViewId" runat="server" Text='<%# Eval("hospitalId") %>' />
                        <br />
                        <span class="formView">Hospital Name:</span>
                        <asp:Label ID="ViewName" runat="server" Text='<%# Bind("hospitalName") %>' />
                        <br />
                        <span class="formView">Address:</span>
                        <asp:Label ID="ViewAddress" runat="server" Text='<%# Bind("address") %>' />
                        <br />
                        <span class="formView">License:</span>
                        <asp:Label ID="ViewLicense" runat="server" Text='<%# Bind("license") %>' />
                        <br />
                        <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteBtn" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');" />
                        <asp:LinkButton ID="BackBtn" runat="server" CausesValidation="false" Text="Back" OnClick="BackBtn_Click" />
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                </asp:FormView>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="Hospitals" Where="hospitalId == @hospitalId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="hospitalId" QueryStringField="Id" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
