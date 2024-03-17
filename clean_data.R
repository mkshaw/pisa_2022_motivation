library(haven)

df <- haven::read_sav("CY08MSP_STU_QQQ.sav")

df <- df[df$CNT %in% c("CAN", "USA"), ]

write.csv(df, "pisa2022_usacan.csv")