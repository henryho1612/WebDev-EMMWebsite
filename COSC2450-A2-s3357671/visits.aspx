<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="visits.aspx.cs" Inherits="COSC2450_A2_s3357671.visits" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Prescription Detail</title>

    <link rel="stylesheet" href="/StyleSheet/Visit.css" />
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
            $("#addTitle").click(function () {
                $("#addPanel").slideToggle("slow");
            });
            $("#searchTitle").click(function () {
                $("#searchPanel").slideToggle("slow");
            });
            $("#visitTitle").click(function () {
                $("#listPanel").slideToggle("slow");
            });
            $("#notice").click(function () {
                $("#noticePanel").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

    <%--<h2 id="addTitle" class="bodyTitle">Add A Visit</h2>
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
                            <label id="Label" class="addOption">Hospital Name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="HospitalTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="HospitalTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender1" TargetControlID="HospitalTxt" ServiceMethod="GetHospitalList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator1" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="HospitalTxt" ForeColor="Red" OnServerValidate="HospitalExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label0" class="addOption">Doctor Name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="DoctorTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="DoctorTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender2" TargetControlID="DoctorTxt" ServiceMethod="GetDoctorList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator2" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="DoctorTxt" ForeColor="Red" OnServerValidate="DoctorExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label1" class="addOption">Patient Name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="PatientTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="PatientTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender3" TargetControlID="PatientTxt" ServiceMethod="GetPatientList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator3" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="PatientTxt" ForeColor="Red" OnServerValidate="PatientExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label2" class="addOption">ICD Name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="ICDTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="ICDTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender4" TargetControlID="ICDTxt" ServiceMethod="GetICDList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator4" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="ICDTxt" ForeColor="Red" OnServerValidate="ICDExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label3" class="addOption">Prescription ID: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="PrescriptionTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="PrescriptionTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender5" TargetControlID="PrescriptionTxt" ServiceMethod="GetPrescriptionList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator5" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="PrescriptionTxt" ForeColor="Red" OnServerValidate="PrescriptionExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label4" class="addOption">Lab Order ID: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="LabOrderTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="LabOrderTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender6" TargetControlID="LabOrderTxt" ServiceMethod="GetLabOrderList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator6" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="LabOrderTxt" ForeColor="Red" OnServerValidate="LabOrderExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label5" class="addOption">Visited Date: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="visitedDate" Enabled="false" /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="visitedDate" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                            <asp:RequiredFieldValidator runat="server" ID="DateRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="A date should be chosen!!" ControlToValidate="visitedDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="Label7" class="addOption">Outcome: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="OutcomeTxt" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="OutcomeTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender7" TargetControlID="OutcomeTxt" ServiceMethod="GetOutcomeList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="CustomValidator7" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="OutcomeTxt" ForeColor="Red" OnServerValidate="OutcomeExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddVisitButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddVisitButton_Click" />
                            <asp:Button runat="server" ID="ResetVisitButton" CausesValidation="false" Text="Reset" OnClick="AddVisitButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false" />
    </div>--%>

    <h2 id="searchTitle" class="bodyTitle">Search A Visit</h2>
    <div id="searchPanel">
        <asp:TextBox ID="SearchTextBox" runat="server" Height="16px" Width="50%"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
        <asp:AutoCompleteExtender runat="server" ID="VisitAutoCompleteExtender" TargetControlID="SearchTextBox" ServiceMethod="GetVisit" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
    </div>

    <%--List All Medical Services--%>
    <h2 id="medicalServiceTitle" class="bodyTitle">List of Visit</h2>
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
                <asp:GridView ID="VisitList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="visitId" DataSourceID="VisitLinqDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="visitId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("visitId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("visitId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital" SortExpression="hospitalId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditHospital" runat="server" Text='<%# Bind("Hospital.hospitalName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditHospital" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender8" TargetControlID="EditHospital" ServiceMethod="GetHospitalList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator8" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditHospital" ForeColor="Red" OnServerValidate="HospitalExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewHospital" runat="server" Text='<%# Bind("Hospital.hospitalName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Doctor" SortExpression="doctorId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDoctor" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDoctor" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender9" TargetControlID="EditDoctor" ServiceMethod="GetDoctorList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator9" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDoctor" ForeColor="Red" OnServerValidate="DoctorExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDoctor" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient" SortExpression="patientId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditPatient" runat="server" Text='<%# Bind("Patient.patientName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPatient" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender10" TargetControlID="EditPatient" ServiceMethod="GetPatientList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator10" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditPatient" ForeColor="Red" OnServerValidate="PatientExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewPatient" runat="server" Text='<%# Bind("Patient.patientName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Icd" SortExpression="icdId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditIcd" runat="server" Text='<%# Bind("Icd.icdName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditIcd" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender11" TargetControlID="EditIcd" ServiceMethod="GetICDList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator11" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditIcd" ForeColor="Red" OnServerValidate="ICDExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewIcd" runat="server" Text='<%# Bind("Icd.icdName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Prescription" SortExpression="prescriptionId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditPrescription" runat="server" Text='<%# Bind("prescriptionId") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPrescription" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender12" TargetControlID="EditPrescription" ServiceMethod="GetPrescriptionList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator12" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditPrescription" ForeColor="Red" OnServerValidate="PrescriptionExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewPrescription" runat="server" Text='<%# Bind("prescriptionId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Lab Order" SortExpression="labOrderId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditLabOrder" runat="server" Text='<%# Bind("labOrderId") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator13" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLabOrder" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender13" TargetControlID="EditLabOrder" ServiceMethod="GetLabOrderList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator13" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditLabOrder" ForeColor="Red" OnServerValidate="LabOrderExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewLabOrder" runat="server" Text='<%# Bind("labOrderId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Visited Date" SortExpression="dateVisit">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDate" runat="server" Text='<%# Bind("dateVisit") %>' Enabled="false"></asp:TextBox><asp:ImageButton ID="CalendarButton1" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="EditDate" PopupButtonID="CalendarButton1"></asp:CalendarExtender>
                                <asp:RequiredFieldValidator runat="server" ID="DateRequiredFieldValidator1" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDate" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDate" runat="server" Text='<%# Bind("dateVisit") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Outcome" SortExpression="outcome">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditOutcome" runat="server" Text='<%# Bind("outcome") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditOutcome" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender14" TargetControlID="EditOutcome" ServiceMethod="GetOutcomeList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="CustomValidator14" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditOutcome" ForeColor="Red" OnServerValidate="OutcomeExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewOutcome" runat="server" Text='<%# Bind("outcome") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField ShowHeader="false" ItemStyle-Width="20px">
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" Text="Update" ValidationGroup="update" OnClick="UpdateBtn_Click"></asp:LinkButton>
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
                        </asp:TemplateField>--%>
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
                <asp:LinqDataSource ID="VisitLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Visits" Where="Doctor.doctorName.Contains(@doctorId) or Hospital.hospitalName.Contains(@hospitalId) or Icd.icdName.Contains(@icdId) or outcome.Contains(@outcome) or Patient.patientName.Contains(@patientId)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="doctorId" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="hospitalId" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="icdId" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="outcome" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="patientId" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
