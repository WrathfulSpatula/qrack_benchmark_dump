library(ggplot2)

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_3-4-21/2021-03-04_g4dn-2x_qft.csv")
names(rawdata) <- c("Qubits", "Time (ms)", "Standard Deviation", "Q0", "Q1", "Q2", "Q3", "Q4", "Simulator")
ggplot(rawdata, aes(`Qubits`, `Time (ms)`, colour = `Simulator`)) + ggtitle("N-Qubit QFT") + xlab("Qubits") + ylab("Time (ms)") + labs(caption="All series are GPU simulators on AWS EC2 gd4n.2xlarge instances running Ubuntu 20.04") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line() 

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_3-4-21/2021-03-04_g4dn-2x_random-circuit.csv")
names(rawdata) <- c("Qubits", "Time (ms)", "Standard Deviation", "Q0", "Q1", "Q2", "Q3", "Q4", "Simulator")
ggplot(rawdata, aes(`Qubits`, `Time (ms)`, colour = `Simulator`)) + ggtitle("N-Qubit Random Circuit, Depth of 20") + xlab("Qubits") + ylab("Time (ms)") + labs(caption="All series are GPU simulators on AWS EC2 gd4n.2xlarge instances running Ubuntu 20.04") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line() 

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_3-4-21/2021-03-04_g4dn-2x_sycamore.csv")
names(rawdata) <- c("Qubits", "Time (ms)", "Standard Deviation", "Q0", "Q1", "Q2", "Q3", "Q4", "Simulator")
ggplot(rawdata, aes(`Qubits`, `Time (ms)`, colour = `Simulator`)) + ggtitle("N-Qubit 'Sycamore' Circuit, Depth of 20") + xlab("Qubits") + ylab("Time (ms)") + labs(caption="All series are GPU simulators on AWS EC2 gd4n.2xlarge instances running Ubuntu 20.04") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line() 

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_3-4-21/2021-03-04_g4dn-2x_qrack_qft_optimization.csv")
names(rawdata) <- c("Qubits", "Time (ms)", "Standard Deviation", "Q0", "Q1", "Q2", "Q3", "Q4", "Simulator")
ggplot(rawdata, aes(`Qubits`, `Time (ms)`, colour = `Simulator`)) + ggtitle("Qrack N-Qubit QFT, Various Initializations") + xlab("Qubits") + ylab("Time (ms)") + labs(caption="All series are GPU simulators on AWS EC2 gd4n.2xlarge instances running Ubuntu 20.04") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28)) + scale_y_log10() + geom_line() 

rawdata <- read.csv(file="/home/iamu/GitHub/qrack_benchmark_dump/qrack_benchmarks_3-4-21/2021-03-06_g4dn-x12_qrack_ccz-ccx-h_f.csv")
names(rawdata) <- c("Qubits", "Time (ms)", "Standard Deviation", "Q0", "Q1", "Q2", "Q3", "Q4")
ggplot(rawdata, aes(`Qubits`, `Time (ms)`)) + ggtitle("Qrack \"test_ccz_ccx_h\" on x4 NVIDIA Tesla T4 GPUs") + xlab("Qubits") + ylab("Time (ms)") + labs(caption="Run on an AWS EC2 gd4n.12xlarge instance, with 4 NVIDIA Tesla T4 GPUs, running Ubuntu 20.04") + scale_x_continuous(breaks=c(4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34)) + scale_y_log10() + geom_line() 
