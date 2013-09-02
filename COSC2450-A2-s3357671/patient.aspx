<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="patient.aspx.cs" Inherits="COSC2450_A2_s3357671.patient" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Patient</title>

    <link rel="stylesheet" href="/StyleSheet/Patient.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
    <%--Normal Javascript--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#addPanel").hide();
            $("#searchPanel").hide();
            $("#addPatientTitle").click(function () {
                $("#addPanel").slideToggle("slow");
            });
            $("#searchTitle").click(function () {
                $("#searchPanel").slideToggle("slow");
            });
            $("#patientTitle").click(function () {
                $("#listPanel").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

    <h2 id="addPatientTitle" class="bodyTitle">Add A Patient</h2>
    <%--Add Patient Panel--%>
    <div id="addPanel">
        <asp:UpdateProgress ID="updateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
            <ProgressTemplate>
                <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
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
                        <th>
                            <label id="lblName" class="addOption">Patient Name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="NameTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="NameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblGender" class="addOption">Gender: </label>
                        </th>
                        <td>
                            <asp:RadioButtonList ID="GenderRadioButtonList1" runat="server" AutoPostBack="True" DataSourceID="LinqDataSource1" DataTextField="genderName" DataValueField="genderId" OnInit="GenderRadioButtonList_Init"></asp:RadioButtonList>
                            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="Genders"></asp:LinqDataSource>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblDOB" class="addOption">D.O.B: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="DOBTextBox" Enabled="false" /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="DOBTextBox" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                            <asp:RequiredFieldValidator runat="server" ID="DOBRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="A date should be chosen!!" ControlToValidate="DOBTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblAddress" class="addOption">Address: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="AddressTextBox" Enabled="true" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="A date should be chosen!!" ControlToValidate="AddressTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddPatientButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddPatientButton_Click" />
                            <asp:Button runat="server" ID="ResetPatientButton" CausesValidation="false" Text="Reset" OnClick="AddPatientButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false"></asp:Label>
    </div>

    <h2 id="searchTitle" class="bodyTitle">Search A Patient</h2>
    <%--Search Patients Panel--%>
    <div id="searchPanel">
        <div id="searchBox">
            <asp:TextBox ID="SearchTextBox" runat="server" Height="16px" Width="580px"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
            <asp:AutoCompleteExtender runat="server" ID="PatientAutoCompleteExtender" TargetControlID="SearchTextBox" ServiceMethod="GetPatients" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
        </div>
    </div>

    <%--List All Drugs--%>
    <h2 id="patientTitle" class="bodyTitle">List of Patients</h2>
    <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
                <img src="Images/loader.gif" alt="Loading" />
                <br />
                <h1>-----Loading----</h1>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="listPanel">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="PatientsList" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="patientId" DataSourceID="PatientsLinqDataSource" ForeColor="#333333" GridLines="None" OnRowDeleting="GridView_RowDeleting" OnPreRender="PatientsList_PreRender" AllowPaging="True" AllowSorting="True">
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="patientId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("patientId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("patientId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="patientName">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("patientName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewName" runat="server" Text='<%# Bind("patientName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gender" SortExpression="genderId">
                            <EditItemTemplate>
                                <asp:Label ID="EditGender" runat="server" Text='<%# Eval("Gender.genderName") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewGender" runat="server" Text='<%# Bind("Gender.genderName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="D.O.B" SortExpression="dob">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="EditDOBTextBox" Enabled="false" Text='<%# Bind("dob") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="EditDOBTextBox" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                                <asp:RequiredFieldValidator runat="server" ID="DOBRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDOBTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDOB" runat="server" Text='<%# Bind("dob") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" SortExpression="address">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditAddress" runat="server" Text='<%# Bind("address") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewAddress" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="false" ItemStyle-Width="20px">
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" Text="Update" ValidationGroup="update" OnClick="UpdateButton_Click"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="false" ItemStyle-Width="20px">
                            <EditItemTemplate>
                                <asp:LinkButton ID="CancelBtn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="ViewBtn" runat="server" NavigateUrl='<%# Eval("patientId", "viewPatient.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
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
                <asp:LinqDataSource ID="PatientsLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Patients" Where="address.Contains(@address) or patientName.Contains(@patientName) or Gender.genderName.Contains(@genderName)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="address" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="patientName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="genderName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

