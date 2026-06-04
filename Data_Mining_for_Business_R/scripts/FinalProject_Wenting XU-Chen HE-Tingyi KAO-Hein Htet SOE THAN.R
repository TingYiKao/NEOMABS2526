##########################################################################################
#              Multiple Correspondence Analysis (MCA) for Final Project                  #
##########################################################################################

############################################
#              Group Members               #
# 1. Wenting XU                            #
# 2. Chen HE                               #
# 3. Tingyi KAO                            #
# 4. Hein Htet SOE THAN                    #
############################################

#------------------------------------------#
# Library Initialization                   #
#------------------------------------------#
library(FactoMineR)
library(ca) # CA in the FactoMineR package

library(readxl)     # for reading excel file
library(dplyr)      # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms and funny visualization
library(dendextend) # for comparing two dendrograms
library(psych)      # for group analysis

#------------------------------------------#
# 1.Data Understainding                    #
#------------------------------------------#

# Read the dataset (replace with your file path if needed)
data <- read.csv("cancer patient data sets.csv")

# Display the first and last rows of the dataset
head(data, 10)
tail(data, 10)
# Display the structure of the dataset (variables and types)
str(data)
# Summary statistics of variables
summary(data)
# Count number of observations and variables
dim(data)
# Plot the 'Age' distribution
hist(data$Age, main = "Age Distribution", xlab = "Age", col = "lightblue", border = "blue")
# Check Null/missing values
which(is.na(data_clean))
sum(is.na(data_clean))

#------------------------------------------#
# 1.2. Data Cleaning.                      #
#------------------------------------------#
# Remove unnecessary columns such as identifiers
# These variables do not provide analytical information
data_clean <- data |>
  select(-index, -'Patient.Id')
# Check the new structure after removing columns
str(data_clean)

#------------------------------------------#
# 1.3. Convert variables to                #
#      categorical factors                 #
#------------------------------------------#
# Many variables are numeric codes representing categorie

# Convert Age and Level explicitly as factors
# Age is numerical, so we discretize it into age groups.
# Young: 0-24, Adult: 25-34, Middle-aged: 35-44, Senior: 45-54, Elderly: 55+
data_clean <- data_clean |>
              mutate(
                Age_group = cut(Age,
                                breaks = c(0, 24, 34, 44, 54, 100),
                                labels = c("1", "2", "3", "4", "5"))
              ) |>
              select(-Age)

data_clean <- data_clean |>
              mutate(Level = 
                     as.numeric(factor(Level, levels = c("Low","Medium","High"))))

# Convrt all numeric variables to factors (if they are not already)
data_clean <- data_clean %>%
  mutate(across(where(is.numeric), as.factor))
            
# Check structure again
str(data_clean)

#------------------------------------------#
# 1.4. Simple Data Visualization           #
#------------------------------------------#

# Create output folder for plots
if (!dir.exists("plots")) dir.create("plots")

# Level distribution
p1 <- ggplot(data_clean, aes(x = Level, fill = Level)) +
      geom_bar() +
      scale_x_discrete(labels = c("1" = "Low", "2" = "Medium", "3" = "High")) +
      scale_fill_manual(values = c("#4CAF50","#FFC107","#F44336")) +
      labs(
        title = "Distribution of Lung Cancer Level",
        x = "Cancer Level",
        y = "Count"
      ) +
      theme_minimal() +
      theme(legend.position = "none")
ggsave("plots/01_level_distribution.png", p1, width = 7, height = 5)

# Gender distribution
p2 <- ggplot(data_clean, aes(x = Gender, fill = Gender)) +
      geom_bar() +
      scale_x_discrete(labels = c("1" = "Male", "2" = "Female")) +
      scale_fill_manual(values = c("#4C78A8", "#F58518")) +
      labs(
        title = "Distribution of Gender",
        x = "Gender",
        y = "Count"
      ) +
      theme_minimal() +
      theme(legend.position = "none")
ggsave("plots/02_gender_distribution.png", p2, width = 7, height = 5)

# Age group distribution
p3 <- ggplot(data_clean, aes(x = Age_group, fill = Age_group)) +
      geom_bar() +
      scale_fill_brewer(palette = "Blues") +
      labs(
        title = "Distribution of Age Groups",
        x = "Age Group",
        y = "Count"
      ) +
      theme_minimal() +
      theme(legend.position = "none")
ggsave("plots/03_agegroup_distribution.png", p3, width = 7, height = 5)

# Association Plot: Smoking vs Level
p4 <- ggplot(data_clean, aes(x = Smoking, fill = Level)) +
      geom_bar(position = "fill") +
      scale_fill_manual(values = c(
        "1" = "#4CAF50",
        "2" = "#FFC107",
        "3" = "#F44336"
      )) +
      scale_y_continuous(labels = scales::percent_format()) +
      labs(
        title = "Smoking Profile by Lung Cancer Level",
        x = "Smoking Category",
        y = "Proportion",
        fill = "Cancer Level"
      ) +
      theme_minimal()
ggsave("plots/04_smoking_vs_level.png", p4, width = 8, height = 5)

# Association Plot: Air Pollution vs Level
p5 <- ggplot(data_clean, aes(x = Air.Pollution, fill = Level)) +
      geom_bar(position = "fill") +
      scale_fill_manual(values = c(
        "1" = "#4CAF50",
        "2" = "#FFC107",
        "3" = "#F44336"
      )) +
      scale_y_continuous(labels = scales::percent_format()) +
      labs(
        title = "Air Pollution Profile by Lung Cancer Level",
        x = "Air Pollution Category",
        y = "Proportion",
        fill = "Cancer Level"
      ) +
      theme_minimal()
ggsave("plots/05_airpollution_vs_level.png", p5, width = 8, height = 5)

# Cross-tabulation between Smoking and Lung Cancer Level
table(data_clean$Smoking, data_clean$Level)

# Chi-square test for association between Smoking and Lung Cancer Level
chisq.test(data_clean$Smoking, data_clean$Level)
# X-squared = 684.5, df = 14, p-value < 2.2e-16
# This indicates a significant association between smoking and lung cancer level.

#------------------------------------------#
# 2.MCA                                    #
#------------------------------------------#
# Complete Disjunctive Coding
data_clean_dis <- tab.disjonctif(data_clean)
dim(data_clean_dis)
write.csv(data_clean_dis, "data_disjunctive.csv", row.names = FALSE)
# Burt’s table
data_clean_burt <- t(data_clean_dis)%*%data_clean_dis
dim(data_clean_burt)
write.csv(data_clean_burt, "data_burt.csv", row.names = TRUE)
?MCA

# Use "level" as supplementary qualitative variable:
# it helps interpretation without forcing the dimensional construction.
mca_data <- MCA(data_clean,
                quali.sup = which(names(data_clean) == "Level"),
                graph = FALSE)
summary(mca_data)
print(mca_data)

# Eigenvalues and % of explained inertia using the factoextra package
mca_eigen <- get_eigenvalue(mca_data)  # to extract the proportion of inertia retained by the different MCA dimensions (axes)et
write.csv(mca_eigen, "mca_eigenvalues.csv", row.names = TRUE)
# to visualize the percentages of inertia explained by each MCA dimensions
p_scree <- fviz_screeplot(mca_data, addlabels = TRUE, ylim = c(0, 15)) +
          theme_minimal() +
          theme(panel.background = element_rect(fill = "transparent"),
                plot.background  = element_rect(fill = "transparent"))
ggsave("plots/06_mca_screeplot.png", p_scree, width = 7, height = 5)

#------------------------------------------#
# 2.1 Results for variable categories      #
#------------------------------------------#

# Extract MCA results once
mca_var <- get_mca_var(mca_data)

# Coordinates, cos2, contributions
mca_coord   <- mca_var$coord
mca_cos2    <- mca_var$cos2
mca_contrib <- mca_var$contrib

# Export tables
write.csv(mca_coord,   "mca_var_coord.csv",   row.names = TRUE)
write.csv(mca_cos2,    "mca_var_cos2.csv",    row.names = TRUE)
write.csv(mca_contrib, "mca_var_contrib.csv", row.names = TRUE)

#-----------------------------#
# Cos2 plot for Dim 1 and 2   #
#-----------------------------#
plot_cos2 <- fviz_cos2(mca_data, choice = "var", axes = 1:2)
ggsave("plots/07_mca_cos2_dim12.png", plot_cos2, width = 20, height = 5)

#-----------------------------------#
# Contribution plots for Dim 1 & 2  #
#-----------------------------------#
# Top contributing categories to Dim 1
top_contrib_dim1 <- sort(mca_contrib[, 1], decreasing = TRUE)
head(top_contrib_dim1, 15)
plot_contrib_dim1 <- fviz_contrib(mca_data, choice = "var", axes = 1, top = 15)
ggsave("plots/08_mca_contrib_dim1.png", plot_contrib_dim1, width = 7, height = 5)

# Top contributing categories to Dim 2
top_contrib_dim2 <- sort(mca_contrib[, 2], decreasing = TRUE)
head(top_contrib_dim2, 15)
plot_contrib_dim2 <- fviz_contrib(mca_data, choice = "var", axes = 2, top = 15)
ggsave("plots/08_mca_contrib_dim2.png", plot_contrib_dim2, width = 7, height = 5)

#---------------------------------------------#
# MCA variable map (categories on Dim1/Dim2)  #
#---------------------------------------------#
plot_var_map <- fviz_mca_var(
  mca_data,
  repel = TRUE,
  ggtheme = theme_minimal()
)
ggsave("plots/09_mca_var_map.png", plot_var_map, width = 20, height = 10)

#------------------------------------------------#
# Variable map with well-represented categories  #
#------------------------------------------------#
plot_var_cos2_04 <- fviz_mca_var(
  mca_data,
  select.var = list(cos2 = 0.4),
  repel = TRUE,
  ggtheme = theme_minimal()
)
ggsave("plots/10_mca_var_cos2_04.png", plot_var_cos2_04, width = 9, height = 7)

# Best represented categories on Dim 1 and 2 combined
cos2_dim12 <- rowSums(mca_cos2[, 1:2])
top_cos2_dim12 <- sort(cos2_dim12, decreasing = TRUE)
head(top_cos2_dim12, 15)

#------------------------------------------#
# 2.2 Results for observations             #
#------------------------------------------#

# Extract MCA individual results once
mca_ind <- get_mca_ind(mca_data)

# Coordinates, cos2, contributions
ind_coord   <- mca_ind$coord
ind_cos2    <- mca_ind$cos2
ind_contrib <- mca_ind$contrib

# Export useful tables
write.csv(ind_coord,   "mca_ind_coord.csv",   row.names = TRUE)
write.csv(ind_cos2,    "mca_ind_cos2.csv",    row.names = TRUE)
write.csv(ind_contrib, "mca_ind_contrib.csv", row.names = TRUE)

# Data used for clustering: retained MCA dimensions
quant.Data <- as.data.frame(ind_coord[, 1:5])

#------------------------------------------#
# Individual map colored by supplementary  #
# qualitative variable                     #
#------------------------------------------#
plot_ind_level <- fviz_mca_ind(
  mca_data,
  label = "none",
  habillage = "Level",
  addEllipses = TRUE,
  ellipse.type = "confidence",
  ggtheme = theme_minimal()
)
ggsave("plots/11_mca_ind_level.png", plot_ind_level, width = 10, height = 7)

#------------------------------------------#
# Optional: map of individuals by cos2     #
#------------------------------------------#
plot_ind_cos2 <- fviz_mca_ind(
  mca_data,
  label = "none",
  col.ind = "cos2",
  gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
  ggtheme = theme_minimal()
)
ggsave("plots/12_mca_ind_cos2.png", plot_ind_cos2, width = 10, height = 7)

#------------------------------------------#
# Optional: MCA biplot                     #
#------------------------------------------#
plot_biplot <- fviz_mca_biplot(
  mca_data,
  repel = TRUE,
  ggtheme = theme_minimal()
)
ggsave("plots/13_mca_biplot.png", plot_biplot, width = 20, height = 10)

#------------------------------------------#
# 3. Hierarchical Clustering               #
#------------------------------------------#
# MCA coordinates retained for clustering
coord_for_clustering <- quant.Data

# Euclidean distance on MCA coordinates
clustering_d <- dist(coord_for_clustering, method = "euclidean")

# Optional: visualize the distance matrix
plot_dist <- fviz_dist(
  clustering_d,
  gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07")
)
ggsave("plots/14_clustering_distance.png", plot_dist, width = 10, height = 7)

#------------------------------------------#
# 3.1 Determining Optimal Clusters         #
#------------------------------------------#
# Elbow method
elbow <- fviz_nbclust(coord_for_clustering, FUN = hcut, method = "wss") +
  labs(title = "Elbow Method for Optimal Clusters") +
  theme_minimal()
ggsave("plots/15_elbow_method.png", elbow, width = 7, height = 5)

# Silhouette method
silhouette_plot <- fviz_nbclust(coord_for_clustering, FUN = hcut, method = "silhouette") +
  labs(title = "Silhouette Method for Optimal Clusters") +
  theme_minimal()
ggsave("plots/16_silhouette_method.png", silhouette_plot, width = 7, height = 5)

#------------------------------------------#
# 3.2 Dendrogram                           #
#------------------------------------------#
hc <- hclust(clustering_d, method = "ward.D2")
png("plots/17_dendrogram.png", width = 1000, height = 700)
plot(hc, cex = 0.6, hang = -1, main = "Hierarchical Clustering on MCA Coordinates")
#rect.hclust(hc, k = 3, border = 2:4)
dev.off()

hc <- hclust(clustering_d, method = "ward.D2")
png("plots/18_dendrogram_k-3.png", width = 1000, height = 700)
plot(hc, cex = 0.6, hang = -1, main = "Hierarchical Clustering on MCA Coordinates")
rect.hclust(hc, k = 3, border = 2:4)
dev.off()

#------------------------------------------#
# 3.3 Assign clusters                      #
#------------------------------------------#
clusters <- cutree(hc, k = 3)
data_clustered <- data_clean |>
  mutate(cluster = factor(clusters))

table(data_clustered$cluster)
write.csv(table(data_clustered$cluster), "cluster_counts.csv", row.names = TRUE)

#------------------------------------------#
# 4. Cluster Visualization                 #
#------------------------------------------#

cluster_plot <- fviz_cluster(
  list(data = mca_data$ind$coord[,1:2], cluster = clusters),
  geom = "point"
)
ggsave("plots/19_cluster_visualization.png", cluster_plot, width = 12, height = 6)

#------------------------------------------#
# 5. Cluster Interpretation                #
#------------------------------------------#

# Cluster vs lung cancer level
cluster_level_tab <- table(data_clustered$cluster, data_clustered$Level)
write.csv(as.data.frame.matrix(cluster_level_tab), "cluster_vs_level.csv")

cluster_vs_level <- ggplot(data_clustered, aes(x = cluster, fill = Level)) +
                    geom_bar(position = "fill") +
                    scale_y_continuous(labels = scales::percent_format()) +
                    scale_fill_manual(values = c(
                        "1" = "#4CAF50",   # soft green
                        "2" = "#F6C85F",   # warm yellow
                        "3" = "#E45756"    # elegant red
                        )) +
                    labs(title = "Cluster Composition by Lung Cancer Level",
                          x = "Cluster",
                          y = "Proportion",
                          fill = "Cancer Level") + theme_minimal()
ggsave("plots/20_cluster_vs_level.png", cluster_vs_level, width = 8, height = 5)


# Example interpretation tables
selected_vars <- c(
                  "Smoking", "Air.Pollution", "OccuPational.Hazards",
                  "Chest.Pain", "Fatigue", "Coughing.of.Blood",
                  "Age_group", "Gender", "Alcohol.use", "Dust.Allergy",
                  "Genetic.Risk", "Balanced.Diet", "Obesity", "Passive.Smoker",
                  "chronic.Lung.Disease", "Weight.Loss", "Shortness.of.Breath",
                  "Wheezing", "Swallowing.Difficulty", "Clubbing.of.Finger.Nails",
                  "Frequent.Cold", "Dry.Cough", "Snoring", "Level")

for (v in selected_vars) {
  tab <- prop.table(table(data_clustered$cluster, data_clustered[[v]]), margin = 1)
  write.csv(as.data.frame.matrix(round(tab,3)),
            paste0("cluster_profile_", v, ".csv"))
}

