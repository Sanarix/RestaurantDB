create schema certification;
drop schema certification cascade;
call initialization();

create or replace procedure initialization ()
language plpgsql
as 
$init$
	begin
		create or replace procedure addDish (�������� varchar, �������� varchar, �������� text, ��� int, ���� decimal)
		language plpgsql
		as 
		$addDish$
			begin
				--�������� ��������
				if ���� <= 0 then 
				raise notice '%', '���� ������� �������';
				return;
				end if;
				if ��� <= 0 then
				raise notice '%', '��� ������ �������';
				end if;
				--�������� ����������
				insert into "����� ����" (���������, ������������, "������/��������", "���(��)", ����)
				values
					((select id from "������ ����" �� where ��.��������� = ��������),
						��������,
						��������,
						���,
						����
					);
				exception when others then
						raise notice '%', '������ ������� �������';
			end;
		$addDish$;
	
		create or replace procedure addDrink (�������� varchar, �������� varchar, �������� text, ����� int, ���� decimal)
		language plpgsql
		as 
		$addDrink$
			begin
				--�������� ��������
				if ���� <= 0 then 
				raise notice '%', '���� ������� �������';
				return;
				end if;
				if ����� <= 0 then
				raise notice '%', '����� ������ �������';
				end if;
				--�������� ����������
				insert into "����� ����" (���������, ������������, "������/��������", "��� �������", "�����(��)", ����)
				values
					((select ��������� from "���� ��������" �� where ��.������������ = ��������),
						��������,
						��������,
						(select ������������ from "���� ��������" �� where ������������ = ��������),
						�����,
						����
					);
				exception when others then
						raise notice '%', '������ ������� �������';
			end;
		$addDrink$;
	
		create or replace procedure addEmployee (������� varchar, ��� varchar, �������� varchar, �������� varchar)
		language plpgsql
		as 
		$addEmployee$
			begin
				insert into ���������� (�������, ���, ��������, ���������)
				values
					(�������,
					���,
					��������,
					(select id from ��������� � where �.��������� = ��������)
					);
			end;
		$addEmployee$;
		
		create or replace procedure fillBasicMenu()
		language plpgsql
		as
		$fill$
			begin
					call addDish ('�������� �������',
					'������� ���������� �� �������, �����, ����',
					'���������� ������ �������� ���� ��� � ����� ������ ������: 
					���������-��������� ����,������ ����������� ����, ������� ���� � �����',
					260,1800);
					call addDish ('�������� �������',
					'�������� ��������', 
					'���������� �� �������, �������� �� ������, 
					�������� ����������� �������� � �������� ����� "���������',
					445, 4100);
					call addDish ('�������� �������',
					'���� � �������� ��������',
					'������ ���� ������������ ������������ ��������� � ��������������� � �������, 
					������ �������� �������� ��������, ����������� ������, ����� �������� ����, ��� ���, 
					������ ������, ��������-��������� ����',
					290, 700);
					call addDish ('�������� �������',
					'����������� ������',
					'������ ������ ������������ ������� ������, �������� ���, ������ ���������',
					280, 500);
					call addDish ('�������� �������',
					'�������� ���', 
					'����� �/�, ������ �/�, ����� �/�, �������� �� �����, 
					������� ���������� ��������, ��������� ������, ������� �����',
					480, 5000);
					call addDish ('�������� �������',
					'������� �� ���',
					'��� ������� �� ���, �������, ����, ����, �����, �������� ����',
					700, 1290);
					call addDish ('�������� �������',
					'����� "�����',
					'���� �����, ���� ����, ���� �����, �������, ������� ���',
					185, 2420);
					call addDish ('������� �������',
					'������� �� ����� ���������',
					'������� �� ����� ���������, ������ ����������� � ����, ������� ���, 
					������ �����������, ����� �� �������� �������, ����� ������',
					370, 900);
					call addDish ('������� �������',
					'������� ����� �������',
					'��������� � ����������� ������� � ��������� ����� ������� ��-���, 
					���� �������, ���� "������", ����� �������� ����',
					240, 1350);
					call addDish ('������� �������',
					'������� � ��������������',
					'�������� ���� �������� ��������, ���� �����, ���� ������� ������������ ��������',
					160, 820);
					call addDish ('������� �������',
					'����� �������������',
					'��������� ���������� ��������, ����� ������� � ��������� �����, ��������� ����, 
					�������� ��������� ��-���, �������� ������, ��������� ������� ������������ ��������, 
					��������� ������, ��������� ������ �����, ���-�����',
					1210, 9500);
					call addDish ('������� �������',
					'������� � ���������',
					'����, ������ ���������������, ����, ����, ���� �� �������� � ��������� ���������� ����,
					 ���� ������� � ������, ���� "��������� ����"',
					250, 800);
					call addDish ('������� �������',
					'������� �������',
					'��������� ���� ������, �����, ��������� ����',
					180, 400);
					call addDish ('������ �����',
					'�������������� ���� � �����',
					'���������� ������� ������, ������, �������, �������, 
					��� �������� � ����������� ����� ��������� � ����������. 
					�������� � �������� ����� ����, �������� �������� � ������� ������',
					475, 850);
					call addDish ('������ �����',
					'������� � �����',
					'������� ��� �� ���� ���� (�����, ��, ������, ����, ����, 
					�/� ������� �� ����������� ������������ ������������), 
					������� �������, ��������� ����, �������� �����, 
					�� ���������� ������� ������� � ����������� �������� ����������, 
					�������, �������� �������, ������ � ������� ��������)',
					350, 820);
					call addDish ('������ �����',
					'�������',
					'����������� �������� �� ������� ������� � �������� ���������, 
					��������, ���������, �������� �� ���� � ���� ������',
					480, 650);
					call addDish ('������ �����',
					'������� �� � ����� � �������� ����������',
					'������������ �� � �������� �� ���������� ������� �� ��������� ���, 
					���� ���� � �������� ��������� � ����������� ������. 
					������������ ������� ��������� � ������� ������',
					400, 850);
					call addDish ('������ �����',
					'���� ��������',
					'��� �� ������ � ������� �������� � ����� ������ ���: ��������, ������, �����, 
					� ����������� ��������, �����-����� � �������',
					370, 850);
					call addDish ('������ �����',
					'����������� ���',
					'��� �� ������ ������� � ��������, �����, �������� � ���������� 
					� ����������� ������ ������. �������� � �������� ������� �����',
					400, 820);
					call addDish ('������ �����',
					'����� "�������"',
					'���-����� �� ���������� ������� ������� � ������ �� ��������� ������� �� ������� ������, 
					����������, �������� �����, ������ ����, ������ ��������� � ����� ������ ����: ����, �����, ����',
					370, 820);
					call addDish ('������ �����',
					'�������� �� "����� �����"',
					'�� ����������� �������� �� ���������� ������� �� ������ ����� �������� � �������� ����, 
					�������� ��������, ������ �������, ������ ���������, �������� ��������',
					400, 850);
					call addDish ('������ �����',
					'������ ������ � ������� �� ������',
					'������ ������ �������� � ��������� ����� � �������� �� �������� � ������� �������.
					�������� � ����� ���� � �������������� ������ ������',
					195, 850);
					call addDish ('������ �����',
					'������� �� ����',
					'������� �� ���� ���� � ����������� ������� �����. 
					�������� � �������� ���������� � ������� �����. ������������ ����� ����� � ������ �����',
					350, 850);
					call addDish ('������ �����',
					'��������� ���������� ��������',
					'���������� ��������, ��������� � ��������� ����� � �����, �������� � ��������, ���������� ��� ����� ���������. 
					�������� � ������� �����',
					270, 1890);
					call addDish ('������ �����',
					'�������� � �������� ����� � ����� �����',
					'������������ ��������, ������, ��������� � �������, ����� ������ ����, 
					������ ��������� ��������, ���� �������, ������� �����, ���� �����, ���� ����, 
					��������� ����, ���, �������������� ����� ��������',
					500, 990);
					call addDish ('������ �����',
					'���������� ������',
					'������ ������� �� ���� �����, ������� ������������ �������� � ������������� ��������. 
					�������� � ��������� ������ �� ����� ��������� � �������� �������� ������',
					170, 1920);
					call addDish ('������ �����',
					'���������',
					'��������� � ����, ������� � ������, ����������� � ��������� � ����� 
					� ����������� �������� ���������, ������� � ������� �����. 
					�������� � ������ �� �������� ���������',
					430, 1700);
					call addDish ('������ �����',
					'����� �� ����� � ������ ����',
					'�������, �������������� ��������, ���������� �� ����� ������, ������� ���, �������,
					���� ������� ����, ���-�����',
					480, 4500);
					call addDish ('�������',
					'������ �� ���������',
					'��������� ������ �� ���� ������ - ����������� � ��������',
					145, 420);
					call addDish ('�������',
					'��������� ������� �����',
					'������ ������� � ��������� � ������, �������, �������� ������ � �����. 
					���������� ��� ������ �� ������� ������� � ���������� ������. 
					�������� � ����������� ������ ������ � ������� ������� �������',
					240, 570);
					call addDish ('�������',
					'���������� ������',
					'�������� ������ �� ������ ����������� ���� � ������ ��������, 
					�������� ���������� �������� �� ����� �������� � �������� ������. 
					�������� � ��������, ������������������� � ������������� ������� � �������� ������ ������',
					200, 1040);
					call addDish ('�������',
					'������� �����',
					'������� �����, ����������� �������� ������ � ����������� �������, 
					�������� ����������������� ������ ��������. 
					�������� � ��������� ������ � ������� �������',
					190, 530);
					call addDish ('�������',
					'����������� �����',
					'����� � ��������� � ��������� �������, �������� � ��������� ���������',
					170, 890);
					call addDrink ('������ ���', '������������ �����', '��� ������ ��������� ���������', 600, 230);
					call addDrink ('������ ���', '��� ����', '��� ������, ����� ���������', 600, 230);
					call addDrink ('������ ���', '�������� �����', '��� ������ � ��������', 600, 230);
					call addDrink ('������ ���', '����� � ����� � ����������', '�����, ��������� ��� �����, ����� ���������, ����� ������', 600, 230);
					call addDrink ('������� ���', '�����', '������� �������� ��� �����', 600, 320);
					call addDrink ('������� ���', '������� ��������', '� �������� �������, ������ ��������, ��������� � ���������� ���������', 600, 230);
					call addDrink ('������� ���', '�������� ����', '��������� �������������������� ���� �� ��������-�������� ��������', 600, 230);
					call addDrink ('������� ���', '������ � 6 ��������', '���� ��� ��������������� � ����������, �������, �������, 
									���������, �������� � �������� ������', 600, 280);
					call addDrink ('������� ���', '����������� ������', '��������� ������� ��� � ���������� �������', 600, 230);
					call addDrink ('������� ����', '����������� �����', '�����', 125, 390);
					call addDrink ('������� ����', '������� ��������', '�����', 125, 220);
					call addDrink ('������� ����', '����������� �������� �������', '�����', 125, 270);
					call addDrink ('������� ����', '��� ���� ��������', '�����', 125, 320);
					call addDrink ('������� ����', '��������� ������������', '�������', 125, 300);
					call addDrink ('������� ����', '����������', '�����', 125, 250);
					call addDrink ('����� ����', '�������� ����', '�����', 125, 270);
					call addDrink ('����� ����', '���������� ������', '�/�������', 125, 315);
					call addDrink ('����� ����', '���� ������� ���� ���� DOC', '�����', 125, 240);
					call addDrink ('����� ����', '������ ��������', '�����', 125, 300);
					call addDrink ('����� ����', '��� ���� �������-��������', '�����', 125, 280);
					call addDrink ('����� ����', '���������', '�����', 125, 290);
					call addDrink ('����� ����', '���� �� ���� �� ����� DOCG', '�����', 125, 360);
					call addDrink ('����� ����', '������ ���� �������', '�/�����', 125, 320);
					call addDrink ('����', 'Maisels Weisse Original', null, 500, 390);
					call addDrink ('����', 'Maisels Weisse Dunkel', null, 500, 390);
					call addDrink ('����', 'Klaster Svetle', null, 500, 330);
					call addDrink ('����', 'Blonde Ale', null, 500, 250);
					call addDrink ('����', 'Belgian weisse', null, 500, 350);
					call addDrink ('����', 'Irish stout', null, 500, 350);
					call addDrink ('����', 'American Pale Ale', null, 500, 300);
					call addDrink ('����', '���� �������� ����', null, 40, 295);
					call addDrink ('����', '���� �������� �������', null, 40, 295);
					call addDrink ('�����', '�������', null, 50, 220);
					call addDrink ('�����', '�����', null, 50, 145);
					call addDrink ('�����', '���� ����', null, 50, 110);
					call addDrink ('�����', '������� �������� ��������', null, 50, 180);
					call addDrink ('�����', '������� �������� ��������', null, 50, 225);
					call addDrink ('�����', '������', null, 50, 120);
					call addDrink ('�����', 'Hennesy VS', null, 40, 495);
					call addDrink ('�����', 'Hennesy VSOP', null, 40, 690);
					call addDrink ('�����', 'Martell VS', null, 40, 395);
					call addDrink ('�����', 'Martell VSOP', null, 40, 420);
					call addDrink ('�����', 'Chivas Regal 12 y.o.', null, 40, 490);
					call addDrink ('�����', 'Chivas Regal 15 y.o.', null, 40, 560);
					call addDrink ('�����', 'Jameson', null, 40, 320);
					call addDrink ('�����', 'Jameson Black Barrel', null, 40, 390);
					call addDrink ('������', 'Ballantines Finest', null, 40, 230);
					call addDrink ('������', 'Macallan 12 y.o.', null, 40, 690);
					call addDrink ('����', 'Beefeater', null, 40, 300);
					call addDrink ('����', 'Beefeater Blood Orange', null, 40, 295);
					call addDrink ('����', 'Beefeater Pink Strawberry', null, 40, 320);
					end;
				$fill$;
	
				create or replace procedure starting (��������� int, "����� ������ ������" timestamp)
				language plpgsql
				as 
				$starting$
					begin
						insert into ������ ("��������� �����", "������ ������")
						values
							(���������,
							"����� ������ ������"
							);
					end;
				$starting$;
			
				create or replace procedure ending (��������� int, "����� ��������� ������" timestamp)
				language plpgsql
				as 
				$ending$
					begin
						update ������ as �
						set "����� ������" = "����� ��������� ������"
						where "��������� �����" = ��������� and �."����� ������" is null;
					end;
				$ending$;
			
			--��������������� ��� �������� ������� �����/������ ��������� �� �������
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
						call addEmployee('���������','������','��������', '�������������');
						call addEmployee('���������','�����','���������', '���-�����');
						call addEmployee('�������','���������','���������', '�����');
						call addEmployee('������','��������','��������', '�����');
						call addEmployee('��������','������','�������-����', '��������');
						call addEmployee('����������','���������','����������', '��������');
						call addEmployee('��������','�����','����������', '��������');
						call addEmployee('���������','���������','����������', '��������');
						call addEmployee('�������','�����','��������', '������ ������');
						call addEmployee('��������','�������','����������', '�������');
						call addEmployee('��������','����������','����������', '�������');
					end;
				$fill$;
			
				create or replace procedure createOrder("����� �����" int, �������� varchar)
				language plpgsql
				as 
				$createOrder$
				begin 
					insert into ������ (����, "����� �����", ��������)
					values
						(current_timestamp, "����� �����", ��������);
				end;
				$createOrder$;
				
				create or replace procedure cancelOrder(����� int)
				language plpgsql
				as 
				$cancelOrder$
				begin
					delete from ������ �  
					where �."����� ������" = �����;
				end;
				$cancelOrder$;
			
				create or replace procedure addDishInOrder("����� ������" int, ����� int, ���������� int)
				language plpgsql
				as 
				$addDishInOrder$
				begin
					insert into "�������� �������" ("����� ������", �����, ����������)
					values
						("����� ������", �����, ����������);
				end;
				$addDishInOrder$;
			
				create or replace procedure addDiscontCard(����� int, ����� int) 
				language plpgsql
				as 
				$$
				begin
					insert into ������ (����, "����� ������", "����� �����")
					values
						(current_timestamp, �����, �����);
					exception when others then
					raise notice '%', '��������, ������ ��� ���������';
				end;
				$$;
			
				create or replace procedure getOrderInvoice(����� int)
				language plpgsql
				as 
				$$
				begin 
					update ����� �
					set ������ = '�����'
					where �."����� ������" = �����;
				
					raise notice '%', '����� � ������ ������ ' || ����� || ' = ' || (select �����::float::varchar from ����� where "����� ������" = �����) || ';';
				end;
				$$;
		
				create or replace procedure pay("����� ������" int, ����� decimal)
				language plpgsql
				as 
				$$
				begin 
					insert into ������� (����, "����� ������", �����)
					values
						(current_timestamp, "����� ������", �����);
				end;
				$$;
				
					create table "���������" (
					id serial primary key,
					��������� varchar not null,
					�������� decimal not null
					);
	
					insert into "���������" (���������, ��������)
					values
						('�������������',55000),
						('���-�����',48000),
						('�����',30000),
						('��������',21000),
						('������ ������',16500),
						('�������',13000);
	
					create table "����������" (
						���������_����� serial primary key,
						������� varchar not null,
						��� varchar not null,
						�������� varchar not null,
						��������� int not null references ��������� on delete cascade on update cascade
					);
	
					create table "������" (
						id serial primary key,
						"��������� �����" int references ���������� on delete cascade on update cascade,
						"������ ������" timestamp not null,
						"����� ������" timestamp default null
					);
				
					create table "����" (
						id serial primary key,
						"��� ����" varchar not null
					);
	
					insert into "����" ("��� ����")
					values
						('�������'),
						('��������'),
						('�������');
	
					create table "������ ����" (
						id serial primary key,
						"��� ����" int not null references "����" on delete cascade on update cascade,
						��������� varchar not null
					);
	
					insert into "������ ����" ("��� ����", ���������)
					values
						((select id from "����" where "��� ����" = '�������'), '�������� �������'),
						((select id from "����" where "��� ����" = '�������'), '������� �������'),
						((select id from "����" where "��� ����" = '��������'), '������ �����'),
						((select id from "����" where "��� ����" = '��������'), '������ �����'),
						((select id from "����" where "��� ����" = '��������'), '�������'),
						((select id from "����" where "��� ����" = '�������'), '�������������� �������'),
						((select id from "����" where "��� ����" = '�������'), '������ �����');

					create table "����� ����" (
						id serial primary key,
						��������� int not null references "������ ����" on delete cascade on update cascade,
						������������ varchar not null,
						"������/��������" text default null,
						"��� �������" varchar default null,
						"���(��)" int default 0 not null,
						"�����(��)" int default 0 not null,
						���� decimal not null
					);
	
					create table "���� ��������" (
						id serial primary key,
						��������� int not null references "������ ����" on delete cascade on update cascade,
						������������ varchar
					);


					insert into "���� ��������" (���������, ������������)
					values
						((select id from "������ ����" where ��������� = '�������������� �������'), '������ ���'),
						((select id from "������ ����" where ��������� = '�������������� �������'), '������� ���'),
						((select id from "������ ����" where ��������� = '������ �����'), '����'),
						((select id from "������ ����" where ��������� = '������ �����'), '������� ����'),
						((select id from "������ ����" where ��������� = '������ �����'), '����� ����'),
						((select id from "������ ����" where ��������� = '������ �����'), '������� ����'),
						((select id from "������ ����" where ��������� = '������ �����'), '����'),
						((select id from "������ ����" where ��������� = '������ �����'), '�����'),
						((select id from "������ ����" where ��������� = '������ �����'), '������'),
						((select id from "������ ����" where ��������� = '������ �����'), '�����'),
						((select id from "������ ����" where ��������� = '������ �����'), '����');
					
					create table ������ ( 
					id serial primary key,
					"����� ������" serial unique,
					���� timestamp,
					"����� �����" int not null,
					�������� varchar,
					������ varchar default '�� �������',
					�������� decimal default 0
					);
				
					create table "�������� �������" (
						id serial primary key,
						"����� ������" int references ������ ("����� ������"),
						����� int references "����� ����",
						���������� int
					);
					
					
					create table ����� (
						id serial primary key,
						"����� ������" int not null references ������("����� ������") on delete cascade on update cascade,
						����� decimal default 0,
						"������ %" int default 0,
						"����� ������" numeric default 0,
						"����� �����" int,
						������ varchar default '�� �����'
					);
				
					create table ������� (
						id serial primary key,
						���� timestamp,
						"����� ������" int references ������ on delete cascade on update cascade,
						����� decimal
					);
				
					create table "������ ���������" (
					pk serial primary key,
					����� timestamp,
					������������ varchar,
					�������� varchar,
					������ text
					);
					
					create table ������ (
					id serial primary key,
					���� timestamp,
					"����� ������" int unique references ������ on delete cascade on update cascade, 
					"����� �����" int
					);
				
					create table "���� ������"(
						id serial primary key,
						�������� text,
						������ int
					);
						
					create table "����� ������" (
						id serial primary key,
						����� int unique,
						��������� int not null references "���� ������" on delete cascade on update cascade
					);
				
					insert into "���� ������" (��������, ������)
					values
						('������� �����', 3),
						('����������������� ������', 5),
						('������ GOLD', 10);
				
					
					insert into "����� ������"(�����, ���������)
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
							insert into ������ (����, "����� �����", ��������)
							values
								('2022-08-01 13:04:44.254 +0300'::timestamp, 1, '����������'),
								('2022-08-01 16:23:12.934 +0300'::timestamp, 2, '��������'),
								('2022-08-01 07:39:54.125 +0300'::timestamp, 3, '��������'),
								('2022-08-02 19:09:23.242 +0300'::timestamp, 1, '��������'),
								('2022-08-02 15:10:10.543 +0300'::timestamp, 2, '���������'),
								('2022-08-02 18:49:22.932 +0300'::timestamp, 3, '���������'),
								('2022-08-03 19:23:12.735 +0300'::timestamp, 1, '��������'),
								('2022-08-03 19:16:01.742 +0300'::timestamp, 2, '����������'),
								('2022-08-03 10:02:32.883 +0300'::timestamp, 3, '����������'),
								('2022-08-04 13:24:11.104 +0300'::timestamp, 1, '��������'),
								('2022-08-04 10:42:42.141 +0300'::timestamp, 2, '���������'),
								('2022-08-04 12:25:14.053 +0300'::timestamp, 3, '��������'),
								('2022-08-05 15:15:08.370 +0300'::timestamp, 1, '��������'),
								('2022-08-05 18:22:45.037 +0300'::timestamp, 2, '��������'),
								('2022-08-05 16:51:31.035 +0300'::timestamp, 3, '��������'),
								('2022-08-06 11:41:44.432 +0300'::timestamp, 1, '��������'),
								('2022-08-06 15:52:48.214 +0300'::timestamp, 2, '���������'),
								('2022-08-06 09:21:56.251 +0300'::timestamp, 3, '���������'),
								('2022-08-06 19:03:21.001 +0300'::timestamp, 1, '��������'),
								('2022-08-06 18:12:34.412 +0300'::timestamp, 2, '����������'),
								('2022-08-06 08:21:12.259 +0300'::timestamp, 3, '��������');
						
					
							insert into "�������� �������" ("����� ������", �����, ����������)
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
							insert into ����� ("����� ������")
							values
								(new."����� ������");
							raise notice '%', '����� ��� ���������� ���� � �����: ' || new."����� ������";
							return new;
						else
						delete from ����� �
						where �."����� ������" = old."����� ������";
						raise notice '%', '����� ������';
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
								����
								from
								"����_���������" ��
								where ��.����� = new.�����
								);
						quantity = new.����������;
						discount = (select "������ %" from ����� where "����� ������" = new."����� ������");
						totalAmount = (select ����� from ����� where "����� ������" = new."����� ������");
						priceWithoutDiscount = (price * quantity);
						update �����
						--���� ������ ����� �� ����� � ����� �������������, ������ ������� �������� �� �� ����� ����� ����� ����������� ����� ��������� �� �������
						set ����� = totalAmount + priceWithoutDiscount - (priceWithoutDiscount * (discount::numeric / 100)), "����� ������" = "����� ������" + price * (discount::numeric / 100)
						where "����� ������" = new."����� ������";
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
						
						for j in (select ������ from ������ � where �."����� ������" = new."����� ������") loop 
							if j = '�������' then
								raise notice '%', '����� ��� �������';
								return null;
							end if;
						end loop;
						
					
						for i in (select ����� from ����� � where �."����� ������" = new."����� ������" and �.������ = '�����') loop
							if new.����� >= i then 
								update ������ �
								set ������ = '�������', �������� = new.�����
								where �."����� ������" = new."����� ������";
								return new;
							else
								raise notice '%', '�������� ����� ������ ���������';
								return null;
							end if;
						end loop;
						raise notice '%', '���� ��� �� ������';
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
						for i in (select ������� from ���������� � where �.��������� = 4) loop
							if(new.�������� = i) then
							return new; 
							end if;
						end loop;
					raise notice '%', '�������� � �������� ' || new.�������� || ' �� ������. �������� ��������.';
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
						for i in (select id from "����� ����") loop
							if new.����� = i then
							return new;
							end if;
						end loop;
						raise notice '%', '����� �� �������. �������� ��������.';
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
						for i in (select ����� from "����� ������") loop
							if new."����� �����" = i then
								discount = (select ��.������ from "����� ������" �� inner join "���� ������" �� on ��.id = (select ��������� from "����� ������" where ����� =  new."����� �����") group by ��.������);
								price = (select ����� from ����� where "����� ������" = new."����� ������");
							
								update �����
								set "������ %" = discount, "����� �����" = new."����� �����" ,"����� ������" = price * (discount::numeric / 100), ����� = price - (price * (discount::numeric(4) / 100))
								where "����� ������" = new."����� ������";
								return new;
							end if;
						end loop;
						raise notice '%', '����� � ����� ������� �� �������';
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
							status = (select ������ from ����� � where �."����� ������" = new."����� ������");
							if status = '�� �����' then
								return new;
							else
								insert into "������ ���������" (�����, ������������, ��������, ������)
								values
									(current_timestamp, current_user, tg_op, '������� �������� ��������:  ������ % = ' || new.������ || ', � ����� = ' || new."����� ������");
								return null;
							end if;
						end;
						$$;	
		
		
					create or replace trigger trigger_addPrice
					before insert or update on "�������� �������"
						for each row execute function triggerfunc_addPrice ();
				
					create or replace trigger trigger_createInvoice
					after insert on ������
						for each row execute function triggerfunc_createInvoice();
					
					create or replace trigger trigger_checkPay
					before insert or update on �������
						for each row execute function triggerfunc_checkPay();
					
					create or replace trigger trigger_checkWaiter
					before insert on ������
						for each row execute function triggerfunc_checkWaiter();
					
					create or replace trigger trigger_checkDish
					before insert or update on "�������� �������"
						for each row execute function triggerfunc_checkDish();
					
					create or replace trigger trigger_recalculatePrice
					before insert or update on ������
						for each row execute function triggerfunc_recalculatePrice();
					
					create or replace trigger trigger_checkViolation
					before update on �����
						for each row execute function triggerfunc_checkViolation();
				
					create or replace view ������_����������� as
					select
					�.���������_�����,
					�.�������,
					�.���,
					�.��������,
					�.��������� 
					from 
					���������� �
					inner join ��������� � on �.��������� = �.id;
			
					create or replace view ����_��������� as
					select
					��.id "�����",
					�."��� ����",
					��.���������,
					��."��� �������",
					��.������������,
					��."������/��������",
					��."���(��)",
					��."�����(��)",
					��.����
					from 
					"����� ����" ��
					inner join "������ ����" �� on ��.id = ��.���������
					inner join ���� � on �.id = ��."��� ����";
				
					create or replace view ������_����� as
					select
					�����,
					"��� ����",
					"��� �������",
					������������,
					"������/��������",
					"�����(��)",
					����
					from 
					����_���������
					where ��������� = '������ �����'
					order by �����;
			
					create or replace view �������_�����������_��_������� as
					select 
					�.�������� "������� ����������",
					sum(�."��������") "���������� �������"
					from 
					������ �
					group by �.��������
					order by "���������� �������" desc;
				
					create or replace view ��������_������ as
					select
					�.id,
					�."����� ������",
					�.����,
					�."����� �����",
					�.��������
					from
					������ �
					where ������ = '�� �������';
				
					create or replace view ��������� as
					select
					�����,
					������������,
					��������,
					������
					from
					"������ ���������";
				
					create or replace view �������_��_������� as
					select
					�."����� ������",
					�.�����  "����� ������",
					�."����� ������",
					�.����� "����� �������",
					�.����::date
					from
					������ �
					inner join ����� � on �."����� ������" = �."����� ������" 
					inner join ������� � on �."����� ������" = �."����� ������"
					where �.������ = '�������' and �.����::date = current_timestamp::date
					order by �."����� ������";
					
					create or replace view ������_view as
					select
					�.id,
					�.����,
					�."����� ������",
					�."����� �����",
					��.������ "������ ������ %",
					��.�������� 
					from 
					������ �
					inner join "����� ������" �� on ��.����� = �."����� �����"
					inner join "���� ������" �� on ��.��������� = ��.id;
			
					create index �����_����_indx
					on "����� ����" (������������, "��� �������", ����);
				
					create index ������_indx
					on ������ ("��������� �����", "������ ������", "����� ������");
				
					create index �����_indx
					on ����� ("����� ������", ����� , ������, "������ %");
				
					create index ������_indx
					on ������ ("����� ������", ����, ��������, ������);
				
					create index �������_indx
					on ������� ("����� ������", ����, �����);
	
					call fillBasicMenu();
					call fillEmployee();
					call fillReportCard();
					call fillOrders();
	end;
$init$;

create schema certification;
drop schema certification cascade;
call initialization();

--������ ���������� ������
--�������� ����� ����� ����� ������� � ������� ���������(�������� ��� ������ ��� �� ������ � �������� ������� ����)
call createOrder (1, '��������');

--���������� ���������� ����� (����� ������ ����� ������ ������� ��� ����� ��� ��� ��������, id ����� �� ������� "����� ����" � ����������� ����� �����)
call addDishInOrder(22, 14, 1);
call addDishInOrder(22, 56, 1);
call addDishInOrder(22, 72, 1);

--���������� ���� � ������� ����, ���� ���� ��������� ����� �� �������� ����� ������ � ����� �����
call addDiscontCard(22, 123456);

--�������� ����� ��� ������ (�������� ����� ������)
call getOrderInvoice(22);

--���������� ������� ���� � ���������� ������ (�������� ����� ������ � ����� ��������� � �����)
call pay(22, 1615.05);

--������ ������ �� ���������� � ����� ����� � ������ ���������
update �����
set "������%" = 50
where "����� ������" = 22;

