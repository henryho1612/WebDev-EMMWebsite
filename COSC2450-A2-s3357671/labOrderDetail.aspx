<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="labOrderDetail.aspx.cs" Inherits="COSC2450_A2_s3357671.labOrderDetail" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Lab Order Detail</title>

    <link rel="stylesheet" href="/StyleSheet/LabOrder.css" />
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
            $("#labOrderDetailTitle").click(function () {
                $("#listPanel").slideToggle("slow");
            });
            $("#noticePanel").click(function () {
                $("#notice").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

    <h2 id="addTitle" class="bodyTitle">Add A Lab Order Detail</h2>
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
                            <label id="lblLOrderId" class="addOption">Lab Order: </label>
                        </th>
                        <td>
                            <asp:DropDownList ID="LabIdDropDown" runat="server" DataSourceID="LabIdLinqDataSource" DataTextField="labOrderId" DataValueField="labOrderId"></asp:DropDownList>
                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LabIdLinqDataSource" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" TableName="LabOrders"></asp:LinqDataSource>
                            <asp:RequiredFieldValidator ID="LabIdRequiredFieldValidator" runat="server" ErrorMessage="You did not choose anything" Text="*" InitialValue="-1" Display="Dynamic" ControlToValidate="LabIdDropDown" ValidationGroup="insert"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblMedicalService" class="addOption">Medical Service: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="MSTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="MSRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="MSTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="MSAutoCompleteExtender" TargetControlID="MSTextBox" ServiceMethod="GetMSNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="MSInsertExistenceCustomValidator" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="MSTextBox" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblResult" class="addOption">Result: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="ResultTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="ResultRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="ResultTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddLabOrderDetailButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddLabOrderDetailButton_Click" />
                            <asp:Button runat="server" ID="ResetLabOrderDetailButton" CausesValidation="false" Text="Reset" OnClick="AddLabOrderDetailButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false" />
    </div>

    <h2 id="searchTitle" class="bodyTitle">Search A Lab Order Detail</h2>
    <div id="searchPanel">
        <div id="searchBox">
            <asp:TextBox ID="SearchTextBox" runat="server" Height="16px" Width="580px"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
            <asp:AutoCompleteExtender runat="server" ID="LabOrderAutoCompleteExtender" TargetControlID="SearchTextBox" ServiceMethod="GetLabOrderDetails" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
        </div>
    </div>

    <h2 id="prescriptionDetailTitle" class="bodyTitle">List of all lab order details</h2>
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
                <asp:GridView ID="LabOrderDetailList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="labOrderDetailId" DataSourceID="LabOrderDetailLinqDataSource" ForeColor="#333333" GridLines="None" OnPreRender="LabOrderDetailList_PreRender" CssClass="listGridView">
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
                <asp:LinqDataSource ID="LabOrderDetailLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="LabOrderDetails" Where="MedicalService.medicalServiceName.Contains(@medicalServiceName) or labResult.Contains(@result)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="medicalServiceName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="result" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <h2 id="notice" class="bodyTitle">Notice</h2>
    <div id="noticePanel">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="medicalServiceId" DataSourceID="MedicalServiceLinqDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="medicalServiceId" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="medicalServiceId" />
                        <asp:BoundField DataField="MedicalServiceGroup.medicalServiceGroupName" HeaderText="Group ID" SortExpression="medicalServiceGroupId" />
                        <asp:BoundField DataField="medicalServiceName" HeaderText="Medical Service" SortExpression="medicalServiceName" />
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
                <asp:LinqDataSource ID="MedicalServiceLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="MedicalServices">
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="labOrderId" DataSourceID="LabOrderLinqDataSource" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="labOrderId" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="labOrderId" />
                        <asp:BoundField DataField="Doctor.doctorName" HeaderText="Doctor" SortExpression="doctorId" />
                        <asp:BoundField DataField="dateVisit" HeaderText="Visited Date" SortExpression="dateVisit" />
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
                <asp:LinqDataSource ID="LabOrderLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="LabOrders">
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
