#Reading Eclipse bug data
file_20 = read.table("resource/files-csv/eclipse-metrics-files-2.0.csv", header = TRUE, sep = ";")
file_21 = read.table("resource/files-csv/eclipse-metrics-files-2.1.csv", header = TRUE, sep = ";")
file_30 = read.table("resource/files-csv/eclipse-metrics-files-3.0.csv", header = TRUE, sep = ";")

#Reading Eclipse Package
package_20 = read.table("resource/packages-csv/eclipse-metrics-packages-2.0.csv", header=TRUE, sep = ";")
package_21 = read.table("resource/packages-csv/eclipse-metrics-packages-2.1.csv", header=TRUE, sep = ";")
package_30 = read.table("resource/packages-csv/eclipse-metrics-packages-3.0.csv", header=TRUE, sep = ";")

#Package Histrogram of the percentage of the post release defectss
hist(package_30$post, main="", breaks = 100, freq=T, axes = F,
     xlab="Number of Post-Release Defects (per Package)", ylab="Percentage", col="darkgray")
axis(1)
axis(2, at=c(0,66.1,66.1*2,66.1*3,66.1*4,66.1*5,66.1*6), 
     labels=c("0%","10%","20%","30%","40%","50%","60%"), las=1)

#Files Histrogram of the percentage of the post release defectss
hist(file_30$post, main="", breaks = 100, freq=T, axes = F,
     xlab="Number of Post-Release Defects (per Package)", ylab="Frequency", col="orange")

#Spearman correlation test for files with release 3.0

#Initializing varriables for file level changes.
pre.p <- rep (-1, 33)
post.p <- rep (-1, 33)
for (i in 3:35) {
  pre.p[i-2] <- cor.test(file_30[,i], file_30$pre, method="spearman", exact=FALSE)$p.value
  post.p[i-2] <- cor.test(file_30[,i], file_30$post, method="spearman", exact=FALSE)$p.value
}
cor(file_30[,3:35], file_30$pre, method="spearman")

#Spearman correlation between pre and post for file level metrics
cbind(cor(file_30[,3:35], file_30$pre, method="spearman"), cor(file_30[,3:35], file_30$post, 
                                                               method="spearman"), (pre.p<0.01), (post.p<0.01))

#Initializing varriables for Package level changes.
pre.p <- rep (-1, 42)
post.p <- rep (-1, 42)

for(i in 3:45) {
  pre.p[i-2] = cor.test(package_30[, i], package_30$pre, method = "spearman", exact = FALSE)$p.value
  post.p[i-2] = cor.test(package_30[, i], package_30$post, method = "spearman", exact = FALSE)$p.value
}

#Spearman correlation between pre and post for file level metrics
cbind(cor(package_30[,3:45], package_30$pre, method="spearman"), cor(package_30[,3:45], package_30$post,
                                                                       method="spearman"), (pre.p<0.01), (post.p<0.01))


#Classification funcion defination for eclipse files.
file_classification_test <- function (train, test) {
  
  #Defining model relations for post release bugs
  model.glm <- glm((post>0) ~ pre + ACD + FOUT_avg + FOUT_max + FOUT_sum + MLOC_avg
                   + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOF_avg + NOF_max + NOF_sum
                   + NOI + NOM_avg + NOM_max + NOM_sum + NOT + NSF_avg + NSF_max + NSF_sum + NSM_avg
                   + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum + + + TLOC + VG_avg
                   + VG_max + VG_sum, data=train, family = "binomial")
  summary(model.glm)
  
  test.prob <- predict(model.glm, test, type="response")
  print( test.prob)
  test.pred <- test.prob >= 0.50
  print( test.pred)
  outcome <- table(factor(test$post>0, levels=c(F,T)), factor(test.pred, levels=c(F,T)))
  print(outcome)
  
  TN <- outcome[1,1]
  FN <- outcome[2,1]
  FP <- outcome[1,2]
  TP <- outcome[2,2]
  
  precision <- if (TP + FP == 0) { 1 } else { TP / (TP + FP) }
  recall <- TP / (TP + FN)
  accuracy <- (TP + TN) / (TN + FN + FP + TP)
  defects <- (TP + FN) / (TN + FN + FP + TP)
  
  return (c("Defects" = defects, "Precision" = precision, "Recall" = recall, "Accuracy" = accuracy))
}

#Cross validation of the classificatio in file level
file_classification_test(file_20, file_20)
file_classification_test(file_20, file_21)
file_classification_test(file_20, file_30)
file_classification_test(file_21, file_20)
file_classification_test(file_21, file_21)
file_classification_test(file_21, file_30)
file_classification_test(file_30, file_20)
file_classification_test(file_30, file_21)
file_classification_test(file_30, file_30)


#Classification funcion defination for eclipse packages.
pkg_classification_test <- function (train, test) 
{
  #Defining model relations for post release bugs
  model.glm <- glm((post>0) ~ pre + ACD_avg + ACD_max + ACD_sum + FOUT_avg + FOUT_max + FOUT_sum
                   + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOCU + NOF_avg
                   + NOF_max + NOF_sum + NOI_avg + NOI_max + NOI_sum + NOM_avg + NOM_max + NOM_sum
                   + NOT_avg + NOT_max + NOT_sum + NSF_avg + NSF_max + NSF_sum + NSM_avg + NSM_max
                   + NSM_sum + PAR_avg + PAR_max + PAR_sum + TLOC_avg + TLOC_max + TLOC_sum
                   + VG_avg + VG_max + VG_sum, data=train, family = "binomial")
  
  test.prob <- predict(model.glm, test, type="response")
  test.pred <- test.prob >= 0.50
  outcome <- table(factor(test$post>0, levels=c(F,T)), factor(test.pred, levels=c(F,T)))
  
  TN <- outcome[1,1]
  FN <- outcome[2,1]
  FP <- outcome[1,2]
  TP <- outcome[2,2]
  
  precision <- if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
  recall <- TP / (TP + FN)
  accuracy <- (TP + TN) / (TN + FN + FP + TP)
  defects <- (TP + FN) / (TN + FN + FP + TP)
  
  return (c("Defects" = defects, "Precision" = precision, "Recall" = recall, "Accuracy" = accuracy))
}

#Cross validation of the classificatio in package level
pkg_classification_test(package_20, package_20)
pkg_classification_test(package_20, package_21)
pkg_classification_test(package_20, package_30)
pkg_classification_test(package_21, package_20)
pkg_classification_test(package_21, package_21)
pkg_classification_test(package_21, package_30)
pkg_classification_test(package_30, package_20)
pkg_classification_test(package_30, package_21)
pkg_classification_test(package_30, package_30)

#Correlation on rank test for file
file_ranking_test <- function (train, test) 
{
  model.lm <- lm(post ~ pre + ACD + FOUT_avg + FOUT_max + FOUT_sum
                 + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max
                 + NBD_sum + NOF_avg + NOF_max + NOF_sum + NOI + NOM_avg
                 + NOM_max + NOM_sum + NOT + NSF_avg + NSF_max + NSF_sum
                 + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum
                 + TLOC + VG_avg + VG_max + VG_sum, data=train)
  
  test.pred <- predict(model.lm, test)
  
  r.squared <- summary(model.lm)$r.squared
  pearson <- cor(test$post, test.pred, method="pearson")
  spearman <- cor(test$post, test.pred, method="spearman")
  pearson.p <- cor.test(test$post, test.pred, method="pearson")$p.value
  spearman.p <- cor.test(test$post, test.pred, method="spearman", exact=FALSE)$p.value
  
  return (c("R-square"=r.squared, "Pearson" = pearson, "Spearman" = spearman,
            "Significant Pearson"=pearson.p<0.01, "Significant Spearman" = spearman.p<0.01))
}

#Test File ranking
file_ranking_test(file_20, file_20)
file_ranking_test(file_20, file_21)
file_ranking_test(file_20, file_30)
file_ranking_test(file_21, file_20)
file_ranking_test(file_21, file_21)
file_ranking_test(file_21, file_30)
file_ranking_test(file_30, file_20)
file_ranking_test(file_30, file_21)
file_ranking_test(file_30, file_30)

#Correlation on rank test for package
package_ranking_test <- function (train, test) 
{
  model.lm <- lm(post ~ pre + ACD_avg + ACD_max + ACD_sum + FOUT_avg
                 + FOUT_max + FOUT_sum + MLOC_avg + MLOC_max + MLOC_sum
                 + NBD_avg + NBD_max + NBD_sum + NOCU + NOF_avg + NOF_max
                 + NOF_sum + NOI_avg + NOI_max + NOI_sum + NOM_avg + NOM_max
                 + NOM_sum + NOT_avg + NOT_max + NOT_sum + NSF_avg + NSF_max
                 + NSF_sum + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max
                 + PAR_sum + TLOC_avg + TLOC_max + TLOC_sum + VG_avg
                 + VG_max + VG_sum, data=train)
  
  test.pred <- predict(model.lm, test)
  
  r.squared <- summary(model.lm)$r.squared
  pearson <- cor(test$post, test.pred, method="pearson")
  spearman <- cor(test$post, test.pred, method="spearman")
  pearson.p <- cor.test(test$post, test.pred, method="pearson")$p.value
  spearman.p <- cor.test(test$post, test.pred, method="spearman", exact=FALSE)$p.value
  
  return (c("R-square"=r.squared, "Pearson" = pearson, "Spearman" = spearman,
            "Significant Pearson"=pearson.p<0.01, "Significant Spearman" = spearman.p < 0.01))
}

#Test Package Ranking
package_ranking_test(package_20, package_20)
package_ranking_test(package_20, package_21)
package_ranking_test(package_20, package_30)
package_ranking_test(package_21, package_20)
package_ranking_test(package_21, package_21)
package_ranking_test(package_21, package_30)
package_ranking_test(package_30, package_20)
package_ranking_test(package_30, package_21)
package_ranking_test(package_30, package_30)

