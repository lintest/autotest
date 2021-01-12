﻿Каталог = ТекущийСценарий().Каталог + "/";
ПутьБиблиотеки = Каталог + "AddIn.zip";
ПутьБиблиотеки = Каталог + "VanessaExtLin64.so";
ПутьБиблиотеки = Каталог + "GitFor1CLin64_1-1-0-26.so";

ПодключитьВнешнююКомпоненту(ПутьБиблиотеки, "VanessaExt", ТипВнешнейКомпоненты.Native);
ВнешняяКомпонента = Новый("AddIn.VanessaExt.GitFor1C");
Сообщить(ВнешняяКомпонента.Версия);

ВнешняяКомпонента = Новый("AddIn.VanessaExt.WindowsControl");

Картинка = Новый ДвоичныеДанные(Каталог + "screen.png");
Фрагмент = Новый ДвоичныеДанные(Каталог + "folder.png");
Сообщить("folder.png - " + ВнешняяКомпонента.НайтиФрагмент(Картинка, Фрагмент));
