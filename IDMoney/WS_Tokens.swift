 import Foundation 
public class WS_Tokens {
 public var Url:String = "http://cgpvx-demo.cloudapp.net/Servicios/WS_Tokens.asmx"
 public var Host:String = "cgpvx-demo.cloudapp.net"
    public func dataToBase64(data:NSData)->String{
        
        let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return result;
    }
    public func dataToBase64(data: Data)->String {
        let result = data.base64EncodedString()
        return result
    }
    public func byteArrayToBase64(data:[UInt])->String{
        let nsdata = NSData(bytes: data, length: data.count)
        let data  = Data.init(referencing: nsdata)
        if let str = String.init(data: data, encoding: String.Encoding.utf8){
            return str
        }
        return "";
    }
    public func timeToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    public func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func base64ToByteArray(base64String: String) -> [UInt8] {
        let data = Data.init(base64Encoded: base64String)
        let dataCount = data!.count
        var bytes = [UInt8].init(repeating: 0, count: dataCount)
        data!.copyBytes(to: &bytes, count: dataCount)
        return bytes
    }
    func stringFromXMLString(xmlToParse:String)->String {
        do
        {
            let xml = SWXMLHash.lazy(xmlToParse)
            var xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            var xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            var xmlElement = xmlResult?.element
            var str = xmlElement?.text
            var xmlElementFirst = xmlElement?.children[0] as!TextElement
            return xmlElementFirst.text
        }
        catch
        {
        }
        //NOT IMPLETEMENTED!
        var returnValue:String!
        return returnValue
    }
    func stringFromXML(data:Data)-> String
    {
        
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return ""
        }
        if xmlToParse?.characters.count==0 {
            return ""
        }
        let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
        
    }
    func stringArrFromXMLString(xmlToParse :String)->[String?]{
        let xml  = SWXMLHash.lazy(xmlToParse)
        let xmlRoot  = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse : XMLIndexer? =  xmlBody?.children.first
        let xmlResult : XMLIndexer?  = xmlResponse?.children.last
        
        var strList = [String?]()
        let childs = xmlResult!.children
        for child in childs {
            let text = child.element?.text
            strList.append(text)
        }
        
        return strList
    }
    func stringArrFromXML(data:Data)->[String?]{
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return [String?]()
        }
        if xmlToParse?.characters.count==0 {
            return [String?]()
        }
        
        let  stringVal = stringArrFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
    }
    
    func byteArrayToBase64(bytes: [UInt8]) -> String {
        
        let data = Data.init(bytes: bytes)
        let base64Encoded = data.base64EncodedString()
        return base64Encoded;
       
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let data = Data.init(base64Encoded: base64String){
            var bytes = [UInt8](repeating: 0, count: data.count)
            data.copyBytes(to: &bytes, count: data.count)
            return bytes;
        }
        return nil // Invalid input
    }
public func Res_RegistrarUsuarioFromXMLString(xmlToParse:String)->Res_RegistrarUsuario {

    let xml = SWXMLHash.lazy(xmlToParse)
    let xmlRoot = xml.children.first
    let xmlBody = xmlRoot?.children.last
    let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
    let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
    var strVal = "" 
    var elemName = "" 
    var returnValue:Res_RegistrarUsuario = Res_RegistrarUsuario()
  if elemName == "" {
// Property name : 
    let itemCount1: Int = (xmlResult0?.children.count)!
    for i1 in 0 ..< itemCount1 {
          let xmlResult1:XMLIndexer? = xmlResult0?.children[i1]
          let elem1: XMLElement? =  xmlResult1!.element
            strVal = "" 
            if elem1?.children.first is TextElement {
                let elemText1:TextElement = elem1?.children.first as! TextElement
                strVal = elemText1.text
            
}
             elemName = elem1!.name
  if elemName == "listaUsuario" {
    // Array Property For returnValue.listaUsuario
    let itemCount2: Int = (xmlResult1?.children.count)!
    for i2 in 0 ..< itemCount2 {
        let rItem2 = Usuario()
        let xmlResult_Parent2:XMLIndexer? = xmlResult1?.children[i2]
        let childCount2 :Int = (xmlResult_Parent2?.children.count)!
        for j2 in 0 ..< childCount2 {

            let xmlResult2: XMLIndexer? =  xmlResult_Parent2?.children[j2]
            let elem2: XMLElement? =  xmlResult2?.element
            strVal = "" 
            if elem2?.children.first is TextElement {
                let elemText:TextElement = elem2?.children.first as! TextElement
                strVal = elemText.text
            
}
            elemName = elem2!.name
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        if elemName == "idCliente" {
            rItem2.idCliente = strVal.toInt64()!
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "nombre" {
            rItem2.nombre =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "apellido1" {
            rItem2.apellido1 =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "apellido2" {
            rItem2.apellido2 =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "identificacion" {
            rItem2.identificacion =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "correo" {
            rItem2.correo =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "login" {
            rItem2.login =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "password" {
            rItem2.password =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "estado" {
            rItem2.estado =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "telefono" {
            rItem2.telefono =  strVal
        }
// Array Propert of returnValue.listaUsuario subProperty for rItem2
        else if elemName == "foto" {
            rItem2.foto =  strVal
        }
         
}
         returnValue.listaUsuario.append(rItem2) 
     
}
 }
        else if elemName == "mensajeError" {
            returnValue.mensajeError =  strVal
        }
        else if elemName == "token" {
            returnValue.token =  strVal
        }
        else if elemName == "exito" {
            returnValue.exito =  (strVal.lowercased()=="true")
        }
    }
 }
    return returnValue
 }
public func Res_RegistrarUsuarioFromXML(data: Data)-> Res_RegistrarUsuario {

     let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
    return Res_RegistrarUsuarioFromXMLString( xmlToParse : xmlToParse)
 }
public func Trok_Login(req:Req_RegistrarUsuario)-> Res_RegistrarUsuario{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_Login xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <usuario>"
soapReqXML += "          <idCliente>"
soapReqXML +=                String(req.usuario.idCliente)
soapReqXML += "          </idCliente>"
soapReqXML += "          <nombre>"
soapReqXML +=                req.usuario.nombre
soapReqXML += "          </nombre>"
soapReqXML += "          <apellido1>"
soapReqXML +=                req.usuario.apellido1
soapReqXML += "          </apellido1>"
soapReqXML += "          <apellido2>"
soapReqXML +=                req.usuario.apellido2
soapReqXML += "          </apellido2>"
soapReqXML += "          <identificacion>"
soapReqXML +=                req.usuario.identificacion
soapReqXML += "          </identificacion>"
soapReqXML += "          <correo>"
soapReqXML +=                req.usuario.correo
soapReqXML += "          </correo>"
soapReqXML += "          <login>"
soapReqXML +=                req.usuario.login
soapReqXML += "          </login>"
soapReqXML += "          <password>"
soapReqXML +=                req.usuario.password
soapReqXML += "          </password>"
soapReqXML += "          <estado>"
soapReqXML +=                req.usuario.estado
soapReqXML += "          </estado>"
soapReqXML += "          <telefono>"
soapReqXML +=                req.usuario.telefono
soapReqXML += "          </telefono>"
soapReqXML += "          <foto>"
soapReqXML +=                req.usuario.foto
soapReqXML += "          </foto>"
soapReqXML += "     </usuario>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_Login>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_Login"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarUsuario=Res_RegistrarUsuarioFromXML(data : responseData)
   return returnValue
}
public func Trok_logOut(req:String)-> Bool{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_logOut xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_logOut>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_logOut"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  false
 }
 let returnValue:Bool = strVal!.lowercased() == "true" 
   return returnValue
}
public func Res_RegistrarTipoPagoFromXMLString(xmlToParse:String)->Res_RegistrarTipoPago {

    let xml = SWXMLHash.lazy(xmlToParse)
    let xmlRoot = xml.children.first
    let xmlBody = xmlRoot?.children.last
    let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
    let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
    var strVal = "" 
    var elemName = "" 
    var returnValue:Res_RegistrarTipoPago = Res_RegistrarTipoPago()
  if elemName == "" {
// Property name : 
    let itemCount1: Int = (xmlResult0?.children.count)!
    for i1 in 0 ..< itemCount1 {
          let xmlResult1:XMLIndexer? = xmlResult0?.children[i1]
          let elem1: XMLElement? =  xmlResult1!.element
            strVal = "" 
            if elem1?.children.first is TextElement {
                let elemText1:TextElement = elem1?.children.first as! TextElement
                strVal = elemText1.text
            
}
             elemName = elem1!.name
  if elemName == "listaTipoPago" {
    // Array Property For returnValue.listaTipoPago
    let itemCount2: Int = (xmlResult1?.children.count)!
    for i2 in 0 ..< itemCount2 {
        let rItem2 = TipoPago()
        let xmlResult_Parent2:XMLIndexer? = xmlResult1?.children[i2]
        let childCount2 :Int = (xmlResult_Parent2?.children.count)!
        for j2 in 0 ..< childCount2 {

            let xmlResult2: XMLIndexer? =  xmlResult_Parent2?.children[j2]
            let elem2: XMLElement? =  xmlResult2?.element
            strVal = "" 
            if elem2?.children.first is TextElement {
                let elemText:TextElement = elem2?.children.first as! TextElement
                strVal = elemText.text
            
}
            elemName = elem2!.name
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        if elemName == "idTipoPago" {
            rItem2.idTipoPago =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "idCliente" {
            rItem2.idCliente =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "idCorrelacion" {
            rItem2.idCorrelacion =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "numeroTarjeta" {
            rItem2.numeroTarjeta =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "nombreTitularTarjeta" {
            rItem2.nombreTitularTarjeta =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "vecimientoMes" {
            rItem2.vecimientoMes = strVal.toInt()!
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "vecimientoYear" {
            rItem2.vecimientoYear = strVal.toInt()!
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "CCV" {
            rItem2.CCV =  strVal
        }
// Array Propert of returnValue.listaTipoPago subProperty for rItem2
        else if elemName == "Estado" {
            rItem2.Estado =  strVal
        }
         
}
         returnValue.listaTipoPago.append(rItem2) 
     
}
 }
        else if elemName == "mensajeError" {
            returnValue.mensajeError =  strVal
        }
        else if elemName == "token" {
            returnValue.token =  strVal
        }
        else if elemName == "exito" {
            returnValue.exito =  (strVal.lowercased()=="true")
        }
    }
 }
    return returnValue
 }
public func Res_RegistrarTipoPagoFromXML(data: Data)-> Res_RegistrarTipoPago {

     let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
    return Res_RegistrarTipoPagoFromXMLString( xmlToParse : xmlToParse)
 }
public func Trok_EliminarTipoPago(req:Req_RegistrarTipoPago)-> Res_RegistrarTipoPago{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_EliminarTipoPago xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <idCliente>"
soapReqXML +=           req.idCliente
soapReqXML += "     </idCliente>"
soapReqXML += "     <numeroTarjeta>"
soapReqXML +=           req.numeroTarjeta
soapReqXML += "     </numeroTarjeta>"
soapReqXML += "     <nombreTitularTarjeta>"
soapReqXML +=           req.nombreTitularTarjeta
soapReqXML += "     </nombreTitularTarjeta>"
soapReqXML += "     <vecimientoMes>"
soapReqXML +=           req.vecimientoMes
soapReqXML += "     </vecimientoMes>"
soapReqXML += "     <vecimientoYear>"
soapReqXML +=           req.vecimientoYear
soapReqXML += "     </vecimientoYear>"
soapReqXML += "     <CCV>"
soapReqXML +=           req.CCV
soapReqXML += "     </CCV>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_EliminarTipoPago>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_EliminarTipoPago"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarTipoPago=Res_RegistrarTipoPagoFromXML(data : responseData)
   return returnValue
}
public func Trok_ObtenerTipoPagoCliente(req:Req_RegistrarTipoPago)-> Res_RegistrarTipoPago{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_ObtenerTipoPagoCliente xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <idCliente>"
soapReqXML +=           req.idCliente
soapReqXML += "     </idCliente>"
soapReqXML += "     <numeroTarjeta>"
soapReqXML +=           req.numeroTarjeta
soapReqXML += "     </numeroTarjeta>"
soapReqXML += "     <nombreTitularTarjeta>"
soapReqXML +=           req.nombreTitularTarjeta
soapReqXML += "     </nombreTitularTarjeta>"
soapReqXML += "     <vecimientoMes>"
soapReqXML +=           req.vecimientoMes
soapReqXML += "     </vecimientoMes>"
soapReqXML += "     <vecimientoYear>"
soapReqXML +=           req.vecimientoYear
soapReqXML += "     </vecimientoYear>"
soapReqXML += "     <CCV>"
soapReqXML +=           req.CCV
soapReqXML += "     </CCV>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_ObtenerTipoPagoCliente>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_ObtenerTipoPagoCliente"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarTipoPago=Res_RegistrarTipoPagoFromXML(data : responseData)
   return returnValue
}
public func Trok_RegistrarTipoPago(req:Req_RegistrarTipoPago)-> Res_RegistrarTipoPago{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_RegistrarTipoPago xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <idCliente>"
soapReqXML +=           req.idCliente
soapReqXML += "     </idCliente>"
soapReqXML += "     <numeroTarjeta>"
soapReqXML +=           req.numeroTarjeta
soapReqXML += "     </numeroTarjeta>"
soapReqXML += "     <nombreTitularTarjeta>"
soapReqXML +=           req.nombreTitularTarjeta
soapReqXML += "     </nombreTitularTarjeta>"
soapReqXML += "     <vecimientoMes>"
soapReqXML +=           req.vecimientoMes
soapReqXML += "     </vecimientoMes>"
soapReqXML += "     <vecimientoYear>"
soapReqXML +=           req.vecimientoYear
soapReqXML += "     </vecimientoYear>"
soapReqXML += "     <CCV>"
soapReqXML +=           req.CCV
soapReqXML += "     </CCV>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_RegistrarTipoPago>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_RegistrarTipoPago"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarTipoPago=Res_RegistrarTipoPagoFromXML(data : responseData)
   return returnValue
}
public func Trok_Setup(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_Setup xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_Setup>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_Setup"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_CalculoMontoViaje(req:Req_CalcularViaje)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_CalculoMontoViaje xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <tipoCamion>"
soapReqXML +=           String(req.tipoCamion)
soapReqXML += "     </tipoCamion>"
soapReqXML += "     <kilometros>"
soapReqXML +=           String(req.kilometros)
soapReqXML += "     </kilometros>"
soapReqXML += "     <tiempoCarga>"
soapReqXML +=           String(req.tiempoCarga)
soapReqXML += "     </tiempoCarga>"
soapReqXML += "     <tiempoDescarga>"
soapReqXML +=           String(req.tiempoDescarga)
soapReqXML += "     </tiempoDescarga>"
soapReqXML += "     <tiempoTrayectoConMovimiento>"
soapReqXML +=           String(req.tiempoTrayectoConMovimiento)
soapReqXML += "     </tiempoTrayectoConMovimiento>"
soapReqXML += "     <tiempoTrayectoSinMovimiento>"
soapReqXML +=           String(req.tiempoTrayectoSinMovimiento)
soapReqXML += "     </tiempoTrayectoSinMovimiento>"
soapReqXML += "     <peso>"
soapReqXML +=           String(req.peso)
soapReqXML += "     </peso>"
soapReqXML += "     <dificultadCarga>"
soapReqXML +=           String(req.dificultadCarga)
soapReqXML += "     </dificultadCarga>"
soapReqXML += "     <dificultadDescarga>"
soapReqXML +=           String(req.dificultadDescarga)
soapReqXML += "     </dificultadDescarga>"
soapReqXML += "     <Seguro>"
soapReqXML +=           String(req.Seguro)
soapReqXML += "     </Seguro>"
soapReqXML += "     <Ayudantes>"
soapReqXML +=           String(req.Ayudantes)
soapReqXML += "     </Ayudantes>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_CalculoMontoViaje>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_CalculoMontoViaje"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_SolicitarViaje(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_SolicitarViaje xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_SolicitarViaje>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_SolicitarViaje"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_CalculoMontoSeguro(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_CalculoMontoSeguro xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_CalculoMontoSeguro>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_CalculoMontoSeguro"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_ObtenerViajesRealizados(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_ObtenerViajesRealizados xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_ObtenerViajesRealizados>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_ObtenerViajesRealizados"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_RegistrarUsuario2(req:Req_RegistrarUsuario2)-> Res_RegistrarTipoPago{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_RegistrarUsuario2 xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <usuario>"
soapReqXML += "          <idCliente>"
soapReqXML +=                String(req.usuario.idCliente)
soapReqXML += "          </idCliente>"
soapReqXML += "          <nombre>"
soapReqXML +=                req.usuario.nombre
soapReqXML += "          </nombre>"
soapReqXML += "          <apellido1>"
soapReqXML +=                req.usuario.apellido1
soapReqXML += "          </apellido1>"
soapReqXML += "          <apellido2>"
soapReqXML +=                req.usuario.apellido2
soapReqXML += "          </apellido2>"
soapReqXML += "          <identificacion>"
soapReqXML +=                req.usuario.identificacion
soapReqXML += "          </identificacion>"
soapReqXML += "          <correo>"
soapReqXML +=                req.usuario.correo
soapReqXML += "          </correo>"
soapReqXML += "          <login>"
soapReqXML +=                req.usuario.login
soapReqXML += "          </login>"
soapReqXML += "          <password>"
soapReqXML +=                req.usuario.password
soapReqXML += "          </password>"
soapReqXML += "          <estado>"
soapReqXML +=                req.usuario.estado
soapReqXML += "          </estado>"
soapReqXML += "          <telefono>"
soapReqXML +=                req.usuario.telefono
soapReqXML += "          </telefono>"
soapReqXML += "     </usuario>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_RegistrarUsuario2>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_RegistrarUsuario2"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarTipoPago=Res_RegistrarTipoPagoFromXML(data : responseData)
   return returnValue
}
public func Trok_RegistrarUsuario(req:Req_RegistrarUsuario)-> Res_RegistrarUsuario{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_RegistrarUsuario xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += "     <usuario>"
soapReqXML += "          <idCliente>"
soapReqXML +=                String(req.usuario.idCliente)
soapReqXML += "          </idCliente>"
soapReqXML += "          <nombre>"
soapReqXML +=                req.usuario.nombre
soapReqXML += "          </nombre>"
soapReqXML += "          <apellido1>"
soapReqXML +=                req.usuario.apellido1
soapReqXML += "          </apellido1>"
soapReqXML += "          <apellido2>"
soapReqXML +=                req.usuario.apellido2
soapReqXML += "          </apellido2>"
soapReqXML += "          <identificacion>"
soapReqXML +=                req.usuario.identificacion
soapReqXML += "          </identificacion>"
soapReqXML += "          <correo>"
soapReqXML +=                req.usuario.correo
soapReqXML += "          </correo>"
soapReqXML += "          <login>"
soapReqXML +=                req.usuario.login
soapReqXML += "          </login>"
soapReqXML += "          <password>"
soapReqXML +=                req.usuario.password
soapReqXML += "          </password>"
soapReqXML += "          <estado>"
soapReqXML +=                req.usuario.estado
soapReqXML += "          </estado>"
soapReqXML += "          <telefono>"
soapReqXML +=                req.usuario.telefono
soapReqXML += "          </telefono>"
soapReqXML += "          <foto>"
soapReqXML +=                req.usuario.foto
soapReqXML += "          </foto>"
soapReqXML += "     </usuario>"
soapReqXML += "     <sys>"
soapReqXML +=           req.sys
soapReqXML += "     </sys>"
soapReqXML += "     <token>"
soapReqXML +=           req.token
soapReqXML += "     </token>"
soapReqXML += "</req>"
soapReqXML += "</Trok_RegistrarUsuario>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_RegistrarUsuario"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let returnValue:Res_RegistrarUsuario=Res_RegistrarUsuarioFromXML(data : responseData)
   return returnValue
}
public func Trok_ObtenerUsuario(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_ObtenerUsuario xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_ObtenerUsuario>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_ObtenerUsuario"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_ObtenerKeyUsuario(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_ObtenerKeyUsuario xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_ObtenerKeyUsuario>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_ObtenerKeyUsuario"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func Trok_CalificarChofer(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Trok_CalificarChofer xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</Trok_CalificarChofer>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Trok_CalificarChofer"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_Login(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_Login xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_Login>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_Login"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_logOut(req:String)-> Bool{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_logOut xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_logOut>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_logOut"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  false
 }
 let returnValue:Bool = strVal!.lowercased() == "true" 
   return returnValue
}
public func TrokDriver_RegistrarChofer(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_RegistrarChofer xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_RegistrarChofer>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_RegistrarChofer"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_ObtenerChofer(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_ObtenerChofer xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_ObtenerChofer>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_ObtenerChofer"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_ObtenerViajesPendintes(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_ObtenerViajesPendintes xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_ObtenerViajesPendintes>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_ObtenerViajesPendintes"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_ObtenerCompromisos(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_ObtenerCompromisos xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_ObtenerCompromisos>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_ObtenerCompromisos"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_ObtenerDetalleViajesPendientes(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_ObtenerDetalleViajesPendientes xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_ObtenerDetalleViajesPendientes>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_ObtenerDetalleViajesPendientes"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDiver_ObtenerDetalleCompromisos(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDiver_ObtenerDetalleCompromisos xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDiver_ObtenerDetalleCompromisos>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDiver_ObtenerDetalleCompromisos"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDiver_AceptarViaje(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDiver_AceptarViaje xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDiver_AceptarViaje>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDiver_AceptarViaje"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDiver_RechazarViaje(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDiver_RechazarViaje xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDiver_RechazarViaje>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDiver_RechazarViaje"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_ObtenerKeyUsuario(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_ObtenerKeyUsuario xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_ObtenerKeyUsuario>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_ObtenerKeyUsuario"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func TrokDriver_CalificarUsuario(req:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<TrokDriver_CalificarUsuario xmlns=\"http://tempuri.org/\">"
soapReqXML += "<req>"
soapReqXML += req
soapReqXML += "</req>"
soapReqXML += "</TrokDriver_CalificarUsuario>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/TrokDriver_CalificarUsuario"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data: responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
}
