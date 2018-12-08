# To just get the graphs in the performance document, just run this top section, changing the input file name and labels
options(scipen=4, digits=3)
eqTable <- data.frame(MinQubit=integer(), Base=numeric(), Intercept=numeric(), RSqr=numeric(), BaseP=numeric(), InterceptP=numeric(), ModelP=numeric())

# The input file name goes here
testData <- read.csv(file="/home/iamu/Github/qrack_benchmark_dump/qft_all.csv", header=TRUE, sep=",")
names(testData) <- c("Count", "AvgT",	"SDT", "Q0", "Q1", "Q2", "Q3", "Q4", "Type")

require(ggplot2)
ggplot(testData, aes(x=factor(Count), y=AvgT, colour = factor(Type))) +
  scale_colour_discrete(name = "Engine Type") +
  geom_boxplot(outlier.size=0, fill = "white", position="identity", alpha=.5)  +
  stat_summary(fun.y=median, geom="line", aes(group=factor(Type)), size=1) + scale_y_log10() +
  ggtitle ("QFT on N Qubits") +
  xlab("N (No. of Qubits)") +
  ylab("Average Time (ms)")

##################################### Everything below here is scratch work ######################################

# Fuction for overall model p-value
lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F)
  attributes(p) <- NULL
  return(p)
}

# Load data
testData <- read.csv(file="/home/iamu/Github/qrack_benchmark_dump/cnot_all.csv", header=TRUE, sep=",")
names(testData) <- c("Count", "AvgT",	"SDT", "Q0", "Q1", "Q2", "Q3", "Q4", "Type")
firstTrendPoint <- 16
lastTrendPoint <- 22
as.numeric(as.matrix(testData[2,firstTrendPoint:lastTrendPoint]))
log(as.numeric(as.matrix(testData[2,firstTrendPoint:lastTrendPoint])))
# Freely varied log base scaling:
modelY <- log(as.numeric(as.matrix(testData[2,firstTrendPoint:lastTrendPoint])))
modelX <- c(17:23)
exponential.model <- lm(modelY~modelX)
modelSummary<-summary(exponential.model)
modelSummary
coefs <- coef(exponential.model)
newdata=data.frame(modelX=c(1:38))
predictions=data.frame(exp(predict(exponential.model, newdata)))
write.csv(predictions, file="/home/iamu/Github/qrack_benchmark_dump/qft_predictions.csv")

# Add to equations table:
eqRow <- data.frame(
  MinQubit=(firstTrendPoint + testData[1,1] - 1),
  Base=coefs[[2]],
  Intercept=(coefs[[1]] / coefs[[2]]),
  RSqr=modelSummary$r.squared,
  BaseP=modelSummary$coefficients[2,4],
  InterceptP=modelSummary$coefficients[1,4],
  ModelP=lmp(exponential.model)
)
row.names(eqRow)<-c('CLAND')
eqTable <- rbind(eqTable, eqRow)

qExpTrend <- exp(predict(exponential.model))
boxplot(testData[c(4,5,6,7,8),], log="y", names=testData[1,], main="X Time vs. No. of Qubits", xlab="No. of Qubits", ylab="Time (ms)")
lines(testData[1,firstTrendPoint:lastTrendPoint] - testData[1,1] + 1, qExpTrend,lwd=2, col = "red", xlab = "No. of Qubits", ylab = "Time (ms)")
# coords <- locator()
text(x=coords$x, y=coords$y, labels=paste('t ≈ exp[', round(coefs[[2]], 2), '( n - ', -round(coefs[[1]] / coefs[[2]], 2), ')]'))

# Exact log(2) scaling fixed:
modelY <- (log(testData[2,firstTrendPoint:lastTrendPoint]) - (log(2) * testData[1,firstTrendPoint:lastTrendPoint]))
modelX <- rep(1, times=length(testData[1,firstTrendPoint:lastTrendPoint]))
exponential.model <- lm(modelY~modelX)
summary(exponential.model)
coefs <- coef(exponential.model)

qExpTrend <- exp(predict(exponential.model) + (log(2) * testData[1,firstTrendPoint:lastTrendPoint]))
boxplot(testData[c(4,5,6,7,8),], log="y", names=testData[1,], main="X Time vs. No. of Qubits", xlab="No. of Qubits", ylab="Time (ms)")
lines(testData[1,firstTrendPoint:lastTrendPoint] - testData[1,1] + 1, qExpTrend,lwd=2, col = "red", xlab = "No. of Qubits", ylab = "Time (ms)")
# coords <- locator()
text(x=coords$x, y=coords$y, labels=paste('t ≈ 2^( n - ', -round(coefs[[1]] / log(2), 2), ')'))

require(ggplot2)
ggplot(testData, aes(x=factor(Count), y=AvgT, colour = factor(Type))) +
  scale_colour_discrete(name = "Engine Type") +
  geom_boxplot(outlier.size=0, fill = "white", position="identity", alpha=.5)  +
  stat_summary(fun.y=median, geom="line", aes(group=factor(Type)), size=1) + scale_y_log10() +
  ggtitle ("QFT on N Qubits") +
  xlab("N (No. of Qubits)") +
  ylab("Average Time (ms)")

orderedEqTable <- eqTable[order(Intercept, Base, MinQubit),]
