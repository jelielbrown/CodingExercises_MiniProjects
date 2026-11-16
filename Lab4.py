# Author: Jeliel Brown
import csv
import matplotlib.pyplot

def load_csv(filename, fieldnames):
    data = {}
    with open(filename, "r") as file:
        reader = csv.DictReader(file, fieldnames = fieldnames)
        for key in reader.fieldnames:
            data[key] = []
        for row in reader:
            for key in row:
                data[key].append(float(row[key]))
    return data

apm_fields = ["time", "memory", "cpu"]
system_fields = ["time", "rx_bytes", "tx_bytes", "disk_access", "disk_utilization"]

apm1 = load_csv("Lab4/APM1_metrics.csv", apm_fields)
apm2 = load_csv("Lab4/APM2_metrics.csv", apm_fields)
apm3 = load_csv("Lab4/APM3_metrics.csv", apm_fields)
apm4 = load_csv("Lab4/APM4_metrics.csv", apm_fields)
apm5 = load_csv("Lab4/APM5_metrics.csv", apm_fields)
apm6 = load_csv("Lab4/APM6_metrics.csv", apm_fields)
system = load_csv("Lab4/system_metrics.csv", system_fields)

# CPU
matplotlib.pyplot.plot(apm1["time"], apm1["cpu"], color="blue", label="APM1")
matplotlib.pyplot.plot(apm2["time"], apm2["cpu"], color="black", label="APM2")
matplotlib.pyplot.plot(apm3["time"], apm3["cpu"], color="red", label="APM3")
matplotlib.pyplot.plot(apm4["time"], apm4["cpu"], color="green", label="APM4")
matplotlib.pyplot.plot(apm5["time"], apm5["cpu"], color="yellow", label="APM5")
matplotlib.pyplot.plot(apm6["time"], apm6["cpu"], color="cyan", label="APM6")
matplotlib.pyplot.title("CPU Utilization")
matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("CPU Utilization (%)")
matplotlib.pyplot.legend()
matplotlib.pyplot.savefig("cpu.png")
matplotlib.pyplot.clf()

# Memory
matplotlib.pyplot.plot(apm1["time"], apm1["memory"], color="blue", label="APM1")
matplotlib.pyplot.plot(apm2["time"], apm2["memory"], color="black", label="APM2")
matplotlib.pyplot.plot(apm3["time"], apm3["memory"], color="red", label="APM3")
matplotlib.pyplot.plot(apm4["time"], apm4["memory"], color="green", label="APM4")
matplotlib.pyplot.plot(apm5["time"], apm5["memory"], color="yellow", label="APM5")
matplotlib.pyplot.plot(apm6["time"], apm6["memory"], color="cyan", label="APM6")
matplotlib.pyplot.title("Memory Utilization")
matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("Memory Utilization (%)")
matplotlib.pyplot.legend()
matplotlib.pyplot.savefig("memory.png")
matplotlib.pyplot.clf()

#Bandwidth
matplotlib.pyplot.plot(system["time"], system["rx_bytes"], color="blue", label="RX")
matplotlib.pyplot.plot(system["time"], system["tx_bytes"], color="red", label="TX")
matplotlib.pyplot.title("Bandwidth Utilization")
matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("Bandwidth (Bytes/s)")
matplotlib.pyplot.legend()
matplotlib.pyplot.savefig("bandwidth.png")
matplotlib.pyplot.clf()

# Hard Disk
matplotlib.pyplot.plot(system["time"], system["disk_utilization"], color="purple", label="Disk Utilization")
matplotlib.pyplot.title("Hard Disk Utilization")
matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("Utilization (KB)")
matplotlib.pyplot.legend()
matplotlib.pyplot.savefig("disk_utilization.png")
matplotlib.pyplot.clf()

# Hard Disk Access Rates
matplotlib.pyplot.plot(system["time"], system["disk_access"], color="green", label="Disk Access")
matplotlib.pyplot.title("Hard Disk Access Rates")
matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("Access Rate (IOPS)")
matplotlib.pyplot.legend()
matplotlib.pyplot.savefig("disk_access.png")
matplotlib.pyplot.clf()

