resource "exoscale_compute" "car-rental" {
  zone = var.zone
  display_name = "car-rental"
  template_id  = data.exoscale_compute_template.ubuntu.id
  size         = "Medium"
  disk_size    = 50
  key_pair     = exoscale_ssh_keypair.jschu.name
  state        = "Running"
  security_group_ids = [exoscale_security_group.car-rental.id]
  user_data = file("userdata/deploy.sh")
}