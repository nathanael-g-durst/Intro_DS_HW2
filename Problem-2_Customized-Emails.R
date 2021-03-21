############### IMPORT LIBRARIES ###############

library(blastula)
library(ggplot2)

############### DATA EMAILS RECIPIENTS ###############

########## Test Code

# rowNames <- c("firstName", "lastName", "gender", "age", "email", "address")
# mailingList <- data.frame(row.names = rowNames)

########## END Test Code

############### GENERATE CONTENT EMAIL ###############

########## GGPLOT ##########

df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)
ds <- do.call(rbind, lapply(split(df, df$gp), function(d) {
  data.frame(mean = mean(d$y), sd = sd(d$y), gp = d$gp)
}))

plot_object <-
  ggplot(df, aes(gp, y)) +
    geom_point() +
    geom_point(data = ds, aes(y = mean), colour = 'red', size = 3)

cta_button <- add_cta_button("https://nathanael-durst.com", "Visit my website !", align = "center")


############### GENERATE EMAIL ###############

email <-
  compose_email(
    
    #Header
    header =
      blocks(
        block_title("Title"),
      ),
    
    #Body
    body = 
      blocks(
        block_articles(
          article(
            image = "https://i.imgur.com/XMU8yJa.jpg",
            title = "Test article 1",
            content = "This is a test!",
          ),
          article(
            image = "https://i.imgur.com/XMU8yJa.jpg",
            title = "Test article 1",
            content = "This is a test!",
          )
        ),
        block_text("Thanks for reading! Find us here:"),
        md(cta_button),
        block_spacer(),
        add_ggplot(
          plot_object,
          width = 5, height = 5,
          alt = NULL,
          align = c("center", "left", "right", "inline"),
          float = c("none", "left", "right")
        ),
      ),
    
    #Footer
    footer = 
      blocks(
        block_text("Thanks for reading! Find us here:", align = "center"),
        block_spacer(),
        block_social_links(
          social_link(service = "github", link = "https://github.com/nathanael-g-durst/Intro_DS_HW2"),
        )
      )
  )

############### PREVIEW EMAIL ###############

if (interactive()) email

############### SEND EMAIL ###############

#Check if the keyring package is installed :
installedPackages <- installed.packages()
keyringPackage <- is.element("keyring", installedPackages)

#Install keyring if not installed
if(keyringPackage != TRUE){
  install.packages("keyring")
}

#Set the password as an environmental variable
Sys.setenv(pass = "_$wIEfL_?&55-,!N~6")

##### /!\ This should not be done (security risk) /!\ #####
######### I'm using a dummy account created for this purpose only which will be deleted afterward.

#Generate credentials
credentials <-
  creds_envvar(
    user = "introds@introds.durst-webmaster.fr",
    pass_envvar = "pass",
    host = "introds.durst-webmaster.fr",
    port = "465",
    use_ssl = TRUE,
  )

#Send e-mail

email %>%
  smtp_send(
    from = "IntroDS@introds.durst-webmaster.fr",
    to = "nathanael.durst@gmail.com",
    subject = "Testing the `smtp_send()` function",
    credentials = credentials,
  )
