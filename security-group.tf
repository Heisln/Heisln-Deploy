resource "exoscale_security_group" "car-rental" {
  name = "car-rental"
  description = "This is the security group for the car rental application"
}

resource "exoscale_security_group_rule" "frontend" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 8100
  end_port = 8100
}

resource "exoscale_security_group_rule" "api" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 8000
  end_port = 8000
}

resource "exoscale_security_group_rule" "db" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 3306
  end_port = 3306
}

resource "exoscale_security_group_rule" "currency-converter" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 9000
  end_port = 9000
}

resource "exoscale_security_group_rule" "ssh" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 22
  end_port = 22
}