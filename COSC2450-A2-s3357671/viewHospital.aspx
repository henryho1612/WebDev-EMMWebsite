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
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="hospitalId" DataSourceID="LinqDataSource1" OnItemDeleted="FormView1_ItemDeleted" OnItemDeleting="FormView1_ItemDeleting">
            <EditItemTemplate>
                hospitalId:
                <asp:Label ID="hospitalIdLabel1" runat="server" Text='<%# Eval("hospitalId") %>' />
                <br />
                hospitalName:
                <asp:TextBox ID="hospitalNameTextBox" runat="server" Text='<%# Bind("hospitalName") %>' />
                <br />
                address:
                <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' />
                <br />
                license:
                <asp:TextBox ID="licenseTextBox" runat="server" Text='<%# Bind("license") %>' />
                <br />
                Visits:
                <asp:TextBox ID="VisitsTextBox" runat="server" Text='<%# Bind("Visits") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                hospitalName:
                <asp:TextBox ID="hospitalNameTextBox" runat="server" Text='<%# Bind("hospitalName") %>' />
                <br />
                address:
                <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' />
                <br />
                license:
                <asp:TextBox ID="licenseTextBox" runat="server" Text='<%# Bind("license") %>' />
                <br />
                Visits:
                <asp:TextBox ID="VisitsTextBox" runat="server" Text='<%# Bind("Visits") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                hospitalId:
                <asp:Label ID="hospitalIdLabel" runat="server" Text='<%# Eval("hospitalId") %>' />
                <br />
                hospitalName:
                <asp:Label ID="hospitalNameLabel" runat="server" Text='<%# Bind("hospitalName") %>' />
                <br />
                address:
                <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>' />
                <br />
                license:
                <asp:Label ID="licenseLabel" runat="server" Text='<%# Bind("license") %>' />
                <br />
                Visits:
                <asp:Label ID="VisitsLabel" runat="server" Text='<%# Bind("Visits") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            </ItemTemplate>
        </asp:FormView>
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="COSC2450_A2_s3357671.DBDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="Hospitals" Where="hospitalId == @hospitalId">
            <WhereParameters>
                <asp:QueryStringParameter Name="hospitalId" QueryStringField="Id" Type="Int64" />
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
</asp:Content>