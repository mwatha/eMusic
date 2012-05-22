
function addToCart(product_id) {       
  try {                                       
    var quantity = document.getElementById("order_quantity").value;             
  }catch(e){
    quantity = 1;
  }

  var html = "";

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp=new XMLHttpRequest();                                             
    }else{// code for IE6, IE5                                                  
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");                           
    }                                                                           
    xmlhttp.onreadystatechange=function() {                                     
      if (xmlhttp.readyState===4 && xmlhttp.status===200) {                       
        var results = eval(xmlhttp.responseText);     
        if(results) {
          for(var i=0; i < results.length; i++) {
            var product = String(results[i]);
            var name = product.split("::")[0];
            var title = product.split("::")[1];
            var product_id = product.split("::")[3];
            if(name !== "" || name == null){
              var qty = parseInt(product.split("::")[2]);
              html += "<li><a href='/products/view/" + product_id + "'>" + name.substring(0,17) + ":" + title.substring(0,17) + ":" + qty + "</a></li>";
            }
          }
        }                               
        if(results) {
          var html2 = "<a class='dropdown-toggle' href='#' data-toggle='dropdown'>Cart&nbsp;(" + results.length + ")<b class='caret'></b></a>";
          if(results.length > 0) {
            html2 += "<ul class='dropdown-menu'>";
            html2 += html;
            html2 += "<li><a href='/order/view'>Finish shopping</a></li>";
            html2 += "<li><a href='javascript:clearCart();'>Clear Cart</a></li>";
            document.getElementById("cart").innerHTML = html2;          
          }
        }                                                                         
      }                                                                         
    } 
    
              
                                                                              
    var url = "/application/add_to_cart?id=album&product_id=" + product_id + "&quantity=" + quantity;
    xmlhttp.open("GET",url,true); 
    xmlhttp.send();
  } 


  addToCart(0);



  function clearCart() {
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari  
      xmlhttp=new XMLHttpRequest();                                             
    }else{// code for IE6, IE5                                                  
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");                           
    }                                                                           
    xmlhttp.onreadystatechange=function() {                                     
      if (xmlhttp.readyState===4 && xmlhttp.status===200) {                     
        var results = eval(xmlhttp.responseText);                               
        if(results) {                                                           
          var html = "<a class='dropdown-toggle' href='#' data-toggle='dropdown'>Cart&nbsp;(0)<b class='caret'></b></a>";
          document.getElementById("cart").innerHTML = html;          
        }                                                                       
      }                                                                         
    }            
                                                                              
    var url = "/application/clear_cart";
    xmlhttp.open("GET",url,true); 
    xmlhttp.send();
  } 
