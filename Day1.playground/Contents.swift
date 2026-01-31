import Foundation

// перечисление ошибок, которые может выбросить функция
enum PasswordError: Error{
    case short, obvious
}

print("password should be minimum 5 characters and one char upper case")

// Функция проверки пароля
// throws — значит функция может выбрасывать ошибки
// возвращает строку с оценкой сложности пароля
func checkPassword(_ password: String) throws -> String{
    
    if password.count < 5{
        throw PasswordError.short
    }
    if password == "password" || password == "12345"{
        throw PasswordError.obvious
    }
    
    //регулярное выражение
    
    let range = NSRange(location: 0, length: password.utf16.count) // utf16 чтобы не было проблем с эмодзи
    let regex = try! NSRegularExpression(pattern: "[A-Z]")
    let hasUpper = regex.firstMatch(in: password, options: [], range: range) != nil
    
    // Проверяем, есть ли хотя бы одно совпадение
    if !hasUpper {
        throw PasswordError.obvious
    }
    if password.count < 8 {
        return "OK"
    }else if password.count < 12{
        return "Good"
    }else if password.count < 16{
        return "Strong"
    }else{
        return "Very Strong"
    }
}

let password = "12345678A"

do{
    // проверка пароля
    let result = try checkPassword(password)
    print("The password has been verified")
}catch{
    // если есть ошибка
    print("ERROR")
}
