# Hierarchical Data Format 

# hdf5 stores large datasets; Supports a range of datasets
# Groups (header having group name and attrs & symbol table for datasets)> 0 or more datasets

#   Datasets can be multi-dimensional arrays. Also they can store metadata. 

# rhdf5 is a bioconductor pckg

library(rhdf5)

# Creating a gdf5 file manually to understand the structure

Created <- h5createFile("Example.h5")

Created

# Creating groups
Created = h5createGroup("Example.h5", "Grp_A")
Created = h5createGroup("Example.h5", "Grp_B")
Created = h5createGroup("Example.h5", "Grp_A/Grp_A1")

# Viewing the str 
h5ls("Example.h5")

# Adding dataset to groups
Matrix_X <- matrix(10, nr=5, nc = 2)
h5write(Matrix_X, "Example.h5", "Grp_A/Dat_A") # Matrix added to h5 

Multi_Dim_Array <- array(seq(0.1, 2.0, 0.1), dim=c(5,2,2)) 
attr(Multi_Dim_Array, "Scale") <- "Kilograms" # adding metadata to our multi dim array

h5write(Multi_Dim_Array, "Example.h5", "Grp_A/Grp_A1/Dat_A1") # Array added to h5
h5ls("Example.h5")


# writing directly to h5 at root level 
df = data.frame('I' = 1L:5L, "Dec" =seq(0, 1, length.out = 5), "Letters" = c('a', 'b', 'c', 'd', 'e'), stringsAsFactors = FALSE)
h5write(df, "Example.h5", "Dataframe") # If no grp/ hierarchy given then adds at top level
h5ls("Example.h5")

#Writing subset of data to a already existing dataset

h5write(c(12,13,14), "Example.h5", "Grp_A/Dat_A", index = list(3:5, 2)) # Giving indices to index arg

## Reading a dataset from hdf5 file

readH5_Dat_A = h5read("Example.h5", "Grp_A/Dat_A")
readH5_Dataframe = h5read("Example.h5", "Dataframe")































