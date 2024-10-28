import SwiftUI

// Основная структура представления, отвечающая за отображение списка пользователей
struct ContentView: View {
    // Создаем объект viewModel, который будет управлять состоянием пользователей
    @StateObject private var viewModel = UserViewModel()
    
    // Основное тело представления
    var body: some View {
        // Используем NavigationStack для навигации между экранами
        NavigationStack {
            // Создаем список пользователей из viewModel
            List(viewModel.users) { user in
                // Каждая строка списка является ссылкой на детальное представление пользователя
                NavigationLink(destination: UserDetailView(user: user)) {
                    HStack {
                        // Отображаем имя пользователя с заголовком
                        Text(user.name)
                            .font(.headline)
                        
                        // Отображаем количество друзей в виде иконки
                        Image(systemName: "\(user.friends.count).circle.fill")
                            .font(.system(size: 25, weight: .thin))
                            .foregroundStyle(Color.black, Color.white)

                        Spacer() // Добавляем пространство между элементами

                        // Отображаем статус активности пользователя (Активен или Неактивен)
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            // Заголовок навигации для списка пользователей
            .navigationTitle("Users")
            // Загружаем пользователей асинхронно при загрузке представления
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

// Структура представления для отображения деталей пользователя
struct UserDetailView: View {
    let user: User // Получаем пользователя для отображения его деталей
    
    var body: some View {
        VStack(alignment: .leading) {
            // Отображаем информацию о пользователе (возраст, компания, email, адрес)
            Text("Age: \(user.age)")
            Text("Company: \(user.company)")
            Text("Email: \(user.email)")
            Text("Address: \(user.address)")
            
            // Заголовок для списка друзей
            Text("Friends:")
                .font(.headline)
                .padding(.top)
            
            // Список друзей пользователя
            List(user.friends) { friend in
                Text(friend.name) // Отображаем имя каждого друга
            }
        }
        .navigationTitle(user.name) // Заголовок навигации - имя пользователя
        .padding() // Добавляем отступы вокруг содержимого
    }
}

// Предварительный просмотр для разработки интерфейса
#Preview {
    ContentView() // Отображаем основное представление в предварительном просмотре
}
