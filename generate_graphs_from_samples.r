library(ggplot2)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_qft.csv")
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack (Rand. 1qb unitary)'
alldata <- avgtime

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qcgpu_qft.csv")
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'QCGPU'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qiskit_gpu_qft.csv")
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'Qiskit Aer GPU'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_qft_perm.csv")
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack (Rand. permutation)'
alldata <- rbind(alldata, avgtime)

names(alldata) <- c("Qubits", "Time (s)", "Simulator")
ggplot(alldata, aes(`Qubits`, `Time (s)`, colour = `Simulator`)) + ggtitle("N-qubit QFT") + xlab("Qubits") + ylab("Time (s)") + labs(caption="All series are GPU simulators on an Alienware 17, BIOS version 1.8.0, Ubuntu 20.04,\nIntel(R) Core(TM) i9-10980HK CPU @ 2.40GHz, NVIDIA GeForce RTX 2070 Super") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line() 

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_random_circuit.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack'
alldata <- avgtime

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qcgpu_random_circuit.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'QCGPU'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qiskit_gpu_random_circuit.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'Qiskit Aer GPU'
alldata <- rbind(alldata, avgtime)

names(alldata) <- c("Qubits", "Time (s)", "Simulator")
ggplot(alldata, aes(`Qubits`, `Time (s)`, colour = `Simulator`)) + ggtitle("N-qubit random circuit to depth=20, [SWAP,CZ,CX,CCX]/[H,X,Y,Z,T]") + xlab("Qubits") + ylab("Time (s)") + labs(caption="All series are GPU simulators on an Alienware 17, BIOS version 1.8.0, Ubuntu 20.04,\nIntel(R) Core(TM) i9-10980HK CPU @ 2.40GHz, NVIDIA GeForce RTX 2070 Super") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line()

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_random_circuit.csv")
rawdata <- rawdata[ , 2:4]
names(rawdata) <- c("Qubits", "Depth", "Seconds")
avgtime <- aggregate(x = rawdata$Seconds, by = list(rawdata$Qubits, rawdata$Depth), FUN = mean)
names(avgtime) <- c("Qubits", "Depth", "Seconds")
widths <- unique(avgtime$Qubits)
depths <- unique(avgtime$Depth)
mtrx <- matrix(nrow=length(widths), ncol=length(depths))
rownames(mtrx) <- widths
colnames(mtrx) <- depths
row <- 1
for (width in 1:length(widths)) {
  for (depth in 1:length(depths)) {
    mtrx[width, depth] <- avgtime[row, 3]
    row = row + 1
  }
}
heatmap(mtrx, Rowv=NA, Colv=NA)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_sycamore.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack'
alldata <- avgtime

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qcgpu_sycamore_approximation.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'QCGPU (approx.*)'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qiskit_gpu_sycamore.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'Qiskit Aer GPU'
alldata <- rbind(alldata, avgtime)

names(alldata) <- c("Qubits", "Time (s)", "Simulator")
ggplot(alldata, aes(`Qubits`, `Time (s)`, colour = `Simulator`)) + ggtitle("N-qubit rectangular 'Sycamore' to depth=20") + xlab("Qubits") + ylab("Time (s)") + labs(caption="All series are GPU simulators on an Alienware 17, BIOS version 1.8.0, Ubuntu 20.04,\nIntel(R) Core(TM) i9-10980HK CPU @ 2.40GHz, NVIDIA GeForce RTX 2070 Super") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line()

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_single_qubits.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack'
alldata <- avgtime

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qcgpu_single_qubits.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'QCGPU'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qiskit_gpu_single_qubits.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'Qiskit Aer GPU'
alldata <- rbind(alldata, avgtime)

names(alldata) <- c("Qubits", "Time (s)", "Simulator")
ggplot(alldata, aes(`Qubits`, `Time (s)`, colour = `Simulator`)) + ggtitle("Single qubits to depth=20 across width=n") + xlab("Qubits") + ylab("Time (s)") + labs(caption="All series are GPU simulators on an Alienware 17, BIOS version 1.8.0, Ubuntu 20.04,\nIntel(R) Core(TM) i9-10980HK CPU @ 2.40GHz, NVIDIA GeForce RTX 2070 Super") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line()

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/pyqrack_random_ccx.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'PyQrack'
alldata <- avgtime

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qcgpu_random_ccx.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'QCGPU'
alldata <- rbind(alldata, avgtime)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_10-10-21/qiskit_gpu_random_ccx.csv")
rawdata <- rawdata[ which(rawdata$depth == 20), ]
avgtime <- aggregate(x = rawdata$time, by = list(rawdata$num_qubits), FUN = mean)
avgtime$Simulator <- 'Qiskit Aer GPU'
alldata <- rbind(alldata, avgtime)

names(alldata) <- c("Qubits", "Time (s)", "Simulator")
ggplot(alldata, aes(`Qubits`, `Time (s)`, colour = `Simulator`)) + ggtitle("Random fully connected CCX to depth=20 across width=n") + xlab("Qubits") + ylab("Time (s)") + labs(caption="All series are GPU simulators on an Alienware 17, BIOS version 1.5.1, Ubuntu 20.04,\nIntel(R) Core(TM) i9-10980HK CPU @ 2.40GHz, NVIDIA GeForce RTX 3080 Laptop GPU") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line()
