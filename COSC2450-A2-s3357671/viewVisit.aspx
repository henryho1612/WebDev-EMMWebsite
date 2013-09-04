<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewVisit.aspx.cs" Inherits="COSC2450_A2_s3357671.viewVisit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/Visit.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

    <h2 id="visitDetailTitle" class="bodyTitle">Visit Detail</h2>
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
                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" DataKeyNames="visitId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated" OnPreRender="FormView1_PreRender">
                    <EditItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("visitId") %>' runat="server" ID="EditId" /><br />
                        Hospital:
                        <asp:TextBox Text='<%# Bind("Hospital.hospitalName") %>' runat="server" ID="EditHospital" /><br />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditHospital" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender8" TargetControlID="EditHospital" ServiceMethod="GetHospitalList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="CustomValidator8" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditHospital" ForeColor="Red" OnServerValidate="HospitalExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        Doctor:
                        <asp:TextBox ID="EditDoctor" runat="server" Text='<%# Bind("Doctor.doctorName") %>' />
                        <br />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDoctor" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender9" TargetControlID="EditDoctor" ServiceMethod="GetDoctorList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="CustomValidator9" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDoctor" ForeColor="Red" OnServerValidate="DoctorExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        Patient:
                        <asp:TextBox runat="server" ID="EditPatient" Text='<%# Bind("Patient.patientName") %>' />
                        <br />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPatient" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender10" TargetControlID="EditPatient" ServiceMethod="GetPatientList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="CustomValidator10" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditPatient" ForeColor="Red" OnServerValidate="PatientExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        Icd:
                        <asp:TextBox ID="EditIcd" runat="server" Text='<%# Bind("Icd.icdName") %>' />
                        <br />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditIcd" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender11" TargetControlID="EditIcd" ServiceMethod="GetICDList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="CustomValidator11" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditIcd" ForeColor="Red" OnServerValidate="ICDExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        Visited Date:
                        <asp:TextBox ID="EditDate" runat="server" Text='<%# Bind("dateVisit") %>' Enabled="false" /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span><br />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="EditDate" PopupButtonID="CalendarButton1"></asp:CalendarExtender>
                        <asp:RequiredFieldValidator runat="server" ID="DateRequiredFieldValidator1" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        Outcome:
                        <asp:TextBox ID="EditOutcome" runat="server" Text='<%# Bind("outcome") %>' /><br />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditOutcome" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="AutoCompleteExtender14" TargetControlID="EditOutcome" ServiceMethod="GetOutcomeList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="CustomValidator14" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditOutcome" ForeColor="Red" OnServerValidate="OutcomeExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="update" CommandName="Update" Text="Update" OnClick="UpdateButton_Click" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White"></EditRowStyle>
                    <FooterStyle BackColor="White" ForeColor="#333333"></FooterStyle>
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <ItemTemplate>
                        ID:
                        <asp:Label Text='<%# Eval("visitId") %>' runat="server" ID="ViewId" /><br />
                        Hospital:
                        <asp:Label Text='<%# Bind("Hospital.hospitalName") %>' runat="server" ID="ViewHospital" /><br />
                        Doctor:
                        <asp:Label Text='<%# Bind("Doctor.doctorName") %>' runat="server" ID="ViewDoctor" /><br />
                        Patient:
                        <asp:Label Text='<%# Bind("Patient.patientName") %>' runat="server" ID="ViewPatient" /><br />
                        Icd:
                        <asp:Label Text='<%# Bind("Icd.icdName") %>' runat="server" ID="ViewIcd" /><br />
                        Visited Date:
                        <asp:Label ID="ViewDate" runat="server" Text='<%# Bind("dateVisit") %>' />
                        <br />
                        Outcome:
                        <asp:Label ID="ViewOutcome" runat="server" Text='<%# Bind("outcome") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                        <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                        <a href="#">
                            <label id="addPrescriptionBtn">Add Prescription</label></a>
                        <a href="#">
                            <label id="addLabOrderBtn">Add Lab Order</label></a>
                    </ItemTemplate>
                    <PagerStyle HorizontalAlign="Center" BackColor="#336666" ForeColor="White"></PagerStyle>
                    <RowStyle BackColor="White" ForeColor="#333333"></RowStyle>
                </asp:FormView>
                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="Visits" Where="visitId == @visitId">
                    <WhereParameters>
                        <asp:QueryStringParameter QueryStringField="ID" Name="visitId" Type="Int64"></asp:QueryStringParameter>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <%--<h2 id="prescriptionTitle" class="bodyTitle">Prescription List</h2>
    <div class="listPanel">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="PrescriptionList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="prescriptionId" DataSourceID="PrescriptionLinqDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="prescriptionId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("prescriptionId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("prescriptionId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Doctor Name" SortExpression="doctorId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="EditNameAutoCompleteExtender" TargetControlID="EditDName" ServiceMethod="GetDoctorList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="EditNameExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDName" ForeColor="Red" OnServerValidate="DoctorExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Visited Date" SortExpression="dateWritten">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="EditDate" Enabled="false" Text='<%# Bind("dateWritten") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                                <asp:CalendarExtender ID="VisitedDateCalendarExtender" runat="server" TargetControlID="EditDate" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                                <asp:RequiredFieldValidator runat="server" ID="VisitedDateRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDate" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDate" runat="server" Text='<%# Bind("dateWritten") %>'></asp:Label>
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
                <asp:LinqDataSource ID="PrescriptionLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Prescriptions" >
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <h2 id="prescriptionDetailTitle" class="bodyTitle">Prescription Detail List</h2>
    <h2 id="addPrescriptionDetail" class="bodyTitle">Add A Prescription Detail</h2>
    <h2 id="labOrderTitle" class="bodyTitle">Lab Order List</h2>
    <div class="listPanel">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:GridView ID="LabOrderList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="labOrderId" DataSourceID="LabOrderLinqDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="labOrderId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("labOrderId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("labOrderId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Doctor Name" SortExpression="doctorId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="GroupNameAutoCompleteExtender" TargetControlID="EditDName" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDName" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Visited Date" SortExpression="dateVisit">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="EditDate" Enabled="false" Text='<%# Bind("dateVisit") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                                <asp:CalendarExtender ID="VisitedDateCalendarExtender" runat="server" TargetControlID="EditDate" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                                <asp:RequiredFieldValidator runat="server" ID="VisitedDateRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDate" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDate" runat="server" Text='<%# Bind("dateVisit") %>'></asp:Label>
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
                <asp:LinqDataSource ID="LabOrderLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="LabOrders" Where="Doctor.doctorName.Contains(@doctorName)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="doctorName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false"/>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <h2 id="labOrderDetailTitle" class="bodyTitle">Lab Order Detail List</h2>
    <asp:UpdateProgress ID="updateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
                <img src="Images/loader.gif" alt="Loading" />
                <br />
                <h1>-----Loading----</h1>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="listPanel">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:GridView ID="LabOrderDetailList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="labOrderDetailId" DataSourceID="LabOrderDetailLinqDataSource" ForeColor="#333333" GridLines="None" OnPreRender="LabOrderDetailList_PreRender">
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID:" InsertVisible="False" SortExpression="labOrderDetailId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("labOrderDetailId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("labOrderDetailId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Lab Order ID:" SortExpression="labOrderId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditLabOrder" runat="server" Text='<%# Bind("labOrderId") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditLabOrderRequiredFieldValidator1" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLabOrder" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator runat="server" ID="EditLabOrderInsertExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditLabOrder" ForeColor="Red" OnServerValidate="InsertExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                                <asp:AutoCompleteExtender runat="server" ID="EditLabOrderAutoCompleteExtender" TargetControlID="EditLabOrder" ServiceMethod="GetLabOrderList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewLabOrder" runat="server" Text='<%# Bind("labOrderId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medical Service Name:" SortExpression="medicalServiceId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditMSName" runat="server" Text='<%# Bind("MedicalService.medicalServiceName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditMSNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditMSName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="EditMSNameAutoCompleteExtender" TargetControlID="EditMSName" ServiceMethod="GetMSNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="EditMSNameCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditMSName" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewMSName" runat="server" Text='<%# Bind("MedicalService.medicalServiceName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Result:" SortExpression="result">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditResult" runat="server" Text='<%# Bind("labResult") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditResult" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewResult" runat="server" Text='<%# Bind("labResult") %>'></asp:Label>
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
                                <asp:HyperLink ID="ViewBtn" runat="server" NavigateUrl='<%# Eval("labOrderDetailId", "viewLabOrderDetail.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
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
                <asp:LinqDataSource ID="LabOrderDetailLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="LabOrderDetails">
                    <WhereParameters>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <h2 id="addLabOrderDetail" class="bodyTitle">Add A Lab Order Detail</h2>--%>
</asp:Content>
