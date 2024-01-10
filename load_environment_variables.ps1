# Load environment variables from .env file

# Parse file
get-content .env | foreach {
    $name, $value = $_.split('=')
    set-content env:\$name $value
}

