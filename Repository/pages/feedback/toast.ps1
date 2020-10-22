New-ComponentPage -Title 'Toast' -Description 'Popup notifications' -Content {
    New-Example -Title 'Toast message from form' -Description 'Shows a toast message based on the text entered' -Example {
New-UDForm -Content {
    New-UDTextbox -Id 'message' -Label 'Message'
} -OnSubmit {
    Show-UDToast -Message $EventData.message
}
    }
} -Cmdlet "Show-UDToast"