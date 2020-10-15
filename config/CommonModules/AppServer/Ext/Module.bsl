﻿Функция ПодключитьОбработку(ИмяФайла) Экспорт
	
	Файл = Новый Файл(ИмяФайла);
	Если НЕ Файл.Существует() Тогда
		ВызватьИсключение "Файл внешней обработки не найден";
	КонецЕсли;
	
	ОписаниеЗащиты = Новый ОписаниеЗащитыОтОпасныхДействий;
	ОписаниеЗащиты.ПредупреждатьОбОпасныхДействиях = Ложь;
	Обработка = ВнешниеОбработки.Создать(ИмяФайла, Ложь, ОписаниеЗащиты);
	Возврат "ВнешняяОбработка." + Обработка.Метаданные().Имя + ".Форма";
	
КонецФункции

Функция СоздатьСоединение() Экспорт
	
	ЧтениеТекста = Новый ЧтениеТекста("app_port.txt");
	Порт = Число(ЧтениеТекста.Прочитать());
	Возврат Новый HTTPСоединение("localhost", Порт);
	
КонецФункции

&НаСервере
Процедура ОтправитьСообщение(HTTPСоединение, Сообщение, Статус, Подробно = "") Экспорт
	
	Структура = Новый Структура("message,category,details", Сообщение, Статус, Подробно);
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Структура);
	ТекстJSON = ЗаписьJSON.Закрыть();
	
	HTTPЗапрос = Новый HTTPЗапрос("/api/build/messages");
	HTTPЗапрос.УстановитьТелоИзСтроки(ТекстJSON);
	HTTPЗапрос.Заголовки.Вставить("Content-type", "application/json");
	HTTPСоединение.ОтправитьДляОбработки(HTTPЗапрос);
	
КонецПроцедуры

Процедура ОтправитьТест(HTTPСоединение, ИмяТеста, ИмяФайла, Длительность, Статус, Подробно = "") Экспорт
	
	Структура = Новый Структура;
	Структура.Вставить("outcome", Статус);
	Структура.Вставить("testName", ИмяТеста);
	Структура.Вставить("fileName", ИмяФайла);
	Структура.Вставить("ErrorMessage", Подробно);
	Структура.Вставить("durationMilliseconds", Длительность);
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Структура);
	ТекстJSON = ЗаписьJSON.Закрыть();
	
	HTTPЗапрос = Новый HTTPЗапрос("/api/tests");
	HTTPЗапрос.УстановитьТелоИзСтроки(ТекстJSON);
	HTTPЗапрос.Заголовки.Вставить("Content-type", "application/json");
	HTTPСоединение.ОтправитьДляОбработки(HTTPЗапрос);
	
КонецПроцедуры