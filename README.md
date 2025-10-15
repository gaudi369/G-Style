# G-Style
streamlined and opinionated data aggregator setup for internet of things

## Technologies Used
- raspberry pi 3b+ 
- diet pi OS
- git
- bash install script
- hostapd, dnsmasq, nftables
- network namespace
- MQTT (for now)
- Grafana (for now)

## Goal Spec
- single hub system (nodes, hub, cloud/home network; never more than 2 "hops")
- should be performant and scalable on raspberry pi 3b+ equivalent hardware ($45)
- FOSS
- there should be a "happy path" / easy way to do things inside spec
- local-first
- hub should be plugged into ethernet uplink

## Design
Data Generation (Nodes) -> Data Ingestion -> Render / React -> Downsample and Store
Other analytics can be preformed on a seperate node from Store

## Goal Usage
Download DietPi onto a Raspberry Pi 3b+ or equivalent device.
Only git is needed to clone. The CLI installs everything else automatically.

sudo apt update
sudo apt install -y git
git clone https://github.com/<you>/gstyle.git
cd gstyle
chmod +x g-style scripts/*.sh

./g-style start    # everything comes up
./g-style status   # versions, state report, live MQTT check
./g-style stop     # everything comes down

### Milestones
0.1: ping via mqtt within the pi, namespace teardown verification
0.2: hotspot up and hotspot down cleanly
0.3: test with simple esp32 node
0.4: implement storage to csv
0.5: implement rendering via grafana

### Of Interest
- custom aggregator
- Zig (in general)
- LSM Tree Database
- Wire Guard

### Project Inspirations
Omarchy
Tiger Style / Tiger Beetle

