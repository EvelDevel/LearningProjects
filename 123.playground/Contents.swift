import UIKit

print("Начало")

DispatchQueue.global().async {
    print("Асинхронная задача выполняется")
}

print("Конец")
