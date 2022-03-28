//  MenuOption.swift
//  StudentManager
//  Created by Daniel Garcia on 28/03/22.

import Foundation

enum MenuOption: Int {
    case none = 0
    case add
    case list
    case search
    case delete
    case exit
}

enum DeleteOption: Int {
    case yes = 1
    case no
}

struct Menu {
    
    func show() {
        
        let message = """
        
        
        ====================================
                     STUDENT APP
        ====================================
        
        1. Agregar nuevo alumno
        2. Listar todos los alumnos
        3. Buscar un alumno por DNI
        4. Eliminar un alumno
        5. Salir
        
        """
        self.clearConsole()
        print(message)
    }
    
    private func clearConsole() {
        let separator = Array(repeating: "\n", count: 20).joined()
        print("", terminator: separator)
    }
}
