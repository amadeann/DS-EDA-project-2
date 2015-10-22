# Check whether the file to be downloaded already exists and if not, download it

destFile <- "pollutant.zip"
file1 <- "Source_Classification_Code.rds"
file2 <- "summarySCC_PM25.rds"


if(!file.exists(destFile)&(!file.exists(file1)|!file.exists(file2))) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileUrl, destfile = destFile, method = "wget")
    message(paste(destFile, "file downloaded"))
} else {
    message(paste(destFile, "file already existed or files", file1, "and", file2, "already existed"))   
}

# check whether the file was already extracted. If not, extract it.

if(!file.exists(file1)|!file.exists(file2)) {
    unzip(destFile)
    message(paste(destFile, "extracted to", exDirName, "diretory"))
} else {
    message(paste("Files", file1, "and", file2, "already existed"))   
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


