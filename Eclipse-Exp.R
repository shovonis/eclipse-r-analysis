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

#pre setting the varriables
pre.p <- rep (-1, 33)
post.p <- rep (-1, 33)
for (i in 3:35) {
  pre.p[i-2] <- cor.test(file_30[,i], file_30$pre, method="spearman", exact=FALSE)$p.value
  post.p[i-2] <- cor.test(file_30[,i], file_30$post, method="spearman", exact=FALSE)$p.value
}
cor(file_30[,3:35], file_30$pre, method="spearman")

cbind(cor(file_30[,3:35], file_30$pre, method="spearman"), cor(file_30[,3:35], file_30$post, method="spearman"), (pre.p<0.01), (post.p<0.01))

pre.p <- rep (-1, 42)
post.p <- rep (-1, 42)

for(i in 3:45) {
  pre.p[i-2] = cor.test(package_30[, i], package_30$pre, method = "spearman", exact = FALSE)$p.value
  post.p[i-2] = cor.test(package_30[, i], package_30$post, method = "spearman", exact = FALSE)$p.value
}

