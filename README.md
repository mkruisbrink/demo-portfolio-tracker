# Demo Portfolio Tracker
This is a stripped down and totally bare portfolio tracker that can be improved a lot and it should be considered a work in progress. Tips and constructive feedback are therefore highly sought after.

I wanted to migrate away from the Google Sheet that I was using and figured I could do it in R since I'm taking R courses and I'm loving R so far.

## Important
These are steps you have to take to get this working for yourself.

  * obtain your *own* Nomics API key via: [nomics.com](https://p.nomics.com/cryptocurrency-bitcoin-api)
  * create your own position and ticker lists in the `create-portfolio.R` scripts
  * replace the `Sys.getenv()` variable in the API call in `create-portfolio.R` with your Nomics API key
    * if you intend to share your code or want to upload to a repo, I recommend that you make a local `.Renviron` file and add your key as a system variable. That way you can store it without exposing your key (like I did here).
    * add the .Renviron file to your .gitignore file if you're using git.

## Contents
A short description of what is what exactly.

### index.Rmd
This file compiles the dashboard and takes data from the data folder as input.

### scripts
Contains all the required scripts. Edit `create-portfolio.R` and run `main.R` to run all scripts in tandem and render the dashboard after.

#### libraries.R
This scripts loads all required libraries.

#### create-portfolio.R
This is where you will construct your positions and perform the Nomics API call to obtain prices for your portfolio.

#### main.R
This is the only script you will need to run if you want to *manually* update the portfolio. It runs all the other scripts and can update the dashboard.

#### task-scheduler.R
This script can automatically update your portfolio on whatever interval you wish. Note that it is currently set-up for windows machines. My personal tracker was configured to run a daily update at 12:00 and my computer ran the `main.R` script every day at 12:00 sharp. 

I did this so I automatically had an additional snapshot of that days value added to the `pf_snapshot.csv` file. It constructs an historical overview of data that is shown in one of the charts. You can manually update this .csv file and the tracker will append the snapshotted data.

### data
Contains neat .csv files for the portfolio tracker itself, the ticker data used and includes a snapshot list which are all used to create the dashboard in the `.Rmd` file.
    
### docs
The live demo dashboard is hosted from this specific folder, you can ignore it for now.



  
