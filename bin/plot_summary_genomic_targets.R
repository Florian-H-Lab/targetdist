
library(ggplot2)
library(tidyverse)
library(dplyr)

tablecounts_peakachu <- read.delim("/home/flow/Documents/targetdist/out/peakachu.csv", header=F)
tablecounts_peakachu[,3] <- rep("PEAKachu", nrow(tablecounts_peakachu)) 

tablecounts_pureclip <- read.delim("/home/flow/Documents/targetdist/out/pureclip.csv", header=F)
tablecounts_pureclip[,3] <- rep("PureCLIP", nrow(tablecounts_pureclip)) 

tablecounts_piranha <- read.delim("/home/flow/Documents/targetdist/out/piranha.csv", header=F)
tablecounts_piranha[,3] <- rep("Piranha", nrow(tablecounts_piranha)) 

tablecounts <- data.frame(tablecounts_peakachu)
tablecounts <- rbind(tablecounts, tablecounts_pureclip)
tablecounts <- rbind(tablecounts, tablecounts_piranha)
tablecounts <- cbind(tablecounts, rep("", nrow(tablecounts)))

colnames(tablecounts) <- c('Target', 'counts', 'method', 'dummy')

# impose factor order
order_targets = c("rRNA", "tRNA", "snoRNA", "snRNA", "lincRNA", "misc_ncRNA", "pseudogene", "protcod_as", "3UTR", "5UTR", "exon", "intron", "antisense", "not_annotated")
tablecounts$Target <- factor(tablecounts$Target, levels=order_targets, ordered=T)

# compare peakachu versus pureclip peaks for all proteins
pdf(file="/home/flow/Documents/targetdist/target_distribution.pdf", width = 5, height = 4)
ggplot(tablecounts) +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_blank(),
        text=element_text(family="Times", size=15)) + 
  geom_bar(aes(x=dummy, fill=Target, weight=counts), position="fill") +
  facet_grid(method ~ dummy) +
  coord_flip() 
dev.off()
  
