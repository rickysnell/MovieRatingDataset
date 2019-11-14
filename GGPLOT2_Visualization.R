
#Must deal with data and understand what data you are working with 1st!!!

movies <- read.csv(file.choose())
head(movies)
tail(movies)
summary(movies)
str(movies)

#Change column names to names that make sense to me
colnames(movies)<- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movies)
###Anaylize str of data and look at the factor variables.  These are the variables to use in visualization

#Sometimes need to convert a numeric variable YEAR to a categorical variable to use in visualization
#Convert year data type from numeric/interger to a factor variable
factor(movies$Year)
movies$Year <- factor(movies$Year)
str(movies)

#---------Aesthetics of visualizations--------------------------------
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
#add geometry layer so you can see aestics and data!!!
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add more things we can see like color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre)) + 
  geom_point()
#add size command to ggplot
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=Genre)) + 
  geom_point()
#better way to add size is to use budget
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=BudgetMillions)) + 
  geom_point()
#this is #1 of our visual requirement and the basis for all other visuals.(We will improve this)
#-------------Geometires Plotting With Layers of visualizations-------------------------------------

#dataframe is copied to an object creates a blank plate until geometries are added
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=BudgetMillions))
#object p and overlayed it with geometry point
p + geom_point()

#object p and overlayed it with geometry lines
p + geom_line()

#object p and overlayed with multiple layers
p + geom_point() + geom_line()
#can see dots better below
p + geom_line() + geom_point()

#-------Overiding Aesthetics using q variable -------------------------------
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             color=Genre, size=BudgetMillions))
#add geom layer
q + geom_point() # it is inheriting aestics from object q ...assume the asthetics of q

#overidding aesthetics by adding objects into parathensis CriticRating overide
#example 1
q +geom_point(aes(size =CriticRating))#shows as cirle increasing in size the critics rate higher
#budget now has no effect on the display..

#example 2 overidding color
q + geom_point(aes(color =BudgetMillions))#shows as color goes from black to light blue budget increase
#color now based on budget not genre in past

#It is clear we are modifying/overriding q aes but not changing q at all with proof below
#q remains the same
q +geom_point()

#example 3 overiding x axis using mapping
q + geom_point(aes(x = BudgetMillions))#modifying x axis to BudgetMillions
#as you move from left to right shows circles as budgetmillions increases

#by default will show old X axis Critic Rating but can change it...mapping
q + geom_point(aes(x=BudgetMillions)) + 
                     xlab("Budget Millions $$$")

#example 4 with 2 geom layers added together
q + geom_line() + geom_point()
#reduce line size thru setting not mapping!!! SIZE = 1 not aes(SIZE=1)!!!

q + geom_line(size=1) + geom_point()

#2nd Chart of Deliverables
q + geom_point(aes(x=BudgetMillions)) + 
  xlab("Budget Millions $$$")

#------------------------------mapping vs setting----------------------
r <- ggplot(data= movies, aes(x= CriticRating, y= AudienceRating))
r + geom_point()
#adding color can occur two ways
#1. mapping (what we have done so far): use mapping to a variable
r + geom_point(aes(color = Genre))

r + geom_point(aes(size = BudgetMillions))

#2nd way is by using setting: to change to a specific set  
r + geom_point(color = "DarkGreen")


r + geom_point(size = I(10))
#ERROR: 
#r + geom_point(aes(color = "DarkGreen"))

#--------Histograms and Density Charts------------
s <- ggplot(data=movies, aes(x=BudgetMillions)) #dont need y axis because creating histogram
s + geom_histogram(binwidth = 10)#show how many movies fall into each bin
#count is a statistic generated from r
#add color 
s + geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border for each in black
s + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")
#Chart nunber 3 but we  will improve it

#sometimes you may need density chart probubility of 0 explaining density
s + geom_density(aes(fill=Genre))
#to see better add stack command 
s + geom_density(aes(fill=Genre), position = "stack")

#-------Strategic approach to chart creation/visualization--------
t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10,
                   fill="White", color="Blue")
#another way to make same plot
t + ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=AudienceRating),
                   fill="White", color="Blue")
# forth example in our briefing
#Which is best???depends on what you are visualizing.  Another way gives you flexibility to explore

t + geom_histogram(binwidth = 10,
                   aes(x=CriticRating),
                   fill="White", color="Blue")
#fith example for briefing

#skeliton plot used for diffrent datasets!!!
t <- ggplot()


#---------------Statistical Transformation of visualizations------------------

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
u + geom_point() + geom_smooth(fill=NA)

#---Boxplots----Audience Rating
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             color=Genre))
u + geom_boxplot() 
u + geom_boxplot(size=1.2)

#add a second statistical layer
u + geom_boxplot(size=1.2) + geom_point()
#tip/hack:
u + geom_boxplot(size=1.2) + geom_jitter()

u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)#dots there and put boxes on top

###do above boxplot for Critics Rating sixth example
l <- ggplot(data=movies, aes(x=Genre, y=CriticRating,
                             color=Genre))
l + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#-------Facets Layer of visualizations-----------------------
#histogram
v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   color="black")

#histogram for all genre
#Genre is the rows but small histograms with own scale
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   color="black") +
  facet_grid(Genre~., scales="free")

v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   color="black") +
  facet_grid(.~Genre)

#scatterplots:
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
w + geom_point(size=3)

w + geom_point(size=3) +
  facet_grid(Genre~., scales="free")

#breakout by Genre along the top and indepent rating along bottom
w + geom_point(size=3) +
  facet_grid(.~Genre, scales="free")

#breakout by year along the top and indepent rating along bottom
w + geom_point(size=3) +
  facet_grid(.~Year, scales="free")

#breakout by genre and year along the top and indepent rating along bottom
w + geom_point(size=3) +
  facet_grid(Genre~Year, scales="free")

#breakout by genre and year along the top and indepent rating along bottom
#add a smoother
w + geom_point(size=3) +
  geom_smooth() +
  facet_grid(Genre~Year, scales="free")

#map budgetmillions to size of dots also!!!
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year, scales="free")

#Chart one but needs to be improved!!!
#need to zoom in on charts to focus or coordinates
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year, scales="free") +
  coord_cartesian(ylim=c(0,100))


#-----Coordinates layer of visualizations---------
m<- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                            size=BudgetMillions, color=Genre))
m + geom_point()
#visualize top corner of above m + geom_point()
m + geom_point() + xlim(50,100) + ylim(50,100)
#wont work well always
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")
#zoom in on 0 to 50 along y axis
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  ylim(0,50)#cut off data above 50 which is not what we wanted
#zoom2
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  coord_cartesian(ylim=c(0,50))

#-------Themes Layer of visualizations----------
o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

#add axis label
h + xlab("Money Axis")+ ylab("Number of Movies")

#label formatting
h + xlab("Money Axis")+ ylab("Number of Movies") +
  theme(axis.title.x=element_text(color="DarkGreen", size=30),
        axis.title.y=element_text(color="Red", size=30))




























































































































































































