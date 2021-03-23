###########################################################################
#####                                                                 #####
#####   Check out the 94 other emails sent by :                       #####
#####                                                                 #####
#####   1) Visiting :         https://webmail.durst-webmaster.fr/     #####
#####   2) Adresse e-mail :   results@introds.durst-webmaster.fr      #####
#####   3) Mot de passe :     ^q5bxQQ[mw_2Wg!Twn                      #####
#####                                                                 #####
###########################################################################

# Requirements

## Packages

### Check if installed, install it if not and load library
installedPackages <- installed.packages()

#### Add here the packages needed #################################################
packagesNeeded <- c("keyring", "blastula", "zoo", "xts", "lubridate", "ggplot2")
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
dataClients <- read.csv("dataClients22032021.csv", header = TRUE, sep =";")
dataVisits <- read.csv("dataVisits22032021.csv", header = TRUE, sep =";")

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
    host = "introds.durst-webmaster.fr",
    port = "465",
    use_ssl = TRUE,
  )

# Static parts of the e-mail

## Generate the e-mail's header
Sys.setlocale("LC_ALL", "English")
mailMonth <- format(Sys.Date(), "%B")
mailSubject <- paste("Durst Webmaster's ", mailMonth, " Newsletter")
mailSender <- c("Adel Ben Snoussi - El-Amine Maamar - Nathanaël Dürst" = "introds@introds.durst-webmaster.fr")

## Header
header <- 
  blocks(
    add_image("https://nathanael-durst.com/documents/Logo%20800x800%20-%20Dark.png", alt = "Dürst Webmaster's Logo", width = 400, align = "center"),
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
##### Edit for it to work no mater the day it's executed  (lack of data)
# currentMonth <- month(today)
# currentDay <- day(today)
currentMonth <- 3
currentDay <- 22

rowsMonth <- currentMonth+1
rowsDayS <- rowsMonth+1
rowsDayE <- currentDay+rowsMonth

monthList <- month.name
dayList <- 1:currentDay

#### Plot
titlePlot <- paste("Plot of your company's website number of daily visitors in", mailMonth)

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
  ##### Edit for it to work no mater the day it's executed  (lack of data)
  # date_time <- add_readable_time()
  date_time <- "Monday, March 22, 2021 at 6:57 PM (CET)"
  mailMonth <- "March"
  websiteStatMonth <- paste("Here's a graph of the number of visitors ", company, "website received during the month of", mailMonth, "up to :", date_time)

  ## Client's site visitors
  
  ### Get data
  monthlyVisitors <- as.vector(dataVisits[i,2:rowsMonth], mode ="integer")
  dailyVisitors <- as.vector(dataVisits[i,rowsDayS:rowsDayE], mode ="integer")
  dailyDataFrame <- data.frame("Days of the month" = dayList, "Number of visitors" = dailyVisitors)
  mean <- round(mean(dailyVisitors))
  meanDaily <- rep(mean, currentDay)
  meanDaily <- data.frame("Days of the month" = dayList, "Mean" = meanDaily)
  subtitle <- paste("Your website is getting traction with a daily average of", mean, "visitors.")
  
  ### Plot
  dailyPlot <- ggplot(data = dailyDataFrame, aes(x = Days.of.the.month, y = Number.of.visitors, group = 1))+ 
    geom_line(linetype = "dashed", color = "steelblue")+
    geom_point(color = "black")+
    geom_line(data=meanDaily,  mapping=aes(x = Days.of.the.month, y = Mean), col="red")+
    labs(title = "Your website's number of visitors daily", subtitle = subtitle)+
    xlab("Days of the month")+
    ylab("Number of visitors")

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
      block_text(md("## This month's spotlight :")),
      spotlight,
      block_text(md("## Thank you !")),
      block_text("To thank you for your thrust in our company, we would like to offer you a small token of appreciation :"),
      md(offer),
      block_spacer(),
      block_text(md("## Statistics :")),
      block_text(websiteStatMonth),
      add_ggplot(
        dailyPlot,
        width = 6, height = 4,
        alt = titlePlot,
        align = "center",
      ),
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
  ## Send the e-mail
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
  
}

# Preview of the last e-mail sent
if (interactive()) email

# ## Send test e-mail to nathanael.duerst@etu.unige.ch
email %>%
  smtp_send(
    from = mailSender,
    to = emailClient,
    subject = mailSubject,
    credentials = credentials,
  )

# Clean environment

## Static
rm(today, credentials, mailMonth, mailSubject, mailSender, offer10, offer20, offer30, offer50, spotlight)

## Loop

### Text
rm(i, lastName, firstName, gender, companyName, emailClient, clientSince, greetings, name, offer,
   company, websiteStatMonth, body, email, header, footer)

## Stats
rm(currentDay, currentMonth, dailyVisitors, date_time, dayList, mean, monthList, monthlyVisitors, rowsDayS,
   rowsDayE, rowsMonth, subtitle, titlePlot, dailyDataFrame, dailyPlot, meanDaily)