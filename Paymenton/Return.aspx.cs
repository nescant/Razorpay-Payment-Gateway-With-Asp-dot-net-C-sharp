using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Paymenton
{
    public partial class Return : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string paymentId = Request.Form["razorpay_payment_id"];
            int am = Convert.ToInt32(Math.Round(Convert.ToDouble(Session["totalprice"].ToString())));
            Dictionary<string, object> input = new Dictionary<string, object>();
            input.Add("amount", am); // this amount should be same as transaction amount

            string key = "rzp_test_cvwiiVvHjyJrmr";
            string secret = "J4d2RxfQ97udLpP5JSNuvwSH";
            
            RazorpayClient client = new RazorpayClient(key, secret);
            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            Dictionary<string, string> attributes = new Dictionary<string, string>();

            attributes.Add("razorpay_payment_id", paymentId);
            attributes.Add("razorpay_order_id", Request.Form["razorpay_order_id"]);
            attributes.Add("razorpay_signature", Request.Form["razorpay_signature"]);

            Utils.verifyPaymentSignature(attributes);
            //string generated_signature = hmac_sha256(Request.Form["razorpay_order_id"] + "|" + paymentId, secret);

            //if (generated_signature == Request.Form["razorpay_signature"])
            //{
            //payment is successful
            Literal1.Text = "<table style='width:100%' border='1'><tr><td>Product Name:</td><td>" + Session["product"].ToString() + "</td></tr><tr><td>Amount ₹:</td><td>" + Session["totalprice"].ToString() + "</td></tr><tr><td>Payment Status:</td><td>Successful</td></tr></table>";
        }
    }
}