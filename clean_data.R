# 0 Load data and dependencies --------------------------------------------

library(haven) # for reading sav files
library(glue)

df <- haven::read_sav("CY08MSP_STU_QQQ.sav")

# 1 Filter to Canada and USA ----------------------------------------------

df_ca <- df[df$CNT %in% c("CAN", "USA"), ]

print(glue("Number of total rows: ", nrow(df)))
print(glue("Number of rows for CAN/USA: ", nrow(df_ca)))
print(glue("Number of non-null outcome rows for CAN/USA: ", df_ca[!is.na(df_ca$ST352Q06JA),] |> nrow()))
print(glue("Proportion of non-null for CA/USA: ", df_ca[!is.na(df_ca$ST352Q06JA),] |> nrow() / df_ca |> nrow()))

# remove null responses to outcome variable
df_ca_nonull <- df_ca[!is.na(df_ca$ST352Q06JA),]

# how many of each response to the outcome?
# 1 = Never
# 2 = A few times
# 3 = About once or twice a week
# 4 = Every day or almost every day
table(df_ca_nonull$ST352Q06JA)

# filter out valid skips, NAs, invalid, no response
# there are none, just 1/2/3/4 responses

# 2 Select only variables of interest -------------------------------------

variables <- c("ST352Q06JA", "AGE", "ST004D01T", "DURECEC", "REPEAT", "MISSSC", 
               "SKIPPING", "TARDYSD", "EXPECEDU", "SISCO", "MATHMOT", "MATHEASE",
               "MATHPREF", "EXERPRAC", "STUDYHMW", "WORKPAY", "WORKHOME",
               "INFOSEEK", "BULLIED", "FEELSAFE", "TEACHSUP", "RELATST",
               "SCHRISK", "BELONG", "GROSAGR", "ANXMAT", "MATHEFF", "MATHEF21",
               "MATHPERS", "FAMCON", "ASSERAGR", "COOPAGR", "CURIOAGR", 
               "EMOCOAGR", "EMPATAGR", "PERSEVAGR", "STRESAGR", "FAMSUP",
               "CREATFAM", "CREATSCH", "CREATEFF", "CREATOP", "IMAGINE",
               "OPENART", "CREATAS", "CREATOOS", "ESCS", "ST352Q01JA",
               "ST352Q02JA", "ST352Q03JA", "ST352Q04JA", "ST352Q05JA", "ST352Q06JA",
               "ST352Q07JA", "ST352Q08JA", "ST354Q02JA", "ST354Q03JA", "ST354Q07JA",
               "ST354Q08JA", "ST354Q09JA", "ST353Q01JA", "ST353Q02JA",
               "ST353Q03JA", "ST353Q04JA", "ST353Q05JA", "ST353Q06JA", "ST353Q07JA",
               "ST353Q08JA", "ST348Q01JA", "ST348Q02JA", "ST348Q03JA", "ST348Q04JA",
               "ST348Q05JA", "ST348Q06JA", "ST348Q07JA", "ST348Q08JA")

df_final <- df_ca_nonull[, variables]

# Export to CSV -----------------------------------------------------------

write.csv(df_final, "pisa2022_usacan.csv")
