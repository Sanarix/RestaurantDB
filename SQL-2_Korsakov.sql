create schema certification;
drop schema certification cascade;
call initialization();

create or replace procedure initialization ()
language plpgsql
as 
$init$
	begin
		create or replace procedure addDish (значение varchar, название varchar, описание text, вес int, цена decimal)
		language plpgsql
		as 
		$addDish$
			begin
				--Проверка значений
				if цена <= 0 then 
				raise notice '%', 'Цена указана неверно';
				return;
				end if;
				if вес <= 0 then
				raise notice '%', 'Вес указан неверно';
				end if;
				--Операция добавления
				insert into "Блюда меню" (категория, наименование, "состав/описание", "вес(гр)", цена)
				values
					((select id from "Группы меню" гм where гм.категория = значение),
						название,
						описание,
						вес,
						цена
					);
				exception when others then
						raise notice '%', 'Данные указаны неверно';
			end;
		$addDish$;
	
		create or replace procedure addDrink (значение varchar, название varchar, описание text, объём int, цена decimal)
		language plpgsql
		as 
		$addDrink$
			begin
				--Проверка значений
				if цена <= 0 then 
				raise notice '%', 'Цена указана неверно';
				return;
				end if;
				if объём <= 0 then
				raise notice '%', 'Объём указан неверно';
				end if;
				--Операция добавления
				insert into "Блюда меню" (категория, наименование, "состав/описание", "вид напитка", "объём(мл)", цена)
				values
					((select категория from "Виды напитков" вн where вн.наименование = значение),
						название,
						описание,
						(select наименование from "Виды напитков" вн where наименование = значение),
						объём,
						цена
					);
				exception when others then
						raise notice '%', 'Данные указаны неверно';
			end;
		$addDrink$;
	
		create or replace procedure addEmployee (фамилия varchar, имя varchar, отчество varchar, вакансия varchar)
		language plpgsql
		as 
		$addEmployee$
			begin
				insert into Сотрудники (фамилия, имя, отчество, должность)
				values
					(фамилия,
					имя,
					отчество,
					(select id from Должность д where д.должность = вакансия)
					);
			end;
		$addEmployee$;
		
		create or replace procedure fillBasicMenu()
		language plpgsql
		as
		$fill$
			begin
					call addDish ('Холодные закуски',
					'Ассорти строганины из мускуса, омуля, чира',
					'Нарезанное тонкой стружкой филе рыб с тремя видами макало: 
					Бруснично-Горчичный соус,соевый подкопченый соус, морская соль и перец',
					260,1800);
					call addDish ('Холодные закуски',
					'Полярный плашкоут', 
					'Строганина из мускуна, рубанина из белуги, 
					рубанина мурманского гребешка и якутский салат "Индигирка',
					445, 4100);
					call addDish ('Холодные закуски',
					'Сало и копченая грудинка',
					'Свиное сало собственного производства засоленое и промаринованное в специях, 
					свиная грудинка горячего копчения, маринованые огурцы, перья зеленого лука, лук фри, 
					ржаные гренки, сметанно-горчичный соус',
					290, 700);
					call addDish ('Холодные закуски',
					'Олюрторская сельдь',
					'Нежная сельдь собственного пряного посола, репчатый лук, жженый картофель',
					280, 500);
					call addDish ('Холодные закуски',
					'Северный бот', 
					'Нерка с/с, мускун с/с, омуль с/с, гравлакс из семги, 
					жареный мурманский гребешок, картофель нуазет, моченый лимон',
					480, 5000);
					call addDish ('Холодные закуски',
					'Холодец из яка',
					'Суб продукт из яка, желатин, вода, соль, перец, лавровый лист',
					700, 1290);
					call addDish ('Холодные закуски',
					'Плато "Искэх',
					'Икра омуля, икра щуки, икра нерки, сметана, зеленый лук',
					185, 2420);
					call addDish ('Горячие закуски',
					'Печеный до черна картофель',
					'Печеный на углях картофель, грузди маринованые в меду, зеленый лук, 
					огурец малосольный, сферы из копченой сметаны, масло укропа',
					370, 900);
					call addDish ('Горячие закуски',
					'Жареные языки барашка',
					'Обжареные с добавлением чеснока и розмарина языки барашка су-вид, 
					микс салатов, соус "аджика", перья зеленого лука',
					240, 1350);
					call addDish ('Горячие закуски',
					'Котомки с морепродуктами',
					'Рубленый фарш морского гребешка, мясо краба, мясо красной аргентинской креветки',
					160, 820);
					call addDish ('Горячие закуски',
					'Плато морепродуктов',
					'Запеченые мурманские гребешки, мидии тушеные в сливочном соусе, запеченые киви, 
					щупальца осьминога су-вид, креветка гамбас, обжареная красная аргентинская креветка, 
					картофель нуазет, запеченые томаты черри, лук-порей',
					1210, 9500);
					call addDish ('Горячие закуски',
					'Хинкали с бараниной',
					'Мука, дрозжи хлебопекаренные, вода, соль, фарш из баранины и копченого курдючного сала,
					 соус сметана с кинзой, соус "сливочный хрен"',
					250, 800);
					call addDish ('Горячие закуски',
					'Жареная корюшка',
					'Сибирская рыба снеток, масло, чесночный соус',
					180, 400);
					call addDish ('Первые блюда',
					'Старосибирский борщ с лосем',
					'Наваристый костный бульон, свекла, морковь, капуста, 
					лук репчатый с добавлением корня сельдерея и пастернака. 
					Подается с томленым мясом лося, копченой сметаной и зеленью укропа',
					475, 850);
					call addDish ('Первые блюда',
					'Селянка с дичью',
					'Сборный суп из мяса дичи (олень, як, косуля, утка, лось, 
					в/к колбаса из медвежатины собственного производства), 
					соленых огурцов, репчатого лука, томатной пасты, 
					на наваристом костном бульоне с добавлением соленого папортника, 
					чеснока, копченой сметаны, лимона и моченой брусники)',
					350, 820);
					call addDish ('Первые блюда',
					'Затирка',
					'Староруская похлебка на курином бульоне с куриными потрохами, 
					морковью, картошкой, затиркой из муки в виде клецок',
					480, 650);
					call addDish ('Первые блюда',
					'Беленые щи с сомом и копченой стерлядкой',
					'Классические щи с капустой на наваристом бульоне из осетровых рыб, 
					филе сома и копченой стерлядки с добавлением молока. 
					Декорируется моченой брусникой и зеленью укропа',
					400, 850);
					call addDish ('Первые блюда',
					'Юшка северная',
					'Суп на рыбном и курином бульонах с тремя видами рыб: стерлядь, муксун, нерка, 
					с балтийскими томатами, луком-порей и зеленью',
					370, 850);
					call addDish ('Первые блюда',
					'Байкальская уха',
					'Суп на рыбном бульоне с муксуном, луком, морковью и картофелем 
					с добавлением печени трески. Подается с рубленым красным луком',
					400, 820);
					call addDish ('Первые блюда',
					'Талан "Таежный"',
					'Суп-гуляш на наваристом костном бульоне и основе из протертых томатов со сладким перцем, 
					картофелем, репчатым луком, перцем чили, корнем сельдерея и тремя видами мяса: лось, олень, утка',
					370, 820);
					call addDish ('Первые блюда',
					'Суточные щи "Дикий навар"',
					'Щи длительного томления на наваристом бульоне на костях диких животных с окороком лося, 
					квашеной капустой, белыми грибами, корнем сельдерея, копченой сметаной',
					400, 850);
					call addDish ('Вторые блюда',
					'Спинка судака с ризотто из цукини',
					'Спинка судака жаренная в сливочном масле с гарниром из томленых в сливках суккини.
					Подается с икрой сига и редуцированным маслом укропа',
					195, 850);
					call addDish ('Вторые блюда',
					'Котлеты из щуки',
					'Котлеты из филе щуки с добавлением свиного шпига. 
					Подаются с толченым картофелем и жареным луком. Декорируются яйцом пашот и щучьей икрой',
					350, 850);
					call addDish ('Вторые блюда',
					'Запеченые мурманские гребешки',
					'Мурманские гребешки, томленные в сливочном соусе с луком, чесноком и фенхелем, запеченные под сыром моцарелла. 
					Подаются с красной икрой',
					270, 1890);
					call addDish ('Вторые блюда',
					'Дранники с северной рыбой и яйцом пашот',
					'Картофельные дранники, шпинат, томленный в сливках, нерка слабой соли, 
					муксун холодного копчения, микс салатов, помидор черри, яйцо пашот, икра щуки, 
					сметанный соус, лук, редуцированное масло петрушки',
					500, 990);
					call addDish ('Вторые блюда',
					'Камчатский пролив',
					'Сочные котлеты из мяса краба, красных аргентинских креветок и командорского кальмара. 
					Подаются с воздушным муссом из корня сельдерея и мочеными яблоками нуазет',
					170, 1920);
					call addDish ('Вторые блюда',
					'Скоблянка',
					'Сковорода с яком, косулей и оленем, обжаренными и томлеными в квасе 
					с добавлением молодого картофеля, лисичек и помидор черри. 
					Подается с муссом из печеного картофеля',
					430, 1700);
					call addDish ('Вторые блюда',
					'Стейк из оленя с соусом чили',
					'Оленина, фламбированная коньяком, обжаренные на гриле огурцы, красный лук, цуккини,
					соус сладкий чили, лук-порей',
					480, 4500);
					call addDish ('Десерты',
					'Десерт из жимолости',
					'Нежнейший десерт из двух муссов - шоколадного и ягодного',
					145, 420);
					call addDish ('Десерты',
					'Сибирский ягодный пирог',
					'Нежный бисквит с брусникой и вишней, корицей, кедровым орехом и медом. 
					Запекается под шапкой из сладкой сметаны и миндальной крошки. 
					Подается с французским соусом англез и лесными ягодами куантро',
					240, 570);
					call addDish ('Десерты',
					'Морошковый десерт',
					'Муссовый десерт на основе морошкового пюре и белого шоколада, 
					покрытый зеркальной глазуоью на белом шоколаде и сгущеном молоке. 
					Подается с морошкой, карамелизированными в медукедровыми орехами и заварным соусом англез',
					200, 1040);
					call addDish ('Десерты',
					'Маковый пирог',
					'Маковые коржи, пропитанные заварным кремом с добавлением коньяка, 
					покрытые черносмородиновой мягкой пастилой. 
					Подается с ежевичным соусом и свежими ягодами',
					190, 530);
					call addDish ('Десерты',
					'Черемуховый пирог',
					'Пирог с шоколадом и кедровыми орехами, подается с ванильным мороженым',
					170, 890);
					call addDrink ('Черный чай', 'Великолепный Ассам', 'Чай черный индийский бархатный', 600, 230);
					call addDrink ('Черный чай', 'Эрл Грей', 'Чай черный, масло бергамота', 600, 230);
					call addDrink ('Черный чай', 'Дорогому гостю', 'Чай черный с чабрецом', 600, 230);
					call addDrink ('Черный чай', 'Ассам с манго и кардамоном', 'Манго, индийский чай ассам, зерна кардамона, сироп ваниль', 600, 230);
					call addDrink ('Зеленый чай', 'Сенча', 'Зеленый японский чай сенча', 600, 320);
					call addDrink ('Зеленый чай', 'Зеленый женьшень', 'С цукатами ананаса, корнем женьшеня, клубникой и лепестками календулы', 600, 230);
					call addDrink ('Зеленый чай', 'Молочный улун', 'Китайский полуферментированный улун со сливочно-молочным ароматом', 600, 230);
					call addDrink ('Зеленый чай', 'Кипрей с 6 специями', 'Иван чай гранулированный с кардамоном, корицей, имбирем, 
									гвоздикой, бадьяном и душистым перцем', 600, 280);
					call addDrink ('Зеленый чай', 'Благородный жасмин', 'Китайский зеленый чай с лепестками жасмина', 600, 230);
					call addDrink ('Красное вино', 'Темпранильо Риоха', 'сухое', 125, 390);
					call addDrink ('Красное вино', 'Мальбек классико', 'сухое', 125, 220);
					call addDrink ('Красное вино', 'Африканский Горизонт Пинотаж', 'сухое', 125, 270);
					call addDrink ('Красное вино', 'Аве Роса Карменер', 'сухое', 125, 320);
					call addDrink ('Красное вино', 'Тбилисоба Киндзмараули', 'сладкое', 125, 300);
					call addDrink ('Красное вино', 'Гремисеули', 'сухое', 125, 250);
					call addDrink ('Белое вино', 'Домашнее вино', 'сухое', 125, 270);
					call addDrink ('Белое вино', 'Алазанская долина', 'п/сладкое', 125, 315);
					call addDrink ('Белое вино', 'Пино Гриджио Алла Мода DOC', 'сухое', 125, 240);
					call addDrink ('Белое вино', 'Гэтано Требьяно', 'сухое', 125, 300);
					call addDrink ('Белое вино', 'Эль Паро Шардоне-Совиньон', 'сухое', 125, 280);
					call addDrink ('Белое вино', 'Цинандали', 'сухое', 125, 290);
					call addDrink ('Белое вино', 'Гави ди Гави ла Гране DOCG', 'сухое', 125, 360);
					call addDrink ('Белое вино', 'Кумала Кейп Классик', 'п/сухое', 125, 320);
					call addDrink ('Пиво', 'Maisels Weisse Original', null, 500, 390);
					call addDrink ('Пиво', 'Maisels Weisse Dunkel', null, 500, 390);
					call addDrink ('Пиво', 'Klaster Svetle', null, 500, 330);
					call addDrink ('Пиво', 'Blonde Ale', null, 500, 250);
					call addDrink ('Пиво', 'Belgian weisse', null, 500, 350);
					call addDrink ('Пиво', 'Irish stout', null, 500, 350);
					call addDrink ('Пиво', 'American Pale Ale', null, 500, 300);
					call addDrink ('Чача', 'Чача Асканели Голд', null, 40, 295);
					call addDrink ('Чача', 'Чача Асканели Сильвер', null, 40, 295);
					call addDrink ('Водка', 'Абсолют', null, 50, 220);
					call addDrink ('Водка', 'Алтай', null, 50, 145);
					call addDrink ('Водка', 'Пять озер', null, 50, 110);
					call addDrink ('Водка', 'Русский стандарт Оригинал', null, 50, 180);
					call addDrink ('Водка', 'Русский стандарт Платинум', null, 50, 225);
					call addDrink ('Водка', 'Тундра', null, 50, 120);
					call addDrink ('Виски', 'Hennesy VS', null, 40, 495);
					call addDrink ('Виски', 'Hennesy VSOP', null, 40, 690);
					call addDrink ('Виски', 'Martell VS', null, 40, 395);
					call addDrink ('Виски', 'Martell VSOP', null, 40, 420);
					call addDrink ('Виски', 'Chivas Regal 12 y.o.', null, 40, 490);
					call addDrink ('Виски', 'Chivas Regal 15 y.o.', null, 40, 560);
					call addDrink ('Виски', 'Jameson', null, 40, 320);
					call addDrink ('Виски', 'Jameson Black Barrel', null, 40, 390);
					call addDrink ('Коньяк', 'Ballantines Finest', null, 40, 230);
					call addDrink ('Коньяк', 'Macallan 12 y.o.', null, 40, 690);
					call addDrink ('Джин', 'Beefeater', null, 40, 300);
					call addDrink ('Джин', 'Beefeater Blood Orange', null, 40, 295);
					call addDrink ('Джин', 'Beefeater Pink Strawberry', null, 40, 320);
					end;
				$fill$;
	
				create or replace procedure starting (табельный int, "время начала работы" timestamp)
				language plpgsql
				as 
				$starting$
					begin
						insert into Табель ("табельный номер", "начало работы")
						values
							(табельный,
							"время начала работы"
							);
					end;
				$starting$;
			
				create or replace procedure ending (табельный int, "Время окончания работы" timestamp)
				language plpgsql
				as 
				$ending$
					begin
						update Табель as т
						set "конец работы" = "Время окончания работы"
						where "табельный номер" = табельный and т."конец работы" is null;
					end;
				$ending$;
			
			--Подразумевается что значения времени входа/выхода заносятся не вручную
				create or replace procedure fillReportCard ()
				language plpgsql
				as 
				$fill$
					begin
						--2022-08-01
						call starting(1, '2022-08-01 07:30 +0300'::timestamp);
						call ending (1, '2022-08-01 20:44 +0300'::timestamp);
						call starting(2, '2022-08-01 07:32+0300'::timestamp);
						call ending (2, '2022-08-01 20:12 +0300'::timestamp);
						call starting(3, '2022-08-01 07:55 +0300'::timestamp);
						call ending (3, '2022-08-01 20:10 +0300'::timestamp);
						call starting(5, '2022-08-01 07:42 +0300'::timestamp);
						call ending (5, '2022-08-01 20:09 +0300'::timestamp);
						call starting(6, '2022-08-01 07:34 +0300'::timestamp);
						call ending (6, '2022-08-01 20:05 +0300'::timestamp);
						call starting(9, '2022-08-01 07:51 +0300'::timestamp);
						call ending (9, '2022-08-01 20:09 +0300'::timestamp);
						call starting(10, '2022-08-01 08:10 +0300'::timestamp);
						call ending (10, '2022-08-01 20:00 +0300'::timestamp);
						--2022-08-02
						call starting(1, '2022-08-02 07:32 +0300'::timestamp);
						call ending (1, '2022-08-02 20:15 +0300'::timestamp);
						call starting(2, '2022-08-02 07:45 +0300'::timestamp);
						call ending (2, '2022-08-02 20:31 +0300'::timestamp);
						call starting(4, '2022-08-02 07:44 +0300'::timestamp);
						call ending (4, '2022-08-02 20:01 +0300'::timestamp);
						call starting(7, '2022-08-02 07:55 +0300'::timestamp);
						call ending (7, '2022-08-02 20:03 +0300'::timestamp);
						call starting(8, '2022-08-02 07:45 +0300'::timestamp);
						call ending (8, '2022-08-02 20:08 +0300'::timestamp);
						call starting(9, '2022-08-02 07:34 +0300'::timestamp);
						call ending (9, '2022-08-02 19:55 +0300'::timestamp);
						call starting(11, '2022-08-02 07:39 +0300'::timestamp);
						call ending (11, '2022-08-02 20:05 +0300'::timestamp);
						--2022-08-03
						call starting(1, '2022-08-03 07:32 +0300'::timestamp);
						call ending (1, '2022-08-03 20:41 +0300'::timestamp);
						call starting(2, '2022-08-03 07:34+0300'::timestamp);
						call ending (2, '2022-08-31 20:11 +0300'::timestamp);
						call starting(3, '2022-08-03 07:52 +0300'::timestamp);
						call ending (3, '2022-08-03 20:11 +0300'::timestamp);
						call starting(5, '2022-08-03 07:46 +0300'::timestamp);
						call ending (5, '2022-08-03 20:03 +0300'::timestamp);
						call starting(6, '2022-08-03 07:35 +0300'::timestamp);
						call ending (6, '2022-08-03 20:02 +0300'::timestamp);
						call starting(9, '2022-08-03 07:57 +0300'::timestamp);
						call ending (9, '2022-08-03 20:05 +0300'::timestamp);
						call starting(10, '2022-08-03 08:12 +0300'::timestamp);
						call ending (10, '2022-08-03 20:07 +0300'::timestamp);
						--2022-08-04
						call starting(1, '2022-08-04 07:35 +0300'::timestamp);
						call ending (1, '2022-08-04 20:19 +0300'::timestamp);
						call starting(2, '2022-08-04 07:43 +0300'::timestamp);
						call ending (2, '2022-08-04 20:39 +0300'::timestamp);
						call starting(4, '2022-08-04 07:42 +0300'::timestamp);
						call ending (4, '2022-08-04 20:05 +0300'::timestamp);
						call starting(7, '2022-08-04 07:57 +0300'::timestamp);
						call ending (7, '2022-08-04 20:01 +0300'::timestamp);
						call starting(8, '2022-08-04 07:42 +0300'::timestamp);
						call ending (8, '2022-08-04 20:04 +0300'::timestamp);
						call starting(9, '2022-08-04 07:34 +0300'::timestamp);
						call ending (9, '2022-08-04 19:56 +0300'::timestamp);
						call starting(11, '2022-08-04 07:33 +0300'::timestamp);
						call ending (11, '2022-08-04 20:01 +0300'::timestamp);
						--2022-08-05
						call starting(1, '2022-08-05 07:42 +0300'::timestamp);
						call ending (1, '2022-08-05 20:24 +0300'::timestamp);
						call starting(2, '2022-08-05 07:52+0300'::timestamp);
						call ending (2, '2022-08-05 20:24 +0300'::timestamp);
						call starting(3, '2022-08-05 07:49 +0300'::timestamp);
						call ending (3, '2022-08-05 20:15 +0300'::timestamp);
						call starting(5, '2022-08-05 07:57 +0300'::timestamp);
						call ending (5, '2022-08-05 20:20 +0300'::timestamp);
						call starting(9, '2022-08-05 07:44 +0300'::timestamp);
						call ending (9, '2022-08-05 20:12 +0300'::timestamp);
						call starting(10, '2022-08-05 07:56 +0300'::timestamp);
						call ending (10, '2022-08-05 20:15 +0300'::timestamp);
						--2022-08-06
						call starting(1, '2022-08-06 07:44 +0300'::timestamp);
						call ending (1, '2022-08-06 20:25 +0300'::timestamp);
						call starting(2, '2022-08-06 07:45 +0300'::timestamp);
						call ending (2, '2022-08-06 20:21 +0300'::timestamp);
						call starting(4, '2022-08-06 07:55 +0300'::timestamp);
						call ending (4, '2022-08-06 20:20 +0300'::timestamp);
						call starting(7, '2022-08-06 07:45 +0300'::timestamp);
						call ending (7, '2022-08-06 20:23 +0300'::timestamp);
						call starting(8, '2022-08-06 07:47 +0300'::timestamp);
						call ending (8, '2022-08-06 20:22 +0300'::timestamp);
						call starting(9, '2022-08-06 07:50 +0300'::timestamp);
						call ending (9, '2022-08-06 20:23 +0300'::timestamp);
						--2022-08-07
						call starting(1, '2022-08-07 07:25 +0300'::timestamp);
						call ending (1, '2022-08-07 20:15 +0300'::timestamp);
						call starting(2, '2022-08-07 07:26 +0300'::timestamp);
						call ending (2, '2022-08-07 20:12 +0300'::timestamp);
						call starting(3, '2022-08-07 07:34 +0300'::timestamp);
						call ending (3, '2022-08-07 20:05 +0300'::timestamp);
						call starting(5, '2022-08-07 07:35 +0300'::timestamp);
						call ending (5, '2022-08-07 20:02 +0300'::timestamp);
						call starting(6, '2022-08-07 07:44 +0300'::timestamp);
						call ending (6, '2022-08-07 20:10 +0300'::timestamp);
						call starting(9, '2022-08-07 07:43 +0300'::timestamp);
						call ending (9, '2022-08-07 20:08 +0300'::timestamp);
						call starting(10, '2022-08-07 07:55 +0300'::timestamp);
						call ending (10, '2022-08-07 20:00 +0300'::timestamp);
					end;
				$fill$;
			
				create or replace procedure fillEmployee ()
				language plpgsql
				as 
				$fill$
					begin
						call addEmployee('Харитонов','Сергей','Петрович', 'Администратор');
						call addEmployee('Абаканова','Мария','Сергеевна', 'Шеф-повар');
						call addEmployee('Гладких','Екатерина','Абрамовна', 'Повар');
						call addEmployee('Ефимов','Анатолий','Иванович', 'Повар');
						call addEmployee('Исмаилов','Торгул','Бахтияр-оглы', 'Официант');
						call addEmployee('Рикошетова','Валентина','Степановна', 'Официант');
						call addEmployee('Николаев','Борис','Викторович', 'Официант');
						call addEmployee('Степанова','Елизавета','Алексеевна', 'Официант');
						call addEmployee('Веселов','Игорь','Петрович', 'Мойщик посуды');
						call addEmployee('Косухина','Надежда','Васильевна', 'Уборщик');
						call addEmployee('Астахова','Александра','Николаевна', 'Уборщик');
					end;
				$fill$;
			
				create or replace procedure createOrder("номер стола" int, официант varchar)
				language plpgsql
				as 
				$createOrder$
				begin 
					insert into Заказы (дата, "номер стола", официант)
					values
						(current_timestamp, "номер стола", официант);
				end;
				$createOrder$;
				
				create or replace procedure cancelOrder(номер int)
				language plpgsql
				as 
				$cancelOrder$
				begin
					delete from Заказы з  
					where з."номер заказа" = номер;
				end;
				$cancelOrder$;
			
				create or replace procedure addDishInOrder("номер заказа" int, блюдо int, количество int)
				language plpgsql
				as 
				$addDishInOrder$
				begin
					insert into "Элементы заказов" ("номер заказа", блюдо, количество)
					values
						("номер заказа", блюдо, количество);
				end;
				$addDishInOrder$;
			
				create or replace procedure addDiscontCard(заказ int, карта int) 
				language plpgsql
				as 
				$$
				begin
					insert into Скидки (дата, "номер заказа", "номер карты")
					values
						(current_timestamp, заказ, карта);
					exception when others then
					raise notice '%', 'Отказано, скидка уже применена';
				end;
				$$;
			
				create or replace procedure getOrderInvoice(номер int)
				language plpgsql
				as 
				$$
				begin 
					update Счета с
					set статус = 'выдан'
					where с."номер заказа" = номер;
				
					raise notice '%', 'Сумма к оплате заказа ' || номер || ' = ' || (select итого::float::varchar from Счета where "номер заказа" = номер) || ';';
				end;
				$$;
		
				create or replace procedure pay("номер заказа" int, сумма decimal)
				language plpgsql
				as 
				$$
				begin 
					insert into Платежи (дата, "номер заказа", сумма)
					values
						(current_timestamp, "номер заказа", сумма);
				end;
				$$;
				
					create table "Должность" (
					id serial primary key,
					должность varchar not null,
					зарплата decimal not null
					);
	
					insert into "Должность" (должность, зарплата)
					values
						('Администратор',55000),
						('Шеф-повар',48000),
						('Повар',30000),
						('Официант',21000),
						('Мойщик посуды',16500),
						('Уборщик',13000);
	
					create table "Сотрудники" (
						табельный_номер serial primary key,
						фамилия varchar not null,
						имя varchar not null,
						отчество varchar not null,
						должность int not null references Должность on delete cascade on update cascade
					);
	
					create table "Табель" (
						id serial primary key,
						"табельный номер" int references Сотрудники on delete cascade on update cascade,
						"начало работы" timestamp not null,
						"конец работы" timestamp default null
					);
				
					create table "Меню" (
						id serial primary key,
						"Вид меню" varchar not null
					);
	
					insert into "Меню" ("Вид меню")
					values
						('Закуски'),
						('Основное'),
						('Напитки');
	
					create table "Группы меню" (
						id serial primary key,
						"Вид меню" int not null references "Меню" on delete cascade on update cascade,
						категория varchar not null
					);
	
					insert into "Группы меню" ("Вид меню", категория)
					values
						((select id from "Меню" where "Вид меню" = 'Закуски'), 'Холодные закуски'),
						((select id from "Меню" where "Вид меню" = 'Закуски'), 'Горячие закуски'),
						((select id from "Меню" where "Вид меню" = 'Основное'), 'Первые блюда'),
						((select id from "Меню" where "Вид меню" = 'Основное'), 'Вторые блюда'),
						((select id from "Меню" where "Вид меню" = 'Основное'), 'Десерты'),
						((select id from "Меню" where "Вид меню" = 'Напитки'), 'Безалкогольные напитки'),
						((select id from "Меню" where "Вид меню" = 'Напитки'), 'Барная карта');

					create table "Блюда меню" (
						id serial primary key,
						категория int not null references "Группы меню" on delete cascade on update cascade,
						наименование varchar not null,
						"состав/описание" text default null,
						"вид напитка" varchar default null,
						"вес(гр)" int default 0 not null,
						"объём(мл)" int default 0 not null,
						цена decimal not null
					);
	
					create table "Виды напитков" (
						id serial primary key,
						категория int not null references "Группы меню" on delete cascade on update cascade,
						наименование varchar
					);


					insert into "Виды напитков" (категория, наименование)
					values
						((select id from "Группы меню" where категория = 'Безалкогольные напитки'), 'Черный чай'),
						((select id from "Группы меню" where категория = 'Безалкогольные напитки'), 'Зеленый чай'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Пиво'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Красное вино'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Белое вино'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Розовое вино'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Чача'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Водка'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Коньяк'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Виски'),
						((select id from "Группы меню" where категория = 'Барная карта'), 'Джин');
					
					create table Заказы ( 
					id serial primary key,
					"номер заказа" serial unique,
					дата timestamp,
					"номер стола" int not null,
					официант varchar,
					статус varchar default 'не оплачен',
					оплачено decimal default 0
					);
				
					create table "Элементы заказов" (
						id serial primary key,
						"номер заказа" int references Заказы ("номер заказа"),
						блюдо int references "Блюда меню",
						количество int
					);
					
					
					create table Счета (
						id serial primary key,
						"номер заказа" int not null references Заказы("номер заказа") on delete cascade on update cascade,
						итого decimal default 0,
						"скидка %" int default 0,
						"сумма скидки" numeric default 0,
						"номер карты" int,
						статус varchar default 'не выдан'
					);
				
					create table Платежи (
						id serial primary key,
						дата timestamp,
						"номер заказа" int references Заказы on delete cascade on update cascade,
						сумма decimal
					);
				
					create table "Журнал нарушений" (
					pk serial primary key,
					время timestamp,
					пользователь varchar,
					действие varchar,
					данные text
					);
					
					create table Скидки (
					id serial primary key,
					дата timestamp,
					"номер заказа" int unique references Заказы on delete cascade on update cascade, 
					"номер карты" int
					);
				
					create table "Типы скидок"(
						id serial primary key,
						описание text,
						размер int
					);
						
					create table "Карты скидок" (
						id serial primary key,
						номер int unique,
						категория int not null references "Типы скидок" on delete cascade on update cascade
					);
				
					insert into "Типы скидок" (описание, размер)
					values
						('Базовая карта', 3),
						('Привелигированный клиент', 5),
						('Статус GOLD', 10);
				
					
					insert into "Карты скидок"(номер, категория)
					values
						(123456, 1),
						(456778, 1),
						(053825, 1),
						(543534, 1),
						(145674, 2),
						(054376, 2),
						(023478, 2),
						(124459, 2),
						(324509, 3),
						(115943, 3),
						(059574, 3);
					
					create or replace procedure fillOrders()
						language plpgsql
						as 
						$fillOrders$
						begin
							insert into Заказы (дата, "номер стола", официант)
							values
								('2022-08-01 13:04:44.254 +0300'::timestamp, 1, 'Рикошетова'),
								('2022-08-01 16:23:12.934 +0300'::timestamp, 2, 'Исмаилов'),
								('2022-08-01 07:39:54.125 +0300'::timestamp, 3, 'Исмаилов'),
								('2022-08-02 19:09:23.242 +0300'::timestamp, 1, 'Николаев'),
								('2022-08-02 15:10:10.543 +0300'::timestamp, 2, 'Степанова'),
								('2022-08-02 18:49:22.932 +0300'::timestamp, 3, 'Степанова'),
								('2022-08-03 19:23:12.735 +0300'::timestamp, 1, 'Исмаилов'),
								('2022-08-03 19:16:01.742 +0300'::timestamp, 2, 'Рикошетова'),
								('2022-08-03 10:02:32.883 +0300'::timestamp, 3, 'Рикошетова'),
								('2022-08-04 13:24:11.104 +0300'::timestamp, 1, 'Николаев'),
								('2022-08-04 10:42:42.141 +0300'::timestamp, 2, 'Степанова'),
								('2022-08-04 12:25:14.053 +0300'::timestamp, 3, 'Николаев'),
								('2022-08-05 15:15:08.370 +0300'::timestamp, 1, 'Исмаилов'),
								('2022-08-05 18:22:45.037 +0300'::timestamp, 2, 'Исмаилов'),
								('2022-08-05 16:51:31.035 +0300'::timestamp, 3, 'Исмаилов'),
								('2022-08-06 11:41:44.432 +0300'::timestamp, 1, 'Николаев'),
								('2022-08-06 15:52:48.214 +0300'::timestamp, 2, 'Степанова'),
								('2022-08-06 09:21:56.251 +0300'::timestamp, 3, 'Степанова'),
								('2022-08-06 19:03:21.001 +0300'::timestamp, 1, 'Исмаилов'),
								('2022-08-06 18:12:34.412 +0300'::timestamp, 2, 'Рикошетова'),
								('2022-08-06 08:21:12.259 +0300'::timestamp, 3, 'Исмаилов');
						
					
							insert into "Элементы заказов" ("номер заказа", блюдо, количество)
							values
								(1, 14, 1),
								(1, 21, 2),
								(2, 32, 1),
								(2, 67, 5),
								(3, 2, 1),
								(3, 78, 3),
								(4, 15, 3),
								(4, 67, 2),
								(5, 45, 2),
								(5, 12, 5),
								(6, 55, 1),
								(6, 2, 4),
								(7, 83, 6),
								(7, 15, 2),
								(8, 44, 2),
								(8, 66, 2),
								(9, 24, 1),
								(9, 61, 4),
								(10, 9, 2),
								(10, 13, 5),
								(11, 79, 1),
								(11, 14, 3),
								(12, 58, 3),
								(12, 41, 6),
								(13, 12, 2),
								(13, 14, 1),
								(14, 53, 2),
								(14, 76, 3),
								(15, 83, 1),
								(15, 7, 1),
								(16, 5, 1),
								(16, 31, 1),
								(17, 8, 2),
								(17, 37, 3),
								(18, 23, 1),
								(18, 74, 2),
								(19, 53, 1),
								(19, 75, 7),
								(20, 11, 1),
								(20, 45, 2),
								(21, 14, 5),
								(21, 21, 2);
							
							call addDiscontCard(1, 123456);
							call addDiscontCard(3, 456778);
							call addDiscontCard(5, 53825);
							call addDiscontCard(6, 543534);
							call addDiscontCard(9, 145674);
							call addDiscontCard(12, 54376);
							call addDiscontCard(13, 124459);
							call addDiscontCard(17, 115943);
							call addDiscontCard(19, 59574);
					
							call getOrderInvoice(1);
							call getOrderInvoice(2);
							call getOrderInvoice(3);
							call getOrderInvoice(4);
							call getOrderInvoice(5);
							call getOrderInvoice(6);
							call getOrderInvoice(7);
							call getOrderInvoice(8);
							call getOrderInvoice(9);
							call getOrderInvoice(10);
							call getOrderInvoice(11);
							call getOrderInvoice(12);
							call getOrderInvoice(13);
							call getOrderInvoice(14);
							call getOrderInvoice(15);
							call getOrderInvoice(16);
							call getOrderInvoice(17);
							call getOrderInvoice(18);
							call getOrderInvoice(19);
							call getOrderInvoice(20);
							call getOrderInvoice(21);
					
							call pay(1, 2473.5);
							call pay(2, 1255);
							call pay(3, 4908.2);
							call pay(4, 2750);
							call pay(5, 4403.8);
							call pay(6, 16257.2);
							call pay(7, 3410);
							call pay(8, 880);
							call pay(9, 3125.5);
							call pay(10, 4700);
							call pay(11, 2940);
							call pay(12, 2707.5);
							call pay(13, 2327.5);
							call pay(14, 2030);
							call pay(15, 2715);
							call pay(16, 6040);
							call pay(17, 2241);
							call pay(18, 1640);
							call pay(19, 2898);
							call pay(20, 10040);
							call pay(21, 5950);
						end;
						$fillOrders$;
			
					create or replace function triggerfunc_createInvoice()
					returns trigger 
					language plpgsql
					as 
					$$
					begin 
						if old is null then
							insert into Счета ("номер заказа")
							values
								(new."номер заказа");
							raise notice '%', 'Номер для добавления блюд в заказ: ' || new."номер заказа";
							return new;
						else
						delete from Счета с
						where с."номер заказа" = old."номер заказа";
						raise notice '%', 'Заказ отменён';
						end if;
					end;
					$$;
		
					create or replace function triggerfunc_addPrice ()
					returns trigger 
					language plpgsql
					as 
					$$
					declare
					price decimal = 0;
					quantity int;
					discount int;
					totalAmount decimal;
					priceWithoutDiscount decimal;
					begin
						 price = (select 
								цена
								from
								"Меню_ресторана" мр
								where мр.номер = new.блюдо
								);
						quantity = new.количество;
						discount = (select "скидка %" from Счета where "номер заказа" = new."номер заказа");
						totalAmount = (select итого from Счета where "номер заказа" = new."номер заказа");
						priceWithoutDiscount = (price * quantity);
						update Счета
						--Если ввести карту то сумма в счёте пересчитается, данная формула отвечает за то чтобы после этого добавленные блюда считались со скидкой
						set итого = totalAmount + priceWithoutDiscount - (priceWithoutDiscount * (discount::numeric / 100)), "сумма скидки" = "сумма скидки" + price * (discount::numeric / 100)
						where "номер заказа" = new."номер заказа";
						return new;
					end;
					$$;
			
					create or replace function triggerfunc_checkPay()
					returns trigger 
					language plpgsql
					as 
					$$
					declare
					i decimal;
					j varchar;
					begin
						
						for j in (select статус from Заказы з where з."номер заказа" = new."номер заказа") loop 
							if j = 'оплачен' then
								raise notice '%', 'Заказ уже оплачен';
								return null;
							end if;
						end loop;
						
					
						for i in (select итого from Счета с where с."номер заказа" = new."номер заказа" and с.статус = 'выдан') loop
							if new.сумма >= i then 
								update Заказы з
								set статус = 'оплачен', оплачено = new.сумма
								where з."номер заказа" = new."номер заказа";
								return new;
							else
								raise notice '%', 'Вносимая сумма меньше расчётной';
								return null;
							end if;
						end loop;
						raise notice '%', 'Счёт еще не закрыт';
						return null;
					end;
					$$;
			
					create or replace function triggerfunc_checkWaiter()
					returns trigger
					language plpgsql
					as 
					$$
					declare
					i varchar;
					begin 
						for i in (select фамилия from Сотрудники с where с.должность = 4) loop
							if(new.официант = i) then
							return new; 
							end if;
						end loop;
					raise notice '%', 'Официант с фамилией ' || new.официант || ' не найден. Операция отменена.';
					return null;
					end;
					$$;
			
					create or replace function triggerfunc_checkDish()
					returns trigger 
					language plpgsql
					as 
					$$
					declare 
					i int;
					begin
						for i in (select id from "Блюда меню") loop
							if new.блюдо = i then
							return new;
							end if;
						end loop;
						raise notice '%', 'Блюдо не найдено. Операция отменена.';
						return null;
					end;
					$$;
				
					create or replace function triggerfunc_recalculatePrice()
					returns trigger 
					language plpgsql
					as 
					$$
					declare 
					discount int;
					price decimal;
					i int;
					begin 
						for i in (select номер from "Карты скидок") loop
							if new."номер карты" = i then
								discount = (select тс.размер from "Карты скидок" кс inner join "Типы скидок" тс on тс.id = (select категория from "Карты скидок" where номер =  new."номер карты") group by тс.размер);
								price = (select итого from Счета where "номер заказа" = new."номер заказа");
							
								update Счета
								set "скидка %" = discount, "номер карты" = new."номер карты" ,"сумма скидки" = price * (discount::numeric / 100), итого = price - (price * (discount::numeric(4) / 100))
								where "номер заказа" = new."номер заказа";
								return new;
							end if;
						end loop;
						raise notice '%', 'Карта с таким номером не найдена';
						return null;
					end;
					$$;	
			
					create or replace function triggerfunc_checkViolation()
						returns trigger 
						language plpgsql
						as 
						$$
						declare 
						status varchar;
						discount varchar;
						begin
							status = (select статус from Счета с where с."номер заказа" = new."номер заказа");
							if status = 'не выдан' then
								return new;
							else
								insert into "Журнал нарушений" (время, пользователь, действие, данные)
								values
									(current_timestamp, current_user, tg_op, 'Попытка вставить значение:  скидка % = ' || new.скидка || ', в заказ = ' || new."номер заказа");
								return null;
							end if;
						end;
						$$;	
		
		
					create or replace trigger trigger_addPrice
					before insert or update on "Элементы заказов"
						for each row execute function triggerfunc_addPrice ();
				
					create or replace trigger trigger_createInvoice
					after insert on Заказы
						for each row execute function triggerfunc_createInvoice();
					
					create or replace trigger trigger_checkPay
					before insert or update on Платежи
						for each row execute function triggerfunc_checkPay();
					
					create or replace trigger trigger_checkWaiter
					before insert on Заказы
						for each row execute function triggerfunc_checkWaiter();
					
					create or replace trigger trigger_checkDish
					before insert or update on "Элементы заказов"
						for each row execute function triggerfunc_checkDish();
					
					create or replace trigger trigger_recalculatePrice
					before insert or update on Скидки
						for each row execute function triggerfunc_recalculatePrice();
					
					create or replace trigger trigger_checkViolation
					before update on Счета
						for each row execute function triggerfunc_checkViolation();
				
					create or replace view Список_сотрудников as
					select
					с.табельный_номер,
					с.фамилия,
					с.имя,
					с.отчество,
					д.должность 
					from 
					Сотрудники с
					inner join Должность д on с.должность = д.id;
			
					create or replace view Меню_ресторана as
					select
					бм.id "номер",
					м."Вид меню",
					гм.категория,
					бм."вид напитка",
					бм.наименование,
					бм."состав/описание",
					бм."вес(гр)",
					бм."объём(мл)",
					бм.цена
					from 
					"Блюда меню" бм
					inner join "Группы меню" гм on гм.id = бм.категория
					inner join Меню м on м.id = гм."Вид меню";
				
					create or replace view Барная_карта as
					select
					номер,
					"Вид меню",
					"вид напитка",
					наименование,
					"состав/описание",
					"объём(мл)",
					цена
					from 
					Меню_ресторана
					where категория = 'Барная карта'
					order by номер;
			
					create or replace view Рейтинг_сотрудников_по_выручке as
					select 
					з.официант "фамилия сотрудника",
					sum(з."оплачено") "принесённая прибыль"
					from 
					Заказы з
					group by з.официант
					order by "принесённая прибыль" desc;
				
					create or replace view Открытые_заказы as
					select
					з.id,
					з."номер заказа",
					з.дата,
					з."номер стола",
					з.официант
					from
					Заказы з
					where статус = 'не оплачен';
				
					create or replace view Нарушения as
					select
					время,
					пользователь,
					действие,
					данные
					from
					"Журнал нарушений";
				
					create or replace view Выручка_за_сегодня as
					select
					з."номер заказа",
					с.итого  "сумма заказа",
					с."сумма скидки",
					п.сумма "сумма платежа",
					з.дата::date
					from
					Заказы з
					inner join Счета с on с."номер заказа" = з."номер заказа" 
					inner join Платежи п on п."номер заказа" = з."номер заказа"
					where з.статус = 'оплачен' and з.дата::date = current_timestamp::date
					order by з."номер заказа";
					
					create or replace view Скидки_view as
					select
					с.id,
					с.дата,
					с."номер заказа",
					с."номер карты",
					тс.размер "размер скидки %",
					тс.описание 
					from 
					Скидки с
					inner join "Карты скидок" кс on кс.номер = с."номер карты"
					inner join "Типы скидок" тс on кс.категория = тс.id;
			
					create index Блюда_меню_indx
					on "Блюда меню" (наименование, "вид напитка", цена);
				
					create index Табель_indx
					on Табель ("табельный номер", "начало работы", "конец работы");
				
					create index Счета_indx
					on Счета ("номер заказа", итого , статус, "скидка %");
				
					create index Заказы_indx
					on Заказы ("номер заказа", дата, официант, статус);
				
					create index Платежи_indx
					on Платежи ("номер заказа", дата, сумма);
	
					call fillBasicMenu();
					call fillEmployee();
					call fillReportCard();
					call fillOrders();
	end;
$init$;

create schema certification;
drop schema certification cascade;
call initialization();

--Пример выполнения заказа
--создадим заказ введя номер столика и фамилию официанта(означает что клиент сел за столик и выбирает позиции меню)
call createOrder (1, 'Николаев');

--посетитель заказывает блюда (нужно ввести номер заказа который был выдан при его создании, id блюда из таблицы "Блюда меню" и колличество этого блюда)
call addDishInOrder(22, 14, 1);
call addDishInOrder(22, 56, 1);
call addDishInOrder(22, 72, 1);

--посетитель поел и требует счёт, если есть скидочная карта то вводится номер заказа и номер карты
call addDiscontCard(22, 123456);

--закрытие счёта для оплаты (вводится номер заказа)
call getOrderInvoice(22);

--посетитель получил счет и производит оплату (вводится номер заказа и сумма указанная в счёте)
call pay(22, 1615.05);

--Данный запрос не выполнится и будет внесён в журнал нарушений
update Счета
set "скидка%" = 50
where "номер заказа" = 22;

