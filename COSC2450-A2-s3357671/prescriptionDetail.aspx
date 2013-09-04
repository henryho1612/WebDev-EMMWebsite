<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="prescriptionDetail.aspx.cs" Inherits="COSC2450_A2_s3357671.prescriptionDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Prescription Detail</title>

    <link rel="stylesheet" href="/StyleSheet/Prescription.css" />
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
            $("#prescriptionDetailTitle").click(function () {
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

    <h2 id="addTitle" class="bodyTitle">Add A Prescription Detail</h2>
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
                            <label id="lblPrescId" class="addOption">Prescription ID: </label>
                        </th>
                        <td>
                            <asp:DropDownList ID="PresIdDropDown" runat="server" DataSourceID="PresIdLinqDataSource" DataTextField="prescriptionId" DataValueField="prescriptionId"></asp:DropDownList>
                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="PresIdLinqDataSource" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" TableName="Prescriptions"></asp:LinqDataSource>
                            <asp:RequiredFieldValidator ID="PresIdRequiredFieldValidator" runat="server" ErrorMessage="You did not choose anything" Text="*" InitialValue="-1" Display="Dynamic" ControlToValidate="PresIdDropDown" ValidationGroup="insert"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblDrug" class="addOption">Drug: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="DrugTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="DrugRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="DrugTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="DrugAutoCompleteExtender" TargetControlID="DrugTextBox" ServiceMethod="GetDrugList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="DrugTextBox" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblQuantity" class="addOption">Quantity: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="QuantityTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="QuantityTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="QuantityRegularExpressionValidator" ValidationGroup="insert" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="QuantityTextBox" ForeColor="Red" ValidationExpression="\d{1,2}" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblDose" class="addOption">Dose Per Day: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="DPDTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="DoseRequiredFieldValidator2" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="DPDTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="DoseRegularExpressionValidator" ValidationGroup="insert" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="DPDTextBox" ForeColor="Red" ValidationExpression="\d{1,2}" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblInstruction" class="addOption">Special Instruction: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="InstructionTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="InstructionTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddPrescriptionDetailButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddPrescriptionDetailButton_Click" />
                            <asp:Button runat="server" ID="ResetPrescriptionDetailButton" CausesValidation="false" Text="Reset" OnClick="AddPrescriptionDetailButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false" />
    </div>

    <h2 id="searchTitle" class="bodyTitle">Search A Prescription</h2>
    <div id="searchPanel">
        <div id="searchBox">
            <asp:TextBox ID="SearchTextBox" runat="server" Height="16px" Width="580px"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
            <asp:AutoCompleteExtender runat="server" ID="PrescriptionAutoCompleteExtender" TargetControlID="SearchTextBox" ServiceMethod="GetPrescriptionDetails" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
        </div>
    </div>

    <h2 id="prescriptionDetailTitle" class="bodyTitle">List of all prescription details</h2>
    <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div style="width: 100%; height: 100%; background-color: lightgrey; text-align: center;">
                <img src="Images/loader.gif" alt="Loading" />
                <br />
                <h1>-----Loading----</h1>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="listPanel">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="PrescriptionDetailList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="prescriptionDetailId" DataSourceID="PresDetailLinqDataSource" ForeColor="#333333" GridLines="None" OnPreRender="PrescriptionDetailList_PreRender" CssClass="listGridView">
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID:" InsertVisible="False" SortExpression="prescriptionDetailId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("prescriptionDetailId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("prescriptionDetailId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Prescription ID:" SortExpression="prescriptionId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditPID" runat="server" Text='<%# Bind("prescriptionId") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditPIDRequiredFieldValidator1" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditPID" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator runat="server" ID="EditPIDInsertExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditPID" ForeColor="Red" OnServerValidate="InsertExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                                <asp:AutoCompleteExtender runat="server" ID="EditPIDAutoCompleteExtender" TargetControlID="EditPID" ServiceMethod="GetPrescriptionList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewPId" runat="server" Text='<%# Bind("prescriptionId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Drug Name:" SortExpression="drugId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDName" runat="server" Text='<%# Bind("Drug.drugName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="GroupNameAutoCompleteExtender" TargetControlID="EditDName" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDName" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDrug" runat="server" Text='<%# Bind("Drug.drugName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity:" SortExpression="quantity">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditQuantity" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditQuantity" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="QuantityRegularExpressionValidator1" ValidationGroup="update" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="EditQuantity" ForeColor="Red" ValidationExpression="\d{1,2}" Display="Dynamic"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewQuantity" runat="server" Text='<%# Bind("quantity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dose Per Day:" SortExpression="dosePerDay">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditDPD" runat="server" Text='<%# Bind("dosePerDay") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDPD" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="DPDRegularExpressionValidator1" ValidationGroup="update" ErrorMessage="Invalid Type! Should be a number" ControlToValidate="EditDPD" ForeColor="Red" ValidationExpression="\d{1,2}" Display="Dynamic"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewDPD" runat="server" Text='<%# Bind("dosePerDay") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Instruction:" SortExpression="specialInstruction">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditInstruction" runat="server" Text='<%# Bind("specialInstruction") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditInstruction" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewInstruction" runat="server" Text='<%# Bind("specialInstruction") %>'></asp:Label>
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
                                <asp:HyperLink ID="ViewBtn" runat="server" NavigateUrl='<%# Eval("prescriptionDetailId", "viewPrescriptionDetail.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
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
                <asp:LinqDataSource ID="PresDetailLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="PrescriptionDetails" Where="Drug.drugName.Contains(@drugName) or specialInstruction.Contains(@specialInstruction)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="drugName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <%--<asp:ControlParameter ControlID="SearchTextBox" Name="dosePerDay" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="quantity" PropertyName="Text" Type="Int32" />--%>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="specialInstruction" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <%--<asp:ControlParameter ControlID="SearchTextBox" Name="prescriptionId" PropertyName="Text" Type="Int64" />--%>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <h2 id="notice" class="bodyTitle">Notice</h2>
    <div id="noticePanel">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:GridView ID="PrescriptionList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="prescriptionId" DataSourceID="PrescriptionLinqDataSource" ForeColor="#333333" GridLines="None" Width="450px" HorizontalAlign="Center">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="prescriptionId" HeaderText="Prescription ID" InsertVisible="False" ReadOnly="True" SortExpression="prescriptionId" />
                        <asp:BoundField DataField="Doctor.doctorName" HeaderText="Doctor Name" SortExpression="doctorId" />
                        <asp:BoundField DataField="dateWritten" HeaderText="Written Date" SortExpression="dateWritten" />
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
                <asp:LinqDataSource ID="PrescriptionLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="Prescriptions">
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:GridView ID="DrugList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="drugId" DataSourceID="DrugLinqDataSource" ForeColor="#333333" GridLines="None" HorizontalAlign="Center">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="drugId" HeaderText="Drug ID" InsertVisible="False" ReadOnly="True" SortExpression="drugId" />
                        <asp:BoundField DataField="DrugGroup.drugGroupName" HeaderText="Group Name" SortExpression="drugGroupId" />
                        <asp:BoundField DataField="drugName" HeaderText="Drug Name" SortExpression="drugName" />
                        <asp:BoundField DataField="drugGenericName" HeaderText="Generic Name" SortExpression="drugGenericName" />
                        <asp:BoundField DataField="unit" HeaderText="Unit" SortExpression="unit" />
                        <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
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
                <asp:LinqDataSource ID="DrugLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="Drugs">
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
