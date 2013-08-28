<%@ Page Title="" Language="C#" MasterPageFile="~/ERM.Master" AutoEventWireup="true" CodeBehind="viewHospital.aspx.cs" Inherits="COSC2450_A2_s3357671.viewHospital" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
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
            
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <h2 id="hospitalDetailTitle" class="bodyTitle">Hospital Detail</h2>
    <%--Display Hospital Detail--%>
    <div id="displayPanel">
        <asp:FormView ID="HospitalFormView" runat="server" DataKeyNames="hospitalId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnItemUpdated="HospitalFormView_ItemUpdated">
            <EditItemTemplate>
                <span class="formView">ID:</span>
                <asp:Label ID="EditId" runat="server" Text='<%# Eval("hospitalId") %>' />
                <br />
                <span class="formView">Hospital Name:</span>
                <asp:TextBox ID="EditName" runat="server" Text='<%# Bind("hospitalName") %>' />
                <asp:RequiredFieldValidator runat="server" ID="EditNameRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditName" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <span class="formView">Address:</span>
                <asp:TextBox ID="EditAddress" runat="server" Text='<%# Bind("address") %>' />
                <asp:RequiredFieldValidator runat="server" ID="EditAddressRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <span class="formView">License:</span>
                <asp:TextBox ID="EditLicense" runat="server" Text='<%# Bind("license") %>' />
                <asp:RequiredFieldValidator runat="server" ID="EditRequiredFieldValidator" ValidationGroup="update" ErrorMessage="Input should not be empty!!" ControlToValidate="EditLicense" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <asp:LinkButton ID="UpdateBtn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="update" OnClick="Button_Click" OnClientClick="return confirm('Are all information correct?');"/>
                &nbsp;<asp:LinkButton ID="CancelBtn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <ItemTemplate>
                <span class="formView">Id:</span>
                <asp:Label ID="ViewId" runat="server" Text='<%# Eval("hospitalId") %>' />
                <br />
                <span class="formView">Hospital Name:</span>
                <asp:Label ID="ViewName" runat="server" Text='<%# Bind("hospitalName") %>' />
                <br />
                <span class="formView">Address:</span>
                <asp:Label ID="ViewAddress" runat="server" Text='<%# Bind("address") %>' />
                <br />
                <span class="formView">License:</span>
                <asp:Label ID="ViewLicense" runat="server" Text='<%# Bind("license") %>' />
                <br />
                <asp:LinkButton ID="EditBtn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteBtn" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClick="Button_Click" OnClientClick="return confirm('Do you want to delete?');"/>
            </ItemTemplate>
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
        </asp:FormView>
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="Hospitals" Where="hospitalId == @hospitalId">
            <WhereParameters>
                <asp:QueryStringParameter Name="hospitalId" QueryStringField="Id" Type="Int64" />
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
</asp:Content>