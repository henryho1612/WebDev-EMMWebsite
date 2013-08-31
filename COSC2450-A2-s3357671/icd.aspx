<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="icd.aspx.cs" Inherits="COSC2450_A2_s3357671.icd" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - ICD</title>

    <link rel="stylesheet" href="/StyleSheet/ICD.css" />
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
            $("#addIcdTitle").click(function () {
                $("#addPanel").slideToggle("slow");
            });
            $("#searchTitle").click(function () {
                $("#searchPanel").slideToggle("slow");
            });
            $("#icdTitle").click(function () {
                $("#listPanel").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

    <h2 id="addIcdTitle" class="bodyTitle">Add An ICD</h2>
    <%--Add Medical Service Panel--%>
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
                            <label id="lblName" class="addOption">ICD: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="NameTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="NameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblGroupId" class="addOption">ICD Group: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="GroupNameTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="GroupNameRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="GroupNameTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:AutoCompleteExtender runat="server" ID="GroupNameAutoCompleteExtender" TargetControlID="GroupNameTextBox" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                            <asp:CustomValidator runat="server" ID="InsertExistenceCustomValidator" ValidationGroup="insert" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="GroupNameTextBox" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th>
                            <label id="lblIcdCode" class="addOption">Code name: </label>
                        </th>
                        <td>
                            <asp:TextBox runat="server" ID="CodeTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="CodeRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="CodeTextBox" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddIcdButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddIcdButton_Click" />
                            <asp:Button runat="server" ID="ResetIcdButton" CausesValidation="false" Text="Reset" OnClick="AddIcdButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="LblNotice" runat="server" Text="Please log in as an admin to make changes" ForeColor="Red" Visible="false"></asp:Label>
    </div>

    <h2 id="searchTitle" class="bodyTitle">Search An Icd</h2>
    <%--Search Medical Service Panel--%>
    <div id="searchPanel">
        <div id="searchBox">
            <asp:TextBox ID="SearchTextBox" runat="server" Height="16px" Width="580px"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
            <asp:AutoCompleteExtender runat="server" ID="IcdAutoCompleteExtender" TargetControlID="SearchTextBox" ServiceMethod="GetIcd" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
        </div>

        <div id="displayPanel">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="LinqDataSource1" ForeColor="#333333" GridLines="None" DataKeyNames="icdChapterId" Width="40%">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="icdChapterId" HeaderText="Chapter Id" ReadOnly="True" SortExpression="icdChapterId" ItemStyle-Width="30%" InsertVisible="False" />
                            <asp:BoundField DataField="icdChapterName" HeaderText="Chapter Name" SortExpression="icdChapterName" ItemStyle-Width="70%" />
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
                    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EntityTypeName="" TableName="IcdChapters">
                    </asp:LinqDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <%--List All Icd--%>
    <h2 id="icdTitle" class="bodyTitle">List of Icds</h2>
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
                <asp:GridView ID="IcdList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="icdId" DataSourceID="IcdLinqDataSource" ForeColor="#333333" GridLines="None" OnRowDeleting="GridView_RowDeleting" OnPreRender="IcdList_PreRender">
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="icdId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("icdId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("icdId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Chapter Name" SortExpression="icdChapterId">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditChapterId" runat="server" Text='<%# Bind("IcdChapter.icdChapterName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="ChapterNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty" ControlToValidate="EditChapterId" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:AutoCompleteExtender runat="server" ID="ChapterNameAutoCompleteExtender" TargetControlID="EditChapterId" ServiceMethod="GetGroupNameList" MinimumPrefixLength="1" CompletionInterval="10" EnableCaching="true" CompletionSetCount="10" Enabled="true"></asp:AutoCompleteExtender>
                                <asp:CustomValidator runat="server" ID="UpdateExistenceCustomValidator" ValidationGroup="update" ErrorMessage="Inputted id does not exist!!!" ControlToValidate="EditChapterId" ForeColor="Red" OnServerValidate="ExistenceCustomValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewChapterId" runat="server" Text='<%# Bind("icdChapterId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Icd Name" SortExpression="icdName">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("icdName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewName" runat="server" Text='<%# Bind("icdName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code Name" SortExpression="icdCode">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditCode" runat="server" Text='<%# Bind("icdCode") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="CodeNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditCode" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewCode" runat="server" Text='<%# Bind("icdCode") %>'></asp:Label>
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
                                <asp:HyperLink ID="ViewBtn" runat="server" NavigateUrl='<%# Eval("icdId", "viewIcd.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
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
                <asp:LinqDataSource ID="IcdLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Icds" Where="icdCode.Contains(@icdCode) or icdName.Contains(@icdName) or IcdChapter.icdChapterName.Contains(@icdChapterName)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="SearchTextBox" Name="icdCode" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="icdName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="SearchTextBox" Name="icdChapterName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
