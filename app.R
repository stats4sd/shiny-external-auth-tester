library(shiny)
library(shinyjs)
library(httr)
library(dotenv)

main_app <- Sys.getenv("MAIN_SHINY_URL")

ui <- fluidPage(
    useShinyjs(),
    ## listen for communications from the child page
    tags$head(
        tags$script(
            HTML(
                paste0('
                    window.addEventListener("message", function(event) {
                        // only accept messages from the shiny app
                        if(event.origin !== "', main_app, '") {
                            alert("the event origin was incorrect. Please check your MAIN_SHINY_URL is correct.")
                            return;
                        }
                        Shiny.setInputValue("session", event.data);
                    }, false)
                ')
            )
        )
    ),

    # a hidden input, for JavaScript to manipulate and communicate with the R server:
    hidden(passwordInput("session", "session")),

    tags$h1(
        "TESTING PAGE"
    ),
    tags$p(
        "The iframe below should render the main Shiny app you are testing. Then, that app Should send the request to authenticate via JavaScript. This app will receive the request, look for the correct information in the file system, and then send the POST request back to authenticate."
    ),
    tags$div(
        HTML(paste0('<iframe src="', Sys.getenv('MAIN_SHINY_URL'), '" id="shiny"
    title="Shiny Dashboard"
    height="1000px"
    width="100%"
    style="border:0"
     ></iframe>'))
    )
)

server <- function(input, output, session) {

    observeEvent(input$session, {
        print(input$session)
        if(input$session != "") {
            ## find the url based on the session, then post to the 'main' shiny app
            fileConn <- file(paste0("../.sessions/", input$session))
            url <- readLines(fileConn)
            print(url)
            ## Always authenticate :)
            POST(url)

        }
     })

}

shinyApp(ui = ui, server = server)