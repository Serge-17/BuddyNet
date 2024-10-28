import Foundation

// Объявляем класс UserViewModel, который будет управлять состоянием пользователей и соответствовать протоколу ObservableObject
@MainActor
class UserViewModel: ObservableObject {
    // Публикуем массив пользователей, чтобы изменения в нем автоматически обновляли интерфейс
    @Published var users = [User]()
    
    // Асинхронная функция для загрузки пользователей
    func fetchUsers() async {
        // Создаем URL для запроса данных о пользователях
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        do {
            // Выполняем асинхронный запрос к URL и получаем данные
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder() // Создаем экземпляр JSONDecoder для декодирования данных
            decoder.dateDecodingStrategy = .iso8601 // Устанавливаем стратегию декодирования дат
            
            // Декодируем данные в массив объектов User
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            // Обновляем массив пользователей на главном потоке
            DispatchQueue.main.async {
                self.users = decodedUsers
            }
        } catch {
            // Обрабатываем ошибки, если загрузка или декодирование не удались
            print("Failed to load users: \(error.localizedDescription)")
        }
    }
}
