$Cache:Help = @{}

$Navigation = @(
    New-UDListItem -Label "Home" -OnClick { Invoke-UDRedirect -Url "/powershell-universal" }
    New-UDListItem -Label "Layout" -Children {
        New-UDListItem -Label "Grid" -OnClick { Invoke-UDRedirect -Url '/grid' }
    }
    New-UDListItem -Label "Inputs" -Children {
        New-UDListItem -Label "Autocomplete" -OnClick { Invoke-UDRedirect -Url '/autocomplete' } 
        New-UDListItem -Label "Button" -OnClick { Invoke-UDRedirect -Url "/button" }
        New-UDListItem -Label "Checkbox" -OnClick { Invoke-UDRedirect -Url '/checkbox' }
        New-UDListItem -Label "Code Editor" -OnClick { Invoke-UDRedirect -Url '/code-editor' }
        New-UDListItem -Label "Date Picker" -OnClick { Invoke-UDRedirect -Url '/date-picker' }
        New-UDListItem -Label "Floating Action Button" -OnClick { Invoke-UDRedirect -Url '/floating-action-button' }
        New-UDListItem -Label "Form" -OnClick { Invoke-UDRedirect -Url '/form' }
        New-UDListItem -Label "Icon Button" -OnClick {}
        New-UDListItem -Label "Radio" -OnClick { Invoke-UDRedirect -Url '/radio' }
        New-UDListItem -Label "Select" -OnClick { Invoke-UDRedirect -Url '/select'}
        New-UDListItem -Label "Slider" -OnClick { Invoke-UDRedirect -Url '/slider'}
        New-UDListItem -Label "Switch" -OnClick { Invoke-UDRedirect -Url '/switch'}
        New-UDListItem -Label "Textbox" -OnClick { Invoke-UDRedirect -Url '/textbox' }
        New-UDListItem -Label "Time Picker" -OnClick { Invoke-UDRedirect -Url '/time-picker' }
    }
    New-UDListItem -Label "Navigation" -Children {
        New-UDListItem -Label "Drawer" -OnClick {}
        New-UDListItem -Label "Link" -OnClick {}
        New-UDListItem -Label "Stepper" -OnClick { Invoke-UDRedirect -Url '/stepper' }
        New-UDListItem -Label "Tabs" -OnClick { Invoke-UDRedirect -Url '/tabs' }
    }
    New-UDListItem -Label "Surfaces" -Children {
        New-UDListItem -Label "AppBar" -OnClick { Invoke-UDRedirect -Url "/appbar" }
        New-UDListItem -Label "Card" -OnClick { Invoke-UDRedirect -Url '/card' }
        New-UDListItem -Label "Paper" -OnClick { Invoke-UDRedirect -Url '/paper' }
        New-UDListItem -Label "Expansion Panel" -OnClick { Invoke-UDRedirect -Url '/expansion-panel' }
    }
    New-UDListItem -Label "Feedback" -Children {
        New-UDListItem -Label "Modal" -OnClick { Invoke-UDRedirect -Url '/modal' }
        New-UDListItem -Label "Progress" -OnClick { Invoke-UDRedirect -Url '/progress' }
        New-UDListItem -Label "Toast" -OnClick { Invoke-UDRedirect -Url '/toast' }
    }
    New-UDListItem -Label "Data Display" -Children {
        New-UDListItem -Label "Avatar" -OnClick { Invoke-UDRedirect -Url '/avatar' } 
        New-UDListItem -Label "Chips" -OnClick {  Invoke-UDRedirect -Url '/chips'  }
        New-UDListItem -Label "Icons" -OnClick { Invoke-UDRedirect -Url '/icons' }
        New-UDListItem -Label "List" -OnClick { Invoke-UDRedirect -Url '/list' }
        New-UDListItem -Label "Table" -OnClick { Invoke-UDRedirect -Url '/table' }
        New-UDListItem -Label "Tree View" -OnClick { Invoke-UDRedirect -Url '/tree-view' }
        New-UDListItem -Label "Typography" -OnClick { Invoke-UDRedirect -Url '/typography' }
    }
    New-UDListItem -Label "Data Visualization" -Children {
        New-UDListItem -Label 'Nivo' -Children {
            New-UDListItem -Label "Overview" -OnClick { Invoke-UDRedirect -Url '/nivo' }
            New-UDListItem -Label "Bar" -OnClick { Invoke-UDRedirect -Url '/nivo-bar' }
            New-UDListItem -Label "Calendar" -OnClick { Invoke-UDRedirect -Url '/nivo-calendar' }
            New-UDListItem -Label "Heatmap" -OnClick { Invoke-UDRedirect -Url '/nivo-heatmap' }
            New-UDListItem -Label "Line" -OnClick { Invoke-UDRedirect -Url '/nivo-line' }
            New-UDListItem -Label "Stream" -OnClick { Invoke-UDRedirect -Url '/nivo-stream' }
            New-UDListItem -Label "Treemap" -OnClick { Invoke-UDRedirect -Url '/nivo-treemap' }
        }
        New-UDListItem -Label "Map" -OnClick { Invoke-UDRedirect -Url '/map' }
    }
)

function New-ComponentPage {
    param(
        [Parameter(Mandatory)]
        [string]$Title, 
        [Parameter(Mandatory)]
        [string]$Description, 
        [Parameter()]
        [string]$SecondDescription, 
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)] 
        [string[]]$Cmdlet
        ) 

    $AdditionalParameters = @{}

    New-UDPage @AdditionalParameters -Name $Title -Navigation $Navigation -Content {
        
        New-UDContainer {
            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDTypography -Text $Title -Variant 'h2' 
            }
        
            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDTypography -Text $Description -Variant 'h4'
            }

            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDElement -Tag 'div' -Content { $SecondDescription }
            }

      
    
            Invoke-Expression $Content.ToString()

            $Columns = @(
                New-UDTableColumn -Title 'Name' -Property 'name' 
                New-UDTableColumn -Title 'Type' -Property 'type' 
                New-UDTableColumn -Title 'Description' -Property 'description'
                New-UDTableColumn -Title 'Required' -Property 'required' 
            )
    
            New-UDElement -Tag 'div' -Attributes @{ style = @{ marginTop = "20px"; marginBottom = "20px"}} -Content {
                New-UDTypography -Text 'Parameters' -Variant h4
            }
    
            New-UDDynamic -Content {
                foreach($item in $Cmdlet)
                {
                    if ($Cache:Help.ContainsKey($item)) {
                        $Parameters = $Cache:Help[$item]
                    }
                    else 
                    {
                        $Parameters = (Get-Command $item).Parameters.GetEnumerator() | ForEach-Object {
                            $Parameter = $_.Key
        
                            $Help = Get-Help -Name $item -Parameter $Parameter -ErrorAction SilentlyContinue
                            
                            if ($null -ne $Help)
                            {
                                @{
                                    name = $Help.name 
                                    type = $Help.type.name
                                    description = $Help.description.text
                                    required = $Help.required
                                }
                            }
                        }
                        $Cache:Help[$item] = $Parameters
                    }
                    
                    if ($Parameters)
                    {
                        New-UDTable -Title $item -Data $Parameters -Columns $Columns
                    }
                }
            }
        } 
    }
}

function New-Example {
    param($Title, $Description, [ScriptBlock]$Example)

    New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content { }

    New-UDTypography -Text $Title -Variant 'h4'
    New-UDElement -Tag 'div' -Content { $Description }

    New-UDTabs -Tabs {
        New-UDTab -Text 'Example' -Content {
            New-UDElement -tag 'div' -Attributes @{
                style = @{
                    minHeight = '100px'
                    width = '100%'
                }
            } -Content $Example
        }
        New-UDTab -Text 'Script' -Content {
            New-UDElement -Tag div -Attribute @{ style = @{ height = "250px"}} -Content {
                New-UDCodeEditor -Language powershell -ReadOnly -Code $Example.ToString().Trim() -Height '250px' -AutoSize
            }
        }
    } 
}

$Pages = @()
$Pages += New-UDPage @AdditionalParameters -Name "PowerShell Universal" -Navigation $Navigation -Content {

    New-UDContainer {
        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 3 -Content {
                New-UDImage -Url 'https://github.com/ironmansoftware/universal-dashboard/raw/master/images/logo.png'
            }
            New-UDGrid -Item -SmallSize 9 -Content { 
                New-UDTypography -Text 'PowerShell Universal' -Variant h2 
                New-UDTypography -Text "The ultimate platform for building web-based IT tools" -Variant h4
                New-UDButton -Variant outlined -Text "Get Started" -OnClick { Invoke-UDRedirect -Url "https://www.ironmansoftware.com/downloads" }
            }
        }

        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Installation" -Content {
                    New-UDTypography -Text "Install on Windows, Linux, or as a Docker container." -Paragraph
                    New-UDButton -Variant outlined -Text "Download" -OnClick { Invoke-UDRedirect -Url "https://www.ironmansoftware.com/downloads" }
                }
            }

            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Get Started" -Content {
                    New-UDTypography -Text "Learn more on our docs" -Paragraph
                    New-UDButton -Variant outlined -Text "Learn More" -OnClick { Invoke-UDRedirect -Url "https://docs.ironmansoftware.com/getting-started" }
                }
            }
        }

        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Templates" -Content {
                    New-UDTypography -Text "Get started with our template library" -Paragraph
                    New-UDButton -Variant outlined -Text "View Now" -OnClick { Invoke-UDRedirect -Url "https://github.com/ironmansoftware/universal-templates" }
                }
            }

            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Forums" -Content {
                    New-UDTypography -Text "Join the growing community of PSU users." -Paragraph
                    New-UDButton -Variant outlined -Text "Join Now" -OnClick { Invoke-UDRedirect -Url "https://forums.universaldashboard.io" }
                }
            }
        }

        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Admin Console" -Content {
                    New-UDTypography -Text "Check out the admin console for Universal. Login with Admin and any password. " -Paragraph
                    New-UDButton -Variant outlined -Text "View Now" -OnClick { Invoke-UDRedirect -Url "https://demo.ironmansoftware.com/admin" -OpenInNewWindow }
                }
            }
        }

        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Source" -Content {
                    New-UDTypography -Text "Check out the sourec for this Universal instance." -Paragraph
                    New-UDButton -Variant outlined -Text "View Now" -OnClick { Invoke-UDRedirect -Url "https://github.com/ironmansoftware/poshud.com" -OpenInNewWindow }
                }
            }
        }
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "pages") -Recurse -File | ForEach-Object {
    $Page = . $_.FullName
    $Pages += $Page
}

New-UDDashboard -Title "PowerShell Universal" -Pages $Pages