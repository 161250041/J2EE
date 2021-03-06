<%@ page import="edu.nju.onlineStock.Model.Commodity" %>
<%@ page import="edu.nju.onlineStock.Action.CommodityListBean" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: hyh
  Date: 2019-01-05
  Time: 21:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品列表</title>

    <style type="text/css">
        *, *::after, *::before {
            box-sizing: border-box;
        }

        html {
            font-size: 62.5%;
        }

        body {
            font-size: 1.6rem;
            font-family: "Work Sans", sans-serif;
            color: #314d5d;
            background-color: #f2f2f2;
        }

        a {
            color: #de5b48;
            text-decoration: none;
        }

        img, svg {
            max-width: 100%;
        }

        button {
            -webkit-appearance: none;
            -moz-appearance: none;
            -ms-appearance: none;
            -o-appearance: none;
            appearance: none;
            cursor: pointer;
            border: none;
            padding: 0;
        }
        button:focus {
            outline: none;
        }

        header {
            height: 80px;
            position: relative;
            padding-top: 40px;
        }
        header h1 {
            text-align: center;
            width: 90%;
            margin: 0 auto;
        }
        @media only screen and (min-width: 768px) {
            header {
                height: 200px;
                padding-top: 100px;
            }
            header h1 {
                font-size: 2.2rem;
            }
        }

        .userInfo {
            position: absolute;
            z-index: 100;
            top: 50px;
            right: 10px;
            height: 50px;
            width: 50px;
            background: url(https://image.flaticon.com/icons/svg/145/145843.svg) no-repeat center center;
        }

        .orders {
            position: absolute;
            z-index: 100;
            top: 50px;
            right: 10px;
            height: 50px;
            width: 50px;
            background: url(https://image.flaticon.com/icons/svg/204/204276.svg) no-repeat center center;
        }

        .cd-cart {
            position: absolute;
            z-index: 100;
            top: 50px;
            right: 10px;
            height: 50px;
            width: 50px;
            background: url(https://image.flaticon.com/icons/svg/1055/1055659.svg) no-repeat center center;
        }

        .cd-cart span {
            /* number of items added to the cart */
            position: absolute;
            z-index: 101;
            top: 2px;
            right: 5px;
            height: 18px;
            width: 18px;
            line-height: 18px;
            background-color: #46b29d;
            color: #ffffff;
            font-size: 1rem;
            font-weight: bold;
            text-align: center;
            border-radius: 50%;
        }
        @media only screen and (min-width: 1100px) {
            .cd-cart {
                position: fixed;
                top: 30px;
                right: 30px;
            }
            .orders{
                position: fixed;
                top: 120px;
                right: 30px;
            }
            .userInfo {
                position: fixed;
                top: 210px;
                right: 30px;

            }

        }

        .cd-gallery {
            width: 90%;
            max-width: 1100px;
            margin: 1.5em auto;
        }
        .cd-gallery > li {
            margin-bottom: 2em;
        }
        @media only screen and (min-width: 768px) {
            .cd-gallery {
                margin-top: 2em;
            }
            .cd-gallery::after {
                clear: both;
                content: "";
                display: table;
            }
            .cd-gallery > li {
                width: 48%;
                float: left;
                margin: 0 4% 6% 0;
            }
            .cd-gallery > li:nth-of-type(2n) {
                margin-right: 0;
            }
        }
        @media only screen and (min-width: 1100px) {
            .cd-gallery {
                margin-top: 2.5em;
            }
            .cd-gallery > li {
                width: 30%;
                float: left;
                margin: 0 5% 5% 0;
            }
            .cd-gallery > li:nth-of-type(2n) {
                margin-right: 5%;
            }
            .cd-gallery > li:nth-of-type(3n) {
                margin-right: 0;
            }
        }


        .cd-single-item {
            position: relative;
            height: 340px;
            z-index: 100;
        }


        .add-to-cart {
            width: calc(50% - 25px);
            float: right;
            line-height: 34px;
            background-color: #46b29d;

            color: #ffffff;
            font-size: 1.2rem;
            font-weight: 600;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }



        .cd-item-info {
            padding: 1em .5em 0;
            color: #314d5d;
            font-weight: bold;
        }
        .cd-item-info::after {
            clear: both;
            content: "";
            display: table;
        }
        .cd-item-info strong {
            float: left;
        }
        .cd-item-info em {
            float: right;
            color: #5484a0;
        }
        .cd-item-info a {
            color: #314d5d;
        }
        .cd-item-info a:hover {
            text-decoration: underline;
        }
        .cd-item-info p {
            font-size: 2px;
        }

    </style>

    <script>
        var hasBought=new Array();
        function Commodity(id,num)
        {
            this.id=id;
            this.num=num;
        }
        Commodity.prototype= {
            id:null,
            num:null,
            show:function()
            {
                alert(this.id+" "+this.num);
            }
        }
        function clickToCart(event)
        {
            event.parentElement.parentElement.parentElement.style.backgroundColor="LightSteelBlue";
            event.style.backgroundColor="gray";
            event.innerHTML="已加入购物车";
            event.onclick=null;
            event.previousElementSibling.disabled=true;
            event.previousElementSibling.style.backgroundColor="Gainsboro";
            document.getElementsByName("span").item(0).innerText=new Number(document.getElementsByName("span").item(0).innerText)+1;
            var id=new Number(event.parentElement.parentElement.nextElementSibling.firstElementChild.innerHTML);
            var num=new Number(event.previousElementSibling.value);
            var com=new Commodity(id,num);
            hasBought[hasBought.length]=com;
        }
    </script>
    <script>
        function clickPayment(){
            if(hasBought.length!==0){
                var xhr = new XMLHttpRequest();
                var url="takeorder";
                alert(url)
                xhr.open("post", url, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var res=xhr.responseText
                        if (res ==="null") {
                            alert("请先登陆")
                            location.replace("signin.html");
                        }else{
                            var json=JSON.parse(res);
                            var realprice = json.realprice
                            var balance=json.balance
                            var r=confirm("折后价格"+realprice+"  您的余额为"+balance+"  确认支付吗？")
                            if (r==true){
                                if(realprice>balance) {
                                    alert("余额不足支付失败")
                                    window.location.href = "CommodityList.jsp"
                                }
                                else{
                                    alert("支付成功")

                                    //将order变为有效
                                    var xhr1 = new XMLHttpRequest();
                                    var url1="payment"
                                    xhr1.open("post", url1, true);
                                    xhr1.onreadystatechange=function () {
                                        if (xhr1.readyState == 4 && xhr1.status == 200) {
                                            //跳转到orderlist
                                            window.location.href = "orderlist"
                                        }
                                    }
                                    xhr1.setRequestHeader("post", "application/json")
                                    xhr1.send(res);
                                }
                            }
                            else{
                                alert("订单已取消")
                                window.location.href = "CommodityList.jsp"
                            }
                        }

                    }
                };
                // alert(JSON.stringify(hasBought))
                xhr.setRequestHeader("post", "application/json")
                xhr.send(JSON.stringify(hasBought))
            }

        }
    </script>
    <script>
        function gotoOrderList(){
            window.location.href = "orderlist"
        }
    </script>
    <script >
        function getUserInfo(){
            var xhr = new XMLHttpRequest();
            var url="userinfo";
            xhr.open("post", url, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var res=xhr.responseText
                    alert(res);
                }
            };
            xhr.setRequestHeader("post", "application/json")
            xhr.send()
        }
    </script>
</head>
<body>
<a href="#" class="cd-cart" onclick="clickPayment()" >
    <span name="span">0</span>
    <p style="position: absolute;top:40px;right: 0px ;font-size: 1rem;font-weight: bold;color: black">付款</p>
</a>
<a href="#" class="orders" onclick="gotoOrderList()" >
    <p style="position: absolute;top:40px;right: 0px ;font-size: 1rem;font-weight: bold;color: black">已有订单</p>
</a>
<a href="#" class="userInfo" onclick="getUserInfo()" >
    <p style="position: absolute;top:40px;right: 0px ;font-size: 1rem;font-weight: bold;color: black">查看用户人数</p>
</a>

<form action="logout" method="post" >
    <!--<img src="url(https://image.flaticon.com/icons/svg/157/157899.svg)" style="size: 5px 3px">-->
    <input type="image" src="https://image.flaticon.com/icons/svg/248/248929.svg" style="height: 40px"><p style="font-size: 3px">&nbsp&nbsp&nbsp&nbsp登出</p>
</form>

<p style="position: fixed;z-index: 100;top: 300px;right: 10px;color:#778899;font-size:3px;text-align:left;
border-left: 8px double #B0C4DE;" >
    累计金额<br/>200～400元：<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp9折优惠<br/>400元以上：<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp8折优惠</p>

<ul class="cd-gallery">
    <%
        ArrayList<Commodity> commodityList = ((CommodityListBean) session.getAttribute("commodityListBean")).getCommodityList();
        for(Commodity commodity:commodityList) {
    %>
    <li name="commodity" style="position: relative; height: 470px;padding: 10px;background-color: white;list-style:none;">

        <div class="cd-single-item">
            <img src="<%=commodity.getUrl()%>"  style="z-index: -10; position: relative;" width="330" height="330" alt="commodities image">
        </div>
        <div>
            <p style="font-family:verdana;color:gray;font-size:2px">&nbsp&nbsp选择购买数量(1~99) :<input style="z-index: 100" type="number" value="1" min="1" max="99">
                <button class="add-to-cart" onclick="clickToCart(this)">
                    <strong>加入购物车</strong>
                </button>
        </div>
        <div class="cd-item-info">
            <p style="height: 3px"><%=commodity.getCommodityID()%></p><strong><a><%=commodity.getCommodityName()%></a></strong>
            <em><%=commodity.getCommodityPrice()%></em>
        </div>
    </li>
    <%
        }
    %>

</ul>

</body>
</html>
