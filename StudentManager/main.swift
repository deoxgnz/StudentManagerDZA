//  main.swift
//  StudentManager
//  Created by Daniel Garcia on 28/03/22.

import Foundation

var option: MenuOption
let menu = Menu()
let inputManager = InputManager()
var arrStudents: [Student] = []

repeat {
    menu.show()
    
    let value = inputManager.getIntWith("Ingrese el número de opción que desea ver",
                                        errorMessage: "La opción ingresada es incorrecta",
                                        withRange: 1...5)
    option = MenuOption(rawValue: value) ?? .none
    
    switch option {
        case .none:
            break
        case .add:
            addStudent()
        case .list:
            listStudents()
        case .search:
            searchStudent()
        case .delete:
            deleteStudent()
        case .exit:
            print("\n  BYE!!!\n")
    }
    let _ = readLine()
} while option != .exit


func addStudent() {
    print("\n -Agregar alumno\n")
    
    let name = inputManager.getStringWith("Ingrese el nombre del alumno", errorMessage: "Nombre no válido")
    let lastName = inputManager.getStringWith("Ingrese el apellido del alumno", errorMessage: "Apellido no válido")
    let address  = inputManager.getStringWith("Ingrese la dirección del alumno", errorMessage: "Dirección no válida")
    let dni = getDNIString()
    let day = inputManager.getIntWith("Ingrese Fecha de nacimiento (día)", errorMessage: "Dato no válido", withRange: 1...31)
    let month = inputManager.getIntWith("Ingrese Fecha de nacimiento (mes)", errorMessage: "Dato no válido", withRange: 1...12)
    let year = inputManager.getIntWith("Ingrese Fecha de nacimiento (año)", errorMessage: "Dato no válido", withRange: 1973...2003)
    
    arrStudents.append(Student(name: name, lastName: lastName, address: address, dniNumber: dni, birthdate: "\(day)/\(month)/\(year)"))
    
    print("¡Alumno Registrado!")
}

func listStudents() {
    print("\n -Listar Alumnos\n")
    guard !arrStudents.isEmpty else {
        print("Aún no hay alumnos inscritos")
        return
    }
    let sortedStudents = arrStudents.sorted(by: { $0.lastName < $1.lastName })
    for (i, student) in sortedStudents.enumerated() {
        print("\(i+1). \(student.nameInitials) - \(student.fullName)")
    }
}

func searchStudent() {
    print("\n -Buscar Alumno\n")
    
    let dni = getDNIString()
    guard let student = getStudentWith(dni: dni) else {
        print("No se encontró el Alumno con DNI: \(dni)")
        return
    }
    
    print("\n*Alumno encontrado:")
    print("Fecha de nacimiento: \(student.birthdate)")
    print("Edad: \(student.age)")
    print("Número de documento: \(student.dniNumber)")
    print("Nombre completo: \(student.fullName)")
    print("Dirección: \(student.address)")
    print("Iniciales: \(student.nameInitials)")
}

func deleteStudent() {
    print("\n -Eliminar Alumno\n")
    guard !arrStudents.isEmpty else {
        print("Aún no hay alumnos inscritos")
        return
    }
    
    let dni = getDNIString()
    guard let index = getStudentIndexWith(dni: dni) else {
        print("No se encontró el Alumno con DNI: \(dni)")
        return
    }
    
    let respuesta = inputManager.getIntWith("\n¿Estás seguro de eliminar al alumuno?\n1.Si\n2.No", errorMessage: "Respuesta no válida", withRange: 1...2)
    guard let option = DeleteOption(rawValue: respuesta) else { return }
    switch option {
        case .yes:
            removeStudentFromArrayWith(index: index)
            print("¡¡Alumno Eliminado!!")
        case .no:
            print("No se eliminó al alumno")
    }
}

private func getStudentWith(dni: String) -> Student? {
    guard let index = getStudentIndexWith(dni: dni) else { return nil }
    return arrStudents[index]
}

private func removeStudentFromArrayWith(index: Int) {
    arrStudents.remove(at: index)
}

private func getStudentIndexWith(dni: String) -> Int? {
    return arrStudents.firstIndex(where: { $0.dniNumber == dni })
}

private func getDNIString() -> String {
    return inputManager.getStringWith("Ingrese el DNI del alumno", errorMessage: "DNI no válido", withRange: 8...8)
}

