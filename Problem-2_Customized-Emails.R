# Requirements

## Load libraries
library("zoo")

## Check if the keyring package is installed :
installedPackages <- installed.packages()
keyringPackage <- is.element("keyring", installedPackages)

## Install keyring if not installed
if(keyringPackage != TRUE){
  install.packages("keyring")
}

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
mailSubject <- paste("Dürst Webmaster's ", mailMonth, " Newsletter")
mailSender <- c("Adel Ben Snoussi - El-Amine Maamar - Nathanaël Dürst" = "introds@introds.durst-webmaster.fr")

## Header
header <- 
  blocks(
    add_image("https://nathanael-durst.com/documents/Logo%20800x800%20-%20Dark.png", alt = "Dürst Webmaster's Logo", width = 400, align = "center"),
  )

## Body

### Offer
offer10 <- add_cta_button("https://nathanael-durst.com?reduction=10", "10% off from  !", align = "center")
offer20 <- add_cta_button("https://nathanael-durst.com?reduction=20", "20% off from  !", align = "center")
offer30 <- add_cta_button("https://nathanael-durst.com?reduction=30", "30% off from  !", align = "center")
offer50 <- add_cta_button("https://nathanael-durst.com?reduction=50", "50% off from  !", align = "center")

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
  email <- dataClients[i, "email"]
  
  ### Number of month since the beginning of the relationship
  clientSince <- as.Date(dataClients[i, "clientSince"])
  clientSince <- round((as.yearmon(strptime(today, format = "%Y-%m-%d"))
                        -as.yearmon(strptime(clientSince, format = "%Y-%m-%d")))*12)
  
  ## Client's site visitors
  
  ## Generate the e-mail's content
  
  ### Greetings depending on the gender and name of the client
  if (gender == "Male") {
    greetings <- paste("Dear Sir ", lastName, ",", sep = "")
  } else if (gender == "Female") {
    greetings <- paste("Dear Madam ", lastName, ",", sep = "")
  } else {
    name <- paste(firstName, lastName)
    greetings <- paste("Dear ", name, ",", sep = "")
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
  websiteText <- paste("Please find below", company, "website statistics for the month of", mailMonth, ":")
  
  ### Body
  body <-
    blocks(
      block_title(md(mailSubject)),
      block_text(md(greetings)),
      md(offer),
      block_spacer(),
      block_text(websiteText)
      
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
  # ## Send the e-mail
  # email %>%
  #   smtp_send(
  #     from = mailSender,
  #     to = email,
  #     subject = mailSubject,
  #     credentials = credentials,
  #   )
  ##########################################################    
  ########################################################## 
  #              DO NOT REMOVE THE COMMENT                 #
  ##########################################################    
  ##########################################################
  
}

############### PREVIEW EMAIL ###############

if (interactive()) email