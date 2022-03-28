# Test Shiny authentication from an external application locally
This repository should be used for testing Shiny applications that require authentication from external applications (e.g. Laravel platforms), without the need to setup the other application locally.

## How to setup:

1. Clone this repository alongside the shiny application you wish to test.
 - e.g. if your Shiny application is at `your-user-folder/projects/your-shiny-app`, clone this into `your-user-folder/projects/test-laravel-proxy`:
 - in Powershell:
```
cd ~
git clone ...
```

2. Create a ".sessions" folder in the same projects folder. This will be the folder that your main Shiny app should write session url files to.

3.