import json
import sys

def main():
    input_data = json.loads(sys.stdin.read())
    project_id = input_data['project_id']
    network_name = input_data['network_name']

    rules = [
        {
            "name": "allow-egress-to-master",
            "direction": "EGRESS",
            "source_ranges": ["172.16.0.0/28"], # GKE master CIDR
            "target_tags": ["gke-node"],
            "protocol": "tcp",
            "ports": ["443", "10250"],
            "source_tags": [],
            "destination_ranges": [],
        },
        {
            "name": "allow-inter-node",
            "direction": "INGRESS",
            "source_ranges": [],
            "target_tags": ["gke-node"],
            "protocol": "tcp",
            "ports": ["0-65535"],
            "source_tags": ["gke-node"],
            "destination_ranges": [],
        },
        {
            "name": "allow-inter-pod",
            "direction": "INGRESS",
            "source_ranges": ["10.0.0.0/24"], # Subnet CIDR
            "target_tags": ["gke-node"],
            "protocol": "tcp",
            "ports": ["0-65535"],
            "source_tags": [],
            "destination_ranges": [],
        }
    ]

    result = {"rules": rules}
    print(json.dumps(result))

if __name__ == "__main__":
    main()