<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Paynow.aspx.cs" Inherits="Paymenton.Paynow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <form action="Return.aspx" method="post" name="razorpayForm">
            <input id="razorpay_payment_id" type="hidden" name="razorpay_payment_id" />
            <input id="razorpay_order_id" type="hidden" name="razorpay_order_id" />
            <input id="razorpay_signature" type="hidden" name="razorpay_signature" />
        </form>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <br />
    <br />
    <center> <button class="gem-button gem-button-size-tiny gem-button-style-outline gem-button-text-weight-normal gem-button-border-2 gem-button-empty" id="rzp-button1" style="    width: 108px;">Pay Now</button></center>
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
            var orderId = "<%=orderId%>"
            var options = {
                "name": "<%=product%>",
                "description": "<%=product%>",
                "order_id": orderId,
                "image": "images/logo.jpg",
                "prefill": {
                    "name": "<%=name%>",
                    "email": "<%=email%>",
                    "contact": "<%=contact%>",
                },
                "notes": {
                    "address": "<%=addressn%>",
                    "merchant_order_id": "<%=orderIds%>",
                },
                "theme": {
                    "color": "#F37254"
                }
            }
            // Boolean whether to show image inside a white frame. (default: true)
            options.theme.image_padding = false;
            options.handler = function (response) {
                document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                document.getElementById('razorpay_order_id').value = orderId;
                document.getElementById('razorpay_signature').value = response.razorpay_signature;
                document.razorpayForm.submit();
            };
            options.modal = {
                ondismiss: function () {
                    console.log("This code runs when the popup is closed");
                },
                // Boolean indicating whether pressing escape key 
                // should close the checkout form. (default: true)
                escape: true,
                // Boolean indicating whether clicking translucent blank
                // space outside checkout form should close the form. (default: false)
                backdropclose: false
            };
            var rzp = new Razorpay(options);
            document.getElementById('rzp-button1').onclick = function (e) {
                rzp.open();
                e.preventDefault();
            }
        </script>
</asp:Content>
