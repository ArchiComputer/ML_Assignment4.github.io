# Load the required library
library(readr)
library(dplyr)

# File path
file_path <- "/Users/jusungkim/ATLAS_Grad_Classes/2024 Spring/Machine Learning/CSCI5622/Assignment2/ML_Assignment2.github.io/use_of_public_bicycles_in_Seoul.csv"

# Read the CSV file
df <- read_csv(file_path)

# Remove single quotation marks from column names
names(df) <- gsub("'", "", names(df))

# Rename the columns
names(df) <- c("Rent Date", "Docking Station Number", "Description of Docking Station", "Rent Classification", "Gender", "Age", "Number of uses", "Exercise Amount", "Saved Carbon Emissions", "Moving distance(meters)", "Time of use(minutes)")

# Convert 'Docking Station Number' column to numerical values using mutate
df <- df %>%
  mutate(`Docking Station Number` = as.numeric(as.factor(`Docking Station Number`)))

# Display the DataFrame
print(df)

# Select the specified columns
selected_features <- df %>%
  select(`Docking Station Number`, `Number of uses`, `Exercise Amount`, `Moving distance(meters)`, `Time of use(minutes)`)

# Display the selected features data frame
print(selected_features)

# Group the selected features by 'Docking Station Number' and calculate the sum
sum_by_docking_station <- selected_features %>%
  group_by(`Docking Station Number`) %>%
  summarise(`Number of uses` = sum(`Number of uses`),
            `Exercise Amount` = sum(`Exercise Amount`),
            `Moving distance(meters)` = sum(`Moving distance(meters)`),
            `Time of use(minutes)` = sum(`Time of use(minutes)`))

# Display the summarized data
print(sum_by_docking_station)

# Normalize the data using Z-score normalization
normalized_data <- scale(sum_by_docking_station)

# Create a new DataFrame with the normalized data
normalized_df <- as.data.frame(normalized_data)

# Copy row names and column names from original DataFrame
rownames(normalized_df) <- rownames(sum_by_docking_station)
colnames(normalized_df) <- colnames(sum_by_docking_station)

# Display the normalized DataFrame
print(normalized_df)


install.packages("fastcluster")
library(fastcluster)
install.packages("cluster")

install.packages("proxy")
library(proxy)



# Compute cosine similarity matrix
cosine_similarity_matrix <- as.matrix(dist(scaled_sum_by_docking_station[, -1], method = "cosine"))

# Perform hierarchical clustering
hclust_result <- hclust(as.dist(cosine_similarity_matrix))

# Determine cluster assignments
cluster_assignments <- cutree(hclust_result, k = 5)  # Adjust the number of clusters as needed

# Count observations in each cluster
cluster_counts <- table(cluster_assignments)

# Display cluster counts
print(cluster_counts)

# Convert hierarchical clustering result to a dendrogram
dend <- as.dendrogram(hclust_result)

# Define colors for clusters
cluster_colors <- rainbow(length(unique(cluster_assignments)))

# Color branches based on cluster assignments
dend_colored <- color_branches(dend, k = length(unique(cluster_assignments)), col = cluster_colors)

# Plot dendrogram
plot(dend_colored, main = "Dendrogram of Cosine Similarity", labels = NULL)

# Add legend for cluster colors
legend("topright", legend = unique(cluster_assignments), fill = cluster_colors)


