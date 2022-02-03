## SE370 AY22-2
## Lesson 13 - Data Manipulation in Base R


# Read in the data for the Summer Olympics, Winter Olympics, and the dictionary

summer <- read.csv("summer.csv")
winter <- read.csv("winter.csv")
dict <- read.csv("dictionary.csv")

#---Filtering
# Get the first 12 rows of the Summer Olympics data
summer[1:12, ]

# Get just the columns for year, athlete, event, and medal
summer[ , c("Year", "Athlete", "Event", "Medal")]

# Access just the rows that contain data for USA athletes
summer[summer$Country == "USA", ]



#---Transforming
# Sort the dictionary by population
dict[order(dict$Population), ]

# Now sort it in descending order
dict[order(-dict$Population), ]

# Check the data type for the Summer olympics medal column
summary(summer$Medal)

# Convert that column to a factor...
summer$Medal <- factor(summer$Medal, levels = c("Gold", "Silver", "Bronze"))

# Create a new column from existing data
# In the winter dataset, create a new column called "summary"
# It should contain the Sport, Event, and Medal in this format:
# Biathlon, Military Patrol: Bronze
winter$summary <- paste0(winter$Sport, ", ", winter$Event, ": ", winter$Medal)

# Look at the dictionary. Create a column that contain the country's GDP
# (should be population * GDP per capita)
dict$GDP <- paste0(dict$Population * dict$GDP.per.Capita)



#---Joins
# Add a row to the summer dataframe. 
# Let's add data from the 2016 Olympics. Create the row of data and add the to the dataframe.
# Year = 2016. City = Rio. Sport = Archery, Discipline = Archery, Athlete = KU, Bonchan, Country = KOR, 
# Gender = Male, Event = Individual, Medal = Gold.

tmp_df <- c(Year = 2016, City = "Rio", Sport = "Archery", Discipline = "Archery", Athlete = "KU, Bonchan", 
            Country = "KOR", Gender = "Male", Event = "Individual", Medal = "Gold")

summer <- rbind(summer, tmp_df)

# Merge the summer data with the dictionary using an appropriate key

merge(summer, dict, by.x = "Country", by.y = "Code")


#---Plotting
# Use plot() to create a basic plot
# Let's filter for just the FVEY countries (US, Canada, UK, Aus, NZ) and plot the population v. GDP per capita
# hint: How do we filter for multiple items at once???

plot_data <- dict[dict$Code %in% c("USA", "CAN", "GBR", "AUS", "NZL"), ]

plot(x = plot_data$Population, y = plot_data$GDP.per.Capita)

# We can use barplot() to plot a categorical variable. Plot country v. population

barplot(x = plot_data$Country, y = plot_data$Population)

# What happened?
# Let's try again...

barplot(plot_data$Population, names.arg = c("Australia", "Canada", "New Zealand", "UK", "US"))

# Great! Now it's time to do some formatting...
# Take that bar plot, add a title "Population of FVEY Countries", add axis labels ("Country" and 
# "Population"), and give the bars some color!!! Turn this complete script in...

