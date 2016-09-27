# Send stream Carriots using Swift
Repository of the Carriots class at Swift 3 to send stream

Class to send stream to Carriots for IoT projects using language Swift

## Example:
    
    let apikey = "YOUR APIKEY HERE"
    
    let device = "YOUR DEVICE's ID_DEVELOPER HERE"
    
    let carriots = Carriots(api_key: apikey, device: device)
    
    var data: Dictionary<String, AnyObject>
    
    data = ["clave1":"valor1" as AnyObject, "clave2":["subvalor" : 1 as AnyObject] as AnyObject, "clave3":"valor3" as AnyObject]
    
    carriots.send_stream(data)
