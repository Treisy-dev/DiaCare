# DiaCare
# Описание приложения:
Это комплексное приложение, которое помогает людям с диабетом 1 и 2 типа эффективно контролировать свое здоровье, упрощающее и ускоряющее привычное использование пищевых дневников и дневников самоконтроля.

Основные функции:
1) Перевод БЖУ в Хлебные Единицы (ХЕ):
2) Легко конвертируйте потребляемые белки, жиры и углеводы в ХЕ для точного расчета дозы инсулина.
3) Используйте обширную базу данных продуктов с информацией о БЖУ.
4) Настраиваемые шаблоны питания:
    - Создайте шаблоны для часто повторяющихся приемов пищи - экономя время и усилия.
    - Применяйте и комбинируйте созданные шаблоны для быстрого добавления нового приема пищи в дневник.
5) Подробный пищевой дневник:
    - Записывайте все приемы пищи, включая количество, время и тип еды. Количество инсулина и ХЕ подсичтывается автоматически, но вы всегда можете скорректировать их.
    - Сахар крови в новой записи вычисляется из вашего среднего сахара, что позволяет быстро указать текущий уровень сахара крови.
    - Отслеживайте потребление инсулина и уровень сахара в крови.
7) Статистика:
    - Удобные графики показателей сахара за день/неделю/месяц.
    - История приемов пищи
    - Статистика по высоким, низким и средним сахарам за выбранный промежуток времени.
    - Статистика по потреблению ХЕ и инсулина за выбранный промежуток времени.
8) Напоминания:
    - Получайте своевременные уведомления о необходимости измерения уровня сахара в крови, приема таблеток или еды.
    - Настройте индивидуальные напоминания для своих нужд.

# Использованные технлогии:
1) Хранение данных:
   - CoreData.
   - UserDefaults.
2) Запросы в сеть:
   - Alamofire.
3) Верстка:
   - UIKit
   - SnapKit
4) DI-Контейнер - Swinject
5) Графики - DGCharts

А также: Combine, SPM, NotificationCentre, UNUserNotificationCenter(Пуш-уведомления) 
