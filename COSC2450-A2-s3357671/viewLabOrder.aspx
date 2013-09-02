<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewLabOrder.aspx.cs" Inherits="COSC2450_A2_s3357671.viewLabOrder" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="/StyleSheet/LabOrder.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="LabOrderDetailTitle" class="bodyTitle">A Lab Order Detail</h2>
    <%--Display Icd Detail--%>
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
                <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="labOrderId" DataSourceID="LinqDataSource1" GridLines="Horizontal" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" OnItemUpdated="FormView1_ItemUpdated" OnPreRender="FormView1_PreRender">
                    <EditItemTemplate>
                        ID:
                        <asp:Label ID="EditId" runat="server" Text='<%# Eval("labOrderId") %>' />
                        <br />
                        Doctor Name:
                        <asp:TextBox ID="EditDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditDName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:AutoCompleteExtender runat="server" ID="GroupNameAutoCompleteExtender" TargetControlID="EditDName" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                        <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditDName" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        <br />
                        Date Visit:
                        <asp:TextBox runat="server" ID="EditDate" Enabled="false" Text='<%# Bind("dateVisit") %>' /><asp:ImageButton ID="CalendarButton" runat="server" ImageUrl="~/Images/calendar.ico" Width="25px" Height="25px" ImageAlign="AbsMiddle" /><span class="requiredField">*</span>
                        <asp:CalendarExtender ID="VisitedDateCalendarExtender" runat="server" TargetControlID="EditDate" PopupButtonID="CalendarButton"></asp:CalendarExtender>
                        <asp:RequiredFieldValidator runat="server" ID="VisitedDateRequiredFieldValidator" ValidationGroup="update" ErrorMessage="A date should be chosen!!" ControlToValidate="EditDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="update" CommandName="Update" Text="Update" OnClick="UpdateButton_Click" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <ItemTemplate>
                        ID:
                        <asp:Label ID="ViewId" runat="server" Text='<%# Eval("labOrderId") %>' />
                        <br />
                        Doctor Name:
                        <asp:Label ID="ViewDName" runat="server" Text='<%# Bind("Doctor.doctorName") %>' />
                        <br />
                        Visited Date:
                        <asp:Label ID="ViewDate" runat="server" Text='<%# Bind("dateVisit") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"></asp:LinkButton>
                        <asp:LinkButton ID="BackButton" runat="server" CausesValidation="False" Text="Back" OnClick="BackButton_Click" />
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                </asp:FormView>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="LabOrders" Where="labOrderId == @labOrderId">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="labOrderId" QueryStringField="ID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
