# Test Shiny authentication from an external application locally
This repository should be used for testing Shiny applications that require authentication from external applications (e.g. Laravel platforms), without the need to setup the other application locally.

This application does the following:

- It includes an iframe that should render your main Shiny app. It points to the url given

## How to setup:

1. Clone this repository alongside the shiny application you wish to test.
 - e.g. if your Shiny application is at `your-user-folder/projects/your-shiny-app`, clone this into `your-user-folder/projects/test-laravel-proxy`:
 - in Powershell:
```
cd ~
git clone ...
```

2. Create a ".sessions" folder in the same projects folder. This will be the folder that your main Shiny app should write session url files to.

3. Run `renv::restore()` to setup the library dependencies for this application.


## How to Run:
To test your main app responds correctly to the authentication POST requests, you need to run both apps at the same time on different ports. Do the following:

1. In one R session, run your main Shiny app on port 7008: `runApp(port=7008)`
2. In another R session, run this app on port 7009: `runApp(port=7009)`.

To secure your main shiny app, it should be setup such that no private data is shown when running normally (http://127.0.0.1:7008), but all data *is* shown when running inside the iframe within this Shiny app (http://127.0.0.1:7009).

