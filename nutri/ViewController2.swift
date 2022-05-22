//
//  ViewController2.swift
//  nutri
//
//  Created by Gla gla  on 21/05/22.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var tvPacientes: UITableView!
    
    var pacientes : [Paciente] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pacientes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPaciente") as! CellPacientesController
        
        cell.lblNombrePaciente.text = pacientes[indexPath.row].nombre_paciente
        cell.lblEdad.text = pacientes [indexPath.row].edad_paciente
        
        return cell
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inicializarPacientes()
        
    }
    func inicializarPacientes() {
        let url = URL(string: " ")!
        var solicitud = URLRequest(url: url)
        solicitud.httpMethod = "GET"
        solicitud.allHTTPHeaderFields = [
            "Accept" : "application/json"
        ]
        let task = URLSession.shared.dataTask(with: solicitud) {
            data, request, error in
            if let data = data {
                //Tenemos algo en data
                if let pacientes_data = try? JSONDecoder().decode([Paciente].self, from: data) {
                    DispatchQueue.main.async {
                        self.pacientes = pacientes_data
                        self.tvPacientes.reloadData()
                    }
                    
                } else {
                    print("No se pudo interpretar respuesta")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! DetailsPacienteontroller
        destino.paciente = pacientes[tvPacientes.indexPathForSelectedRow!.row]

    }
}
