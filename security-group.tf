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

resource "exoscale_security_group_rule" "user-service" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 9001
  end_port = 9001
}

resource "exoscale_security_group_rule" "carrental-service" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 9002
  end_port = 9002
}

resource "exoscale_security_group_rule" "currency-converter" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 9000
  end_port = 9000
}

resource "exoscale_security_group_rule" "rabbitmq-1" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 15672
  end_port = 15672
}

resource "exoscale_security_group_rule" "rabbitmq-2" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 5672
  end_port = 5672
}

resource "exoscale_security_group_rule" "mongo" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 27017
  end_port = 27017
}

resource "exoscale_security_group_rule" "ssh" {
  security_group_id = exoscale_security_group.car-rental.id
  type = "INGRESS"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 22
  end_port = 22
}