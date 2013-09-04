<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewPatient.aspx.cs" Inherits="COSC2450_A2_s3357671.viewPatient" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
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
            $("#addVisitBtn").click(function () {
                $("#addPanel").show("slow");
            });
            $("#cancelBtn").click(function () {
                $("#addPanel").hide("slow");
            });
            //$("#searchTitle").click(function () {
            //    $("#searchPanel").slideToggle("slow");
            //});
            //$("#visitTitle").click(function () {
            //    $("#listPanel").slideToggle("slow");
            //});
            //$("#notice").click(function () {
            //    $("#noticePanel").slideToggle("slow");
            //});
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="patientDetailTitle" class="bodyTitle">Patient Detail</h2>
    <%--Display Patient Detail--%>
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
                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" DataKeyNames="patientId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated" OnPreRender="FormView1_PreRender">
                    <EditItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("patientId") %>' runat="server" ID="EditId" /><br />
                        Name:
                        <asp:TextBox Text='<%# Bind("patientName") %>' runat="server" ID="EditName" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Gender:
                        <asp:Label Text='<%# Eval("Gender.genderName") %>' runat="server" ID="EditGender" /><br />
                        D.O.B:
                        <asp:TextBox runat="server" ID="EditDOB" Enabled="false" Text='<%# Bind("dob") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="EditDOB" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                        <asp:RequiredFieldValidator runat="server" ID="DOBRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDOB" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Address:
                        <asp:TextBox Text='<%# Bind("address") %>' runat="server" ID="EditAddress" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="update" CommandName="Update" Text="Update" OnClick="UpdateButton_Click" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White"></EditRowStyle>
                    <FooterStyle BackColor="White" ForeColor="#333333"></FooterStyle>
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <ItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("patientId") %>' runat="server" ID="ViewId" /><br />
                        Name:
                        <asp:Label Text='<%# Bind("patientName") %>' runat="server" ID="ViewName" /><br />
                        Gender:
                        <asp:Label Text='<%# Eval("Gender.genderName") %>' runat="server" ID="ViewGender" /><br />
                        D.O.B:
                        <asp:Label Text='<%# Bind("dob") %>' runat="server" ID="ViewDOB" /><br />
                        Address:
                        <asp:Label Text='<%# Bind("address") %>' runat="server" ID="ViewAddress" /><br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                        <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                        <a href="#">
                            <label id="addVisitBtn">Add Visit</label></a>
                    </ItemTemplate>
                    <PagerStyle HorizontalAlign="Center" BackColor="#336666" ForeColor="White"></PagerStyle>
                    <RowStyle BackColor="White" ForeColor="#333333"></RowStyle>
                </asp:FormView>
                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="Patients" Where="patientId == @patientId">
                    <WhereParameters>
                        <asp:QueryStringParameter QueryStringField="ID" Name="patientId" Type="Int64"></asp:QueryStringParameter>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <h2 id="addTitle" class="bodyTitle">Add A Visit</h2>
    <div id="addPanel">
        <asp:UpdateProgress ID="updateProgress4" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
            <ProgressTemplate>
                <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
                    <img src="Images/loader.gif" alt="Loading" />
                    <br />
                    <h1>-----Loading----</h1>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
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
                            <asp:TextBox runat="server" ID="PatientTxt" Enabled="false" OnLoad="PatientTxt_Load" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="PatientTxt" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender3" TargetControlID="PatientTxt" ServiceMethod="GetPatientList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true" UseContextKey="True"></asp:AutoCompleteExtender>
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
                    <%--<tr class="addOptionLabel">
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
                    </tr>--%>
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
                            <a href="#">
                                <label id="cancelBtn">Cancel</label></a>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false" />
    </div>

    <h2 id="visitTitle" class="bodyTitle">List of Visit</h2>
    <asp:UpdateProgress ID="updateProgress5" runat="server" AssociatedUpdatePanelID="UpdatePanel5">
        <ProgressTemplate>
            <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
                <img src="Images/loader.gif" alt="Loading" />
                <br />
                <h1>-----Loading----</h1>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="listPanel">
        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>
                <asp:GridView ID="VisitList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="visitId" DataSourceID="VisitLinqDataSource" ForeColor="#333333" GridLines="None" OnPreRender="VisitList_PreRender" CssClass="listGridView">
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
                                <asp:TextBox ID="EditPrescription" runat="server" Text='<%# Eval("prescriptionId") %>'></asp:TextBox>
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
                                <asp:TextBox ID="EditLabOrder" runat="server" Text='<%# Eval("labOrderId") %>'></asp:TextBox>
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
                        <asp:TemplateField ShowHeader="false" ItemStyle-Width="20px">
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
                            <ItemStyle Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="ViewBtn" runat="server" NavigateUrl='<%# Eval("visitId", "viewVisit.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
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
                <asp:LinqDataSource ID="VisitLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Visits" Where="patientId == @patientId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="patientId" QueryStringField="ID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
