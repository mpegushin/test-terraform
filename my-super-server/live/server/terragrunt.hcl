terraform {
  source = "../../modules/super-server"
}

include { path = find_in_parent_folders() }

inputs = {
  cloud             = "timeweb"
  name              = "test-server"
  location          = "ru-1"
  availability_zone = "spb-3"
}
