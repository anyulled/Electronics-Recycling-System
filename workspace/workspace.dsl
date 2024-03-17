workspace {
    name "Conference Kata"
    description "The software architecture of Going Green Kata."

    !adrs adrs
    !docs docs

    model {
        customer = person "Customer"

        softwareSystem = softwareSystem "Going Green" "System desgin for Going Green" {
            website = container "Website" "Website"
            desktopApp = container "Desktop App" "Desktop App"
            asssessment = container "Device Assessment" "Device Assessment" {
                inventory = component "Inventory" "Inventory"
                quoting = component "Quoting" "Quoting Engine"
                deprecation = component "Deprecation" "Deprecation Engine"
            }
            inventoryDb = container "Database" "Database"
            payment = container "Payment" "Payment"
            mailService = container "Email Integration" "Handles sending and receiving boxes for electronics." "Email Integration"
        }

        ebay = softwareSystem "eBay" "Platform used for selling electronics that are in good condition."{
            ebayContainer = container "eBay Container" "eBay Container"
        }

        deploymentEnvironment "AWS" {
            deploymentNode "AWS Cloud" {
                deploymentNode "Elastic Beanstalk" "PaaS for deploying applications" "AWS Elastic Beanstalk" {
                    containerInstance website "Runs the Web Application"
                    containerInstance desktopApp "Hosts the Kiosk Application"
                }
                deploymentNode "RDS" "Managed relational database service" "AWS RDS" {
                    containerInstance inventoryDb "Stores electronic types, rules, and inventory" "MySQL"
                }
                deploymentNode "Lambda" "Serverless compute service" "AWS Lambda" {
                    containerInstance mailService "Manages sending and receiving boxes"
                    containerInstance asssessment "Assesses condition and routes electronics"
                }
                deploymentNode "S3" "Object storage service" "AWS S3" {
                    containerInstance payment "Stores quote requests and assessments"
                }
                deploymentNode "EC2" "Scalable compute capacity" "AWS EC2" {
                    containerInstance ebayContainer "Manages listings on eBay"
                }
            }

            customer -> website "get quotation"
            customer -> desktopApp "get quotation"
            website -> asssessment "get assessment"
            desktopApp -> asssessment "get assessment"
            asssessment -> payment "emit order"
            asssessment -> ebay "Sell item"
            payment -> customer "pay check"
            website -> mailService "send box"
            mailService -> customer "Sends box to"
            mailService -> asssessment "Delivers electronic for assessment"
        }
    }

    views {
        systemLandscape softwareSystem {
            title "Going Green Landscape"
            include *
        }
        container softwareSystem {
            title "Going Green Landscape"
            include *
        }
        component asssessment {
            include *
        }
        dynamic softwareSystem {
            customer -> website "Requests quote for electronic"
            website -> mailService "Quote accepted, initiates mail service"
            mailService -> customer "Sends box to"
            customer -> mailService "Sends electronic back in box to"
            mailService -> asssessment "Delivers electronic for assessment"
            asssessment -> ebay "Sells on"
            autolayout lr
        }
         deployment * "AWS" {
            include *
            autolayout lr
        }

        styles {
            element "Group:Third-party" {
                border dotted
                color #AA0000
                background #BB0000
                opacity 75
            }
            element "external" {
                shape component
                background #000088
            }
            element "Database" {
                color #FFFFFF
                background #00aa00
            }
            element "speaker" {
                background #000000
                color #ffffff
            }

            element "organizer" {
                background #002454
                color #ffffff
            }
            element "sponsor" {
                background #FF0000
                color #ffffff
            }
            element "Database" {
                shape cylinder
            }
            element "website" {
                shape WebBrowser
            }
            element "Ubuntu" {
                color #E95420
                background #E95420
                stroke #E95420
                icon "images/ubuntu-logo.jpeg"
            }
            relationship "gRPC" {
                color #000088
                style dotted
            }
        }

        theme default
        themes https://static.structurizr.com/themes/amazon-web-services-2023.01.31/theme.json
        themes https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json
    }

}
