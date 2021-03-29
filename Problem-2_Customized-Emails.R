#################################################################################################
#####                                                                                       #####
#####   Check out the 90 other emails sent by :                                             #####
#####                                                                                       #####
#####   1) Visiting :         https://webmail.durst-webmaster.fr/                           #####
#####   2) Adresse e-mail :   results@introds.durst-webmaster.fr                            #####
#####   3) Mot de passe :     ^q5bxQQ[mw_2Wg!Twn                                            #####
#####                                                                                       #####
#####   In case of SSL_ERROR_BAD_CERT_DOMAIN, it's just me being bad with SSL certificates. #####
#####   It's hopefully fixed by the time you're reading this.                               #####
#####                                                                                       #####
#################################################################################################

# Requirements

## Packages

### Check if installed, install it if not and load library
installedPackages <- installed.packages()

#### Add here the packages needed #################################################
packagesNeeded <- c("keyring", "blastula", "zoo", "xts", "lubridate",
                    "ggplot2", "shiny")
###################################################################################

for (packageName in packagesNeeded) {
  packageExists <- is.element(packageName, installedPackages)
  if(packageExists != TRUE){
    install.packages(packageName)
    library(packageName, character.only = TRUE)
    print(paste(packageName, "has been installed and the library is loaded !"))
  } else {
    library(packageName, character.only = TRUE)
    print(paste(packageName, "is installed and the library is loaded !"))
  }
}

### Clean environment
rm(installedPackages, packageName, packagesNeeded, packageExists)

## Import data
dataClients <- read.csv("dataClients22032021.csv", header = TRUE, sep =",")
dataVisits <- read.csv("dataVisits.csv", header = TRUE, sep =",")

## Date of today
today <- Sys.Date()

## Set the password as an environmental variable
Sys.setenv(pass = "_$wIEfL_?&55-,!N~6")
##### /!\ This should not be done (security risk) /!\ #####
######### I'm using a dummy account created for this purpose only which will be deleted afterward.

## Generate credentials
credentials <-
  creds_envvar(
    user = "introds@introds.durst-webmaster.fr",
    pass_envvar = "pass",
    host = "mail.durst-webmaster.fr",
    port = "465",
    use_ssl = TRUE,
  )

# Static parts of the e-mail

## Generate the e-mail's header
Sys.setlocale("LC_ALL", "English")
mailMonth <- format(Sys.Date(), "%B")
mailSubject <- paste("Durst Webmaster's ", mailMonth, " Newsletter")
mailSender <- c("Adel Ben Snoussi - El-Amine Maamar - Nathanael Durst" = "introds@introds.durst-webmaster.fr")

## Header
header <- 
  blocks(
    add_image("https://nathanael-durst.com/documents/Logo%20800x800%20-%20Dark.png", alt = "Durst Webmaster's Logo", width = 400, align = "center"),
  )

## Body

### Offer
offer10 <- add_cta_button("https://nathanael-durst.com?reduction=10", "Get 10% off from your Instabot.py's installation !", align = "center")
offer20 <- add_cta_button("https://nathanael-durst.com?reduction=20", "Get 20% off from your Instabot.py's installation !", align = "center")
offer30 <- add_cta_button("https://nathanael-durst.com?reduction=30", "Get 30% off from your Instabot.py's installation !", align = "center")
offer50 <- add_cta_button("https://nathanael-durst.com?reduction=50", "Get 50% off from your Instabot.py's installation !", align = "center")

### Spotlight
spotlight <-
  block_articles(
    article(
      image = "https://nathanael-durst.com/documents/insta.png",
      title = "Instabot.py",
      content =
        "Boost your presence on Intagram with Instagram.py! 
        It is an extremely light instagram bot that uses the undocumented Web API.  
        Unlike other bots, Instabot.py does not require Selenium or a WebDriver.culture, and high-tech development.
        We can provide assistance to set up the bot and will gadly help you with your digital marketing strategy."
    ),
    article(
      image = "https://nathanael-durst.com/documents/ovh.png",
      title = "Fire at OVH",
      content =
        "As you may have heard, there has been a fire at one of OVH's datacenters. 
        Millions of websites have been affected by it and some event went offline. 
        We have been monitoring the situation and will be in touch with those affected.
        It is good to remember that every website we create are backed up each day 
        on distants server to avoid any data loss."
    )
  )

### Stats

#### Data row selection
currentDay <- day(today)
rowsDayS <- 2
rowsDayE <- currentDay+1
dayList <- 1:currentDay

### Survey
survey <- md("
<div><!--[if mso]>
  <v:roundrect xmlns:v='urn:schemas-microsoft-com:vml' xmlns:w='urn:schemas-microsoft-com:office:word' href='http://introds.durst-webmaster.fr/answer.php?answer=%22Excellent%22' style='height:40px;v-text-anchor:middle;width:120px;' arcsize='14%' strokecolor='#1e3650' fillcolor='#006400'>
    <w:anchorlock/>
    <center style='color:#ffffff;font-family:sans-serif;font-size:13px;font-weight:bold;'>Excellent</center>
  </v:roundrect>
<![endif]--><a href='http://introds.durst-webmaster.fr/answer.php?answer=%22Excellent%22'
style='background-color:#006400;border:1px solid #313131;border-radius:4px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:13px;font-weight:bold;line-height:40px;text-align:center;text-decoration:none;width:120px;-webkit-text-size-adjust:none;mso-hide:all;'>EXCELLENT</a>
<!--[if mso]>
  <v:roundrect xmlns:v='urn:schemas-microsoft-com:vml' xmlns:w='urn:schemas-microsoft-com:office:word' href='http://introds.durst-webmaster.fr/answer.php?answer=%22Good%22' style='height:40px;v-text-anchor:middle;width:120px;' arcsize='14%' strokecolor='#313131' fillcolor='#338333'>
    <w:anchorlock/>
    <center style='color:#ffffff;font-family:sans-serif;font-size:13px;font-weight:bold;'>GOOD</center>
  </v:roundrect>
<![endif]--><a href='http://introds.durst-webmaster.fr/answer.php?answer=%22Good%22'
style='background-color:#338333;border:1px solid #313131;border-radius:4px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:13px;font-weight:bold;line-height:40px;text-align:center;text-decoration:none;width:120px;-webkit-text-size-adjust:none;mso-hide:all;'>GOOD</a>
<!--[if mso]>
  <v:roundrect xmlns:v='urn:schemas-microsoft-com:vml' xmlns:w='urn:schemas-microsoft-com:office:word' href='http://introds.durst-webmaster.fr/answer.php?answer=%22Fair%22' style='height:40px;v-text-anchor:middle;width:120px;' arcsize='14%' strokecolor='#313131' fillcolor='#cc6600'>
    <w:anchorlock/>
    <center style='color:#ffffff;font-family:sans-serif;font-size:13px;font-weight:bold;'>FAIR</center>
  </v:roundrect>
<![endif]--><a href='http://introds.durst-webmaster.fr/answer.php?answer=%22Fair%22'
style='background-color:#cc6600;border:1px solid #313131;border-radius:4px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:13px;font-weight:bold;line-height:40px;text-align:center;text-decoration:none;width:120px;-webkit-text-size-adjust:none;mso-hide:all;'>FAIR</a>
<!--[if mso]>
  <v:roundrect xmlns:v='urn:schemas-microsoft-com:vml' xmlns:w='urn:schemas-microsoft-com:office:word' href='http://introds.durst-webmaster.fr/answer.php?answer=%22Poor%22' style='height:40px;v-text-anchor:middle;width:120px;' arcsize='14%' strokecolor='#313131' fillcolor='#804000'>
    <w:anchorlock/>
    <center style='color:#ffffff;font-family:sans-serif;font-size:13px;font-weight:bold;'>POOR</center>
  </v:roundrect>
<![endif]--><a href='http://introds.durst-webmaster.fr/answer.php?answer=%22Poor%22'
style='background-color:#804000;border:1px solid #313131;border-radius:4px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:13px;font-weight:bold;line-height:40px;text-align:center;text-decoration:none;width:120px;-webkit-text-size-adjust:none;mso-hide:all;'>POOR</a></div>
")
######## Used Bulletproof email buttons by @stigm (https://buttons.cm/) to make sure it works on every mail client

## Footer
footer <-
  blocks(
    block_text("Thanks for reading! Find us here:", align = "center"),
    block_spacer(),
    block_social_links(
      social_link(service = "website", link = "https://durst-webmaster.fr/", variant = "dark_gray"),
      social_link(service = "facebook", link = "https://fr-fr.facebook.com/DurstWebmaster", variant = "dark_gray"),
      social_link(service = "instagram", link = "https://www.instagram.com/durstwebmaster/", variant = "dark_gray"),
      social_link(service = "linkedin", link = "https://www.linkedin.com/company/durst-webmaster/", variant = "dark_gray"),
      social_link(service = "github", link = "https://github.com/nathanael-g-durst/Intro_DS_HW2", variant = "dark_gray"),
    )
  )

#Mass mailling
for(i in dataClients$id){
  
  ## Get the client's information
  
  ### Text
  lastName <- dataClients[i, "lastName"]
  firstName <- dataClients[i, "firstName"]
  gender <- dataClients[i, "gender"]
  companyName <- dataClients[i, "companyName"]
  emailClient <- dataClients[i, "email"]
  
  ### Number of month since the beginning of the relationship
  clientSince <- as.Date(dataClients[i, "clientSince"])
  clientSince <- round((as.yearmon(strptime(today, format = "%Y-%m-%d"))
                        -as.yearmon(strptime(clientSince, format = "%Y-%m-%d")))*12)

  ## Generate the e-mail's content

  ### Greetings depending on the gender and name of the client
  if (gender == "Male") {
    greetings <- paste("**Dear Sir ", lastName, ",**", sep = "")
  } else if (gender == "Female") {
    greetings <- paste("**Dear Madam ", lastName, ",**", sep = "")
  } else {
    name <- paste(firstName, lastName)
    greetings <- paste("**Dear ", name, ",**", sep = "")
  }

  ### Promotion percentage depending on the fidelity of the client (1/3/5 or more years)
  if (clientSince <= 12) {
    offer <- offer10
  } else if (clientSince <= 36) {
    offer <- offer20
  } else if (clientSince <= 60) {
    offer <- offer30
  } else {
    offer <- offer50
  }

  ### Company name
  company <- paste(companyName, "'s", sep = "")
  mailMonth <- "March"
  websiteStatMonth <- paste("Here's a graph representing the number of visitors your company's website received during the month of", mailMonth, "up to today.")
  
  ## Client's site visitors
  
  ### Get data
  dailyVisitors <- as.vector(dataVisits[i,rowsDayS:rowsDayE], mode ="integer")
  dailyDataFrame <- data.frame("Days of the month" = dayList, "Number of visitors" = dailyVisitors)
  totalVisitors <- sum(dailyVisitors)
  mean <- round(mean(dailyVisitors))
  meanDaily <- rep(mean, currentDay)
  meanDaily <- data.frame("Days of the month" = dayList, "Mean" = meanDaily)
  titlePlot <- paste(company, "number of visitors daily in", mailMonth)
  subtitlePlot <- paste("Daily average of", mean, "visitors and a total of", totalVisitors, "visitors so far.")
  
  ### Plot
  dailyPlot <- ggplot(data = dailyDataFrame, aes(x = Days.of.the.month, y = Number.of.visitors, group = 1))+ 
    geom_line(linetype = "dashed", color = "steelblue")+
    geom_point(color = "black")+
    geom_line(data=meanDaily,  mapping=aes(x = Days.of.the.month, y = Mean), col="red")+
    labs(title = titlePlot, subtitle = subtitlePlot)+
    xlab("Days of the month")+
    ylab("Number of visitors")+
    scale_x_continuous(breaks = dayList)

  ### Body
  body <-
    blocks(
      block_title(md(mailSubject)),
      block_text(md(greetings)),
      block_text(
        "We are pleased to announce you that our latest newsletter is out ! 
        Today we will be talking about a way to increase your Instagram's 
        account growth and the incident that happened at OVH. 
        As always, you will find the data regarding the number of visitors 
        your company's website received at the end of this e-mail."
      ),
      block_spacer(),
      block_text(md("## This month's spotlight :")),
      spotlight,
      block_spacer(),
      block_text(md("## Thank you !")),
      block_text("To thank you for your trust, we would like to offer you a small token of appreciation :"),
      md(offer),
      block_spacer(),
      block_text(md("## Statistics :")),
      block_text(websiteStatMonth),
      block_spacer(),
      add_ggplot(
        dailyPlot,
        width = 6, height = 4,
        alt = titlePlot,
        align = "center",
      ),
      block_spacer(),
      block_text(md("## Survey :")),
      block_text("How would you rate your overall satisfaction of our services ?"),
      survey,
      block_spacer(),
      block_text(md("**Yours sincerely,**")),
      block_text(md("<p style='text-align: right; font-weight: bold;'>The Team at Durst Webmaster</p>"))
    )
  
  ## Compose the e-mail
  email <-
    compose_email(
      header = header,
      body = body,
      footer = footer,
    )

  ##########################################################    
  ########################################################## 
  #              DO NOT REMOVE THE COMMENT                 #
  ##########################################################    
  ##########################################################  
  # # Send the e-mail
  # email %>%
  #   smtp_send(
  #     from = mailSender,
  #     to = emailClient,
  #     subject = mailSubject,
  #     credentials = credentials,
  #   )
  ##########################################################    
  ########################################################## 
  #              DO NOT REMOVE THE COMMENT                 #
  ##########################################################    
  ##########################################################

  print(i)

}

# Preview of the last e-mail sent
if (interactive()) email

## Replace "xxx@xxx.com" with an email address and un-comment the following section to send a test e-mail
# email %>%
#   smtp_send(
#     from = mailSender,
#     to = "xxx@xxx.com",
#     subject = mailSubject,
#     credentials = credentials,
#   )

# Clean environment

## Static
rm(today, credentials, mailMonth, mailSubject, mailSender, offer10, offer20, offer30, offer50, spotlight)

## Loop

### Text
rm(i, lastName, firstName, gender, companyName, emailClient, clientSince, greetings, name, offer,
   company, websiteStatMonth, body, email, header, survey, footer)

## Stats
rm(currentDay, dailyVisitors, totalVisitors, dayList, mean, rowsDayS,
   rowsDayE, titlePlot, subtitlePlot, dailyDataFrame, dailyPlot, meanDaily)
