<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="hospital.aspx.cs" Inherits="COSC2450_A2_s3357671.hospital" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>ERM System - Hospital</title>

    <link rel="stylesheet" href="/StyleSheet/Hospital.css" />
    <%--Use for thread sleep on the server side--%>
    <script runat="server" type="text/javascript">
        protected void Button_Click(object sender, EventArgs e) {
            System.Threading.Thread.Sleep(3000);
        }
    </script>
    <%--Normal Javascript--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#addPanel").fadeOut();
            $("#searchPanel").fadeOut();
            $("#listPanel").fadeOut();
            $("#addTitle").click(function () {
                $("#addPanel").slideToggle("slow");
            });
            $("#doctorTitle").click(function () {
                $("#listPanel").slideToggle("slow");
            });
            $("#searchTitle").click(function () {
                $("#searchPanel").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    
    <h2 id="searchTitle" class="bodyTitle">Search A Hospital</h2>
    <%--Search Hospital Panel--%>
    <div id="searchPanel">
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><asp:Button ID="SearchBtn" runat="server" Text="Search" />
    </div>
    <h2 id="doctorTitle" class="bodyTitle">List of Hospital</h2>
    <%--List All Hospitals--%>
    <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div style="width:100%; height: 100%; background-color:lightgrey; text-align:center;">
                <img src="Images/loader.gif" alt="Loading" />
                <br />
                <h1>-----Loading----</h1>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="listPanel">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="HospitalList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="hospitalId" DataSourceID="HospitalLinqDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="listGridView">
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>
                        <label id="lblError">No data exists (404)</label>
                    </EmptyDataTemplate>
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="hospitalId">
                            <EditItemTemplate>
                                <asp:Label ID="EditId" runat="server" Text='<%# Eval("hospitalId") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewId" runat="server" Text='<%# Bind("hospitalId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="hospitalName">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("hospitalName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewName" runat="server" Text='<%# Bind("hospitalName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" SortExpression="address">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditAddress" runat="server" Text='<%# Bind("address") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditAddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewAddress" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="License" SortExpression="license">
                            <EditItemTemplate>
                                <asp:TextBox ID="EditLicense" runat="server" Text='<%# Bind("license") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="EditRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLicense" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ViewLicense" runat="server" Text='<%# Bind("license") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-Width="20px">
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="update" OnClick="Button_Click" OnClientClick="return confirm('Are all information correct?');"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-Width="20px">
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
                                <asp:HyperLink ID="viewBtn" runat="server" NavigateUrl='<%# Eval("hospitalId", "viewHospital.aspx?ID={0}") %>' Text="View"></asp:HyperLink>
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
                <asp:LinqDataSource ID="HospitalLinqDataSource" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Hospitals" Where="address.Contains(@address) or hospitalName.Contains(@hospitalName) or license.Contains(@license) ">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="TextBox1" Name="address" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                        <asp:ControlParameter ControlID="TextBox1" Name="hospitalName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false"/>
                        <asp:ControlParameter ControlID="TextBox1" Name="license" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false"/>
                    </WhereParameters>
                </asp:LinqDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <h2 id="addTitle" class="bodyTitle">Add A Hospital</h2>
    <%--Add Hospital Panel--%>
    <div id="addPanel">
        <asp:UpdateProgress ID="updateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
            <ProgressTemplate>
                <div style="width:100%; height: 100%; background-color:lightgrey; text-align:center;">
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
                        <th><label id="lblName" class="addOption">Hospital Name: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="NameTextBox" ToolTip="FV, Tu Du..." /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="NameRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="NameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th><label id="lblAddress" class="addOption">Hospital Address: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="AddressTextBox" ToolTip="702 Nguyen Van Linh" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="AddressRequiredFieldValidator" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="AddressTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <th><label id="lblLicense" class="addOption">Hospital License: </label></th>
                        <td>
                            <asp:TextBox runat="server" ID="LicenseTextBox" /><span class="requiredField">*</span>
                            <asp:RequiredFieldValidator runat="server" ID="LicenseRequiredFieldValidator1" ValidationGroup="insert" ErrorMessage="Input should not be empty!!" ControlToValidate="LicenseTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="addOptionLabel">
                        <td></td>
                        <td>
                            <asp:Button runat="server" ID="AddHospitalButton" CausesValidation="true" ValidationGroup="insert" Text="Submit" UseSubmitBehavior="true" OnClick="AddHospitalButton_Click"/>
                            <asp:Button runat="server" ID="ResetHospitalButton" CausesValidation="false" Text="Reset" OnClick="AddHospitalButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
