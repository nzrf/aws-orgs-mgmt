#Setting up application top level org ou. Need to figure out how to make this a module.
resource "aws_organizations_organizational_unit" "application" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organization.org]
    name =  "application"
    parent_id = aws_organizations_organization.org.roots[0].id
}

#Setting up infrastructure top level org ou. Need to figure out how to make this a module.
resource "aws_organizations_organizational_unit" "infrastructure" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organization.org]
    name =  "infrastructure"
    parent_id = aws_organizations_organization.org.roots[0].id
}

#Setting up nonprod org unit under application. Need to figure out how to make this more clear or a module.
resource "aws_organizations_organizational_unit" "app_nonprod" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organizational_unit.application]
    name =  "nonprod"
    parent_id = aws_organizations_organizational_unit.application.id
}