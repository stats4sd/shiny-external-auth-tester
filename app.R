library(shiny)
library(shinyjs)
library(httr)

main_app <- "http://127.0.0.1:7008"

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
                            alert("nope")
                            return;
                        }
                        alert(event.data);
                        Shiny.setInputValue("session", event.data);
                    }, false)
                ')
            )
        )
    ),

    # a hidden input, for JavaScript to manipulate and communicate with the R server:
    hidden(passwordInput("session", "session")),

    tags$div(
        HTML('<iframe src="http://127.0.0.1:7008" id="shiny"
    title="Shiny Dashboard"
    height="1000px"
    width="100%"
    style="border:0"
     ></iframe>')
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