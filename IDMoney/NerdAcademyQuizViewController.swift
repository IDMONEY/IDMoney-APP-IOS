//
//  NerdAcademyQuizViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 22/4/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

var realm = try! Realm()
var preguntas: Results<Pregunta>!
var preguntasContestada: Results<PreguntaContestada>!

class Pregunta: Object {
    dynamic var pregunta = ""
    dynamic var RespuestaCorrecta = ""
    dynamic var IDRespuesta = ""
    dynamic var Respuesta1 = ""
    dynamic var Respuesta2 = ""
    dynamic var Respuesta3 = ""
    dynamic var Respuesta4 = ""
}

class PreguntaContestada: Object{
    dynamic var preguntaContestada = ""
    dynamic var preguntaContestadaID = ""
    dynamic var preguntaCorrecta = false
    
}

class NerdAcademyQuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewPreguntas: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPreguntas.register(UINib(nibName: "PreguntaTableViewCell", bundle: nil), forCellReuseIdentifier: "cellPreguntas")

        
        preguntas = realm.objects(Pregunta.self)
        preguntasContestada = realm.objects(PreguntaContestada.self)
        
        
        let lstPreguntas = CargarListaPreguntas()
        
        do {
            try realm.write {
                if preguntas.count <= 0{
                    for itemPregunta in lstPreguntas{
                        CargarPreguntas(itemPregunta)
                    }
                }else{
                    let lstAgregar = List<Pregunta>()
                    for itemPregunta in lstPreguntas{
                        for select in preguntasContestada{
                            if itemPregunta.IDRespuesta != select.preguntaContestadaID{
                                let objectsToDelete = preguntasContestada.filter("preguntaContestadaID = %@", itemPregunta.IDRespuesta)
                                if !objectsToDelete.isEmpty{
                                    lstAgregar.append(itemPregunta)
                                }                                
                            }else{
                                let objectsToDelete = realm.objects(Pregunta.self).filter("IDRespuesta = %@", itemPregunta.IDRespuesta)
                                realm.delete(objectsToDelete)
                            }
                        }
                    }
                    for pregunta in lstAgregar{
                        CargarPreguntas(pregunta)
                    }
                }
            }
        }catch {
            
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        tableViewPreguntas.reloadData()
        
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PreguntaTableViewCell = tableViewPreguntas.dequeueReusableCell(withIdentifier: "cellPreguntas", for: indexPath) as! PreguntaTableViewCell
        cell.cargarPregunta(pregunta: preguntas[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        cell.shouldSelectRow = indexPath
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell:UITableViewCell = tableViewPreguntas.cellForRow(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.clear
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let selectedCell:UITableViewCell = tableViewPreguntas.cellForRow(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.clear
//    }
    
    //    MARK: - Metodos
    func CargarListaPreguntas() -> List<Pregunta>{
        let pregunta1 = Pregunta()
        pregunta1.pregunta = "¿Por qué IDMoney es social?"
        pregunta1.RespuestaCorrecta = "4"
        pregunta1.IDRespuesta = "1"
        pregunta1.Respuesta1 = "Porque el proyecto se creó solamente para ayudar a políticos."
        pregunta1.Respuesta2 = "Porque el proyecto se creó solamente para ayudar a gente rica."
        pregunta1.Respuesta3 = "Porque el proyecto se creó solamente para ayudar a gente pobre."
        pregunta1.Respuesta4 = "Porque el proyecto contiene algunas características importantes diseñadas para ayudar a reducir la pobreza."
        
        let pregunta2 = Pregunta()
        pregunta2.pregunta = "¿Qué aspectos sociales contiene el proyecto IDMoney?"
        pregunta2.RespuestaCorrecta = "3"
        pregunta2.IDRespuesta = "2"
        pregunta2.Respuesta1 = "Lucha por la paz mundial."
        pregunta2.Respuesta2 = "El proyecto apoyará deportes para unir a las personas."
        pregunta2.Respuesta3 = "El proyecto incluye transferir tokens IDM a personas muy pobres con el fin de ayudar a reducir la pobrez."
        pregunta2.Respuesta4 = "Los aspectos sociales no son muy importantes dentro del proyecto."
        
        
        let pregunta3 = Pregunta()
        pregunta3.pregunta = "¿Qué porcentaje o cantidad de tokens IDM se distribuirá, como parte del proyecto, entre los pobres?"
        pregunta3.RespuestaCorrecta = "1"
        pregunta3.IDRespuesta = "3"
        pregunta3.Respuesta1 = "Un 20% del total de tokens totales IDM que se crearon."
        pregunta3.Respuesta2 = "Un 18% del total de tokens totales IDM que se crearon."
        pregunta3.Respuesta3 = "Un 20% de los tokens ETH que se colecten durante la venta de tokens IDM."
        pregunta3.Respuesta4 = "Cero."
        
        
        let pregunta4 = Pregunta()
        pregunta4.pregunta = "¿Qué cantidad de tokens IDM se distribuirá entre los pobres, como parte del proyecto?"
        pregunta4.RespuestaCorrecta = "3"
        pregunta4.IDRespuesta = "4"
        pregunta4.Respuesta1 = "3.5 millones de tokens IDM"
        pregunta4.Respuesta2 = "6.3 millones de tokens IDM."
        pregunta4.Respuesta3 = "7 millones de tokens IDM."
        pregunta4.Respuesta4 = "Cero."
        
        let pregunta5 = Pregunta()
        pregunta5.pregunta = "¿Qué cantidad de tokens ETH se distribuirá a los pobres, como parte del proyecto?"
        pregunta5.RespuestaCorrecta = "4"
        pregunta5.IDRespuesta = "5"
        pregunta5.Respuesta1 = "10% del total de tokens ETH que se colecten durante la venta"
        pregunta5.Respuesta2 = "El equivalente en ETH al 10% de los tokens totales IDM que se crearon."
        pregunta5.Respuesta3 = "3.5 millones de tokens IDM."
        pregunta5.Respuesta4 = "Cero."
        
        let pregunta6 = Pregunta()
        pregunta6.pregunta = "¿Cuánto tendrán que pagar los pobres para obtener los tokens IDM que el proyecto contempla distribuir entre los pobres?"
        pregunta6.RespuestaCorrecta = "4"
        pregunta6.IDRespuesta = "6"
        pregunta6.Respuesta1 = "El equivalente a $0.75 USD por cada IDM."
        pregunta6.Respuesta2 = "El equivalente a $0.37 USD por cada IDM."
        pregunta6.Respuesta3 = "0.00075 ETH por cada IDM."
        pregunta6.Respuesta4 = "Cero."
        
        let pregunta7 = Pregunta()
        pregunta7.pregunta = "Los pobres a los que se les transferirán tokens IDM serán de:"
        pregunta7.RespuestaCorrecta = "2"
        pregunta7.IDRespuesta = "7"
        pregunta7.Respuesta1 = "Un único país."
        pregunta7.Respuesta2 = "Tres gobiernos locales distintos del mundo, seleccionados para participar en el proyecto."
        pregunta7.Respuesta3 = "Todo el mundo."
        pregunta7.Respuesta4 = "Tres continentes diferentes."
        
        let pregunta8 = Pregunta()
        pregunta8.pregunta = "¿Quién seleccionará a los pobres que recibirán tokens IDM que el proyecto contempla repartir?"
        pregunta8.RespuestaCorrecta = "3"
        pregunta8.IDRespuesta = "8"
        pregunta8.Respuesta1 = "Políticos."
        pregunta8.Respuesta2 = "IDMoney S.A."
        pregunta8.Respuesta3 = "Tres gobiernos locales, junto con organizaciones locales."
        pregunta8.Respuesta4 = "Los token holders."
        
        let pregunta9 = Pregunta()
        pregunta9.pregunta = "¿Quién hará la transferencia de los tokens a los pobres?"
        pregunta9.RespuestaCorrecta = "1"
        pregunta9.IDRespuesta = "9"
        pregunta9.Respuesta1 = "Lo harán gobiernos locales supervisados por organizaciones locales."
        pregunta9.Respuesta2 = "Los gobiernos locales seleccionados para participar en el proyecto, de manera independiente y sin supervisión."
        pregunta9.Respuesta3 = "Cualquier persona, sin supervisión; no interesa la transparencia."
        pregunta9.Respuesta4 = "Organizaciones que luchan contra la pobreza, de manera independiente y sin supervisión."
        
        let pregunta10 = Pregunta()
        pregunta10.pregunta = "¿Cuándo se hará la transferencia de tokens a los pobres?"
        pregunta10.RespuestaCorrecta = "1"
        pregunta10.IDRespuesta = "10"
        pregunta10.Respuesta1 = "Cuando los gobiernos locales y organizaciones locales que luchan contra la pobreza estén listos y envíen la lista de pobres seleccionados para transferirles los tokens."
        pregunta10.Respuesta2 = "Apenas se termine la venta de tokens IDM."
        pregunta10.Respuesta3 = "Tres años después de iniciada la venta de tokens IDM."
        pregunta10.Respuesta4 = "Poco antes de terminar el proyecto."
        
        let pregunta11 = Pregunta()
        pregunta11.pregunta = "¿Qué requisitos deben cumplir las personas para recibir tokens IDM de los que se repartirán entre los pobres como parte del proyecto?"
        pregunta11.RespuestaCorrecta = "4"
        pregunta11.IDRespuesta = "11"
        pregunta11.Respuesta1 = "Ser seleccionada y tener una cuenta bancaria de ahorro."
        pregunta11.Respuesta2 = "Ser seleccionada basta, no requiere tener una billetera de crypto tokens."
        pregunta11.Respuesta3 = "Ser seleccionada y tener una billetera de crypto tokens de cualquier tipo."
        pregunta11.Respuesta4 = "Ser seleccionada y tener una billetera crypto compatible con tokens tipo ERC20."
        
        let pregunta12 = Pregunta()
        pregunta12.pregunta = "¿Actualmente existen billeteras crypto gratuitas, que puedan usar las personas pobres para recibir crypto tokens tipo ERC20 como el token IDM?"
        pregunta12.RespuestaCorrecta = "2"
        pregunta12.IDRespuesta = "12"
        pregunta12.Respuesta1 = "No."
        pregunta12.Respuesta2 = "Sí."
        pregunta12.Respuesta3 = "No; habrá que esperar hasta que los gobiernos locales implementen la billetera crypto que se está desarrollando en el Proyecto IDMoney."
        pregunta12.Respuesta4 = "Nunca habrán; las personas pobres estarán obligadas a comprar una billetera segura."
        
        let pregunta13 = Pregunta()
        pregunta13.pregunta = "¿Hará algo IDMoney S.A. para resolver el problema de que algunos pobres pueden no tener conectividad a Internet o el conocimiento necesario para crear y utilizar una billetera de tokens crypto?"
        pregunta13.RespuestaCorrecta = "1"
        pregunta13.IDRespuesta = "13"
        pregunta13.Respuesta1 = "Solicitará a los gobiernos locales participantes en el proyecto, que establezcan un programa educativo, de ayuda y de conectividad a Internet; para que puedan crear una billetera crypto y utilizarla."
        pregunta13.Respuesta2 = "IDMoney S.A. dará entrenamiento directamente a los pobres para que creen una billetera de crypto tokens y la sepan utilizar."
        pregunta13.Respuesta3 = "Creará un manual que puedan usar los pobres para crear y utilizar una billetera crypto; pero no se ayudará más allá de eso."
        pregunta13.Respuesta4 = "No hará nada."
        
        let pregunta14 = Pregunta()
        pregunta14.pregunta = "¿Qué es la Herramienta de Alivio de la Pobreza que se desarrolla en el Proyecto IDMoney?"
        pregunta14.RespuestaCorrecta = "4"
        pregunta14.IDRespuesta = "14"
        pregunta14.Respuesta1 = "Es un software que se usará para repartir el 20% de los tokens IDM que se repartirán entre los pobres."
        pregunta14.Respuesta2 = "Es un hardware (un aparato o dispositivo)."
        pregunta14.Respuesta3 = "Es un software especial para coordinar programas de lucha contra la pobreza, que funciona sobre una red local."
        pregunta14.Respuesta4 = "Es un software libre, basado en la blockchain, especial para manejar y coordinar programas interinstitucionales de lucha contra la pobreza."
        
        let pregunta15 = Pregunta()
        pregunta15.pregunta = "¿Para qué se está desarrollando la Herramienta de Alivio de la Pobreza?"
        pregunta15.RespuestaCorrecta = "2"
        pregunta15.IDRespuesta = "15"
        pregunta15.Respuesta1 = "Para que empresas privadas la implementen y cobren por su uso."
        pregunta15.Respuesta2 = "Para llevar estadísticas de pobreza."
        pregunta15.Respuesta3 = "Principalmente para que los programas de alivio de la pobreza de los gobiernos y otras organizaciones locales la implementen y utilicen para unir esfuerzos, compartir datos, ahorrar recursos y coordinarse mejor; pero cualquiera podría implementarla, pues se desarrolla como software libre."
        pregunta15.Respuesta4 = "Sólo para que los gobiernos locales manejen y coordinen sus propios programas de lucha contra la pobreza."
        
        
        let pregunta16 = Pregunta()
        pregunta16.pregunta = "¿Qué problema resolvería la Herramienta de Alivio de la Pobreza de IDMoney a los programas de combate a la pobreza de diferentes organizaciones?"
        pregunta16.RespuestaCorrecta = "3"
        pregunta16.IDRespuesta = "16"
        pregunta16.Respuesta1 = "El problema de falta de recursos económicos para pagar el salario a los trabajadores del programa de alivio de la pobreza."
        pregunta16.Respuesta2 = "El problema de lentitud de sus sistemas. "
        pregunta16.Respuesta3 = "El problema de que los programas de alivio de la pobreza de diferentes organizaciones no se comunican entre sí y eso les dificulta coordinarse."
        pregunta5.Respuesta4 = "Los problemas de seguridad que tengan sus distintos sistemas."
        //
        
        let pregunta17 = Pregunta()
        pregunta17.pregunta = "¿Qué otro problema le ayuda a resolver la Herramienta de Alivio de la Pobreza de IDMoney a los programas de alivio de la pobreza de diferentes organizaciones?"
        pregunta17.RespuestaCorrecta = "1"
        pregunta17.IDRespuesta = "17"
        pregunta17.Respuesta1 = "El problema de que por no poder compartir datos, los programas de alivio de la pobreza asignan redundantemente recursos a las mismas personas o familias, mientras otras quedan sin ayuda."
        pregunta17.Respuesta2 = "La excesiva comunicación entre sus diferentes sistemas."
        pregunta17.Respuesta3 = "El excesivo consumo de electricidad de sus sistemas."
        pregunta17.Respuesta4 = "El aburrimiento de los operadores de sus sistemas."

        let pregunta18 = Pregunta()
        pregunta18.pregunta = "Mencione una ventaja que produciría el que distintos programas de Alivio de la Pobreza usen la misma Herramienta de Alivio de la Pobreza de IDMoney:"
        pregunta18.RespuestaCorrecta = "2"
        pregunta18.IDRespuesta = "18"
        pregunta18.Respuesta1 = "No tendría beneficios."
        pregunta18.Respuesta2 = "Al compartir datos entre los distintos programas podrían compararlos, verificarlos y documentarlos de manera conjunta; evitaría duplicar esfuerzos."
        pregunta18.Respuesta3 = "Generaría multiplicación de esfuerzos para conseguir y/o confirmar un mismo dato."
        pregunta18.Respuesta4 = "Generaría más gastos."

        let pregunta19 = Pregunta()
        pregunta19.pregunta = "La Herramienta de Alivio de la Pobreza la podrán usar para ponerla a funcionar:"
        pregunta19.RespuestaCorrecta = "4"
        pregunta19.IDRespuesta = "19"
        pregunta19.Respuesta1 = "Solamente gobiernos centrales."
        pregunta19.Respuesta2 = "Solamente gobiernos locales."
        pregunta19.Respuesta3 = "Solamente organizaciones internaciones."
        pregunta19.Respuesta4 = "Cualquiera que quiera implementar el uso de la herramienta, pues es software libre."
        
        let pregunta20 = Pregunta()
        pregunta20.pregunta = "¿Cuáles datos de la personalidad virtual de los usuarios de la Money Making Wallet APP, sería beneficioso que ellos compartieran con la Herramienta de Alivio de la Pobreza?"
        pregunta20.RespuestaCorrecta = "2"
        pregunta20.IDRespuesta = "20"
        pregunta20.Respuesta1 = "Principalmente los datos básicos el usuario como el nombre, fecha de nacimiento, sexo, dirección, etc."
        pregunta20.Respuesta2 = "Principalmente la expresión de las necesidades de ayuda que tienen las personas en distinto áreas: salud, trabajo, educación y económica."
        pregunta20.Respuesta3 = "Principalmente la información sobre las propiedades y los activos financieros (tarjetas de débito, crédito) de las personas."
        pregunta20.Respuesta4 = "Ningún dato."
        
        let pregunta21 = Pregunta()
        pregunta21.pregunta = "Las organizaciones que luchan contra la pobreza, usuarias de la Herramienta de Alivio de la Pobreza, podrán leer la información que hayan puesto las personas en sus Money Making Wallets:"
        pregunta21.RespuestaCorrecta = "3"
        pregunta21.IDRespuesta = "21"
        pregunta21.Respuesta1 = "Siempre."
        pregunta21.Respuesta2 = "Nunca."
        pregunta21.Respuesta3 = "Solo mientras el usuario ponga en su Money Making Wallet APP que desea compartir toda o parte de su información con las organizaciones que sean usuarias de la Herramienta de Alivio de la Pobreza."
        pregunta21.Respuesta4 = "Siempre que el usuario de la Money Making Wallet tenga encendido su dispositivo móvil donde tenga instalada su Money Making Wallet APP."
        
        let pregunta22 = Pregunta()
        pregunta22.pregunta = "¿Por qué razón querrían las personas usuarias de la Money Making Wallet APP querer compartir, al menos parte de su información, con las organizaciones que luchan contra la pobreza?"
        pregunta22.RespuestaCorrecta = "3"
        pregunta22.IDRespuesta = "22"
        pregunta22.Respuesta1 = "No hay beneficio para ellos y, por lo tanto, no querrán compartir la información."
        pregunta22.Respuesta2 = "Para que las organizaciones de lucha contra la pobreza tengan sus datos básicos y lo tomen en cuenta."
        pregunta22.Respuesta3 = "Para asegurarse que las organizaciones que luchan contra la pobreza conozcan sus necesidades exactas de ayuda."
        pregunta22.Respuesta4 = "No es necesario que quieran compartir la información, porque las organizaciones que luchan siempre tendrán acceso a su información en la Money Making Wallet."
        
        let pregunta23 = Pregunta()
        pregunta23.pregunta = "¿Quiénes se benefician con lo de la donación que hará IDMoney del 20% de sus tokens IDM a personas pobres y con el uso de la Herramienta de Alivio de la Pobreza?"
        pregunta23.RespuestaCorrecta = "4"
        pregunta23.IDRespuesta = "23"
        pregunta23.Respuesta1 = "Solamente las personas que reciban tokens IDM."
        pregunta23.Respuesta2 = "Solamente los gobiernos locales, porque tendrán en sus regiones un programa de alivio de alivio a la pobreza efectivo."
        pregunta23.Respuesta3 = "Solamente las organizaciones que luchan contra la pobreza."
        pregunta23.Respuesta4 = "Las personas pobres que reciban tokens IDM y compartan sus necesidades de ayuda; las organizaciones que luchan contra la pobreza, con la Herramienta de Alivio de la Pobreza; y los gobiernos locales, que podrán mejorar las condiciones sociales de sus ciudadanos."
        
        let pregunta24 = Pregunta()
        pregunta24.pregunta = "¿Qué ventaja o beneficio tiene el Proyecto IDMoney al incluir características o componentes sociales en el proyecto?"
        pregunta24.RespuestaCorrecta = "1"
        pregunta24.IDRespuesta = "24"
        pregunta24.Respuesta1 = "Lo hace atractivo para los gobiernos locales; para los compradores de tokens, que aparte de recibir los beneficios de tener tokens, ayudan; y para los pobres."
        pregunta24.Respuesta2 = "Lo hacen atractivo para los gobiernos locales, pero no para los compradores de tokens."
        pregunta24.Respuesta3 = "Lo hacen atractivo solamente para los pobres."
        pregunta24.Respuesta4 = "Los componentes sociales del proyecto no son de beneficio para nadie."
        
        let pregunta25 = Pregunta()
        pregunta25.pregunta = "¿Eso de distribuir un 20% de los tokens IDMoney entre los pobres seleccionados por gobiernos locales es sólo por ayudar o tiene algún propósito adicional?"
        pregunta25.RespuestaCorrecta = "2"
        pregunta25.IDRespuesta = "25"
        pregunta25.Respuesta1 = "Es solamente para ayudar a personas en condición de pobreza."
        pregunta25.Respuesta2 = "Es para ayudar a personas pobres; educarlas en finanzas, dándoles la oportunidad de aprender a ahorrar y a vender sus tokens cuando sea oportuno; y es un experimento social, que busca reducir la pobreza."
        pregunta25.Respuesta3 = "Es solamente para educar en finanzas a personas pobres, para que sepan ahorrar y administrar mejor sus valores, usando crypto tokens."
        pregunta25.Respuesta4 = "Es sólo para hacer más atractivo el proyecto. "
        
        let pregunta26 = Pregunta()
        pregunta26.pregunta = "¿Por qué razón IDMoney es o será público?"
        pregunta26.RespuestaCorrecta = "3"
        pregunta26.IDRespuesta = "26"
        pregunta26.Respuesta1 = "Porque es popular."
        pregunta26.Respuesta2 = "Porque el software que se desarrollará en el proyecto será solamente para instituciones públicas."
        pregunta26.Respuesta3 = "Porque al final del proyecto las acciones de la compañía se donarán a tres gobiernos locales que acepten la donación; luego el proyecto será manejado por ellos."
        pregunta26.Respuesta4 = "No es de propiedad pública, pero el software que se desarrolle es para el público."
        
        let pregunta27 = Pregunta()
        pregunta27.pregunta = "¿Cómo contactará IDMoney S.A. a los gobiernos locales que se quiera atraer para participar en el proyecto y aceptar la donación de las acciones de IDMoney?"
        pregunta27.RespuestaCorrecta = "4"
        pregunta27.IDRespuesta = "27"
        pregunta27.Respuesta1 = "Mediante publicidad gratuita o pagada y directa o indirecta."
        pregunta27.Respuesta2 = "Se contactará por email a muchos gobiernos locales donde se sepa que los tokens se pueden comprar y vender legalmente."
        pregunta27.Respuesta3 = "Se les visitará personalmente."
        pregunta27.Respuesta4 = "Todas las opciones anteriores dentro de un programa coordinado de Embajadores de IDMoney."

        let pregunta28 = Pregunta()
        pregunta28.pregunta = "¿Cómo se pueden convertir los compradores de tokens IDMoney en embajadores del proyecto?"
        pregunta28.RespuestaCorrecta = "2"
        pregunta28.IDRespuesta = "28"
        pregunta28.Respuesta1 = "Sólo solicitando a IDMoney querer ser embajadores."
        pregunta28.Respuesta2 = "Usando la IDMoney Play App, y  solicitar ser nombrados embajadores. El proceso incluye pruebas, algunas con premios en tokens."
        pregunta28.Respuesta3 = "Solamente contactando gobiernos locales, sin necesidad de prepararse."
        pregunta28.Respuesta4 = "Solamente preparándose y contactando a los gobiernos locales, no necesitan utilizar la IDMoney Play App."
        
        let pregunta29 = Pregunta()
        pregunta29.pregunta = "¿Cuál será la función principal de los embajadores del proyecto IDMoney?"
        pregunta29.RespuestaCorrecta = "4"
        pregunta29.IDRespuesta = "29"
        pregunta29.Respuesta1 = "Hablar bien del proyecto."
        pregunta29.Respuesta2 = "Informar al público y a los gobiernos locales del mundo sobre el proyecto."
        pregunta29.Respuesta3 = "Contactar a gobiernos locales por vía de correo electrónico."
        pregunta29.Respuesta4 = "Establecerían contacto con gobiernos locales del mundo y tratarían de atraer esos gobiernos locales para que sean seleccionados y queden participando en el proyecto; todo con apoyo de IDMoney."
        
        let pregunta30 = Pregunta()
        pregunta30.pregunta = "¿Qué significa que los gobiernos locales participen en el proyecto?"
        pregunta30.RespuestaCorrecta = "2"
        pregunta30.IDRespuesta = "30"
        pregunta30.Respuesta1 = "Solamente pedir participar en el proyecto."
        pregunta30.Respuesta2 = "Que les guste el proyecto y deseen llegar a implementar el software y la visión futura del proyecto; que colaboren en los aspectos sociales; que sean seleccionados; y que acepten la donación de las acciones de IDMoney S.A."
        pregunta30.Respuesta3 = "Solamente aceptar la donación de las acciones de IDMoney S.A."
        pregunta30.Respuesta4 = "Solamente recibir el software e implementarlo."

        let pregunta31 = Pregunta()
        pregunta31.pregunta = "¿Por qué querrían los compradores de tokens convertirse en embajadores de IDMoney?"
        pregunta31.RespuestaCorrecta = "3"
        pregunta31.IDRespuesta = "31"
        pregunta31.Respuesta1 = "Por el prestigio del proyecto."
        pregunta31.Respuesta2 = "Por la emoción de participar en la búsqueda de los gobiernos locales."
        pregunta31.Respuesta3 = "Por ayudar a realizar uno de los objetivos principales del proyecto y por los premios que pueden ganar."
        pregunta31.Respuesta4 = "No querrían participar."
        
        let pregunta32 = Pregunta()
        pregunta32.pregunta = "¿Cuál será el gran premio para cada embajador que logre traer un gobierno local que quede participando en el proyecto?"
        pregunta32.RespuestaCorrecta = "4"
        pregunta32.IDRespuesta = "32"
        pregunta32.Respuesta1 = "$10,000 USD."
        pregunta32.Respuesta2 = "100 ETH."
        pregunta32.Respuesta3 = "100,000 IDM."
        pregunta32.Respuesta4 = "100,000 IDM y 400 ETH."
        
        let pregunta33 = Pregunta()
        pregunta33.pregunta = "¿Cuándo se pagará el premio por traer un gobierno local que quede participando en el proyecto al embajador que lo haya hecho posible?"
        pregunta33.RespuestaCorrecta = "4"
        pregunta33.IDRespuesta = "33"
        pregunta33.Respuesta1 = "Apenas el gobierno sea seleccionado para participar en el proyecto."
        pregunta33.Respuesta2 = "Apenas el gobierno comunique oficialmente a IDMoney que desea participar en el proyecto."
        pregunta33.Respuesta3 = "Después de que se reparta el 20% de los tokens a los pobres."
        pregunta33.Respuesta4 = "Después de que se concrete la donación de las acciones de IDMoney S.A. al gobierno local que haya sido traído por el embajador."
        
        let pregunta34 = Pregunta()
        pregunta34.pregunta = "¿Habrá otros premios para los embajadores que pasen pruebas o logren otros objetivos aparte de traer alguno de los tres gobiernos locales que queden participando en el proyecto?"
        pregunta34.RespuestaCorrecta = "2"
        pregunta34.IDRespuesta = "34"
        pregunta34.Respuesta1 = "No."
        pregunta34.Respuesta2 = "Sí."
        pregunta34.Respuesta3 = "Sólo si traen un gobierno local que casi resulte elegido para participar."
        pregunta34.Respuesta4 = "Talvez."
        
        let pregunta35 = Pregunta()
        pregunta35.pregunta = "¿Qué características deberán tener los gobiernos locales para ser elegibles para participar en el proyecto?"
        pregunta35.RespuestaCorrecta = "4"
        pregunta35.IDRespuesta = "35"
        pregunta35.Respuesta1 = "Estar en un país donde sea legal la realización de transacciones con crypto tokens."
        pregunta35.Respuesta2 = "Ser de un país de primer mundo, altamente organizado y progresista."
        pregunta35.Respuesta3 = "Querer participar en el proyecto, estar de acuerdo con recibir la donación de las acciones de IDMoney S.A. y querer llegar a implementar el software que se desarrolle en el proyecto."
        pregunta35.Respuesta4 = "Las tres opciones anteriores; donde las opciones ‘a’ y ‘C’ son indispensables y la opción ‘b’ es muy deseable."

        let pregunta36 = Pregunta()
        pregunta36.pregunta = "¿Cuántos gobiernos locales serán elegidos para quedar participando en el proyecto y recibir la donación de las acciones de IDMoney S.A.?"
        pregunta36.RespuestaCorrecta = "1"
        pregunta36.IDRespuesta = "36"
        pregunta36.Respuesta1 = "Tres."
        pregunta36.Respuesta2 = "Cinco."
        pregunta36.Respuesta3 = "Diez."
        pregunta36.Respuesta4 = "No hay límite fijo."
        
        let pregunta37 = Pregunta()
        pregunta37.pregunta = "¿Quién seleccionará los gobiernos locales que quedarán  participando en el proyecto?"
        pregunta37.RespuestaCorrecta = "2"
        pregunta37.IDRespuesta = "37"
        pregunta37.Respuesta1 = "IDMoney S.A."
        pregunta37.Respuesta2 = "Los token holders, mediante votación, seleccionarán a los gobiernos locales de entre una lista de gobiernos locales elegibles."
        pregunta37.Respuesta3 = "Gobernance Labs."
        pregunta37.Respuesta4 = "Legal Labs, la empresa que conduce de forma exclusiva la venta de los tokens IDM."
        
        let pregunta38 = Pregunta()
        pregunta38.pregunta = "¿Qué se hará con los gobiernos locales que estaban interesados en participar en el proyecto IDMoney y no resulten seleccionados?"
        pregunta38.RespuestaCorrecta = "3"
        pregunta38.IDRespuesta = "38"
        pregunta38.Respuesta1 = "Simplemente no podrán participar."
        pregunta38.Respuesta2 = "Se perderán la oportunidad y no podrán participar en otro proyecto similar."
        pregunta38.Respuesta3 = "Podrán participar en un nuevo proyecto hermano que se llamará Global Money; lanzado por el mismo grupo de empresas del Proyecto IDMoney."
        pregunta38.Respuesta4 = "No podrán participar y no se les dará seguimiento."
        
        let pregunta39 = Pregunta()
        pregunta39.pregunta = "¿Cuál es el precio de venta de los tokens IDM en la venta oficial que es manejada por Legal Labs?"
        pregunta39.RespuestaCorrecta = "2"
        pregunta39.IDRespuesta = "39"
        pregunta39.Respuesta1 = "US $0.75 por cada IDM."
        pregunta39.Respuesta2 = "0.00075 ETH por cada IDM."
        pregunta39.Respuesta3 = "0.75 ETH por cada IDM."
        pregunta39.Respuesta4 = "Ninguna de las opciones anteriores."
        
        let pregunta40 = Pregunta()
        pregunta40.pregunta = "¿El precio del IDM sube o baja de valor conforme suba o baje el valore de cuál de los siguientes tokens o moneda?"
        pregunta40.RespuestaCorrecta = "3"
        pregunta40.IDRespuesta = "40"
        pregunta40.Respuesta1 = "Dólar estadounidense."
        pregunta40.Respuesta2 = "Bitcoin."
        pregunta40.Respuesta3 = "Ethereum."
        pregunta40.Respuesta4 = "Ninguna de las opciones anteriores."

        let pregunta41 = Pregunta()
        pregunta41.pregunta = "¿Cuáles son las empresas privadas que forman parte del Crypto Liberty Group que maneja actualmente el proyecto IDMoney?"
        pregunta41.RespuestaCorrecta = "4"
        pregunta41.IDRespuesta = "41"
        pregunta41.Respuesta1 = "IDMoney S.A. y Legal Crypto Labs Global."
        pregunta41.Respuesta2 = "Legal Crypto Labs Global y IDMoney S.A."
        pregunta41.Respuesta3 = "Gobernance Labs y IDMoney S.A."
        pregunta41.Respuesta4 = "Gobernance Labs, Legal Crypto Labs Global, Cryptoland y IDMoney S.A."
        
        let pregunta42 = Pregunta()
        pregunta42.pregunta = "¿Las acciones de cuál o cuáles compañías serán donadas a los tres gobiernos locales del mundo que sean seleccionados para participar en el proyecto?"
        pregunta42.RespuestaCorrecta = "2"
        pregunta42.IDRespuesta = "42"
        pregunta42.Respuesta1 = "Gobernance Crypto Labs Global y IDMoney S.A."
        pregunta42.Respuesta2 = "IDMoney S.A."
        pregunta42.Respuesta3 = "Gobernance Labs y IDMoney S.A."
        pregunta42.Respuesta4 = "Cryptoland.TV y IDMoney S.A."
        
        let pregunta43 = Pregunta()
        pregunta43.pregunta = "¿Intentará IDMoney S.A. o cualquiera de las empresas del Crypto Liberty Group crear un mercado secundario para transar tokens IDM para intentar hacer subir el precio del token IDM?"
        pregunta43.RespuestaCorrecta = "1"
        pregunta43.IDRespuesta = "43"
        pregunta43.Respuesta1 = "No lo harán."
        pregunta43.Respuesta2 = "Sí lo harán."
        pregunta43.Respuesta3 = "Pedirán a alguien que lo haga."
        pregunta43.Respuesta4 = "Ninguna de las opciones anteriores."
        
        let pregunta44 = Pregunta()
        pregunta44.pregunta = "¿Otras personas o empresas no relacionadas con el Crypto Liberty Group podrían crear un mercado secundario para transar el token IDM y que en ese mercado secundario el token pueda subir o bajar su precio?"
        pregunta44.RespuestaCorrecta = "1"
        pregunta44.IDRespuesta = "44"
        pregunta44.Respuesta1 = "Otras personas/empresas no relacionadas con el grupo sí pueden crear un mercado secundario para el token IDM. Serían revendedores, no se puede evitar."
        pregunta44.Respuesta2 = "Otras personas/empresas no relacionadas con el grupo no podrán crear un mercado secundario para el token IDM."
        pregunta44.Respuesta3 = "Es totalmente seguro que eso sucederá."
        pregunta44.Respuesta4 = "Eso nunca sucederá."
        
        let pregunta45 = Pregunta()
        pregunta45.pregunta = "A los gobiernos locales que reciban las acciones de IDMoney S.A. y queden a cargo del proyecto, ¿les serviría que el valor del Ethereum token (ETH) suba de valor?"
        pregunta45.RespuestaCorrecta = "3"
        pregunta45.IDRespuesta = "45"
        pregunta45.Respuesta1 = "Es indiferente, el valor del ETH nada tiene que ver con el valor del token IDM."
        pregunta45.Respuesta2 = "No les sirve porque si el ETH sube de valor, automáticamente baja el valor del IDM."
        pregunta45.Respuesta3 = "Sí les sirve; porque si el valor del ETH sube, también el valor del IDM subirá; eso haría que los tokens IDM de las personas pobres suban de valor."
        pregunta45.Respuesta4 = "Nunca hay relación entre ninguna de los diferentes tokens del mundo crypto."

        let pregunta46 = Pregunta()
        pregunta46.pregunta = "Especulando que alguien, fuera del Crypto Liberty Group, creara un mercado secundario para transar tokens IDM y en ese mercado los IDM subieran de valor, ¿eso le convendría a los gobiernos locales?"
        pregunta46.RespuestaCorrecta = "3"
        pregunta46.IDRespuesta = "46"
        pregunta46.Respuesta1 = "Eso les sería indiferente."
        pregunta46.Respuesta2 = "No les serviría."
        pregunta46.Respuesta3 = "Suponiendo que subiera el valor, sí les serviría; para que los tokens que transfieran a los pobres tengan mayor valor, con lo cual podrían bajar más la pobreza."
        pregunta46.Respuesta4 = "No; no es conveniente que los tokens IDM suban de valor."
        
        let pregunta47 = Pregunta()
        pregunta47.pregunta = "Siempre suponiendo que alguien  fuera del Crypto Liberty Group creara un mercado secundario para transar tokens IDM, ¿las acciones de los gobiernos locales podrían hacer que los tokens IDM suban de valor?"
        pregunta47.RespuestaCorrecta = "2"
        pregunta47.IDRespuesta = "47"
        pregunta47.Respuesta1 = "Normalmente no."
        pregunta47.Respuesta2 = "Sí, depende de las acciones que realicen."
        pregunta47.Respuesta3 = "No hay nada que puedan hacer para que el token IDM suba de valor."
        pregunta47.Respuesta4 = "Ninguna de las opciones anteriores."
        
        let pregunta48 = Pregunta()
        pregunta48.pregunta = "Si existiera un mercado secundario para los tokens IDM, ¿cuáles de las siguientes acciones que pudieran realizar los gobiernos locales, que reciban las acciones de IDMoney, podrían hacer que el proyecto suba de valor?"
        pregunta48.RespuestaCorrecta = "4"
        pregunta48.IDRespuesta = "48"
        pregunta48.Respuesta1 = "Cada vez que uno de los gobiernos locales sea seleccionado para participar en el proyecto sea seleccionado y lo anuncie en su país y el mundo."
        pregunta48.Respuesta2 = "Cada vez que uno de los gobiernos locales participantes anuncie que se concretó la transferencia de tokens a las personas pobres de su localidad."
        pregunta48.Respuesta3 = "Cuando los gobiernos locales implementen el software desarrollado y cuando aprovechen el software para hacer cosas como permitir el pago de impuestos y servicios con tokens IDM aplicando descuentos."
        pregunta48.Respuesta4 = "Todas las opciones anteriores y muchas más."
        
        let pregunta49 = Pregunta()
        pregunta49.pregunta = "¿A los fundadores del proyecto les convendría que los gobiernos locales lleguen a la implementación del software y otros aspectos proyecto después de que las acciones de IDMoney S.A. pasen a manos de los gobiernos locales?"
        pregunta49.RespuestaCorrecta = "3"
        pregunta49.IDRespuesta = "49"
        pregunta49.Respuesta1 = "Para los fundadores no habría conveniencia."
        pregunta49.Respuesta2 = "Les convendría por la satisfacción de ver el proyecto implementado exitosamente."
        pregunta49.Respuesta3 = "Les convendría por la satisfacción; porque el proyecto tomaría mucho valor; y porque luego piensan lanzar otro proyecto llamado Global Money, igual que el proyecto IDMoney pero con mejoras y a nivel global."
        pregunta49.Respuesta4 = ""
        
        let pregunta50 = Pregunta()
        pregunta50.pregunta = "¿Qué es la Money Making Wallet (MMW) de IDMoney?"
        pregunta50.RespuestaCorrecta = "3"
        pregunta50.IDRespuesta = "50"
        pregunta50.Respuesta1 = "Es una aplicación que desarrolla IDMoney que se utilizará para almacenar y transferir solamente tokens IDM."
        pregunta50.Respuesta2 = "Es una aplicación que desarrolla IDMoney que se utilizará para almacenar y transferir solamente tokens compatibles con ETH."
        pregunta50.Respuesta3 = "Es una aplicación que desarrollará IDMoney para dispositivos móviles; que permitirá almacenar y transferir diferentes tokens, e incluye funciones adicionales a los de una billetera crypto."
        pregunta50.Respuesta4 = "Es una billetera crypto común."

        let pregunta51 = Pregunta()
        pregunta51.pregunta = "¿Cuál de las siguientes es una función de la Money Making Wallet App. (MMW)?"
        pregunta51.RespuestaCorrecta = "4"
        pregunta51.IDRespuesta = "51"
        pregunta51.Respuesta1 = "Recibir tokens provenientes de otras billeteras MMW o diferentes."
        pregunta51.Respuesta2 = "Transferir tokens crypto hacia otras billeteras MMW o diferentes."
        pregunta51.Respuesta3 = "Permitirá almacenar tokens crypto de diferentes tipos."
        pregunta51.Respuesta4 = "Todas las tres anteriores."
        
        let pregunta52 = Pregunta()
        pregunta52.pregunta = "¿Cuál de las siguientes es una función especial de la Money Making Wallet (MMW)?"
        pregunta52.RespuestaCorrecta = "3"
        pregunta52.IDRespuesta = "52"
        pregunta52.Respuesta1 = "Es un software diseñado exclusivamente para almacenar, manipular y mostrar las fotografías de un usuario."
        pregunta52.Respuesta2 = "Elimina los virus que puedan haber en un móvil."
        pregunta52.Respuesta3 = "Permitirá almacenar, mantener y compartir, si lo desea, la información de la personalidad virtual del usuario de la APP."
        pregunta52.Respuesta4 = "Permite chatear con voz entre diferentes usuarios."
        
        let pregunta53 = Pregunta()
        pregunta53.pregunta = "¿Cuál de las siguientes es una función especial de la Money Making Wallet (MMW)?"
        pregunta53.RespuestaCorrecta = "1"
        pregunta53.IDRespuesta = "53"
        pregunta53.Respuesta1 = "Credit Identity Theft Protection."
        pregunta53.Respuesta2 = "Antivirus protection."
        pregunta53.Respuesta3 = "Calendar."
        pregunta53.Respuesta4 = "Photo animation."
        
        let pregunta54 = Pregunta()
        pregunta54.pregunta = "¿Cuál de las siguientes es una función especial de la Money Making Wallet (MMW)?"
        pregunta54.RespuestaCorrecta = "1"
        pregunta54.IDRespuesta = "54"
        pregunta54.Respuesta1 = "Title Fraud Prevention."
        pregunta54.Respuesta2 = "Data Stealing Prevention."
        pregunta54.Respuesta3 = "Photo Stealing Prevention."
        pregunta54.Respuesta4 = "Ninguna de las anteriores."
        
        let pregunta55 = Pregunta()
        pregunta55.pregunta = "¿Cuál de las siguientes es una función especial de la Money Making Wallet (MMW)?"
        pregunta55.RespuestaCorrecta = "3"
        pregunta55.IDRespuesta = "55"
        pregunta55.Respuesta1 = "Bad Words Filter."
        pregunta55.Respuesta2 = "Word Processor & Translation."
        pregunta55.Respuesta3 = "Finantial Transaction Filter."
        pregunta55.Respuesta4 = "Bad Thoughts Filter."

        let pregunta56 = Pregunta()
        pregunta56.pregunta = "¿Cuál de las siguientes tecnologías sería soportada con la Money Making Wallet?"
        pregunta56.RespuestaCorrecta = "2"
        pregunta56.IDRespuesta = "56"
        pregunta56.Respuesta1 = "NHC."
        pregunta56.Respuesta2 = "NFC."
        pregunta56.Respuesta3 = "RFS."
        pregunta56.Respuesta4 = "FTP."
        
        let pregunta57 = Pregunta()
        pregunta57.pregunta = "La personalidad virtual es similar a:"
        pregunta57.RespuestaCorrecta = "4"
        pregunta57.IDRespuesta = "57"
        pregunta57.Respuesta1 = "Identidad virtual."
        pregunta57.Respuesta2 = "Entidad virtual."
        pregunta57.Respuesta3 = "Identidad digital."
        pregunta57.Respuesta4 = "Todas las anteriores."
        
        let pregunta58 = Pregunta()
        pregunta58.pregunta = "¿Qué protege la personalidad virtual?"
        pregunta58.RespuestaCorrecta = "4"
        pregunta58.IDRespuesta = "58"
        pregunta58.Respuesta1 = "Existencia."
        pregunta58.Respuesta2 = "Presencia."
        pregunta58.Respuesta3 = "Contenido y proyección. "
        pregunta58.Respuesta4 = "Todas las anteriores."
        
        let pregunta59 = Pregunta()
        pregunta59.pregunta = "¿Cuál es la manera más segura de guardar los datos?"
        pregunta59.RespuestaCorrecta = "1"
        pregunta59.IDRespuesta = "59"
        pregunta59.Respuesta1 = "Fuera de Internet."
        pregunta59.Respuesta2 = "En Internet."
        pregunta59.Respuesta3 = "En blockchain."
        pregunta59.Respuesta4 = "Todas las anteriores."
        
        let pregunta60 = Pregunta()
        pregunta60.pregunta = "¿Existe el derecho fundamental a no tener personalidad virtual?"
        pregunta60.RespuestaCorrecta = "1"
        pregunta60.IDRespuesta = "60"
        pregunta60.Respuesta1 = "Sí."
        pregunta60.Respuesta2 = "No."
        pregunta60.Respuesta3 = ""
        pregunta60.Respuesta4 = ""

        let pregunta61 = Pregunta()
        pregunta61.pregunta = "El derecho a no tener personalidad virtual tiene que ver con:"
        pregunta61.RespuestaCorrecta = "4"
        pregunta61.IDRespuesta = "61"
        pregunta61.Respuesta1 = "Remover datos."
        pregunta61.Respuesta2 = "Regular la presencia."
        pregunta61.Respuesta3 = "Comer sin tener dispositivos electrónicos encendidos."
        pregunta61.Respuesta4 = "Todas las anteriores."
        
        let pregunta62 = Pregunta()
        pregunta62.pregunta = "El derecho a tener o no tener personalidad virtual tendrá implicaciones en los contratos de usuarios de:"
        pregunta62.RespuestaCorrecta = "4"
        pregunta62.IDRespuesta = "62"
        pregunta62.Respuesta1 = "Facebook."
        pregunta62.Respuesta2 = "Google."
        pregunta62.Respuesta3 = "Twitter."
        pregunta62.Respuesta4 = "Todas las anteriores."
        
        let pregunta63 = Pregunta()
        pregunta63.pregunta = "Un ejemplo de protección del contenido en el derecho fundamental de la personalidad virtual es:"
        pregunta63.RespuestaCorrecta = "3"
        pregunta63.IDRespuesta = "63"
        pregunta63.Respuesta1 = "Que no me puedan contactar sin mi permiso."
        pregunta63.Respuesta2 = "Comunicarme sin tensiones."
        pregunta63.Respuesta3 = "Compartir el contenido según mis condiciones."
        pregunta63.Respuesta4 = "Ninguna  de las anteriores."
        
        let pregunta64 = Pregunta()
        pregunta64.pregunta = "Un ejemplo de protección de la presencia en el derecho fundamental de la personalidad virtual es:"
        pregunta64.RespuestaCorrecta = "1"
        pregunta64.IDRespuesta = "64"
        pregunta64.Respuesta1 = "Que no me contacten sin mi permiso."
        pregunta64.Respuesta2 = "Poder manejar mi contenido."
        pregunta64.Respuesta3 = "Difundir mis deseos e intenciones."
        pregunta64.Respuesta4 = "Ninguna de las anteriores."
        
        let pregunta65 = Pregunta()
        pregunta65.pregunta = "Un ejemplo de proyección en el derecho fundamental de la personalidad virtual es:"
        pregunta65.RespuestaCorrecta = "4"
        pregunta65.IDRespuesta = "65"
        pregunta65.Respuesta1 = "No tener crédito."
        pregunta65.Respuesta2 = "Solicitar pareja."
        pregunta65.Respuesta3 = "No querer hipotecar o vender una propiedad."
        pregunta65.Respuesta4 = "Todas la anteriores."

        let pregunta66 = Pregunta()
        pregunta66.pregunta = "¿Cómo se llama el principal personaje femenino de la manga de IDMoney?"
        pregunta66.RespuestaCorrecta = "1"
        pregunta66.IDRespuesta = "66"
        pregunta66.Respuesta1 = "Yuki."
        pregunta66.Respuesta2 = "Ichiko."
        pregunta66.Respuesta3 = "Ayaka."
        pregunta66.Respuesta4 = "Miyu."
        
        let pregunta67 = Pregunta()
        pregunta67.pregunta = "¿Cómo se llama el principal personaje masculino de la manga de IDMoney?"
        pregunta67.RespuestaCorrecta = "1"
        pregunta67.IDRespuesta = "67"
        pregunta67.Respuesta1 = "Kei."
        pregunta67.Respuesta2 = "Satoshi."
        pregunta67.Respuesta3 = "Akito."
        pregunta67.Respuesta4 = "Gaku."
        
        let pregunta68 = Pregunta()
        pregunta68.pregunta = "¿A qué se dedica la empresa CryptoLand?"
        pregunta68.RespuestaCorrecta = "2"
        pregunta68.IDRespuesta = "68"
        pregunta68.Respuesta1 = "Minería."
        pregunta68.Respuesta2 = "Comunicación crypto."
        pregunta68.Respuesta3 = "Venta de bienes raíces."
        pregunta68.Respuesta4 = "Todas las anteriores."
        
        let pregunta69 = Pregunta()
        pregunta69.pregunta = "¿Cómo se llama la manga que produce CryptoLand?"
        pregunta69.RespuestaCorrecta = "1"
        pregunta69.IDRespuesta = "69"
        pregunta69.Respuesta1 = "Cryptoland."
        pregunta69.Respuesta2 = "Bitcoin World."
        pregunta69.Respuesta3 = "Ethereum, Bitcoin and Alt-coins."
        pregunta69.Respuesta4 = "Todas las anteriores."
        
        let pregunta70 = Pregunta()
        pregunta70.pregunta = "¿Cuáles son los primeros clientes de Cryptoland?"
        pregunta70.RespuestaCorrecta = "4"
        pregunta70.IDRespuesta = "70"
        pregunta70.Respuesta1 = "IDMoney."
        pregunta70.Respuesta2 = "Global Money."
        pregunta70.Respuesta3 = "Legal Crypto Labs Global."
        pregunta70.Respuesta4 = "Todas las anteriores."

        let pregunta71 = Pregunta()
        pregunta71.pregunta = "¿Por qué el software libre es mejor que el código abierto?"
        pregunta71.RespuestaCorrecta = "1"
        pregunta71.IDRespuesta = "71"
        pregunta71.Respuesta1 = "Porque se preocupa por la libertad."
        pregunta71.Respuesta2 = "Porque comparte el código."
        pregunta71.Respuesta3 = "Porque se puede modificar el código."
        pregunta71.Respuesta4 = "Porque se preocupa por la eficiencia."
        
        let pregunta72 = Pregunta()
        pregunta72.pregunta = "¿Por qué se decidió que el software de IDMoney sea software libre?"
        pregunta72.RespuestaCorrecta = "4"
        pregunta72.IDRespuesta = "72"
        pregunta72.Respuesta1 = "Por la libertad para el usuario"
        pregunta72.Respuesta2 = "Por la eficiencia."
        pregunta72.Respuesta3 = "Para que pueda ser adaptado localmente de una manera más fácil."
        pregunta72.Respuesta4 = "Todas las anteriores."
        
        let pregunta73 = Pregunta()
        pregunta73.pregunta = "¿Cuál es el nombre de la primera licencia de software libre?"
        pregunta73.RespuestaCorrecta = "3"
        pregunta73.IDRespuesta = "73"
        pregunta73.Respuesta1 = "MIT."
        pregunta73.Respuesta2 = "Apache."
        pregunta73.Respuesta3 = "GPL."
        pregunta73.Respuesta4 = "BSD."
        
        let pregunta74 = Pregunta()
        pregunta74.pregunta = "El origen de los ‘forks’ se encuentra en:"
        pregunta74.RespuestaCorrecta = "2"
        pregunta74.IDRespuesta = "74"
        pregunta74.Respuesta1 = "La mitosis."
        pregunta74.Respuesta2 = "Las licencias de software libre."
        pregunta74.Respuesta3 = "Hydra."
        pregunta74.Respuesta4 = "Todas las anteriores."
        
        let pregunta75 = Pregunta()
        pregunta75.pregunta = "¿Qué empresa maneja el fondo de contingencia del proyecto IDMoney?"
        pregunta75.RespuestaCorrecta = "3"
        pregunta75.IDRespuesta = "75"
        pregunta75.Respuesta1 = "Global Money."
        pregunta75.Respuesta2 = "Governance Labs."
        pregunta75.Respuesta3 = "Legal Crypto Labs Global."
        pregunta75.Respuesta4 = "CryptoLand."

        let pregunta76 = Pregunta()
        pregunta76.pregunta = "¿Cuál empresa está realizando la venta exclusivamente?"
        pregunta76.RespuestaCorrecta = "3"
        pregunta76.IDRespuesta = "76"
        pregunta76.Respuesta1 = "IDMoney S.A."
        pregunta76.Respuesta2 = "Governance Labs."
        pregunta76.Respuesta3 = "Legal Crypto Labs Global."
        pregunta76.Respuesta4 = "CryptoLand."
        
        let pregunta77 = Pregunta()
        pregunta77.pregunta = "¿Cuánto es el monto del fondo de contingencia del proyecto IDMoney?"
        pregunta77.RespuestaCorrecta = "2"
        pregunta77.IDRespuesta = "77"
        pregunta77.Respuesta1 = "30% de todos los tokens IDM."
        pregunta77.Respuesta2 = "30% de los ingresos."
        pregunta77.Respuesta3 = "20% de los ingresos."
        pregunta77.Respuesta4 = "40% de los ingresos."
        
        let pregunta78 = Pregunta()
        pregunta78.pregunta = "¿Cuánto es el premio mayor que se puede ganar en la IDMoney Play APP?"
        pregunta78.RespuestaCorrecta = "3"
        pregunta78.IDRespuesta = "78"
        pregunta78.Respuesta1 = "200 ETH."
        pregunta78.Respuesta2 = "100 BTC."
        pregunta78.Respuesta3 = "400 ETH más 100 mil IDM."
        pregunta78.Respuesta4 = "300 mil IDM."
        
//        let pregunta29 = Pregunta()
//        pregunta29.pregunta = ""
//        pregunta29.RespuestaCorrecta = "2"
//        pregunta29.IDRespuesta = "29"
//        pregunta29.Respuesta1 = ""
//        pregunta29.Respuesta2 = ""
//        pregunta29.Respuesta3 = ""
//        pregunta29.Respuesta4 = ""
//
//        let pregunta30 = Pregunta()
//        pregunta30.pregunta = ""
//        pregunta30.RespuestaCorrecta = "2"
//        pregunta30.IDRespuesta = "30"
//        pregunta30.Respuesta1 = ""
//        pregunta30.Respuesta2 = ""
//        pregunta30.Respuesta3 = ""
//        pregunta30.Respuesta4 = ""
//
//        let pregunta26 = Pregunta()
//        pregunta26.pregunta = ""
//        pregunta26.RespuestaCorrecta = "2"
//        pregunta26.IDRespuesta = "26"
//        pregunta26.Respuesta1 = ""
//        pregunta26.Respuesta2 = ""
//        pregunta26.Respuesta3 = ""
//        pregunta26.Respuesta4 = ""
//
//        let pregunta27 = Pregunta()
//        pregunta27.pregunta = ""
//        pregunta27.RespuestaCorrecta = "2"
//        pregunta27.IDRespuesta = "27"
//        pregunta27.Respuesta1 = ""
//        pregunta27.Respuesta2 = ""
//        pregunta27.Respuesta3 = ""
//        pregunta27.Respuesta4 = ""
//
//        let pregunta28 = Pregunta()
//        pregunta28.pregunta = ""
//        pregunta28.RespuestaCorrecta = "2"
//        pregunta28.IDRespuesta = "28"
//        pregunta28.Respuesta1 = ""
//        pregunta28.Respuesta2 = ""
//        pregunta28.Respuesta3 = ""
//        pregunta28.Respuesta4 = ""
//
//        let pregunta29 = Pregunta()
//        pregunta29.pregunta = ""
//        pregunta29.RespuestaCorrecta = "2"
//        pregunta29.IDRespuesta = "29"
//        pregunta29.Respuesta1 = ""
//        pregunta29.Respuesta2 = ""
//        pregunta29.Respuesta3 = ""
//        pregunta29.Respuesta4 = ""
//
//        let pregunta30 = Pregunta()
//        pregunta30.pregunta = ""
//        pregunta30.RespuestaCorrecta = "2"
//        pregunta30.IDRespuesta = "30"
//        pregunta30.Respuesta1 = ""
//        pregunta30.Respuesta2 = ""
//        pregunta30.Respuesta3 = ""
//        pregunta30.Respuesta4 = ""
        
        let lstPreguntas = List<Pregunta>()
        lstPreguntas.append(pregunta1)
        lstPreguntas.append(pregunta2)
        lstPreguntas.append(pregunta3)
        lstPreguntas.append(pregunta4)
        lstPreguntas.append(pregunta5)
        lstPreguntas.append(pregunta6)
        lstPreguntas.append(pregunta7)
        lstPreguntas.append(pregunta8)
        lstPreguntas.append(pregunta9)
        lstPreguntas.append(pregunta10)
        lstPreguntas.append(pregunta11)
        lstPreguntas.append(pregunta12)
        lstPreguntas.append(pregunta13)
        lstPreguntas.append(pregunta14)
        lstPreguntas.append(pregunta15)
        lstPreguntas.append(pregunta16)
        lstPreguntas.append(pregunta17)
        lstPreguntas.append(pregunta18)
        lstPreguntas.append(pregunta19)
        lstPreguntas.append(pregunta20)
        lstPreguntas.append(pregunta21)
        lstPreguntas.append(pregunta22)
        lstPreguntas.append(pregunta23)
        lstPreguntas.append(pregunta24)
        lstPreguntas.append(pregunta25)
        lstPreguntas.append(pregunta26)
        lstPreguntas.append(pregunta27)
        lstPreguntas.append(pregunta28)
        lstPreguntas.append(pregunta29)
        lstPreguntas.append(pregunta30)
        lstPreguntas.append(pregunta31)
        lstPreguntas.append(pregunta32)
        lstPreguntas.append(pregunta33)
        lstPreguntas.append(pregunta34)
        lstPreguntas.append(pregunta35)
        lstPreguntas.append(pregunta36)
        lstPreguntas.append(pregunta37)
        lstPreguntas.append(pregunta38)
        lstPreguntas.append(pregunta39)
        lstPreguntas.append(pregunta40)
        lstPreguntas.append(pregunta41)
        lstPreguntas.append(pregunta42)
        lstPreguntas.append(pregunta43)
        lstPreguntas.append(pregunta44)
        lstPreguntas.append(pregunta45)
        lstPreguntas.append(pregunta46)
        lstPreguntas.append(pregunta47)
        lstPreguntas.append(pregunta48)
        lstPreguntas.append(pregunta49)
        lstPreguntas.append(pregunta50)
        lstPreguntas.append(pregunta51)
        lstPreguntas.append(pregunta52)
        lstPreguntas.append(pregunta53)
        lstPreguntas.append(pregunta54)
        lstPreguntas.append(pregunta55)
        lstPreguntas.append(pregunta56)
        lstPreguntas.append(pregunta57)
        lstPreguntas.append(pregunta58)
        lstPreguntas.append(pregunta59)
        lstPreguntas.append(pregunta60)
        lstPreguntas.append(pregunta61)
        lstPreguntas.append(pregunta62)
        lstPreguntas.append(pregunta63)
        lstPreguntas.append(pregunta64)
        lstPreguntas.append(pregunta65)
        lstPreguntas.append(pregunta66)
        lstPreguntas.append(pregunta67)
        lstPreguntas.append(pregunta68)
        lstPreguntas.append(pregunta69)
        lstPreguntas.append(pregunta70)
        lstPreguntas.append(pregunta71)
        lstPreguntas.append(pregunta72)
        lstPreguntas.append(pregunta73)
        lstPreguntas.append(pregunta74)
        lstPreguntas.append(pregunta75)
        lstPreguntas.append(pregunta76)
        lstPreguntas.append(pregunta77)
        lstPreguntas.append(pregunta78)
        
        return lstPreguntas
    }
    
    
    fileprivate func CargarPreguntas(_ itemPregunta: Pregunta) {
        let item = preguntas.filter{ $0.IDRespuesta.description == itemPregunta.IDRespuesta.description }
        if item.isEmpty
        {
            if !itemPregunta.IDRespuesta.isEmpty{
                let objectsNotAdd = preguntasContestada.filter("preguntaContestadaID = %@", itemPregunta.IDRespuesta)
                if objectsNotAdd.isEmpty{
                    realm.add(itemPregunta)
                }
            }
            
        }
    }
    
    fileprivate func PreguntaMarcada(_ pregunta: Pregunta) {
        do
        {
            try realm.write {
                let objectsToDelete = realm.objects(Pregunta.self).filter("IDRespuesta = %@", pregunta.IDRespuesta)
                realm.delete(objectsToDelete)
                tableViewPreguntas.reloadData()
            }
        }catch {
        }
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }
    }

    //    MARK: - Eventos
    
    //    MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func anadirPreguntasContestadas(preguntaContestada: Pregunta, identBoton : String){
        let idPregunta: String = preguntaContestada.IDRespuesta
        let respBuena: String = preguntaContestada.RespuestaCorrecta
        var respContestada: String = ""
        switch identBoton {
        case "1":
             respContestada = "1"
        case "2":
             respContestada = "2"
        case "3":
             respContestada = "3"
        case "4":
             respContestada = "4"
        default:
            respContestada = ""
        }
        
        
        do{
        try realm.write {
            let preguntaItem = preguntasContestada.filter{ $0.preguntaContestadaID.description == preguntaContestada.IDRespuesta }
            if preguntaItem.isEmpty
            {
                let preguntaCont = PreguntaContestada()
                preguntaCont.preguntaContestada = respContestada
                preguntaCont.preguntaContestadaID = idPregunta
                preguntaCont.preguntaCorrecta = respContestada == respBuena ? true : false
                realm.add(preguntaCont)
            }else{
                let alert = UIAlertController(title: "Alerta", message: "Esta pregunta ya fue contestada.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }

            }
        } catch {
        }
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }

    }
    
    func buscarPreguntaContestada(){
        
    }
}

//    MARK: - Extension cell delegate
extension NerdAcademyQuizViewController : PreguntaCellDelegate
{
    
    func didBtnRespuesta1(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 1")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "1")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta2(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 2")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "2")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta3(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 3")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "3")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta4(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 4")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "4")
        PreguntaMarcada(pregunta)
    }
    

    
    
}
