/* THIS script contains a bunch of snippets to make a startup script:
 * We need to ensure that:
 * 1. The brower is firefox >= 3.6 (soon v4)
 * 2. That popups are enabled
 * 3. That javascript is enabled
 * 4. That cookies are enabled
 * 5. Other??
 * Otherwise graceful shutdown.
 * 
 * @todo
 */
<div id="example"></div>

<script type="text/javascript">

txt = "<p>Browser CodeName: " + navigator.appCodeName + "</p>";
txt+= "<p>Browser Name: " + navigator.appName + "</p>";
txt+= "<p>Browser Version: " + navigator.appVersion + "</p>";
txt+= "<p>Cookies Enabled: " + navigator.cookieEnabled + "</p>";
txt+= "<p>Platform: " + navigator.platform + "</p>";
txt+= "<p>User-agent header: " + navigator.userAgent + "</p>";

document.getElementById("example").innerHTML=txt;

</script>
<script type="text/javascript">
document.write('Javascript is enabled');
</script>
<noscript>Javascript is disabled</noscript>

OR

<noscript>
    <style type="text/css">
        .pagecontainer {display:none;}
      page container is the whole of application.html.erb
    </style>
    <div class="noscriptmsg">
    You don't have javascript enabled.  Good luck with that.
    </div>
</noscript>

Detect if popups are enabled

<a href="page.html" target="_blank"
onclick="w=window.open(this.href,this.target,'width=400,height=500');
return w?false:true">Popup</a>

