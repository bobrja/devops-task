output "instance_public_ip" {
  description = "Public IP address of the Compute Engine instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_image_id" {
  description = "ID of the image used for the Compute Engine instance"
  value       = data.google_compute_image.image.self_link
}

output "instance_type" {
  description = "Instance type of the Compute Engine instance"
  value       = google_compute_instance.vm_instance.machine_type
}

output "instance_network" {
  description = "Name of the network the Compute Engine instance is connected to"
  value       = google_compute_network.vpc_network.name
}

output "instance_subnet" {
  description = "Name of the subnet the Compute Engine instance is connected to"
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
}

output "instance_zone" {
  description = "Zone where the Compute Engine instance is located"
  value       = google_compute_instance.vm_instance.zone
}
