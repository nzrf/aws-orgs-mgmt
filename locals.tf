locals {
  root = aws_organizations_organization.org.id
}

locals {
  application = aws_organizations_organizational_unit.application.id
}

locals {
  application-nonprod = aws_organizations_organizational_unit.app_nonprod.id
}
