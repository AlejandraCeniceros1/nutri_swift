//
//  DetailsPacienteontroller.swift
//  nutri
//
//  Created by Gla gla  on 21/05/22.
//

import Foundation
import UIKit

class DetailsPacienteontroller : UIViewController {
    var paciente : Paciente?
    
    @IBOutlet weak var imgEvidence: UIImageView!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblPeso: UILabel!
    @IBOutlet weak var lblSexo: UILabel!
    @IBOutlet weak var lblEdad: UILabel!
    @IBOutlet weak var lblNombrePaciente: UILabel!
    
    override func viewDidLoad() {
        if paciente?.descripcion == nil {
            let url = URL(string: "http://172.31.197.130:8000/api/pacientes/\(paciente!.id!)")!
                  var solicitud = URLRequest(url: url)
                  solicitud.httpMethod = "GET"
                  solicitud.allHTTPHeaderFields = [
                      "Accept" : "application/json"
                  ]
                  let task = URLSession.shared.dataTask(with: solicitud) {
                      data, request, error in
                      if let data = data {
                          //Tenemos algo en data
                       if let detalles_paciente = try? JSONDecoder().decode(Paciente.self, from: data) {
                           self.paciente?.descripcion = detalles_paciente.descripcion
                           self.paciente?.evidence = detalles_paciente.evidence
                              DispatchQueue.main.async {
                               self.lblDescripcion.text = self.paciente!.descripcion
                               
                              }
                           if self.paciente?.evidence != nil{
                           self.cargarImagen()
                           }
                          } else {
                              print("No se pudo interpretar respuesta")
                          }
                      } else if let error = error {
                          print(error.localizedDescription)
                      }
                  }
                  task.resume()
           } else {
               lblDescripcion.text = paciente!.descripcion!
               if paciente?.evidence != nil{
                   cargarImagen()
               }
           }
        
    
    }
    func cargarImagen() {
        let url = URL(string: "http://172.31.197.130:8000/storage/evidences/\(paciente!.evidence!)")!
        var solicitud = URLRequest(url: url)
        solicitud.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: solicitud) {
            data, request, error in
            if let data = data {
                //Tenemos algo en data
                DispatchQueue.main.async {
                    self.imgEvidence.image = UIImage(data: data)
             
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()

}

}

