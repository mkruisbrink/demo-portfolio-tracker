
# DEMO PORTFOLIO TRACKER
Totally bare portfolio tracker that can be improved a lot. Should be considered a work in progres. Tips and constructive feedback highly sought after.

  * obtain your *own* Nomics API key via: [nomics.com](https://p.nomics.com/cryptocurrency-bitcoin-api)
  * create your own position and ticker lists in the `create-portfolio.R` scripts
  * replace the `Sys.getenv()` variable in the API call in `create-portfolio.R` with your Nomics API key
    * if you intend to share your code or want to upload to a repo, I recommend that you make a local `.Renviron` file and add your key as a system variable. That way you can store it without exposing your key (like I did here).
    * add the .Renviron file to your .gitignore file if you're using git.

## scripts
Contains all the required scripts. Edit `create-portfolio.R` and run `main.R` to run all scripts in tandem and render the dashboard after.

## data
Contains outputs of the portfolio tracker, portfolio snapshot and ticker data for use in the `.Rmd` file to create the dashboard.
    
## docs
The dashboard is hosted from this specific folder, you can ignore it for now.


  
