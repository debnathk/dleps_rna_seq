# Parsing annotated GCTX file used in Connectivity Map

# Install package
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("cmapR")
BiocManager::install("roller")

# Load package
library(cmapR)

# Accessing GCT object components
# access the data matrix
m <- mat(ds)

# access the row and column metadata
rdesc <- meta(ds, dimension = "row")
cdesc <- meta(ds, dimension = "column")

# access the row and column ids
rid <- ids(ds, dimension = "row")
cid <- ids(ds, dimension = "column")

# update the matrix data to set some values to zero
# note that the updated matrix must be the of the same dimensions as 
# the current matrix
m[1:10, 1:10] <- 0
mat(ds) <- m

# replace row and column metadata
meta(ds, dimension = "row") <- data.frame(x=sample(letters, nrow(m),
                                                   replace=TRUE))
meta(ds, dimension = "column") <- data.frame(x=sample(letters, ncol(m),
                                                      replace=TRUE))

# replace row and column ids
ids(ds, dimension = "row") <- as.character(seq_len(nrow(m)))
ids(ds, dimension = "column") <- as.character(seq_len(ncol(m)))

# and let's look at the modified object
ds

# Parsing GCTX files
ds_path <- system.file("extdata", 
                       "LINCS_DCIC_2021_siRNAPert_PredictedRNAseq_ChDir_Sigs.gctx", 
                       package="cmapR")
my_ds <- parse_gctx(ds_path)
my_ds
View(my_ds@mat)
