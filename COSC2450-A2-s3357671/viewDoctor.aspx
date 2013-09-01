<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewDoctor.aspx.cs" Inherits="COSC2450_A2_s3357671.viewDoctor" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/Doctor.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="doctorDetailTitle" class="bodyTitle">Doctor Detail</h2>
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
                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" DataKeyNames="doctorId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated" OnPreRender="FormView1_PreRender">
                    <EditItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("doctorId") %>' runat="server" ID="EditId" /><br />
                        Name:
                        <asp:TextBox Text='<%# Bind("doctorName") %>' runat="server" ID="EditName" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                        Gender:
                        <asp:Label Text='<%# Eval("Gender.genderName") %>' runat="server" ID="EditGender" /><br />
                        D.O.B:
                        <asp:TextBox runat="server" ID="EditDOB" Enabled="false" Text='<%# Bind("dob") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="EditDOB" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                        <asp:RequiredFieldValidator runat="server" ID="DOBRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDOB" ForeColor="Red"></asp:RequiredFieldValidator>
                        Address:
                        <asp:TextBox Text='<%# Bind("address") %>' runat="server" ID="EditAddress" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                        License:
                        <asp:TextBox Text='<%# Bind("license") %>' runat="server" ID="EditLicense" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="LicenseRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLicense" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="update" CommandName="Update" Text="Update" OnClick="UpdateButton_Click" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White"></EditRowStyle>
                    <FooterStyle BackColor="White" ForeColor="#333333"></FooterStyle>
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <ItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("doctorId") %>' runat="server" ID="ViewId" /><br />
                        Name:
                        <asp:Label Text='<%# Bind("doctorName") %>' runat="server" ID="ViewName" /><br />
                        Gender:
                        <asp:Label Text='<%# Eval("Gender.genderName") %>' runat="server" ID="ViewGender" /><br />
                        D.O.B:
                        <asp:Label Text='<%# Bind("dob") %>' runat="server" ID="ViewDOB" /><br />
                        Address:
                        <asp:Label Text='<%# Bind("address") %>' runat="server" ID="ViewAddress" /><br />
                        License:
                        <asp:Label Text='<%# Bind("license") %>' runat="server" ID="ViewLicense" /><br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                        <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                    </ItemTemplate>

                    <PagerStyle HorizontalAlign="Center" BackColor="#336666" ForeColor="White"></PagerStyle>

                    <RowStyle BackColor="White" ForeColor="#333333"></RowStyle>
                </asp:FormView>
                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="Doctors" Where="doctorId == @doctorId">
                    <WhereParameters>
                        <asp:QueryStringParameter QueryStringField="ID" Name="doctorId" Type="Int64"></asp:QueryStringParameter>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
