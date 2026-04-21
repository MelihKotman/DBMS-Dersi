/*
********* JOIN'ler **********
*/
-- 1. Öğrencilerin adları ve başvurdukları ana dallarını döndüren sorgu
select ogr_adi, ana_dal
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id;

-- 2. Theta Join Sorgusu: Öğrencilerin adları ve başvurdukları ana dallarını döndüren sorgu
select ogr_adi, ana_dal
from ogrenciler o inner join basvurular b
on o.ogr_id = b.ogr_id;

-- Join türü belirtilmezse default olarak Inner Join yapılır
-- Inner Join: İki tablonun kesişimini verir, yani her iki tabloda da bulunan kayıtları döndürür

-- Inner Join yerine JOIN yazmak da mümkündür
select ogr_adi, ana_dal
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id;


-- 3. Lise mevcudu 100'den büyük olan, Ankara Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu

select ogr_adi, ort
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id 
	and lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';


-- 4. JOIN kullanarak, lise mevcudu 100'den büyük olan, Ank Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu

select ogr_adi, ort
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id 
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

-- 5. Tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og, okullar ok, basvurular b
where og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi;

/*
6. Tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve
başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
burada join kullanarak yapmaya çalıştık ancak join yaparken on koşulunu belirtmediğimiz için hata alırız.
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og join okullar ok join basvurular b
on og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi; -- on olmadığı için hata alırız;

select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og join basvurular b on og.ogr_id = b.ogr_id join okullar ok on b.okul_adi = ok.okul_adi;
-- on ile join yaparken hangi sütunlar üzerinden join yapacağımızı belirtmemiz gerekir, bu yüzden hata alırız;

select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og join basvurular b using (ogr_id) join okullar ok using (okul_adi);
-- using ile join yaparken hangi sütunlar üzerinden join yapacağımızı belirtmemiz gerekir, bu yüzden hata alırız;

select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og natural join basvurular b natural join okullar ok;
-- natural join yaparken hangi sütunlar üzerinden join yapacağımızı belirtmemiz gerek yoktur.

/*
7. tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve
başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
Burada ise ilk önce ogrenciler ve basvurular tablolarını ogr_id üzerinden join yaparak birbirine bağladık,
Sonra da bu sonucu okullar tablosu ile okul_adi üzerinden join yaparak birbirine bağladık.
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from (ogrenciler og join basvurular b on og.ogr_id = b.ogr_id) join okullar ok
on b.okul_adi = ok.okul_adi;

-- 8. Distinct kullanarak, başvuru yapan öğrencilerin adları ve başvurdukları ana dallarını döndüren sorgu
select distinct ogr_adi, ana_dal
from ogrenciler o inner join basvurular b
on o.ogr_id = b.ogr_id;

-- 9. Natural Join Sorgusu: Öğrencilerin adları ve başvurdukları ana dallarını döndüren sorgu
select distinct ogr_adi, ana_dal
from ogrenciler o natural join basvurular b;


select *
from ogrenciler o natural join basvurular b;

/*
10. lise mevcudu 100'den büyük olan, Ank Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu
JOIN kullanarak
*/
select ogr_adi, ort
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id 
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
11. Üstteki sorgunun NATURAL JOIN kullanılarak oluşturulmuş dengi
*/
select ogr_adi, ort
from ogrenciler o natural join basvurular b
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
INNER JOIN ve USING Sorgusu: Üstteki sorgunun USING kullanarak oluşturulmuş dengi
Using burada ogr_id sütunu üzerinden join yapacağımızı belirtir, bu sayede ON koşulunu yazmamıza gerek kalmaz.
*/
select ogr_adi, ort
from ogrenciler o join basvurular b using(ogr_id)
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
12. Aynı ortalamaya sahip öğrencilerin listesini döndüren sorgu
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1, ogrenciler o2
where o1.ort = o2.ort and o1.ogr_id < o2.ogr_id;

/*
13. Yukarıdaki sorgunun Join kullanılan versiyonu
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1 join ogrenciler o2 using(ort)
where o1.ogr_id < o2.ogr_id;

-- 14. Tablonun kendisi ile Natural Join'i tablonun kendisini döndürür
select *
from ogrenciler o1 natural join ogrenciler o2;

-- 15.  Başvuruda bulunan tüm öğrencilerin id, ad, başvuru okulları ve ana dalları bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler inner join basvurular using(ogr_id);

-- 16. LEFT OUTER JOIN / LEFT JOIN Sorgusu: Başvuruda bulunan ve bulunmayan tüm öğrencilerin id, ad, başvuru okulları ve ana dalları bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler left outer join basvurular using(ogr_id);

-- 17. Başvuruda bulunan ve bulunmayan tüm öğrencilerin bilgileri
-- LEFT OUTER JOIN yerine LEFT JOIN yazmak da mümkündür.
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler left join basvurular using(ogr_id);

-- 18. Yukardaki sorgunun left outer join olmadan tekrar yazımı
select o.ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id
union
select ogr_id, ogr_adi, NULL, NULL
from ogrenciler
where ogr_id not in (select ogr_id from basvurular);

-- 19. Yeni bilgi girişi
insert into basvurular 
values 
(999, 'Boğaziçi', 'Elk. Müh.', 'K'),
(999, 'Boğaziçi', 'Bilg. Müh.', 'R');

-- 20. Başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from basvurular left outer join ogrenciler using(ogr_id);

-- 21. RIGHT OUTER JOIN Sorgusu: Başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler right outer join basvurular using(ogr_id);

-- 22. Tüm öğrencilerin ve başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler full outer join basvurular using(ogr_id);

/*
***** Limit ve First N *****
*/

-- 23. LIMIT Sorgusu: En yüksek ortalamaya sahip ilk 3 öğrenci
select ort, ogr_id
from ogrenciler
where ort is not null
order by ort desc
limit 3;

-- 24. FETCH FIRST N ROWS ONLY Sorgusu: En yüksek ortalamaya sahip ilk 3 öğrenci
select ort, ogr_id
from ogrenciler
where ort is not null
order by ort desc
fetch first 3 rows only;

/*
***** Yığışım (Aggregation) *****
*/

-- 25. yeni kayıt
insert into basvurular values(100, 'Ankara', 'Bilg. Müh.', 'K');
insert into basvurular values(100, 'Ankara', 'Elk. Müh.', 'R');

-- 26. AVERAGE (AVG) Sorgusu : Lise mevcudu ortalaması
select avg(lis_mev)
from ogrenciler;

-- 27. MIN Sorgusu: Bilg Müh'e başvuran en düşük ortalamalı öğrenci
select min(ort)
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.';

-- Alternatif
select ort
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.'
ORDER BY ort ASC
LIMIT 1; -- fetch first 1 rows only da yazılabilir.

-- 28. Bilg Müh'e başvuran öğrencilerin ortalama not ortalaması (Yanlış)
select avg(ort)
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.'; --Birden fazla öğrenci bilg müh'e başvurduysa 2 kere bulunacağı için

-- 29. Bilg Müh'e başvuran öğrencilerin not ortalaması (Doğru)
select avg(ort)
from ogrenciler
where ogr_id in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.'); -- Bilgisayar mühendisliğine başvurmuş olanları alıyor

-- 30. COUNT Sorgusu: Kayıt sayısı > 10000 olan okulların sayısını döndüren query
select count(*)
from okullar
where kayit_sayisi > 10000;

-- 31. Ankara üniversitesine başvuran örencilerin sayısı
select count(distinct ogr_id)
from basvurular
where okul_adi = 'Ankara';

/*
32. Bilg Mühe başvuran öğrencilerin ortalama not ortalaması ile
Bilg Mühe başvurmayan öğrencilerin ortalama not ortalaması arasındaki farkı bulan sorgu
*/
select Bil.avg_ort - BilDegil.avg_ort as ortalama_farki
from (select avg(ort) as avg_ort
	  from ogrenciler
	 where ogr_id in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.')) as Bil,
	 (select avg(ort) as avg_ort
	  from ogrenciler
	 where ogr_id not in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.')) as BilDegil;
	 
-- 33.GROUP BY Sorgusu: Her okula yapılan başvuru sayıları
select * from basvurular order by okul_adi;

-- Tek tek sayamayacağımız için GROUP BY kullanırız.

select okul_adi, count(*) as basvuru_sayisi
from basvurular
group by okul_adi;


-- 34. SUM Sorgusu: Şehirlere göre üniversitelerin toplam kayıt sayıları
select *
from okullar
order by sehir;

select sehir, sum(kayit_sayisi)
from okullar
group by sehir;

-- 35. Her okulun ana dallarına yapılan başvurular arasındaki en büyük ve en düşük ortalamalar
select *
from ogrenciler inner join basvurular using(ogr_id)
order by okul_adi, ana_dal;

-- Burada öğrenciler.ogr_id fazladan ekleniyor.
select *
from ogrenciler inner join basvurular on ogrenciler.ogr_id = basvurular.ogr_id
order by okul_adi, ana_dal;

select okul_adi, ana_dal, max(ort), min(ort)
from ogrenciler inner join basvurular using(ogr_id)
group by okul_adi, ana_dal;

-- 36. Öğrencilerin başvuruda bulunduğu üniversite sayıları
-- Bir öğrenci hiçbir başvuruda bulunmadıysa yanında 0 yazmalıdır.
select *
from ogrenciler o left outer join basvurular b  on o.ogr_id = b.ogr_id
order by o.ogr_id;

-- Başvuruda bulunmayanlar 0 olacaktır. Sütuna bakar ve null varsa değeri saymaz null olduğu için 0 yazar
select o.ogr_id, count(distinct b.okul_adi) as b_u_s
from ogrenciler o left outer join basvurular b
	on o.ogr_id = b.ogr_id
group by o.ogr_id
order by o.ogr_id; -- Group ile order yeri değişmez yoksa hata alırız.

-- Başvuruda bulunmayanlar 1 olacaktır. direkt null olup olmadığına bakmaz satır olarak alır ve 1 yazar.
select o.ogr_id, count(*) as b_u_s
from ogrenciler o left outer join basvurular b
	on o.ogr_id = b.ogr_id
group by o.ogr_id
order by o.ogr_id;

-- 37. Öğrencilerin başvuruda bulunduğu üniversite sayıları birden fazla (bs > 1)
-- Left Outer Join yoksa
select * from(
select ogrenciler.ogr_id, count(distinct okul_adi) as bs
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id -- inner join
group by ogrenciler.ogr_id
union
select ogr_id, 0 as bs
from ogrenciler
where ogr_id not in (select ogr_id from basvurular))
where bs > 1;

-- 38. 3'ten daha az başvuru yapılmış üniversiteler

-- (HATALI)
select okul_adi, count(*) as bs
from basvurular
group by okul_adi
where bs < 3; -- group by sonrası kullanamayız

-- (DOĞRU)
select okul_adi, count(*) as bs
from basvurular
group by okul_adi
having count(*) < 3; -- count yerine bs yazamayız.

select * 
from (select okul_adi, count(*) as basvuru_sayisi
		from basvurular
		group by okul_adi)
where basvuru_sayisi < 3;

-- 39. 3'ten daha az farklı öğrencinin başvuru yapmış olduğu üniversiteler
select okul_adi
from basvurular
order by okul_adi;

select okul_adi
from basvurular
group by okul_adi
having count(distinct ogr_id) < 3;

select *
from (
	-- b_y_f_o_s: basvuru yapan farklı ogrenci sayisi
	select okul_adi, count(distinct ogr_id) as b_y_f_o_s
	from basvurular
	group by okul_adi)
where b_y_f_o_s < 3;

/*
40. ***** NULL Değerler *****
*/

insert into ogrenciler values
(120, 'Adem', NULL, 900),
(121, 'Keriman', NULL, 1500);

-- 41. ort > 3.0 olan öğrenciler
select *
from ogrenciler
where ort > 3.0;

-- 42. ort > 3.0 veya <= 3.0 olan öğrenciler
select *
from ogrenciler
where ort > 3.0 or ort <= 3.0;

-- 43. ort > 3.0 veya <= 3.0 olan öğrenciler veya ortalaması veya null olanlar
select *
from ogrenciler
where ort > 3.0 or ort <= 3.0 or ort is null; -- ort = NULL yazılabilir ancak hiçbir zaman true olmaz,

-- 44. ort null olmayan öğrencilerin sayısı
select count(*)
from ogrenciler
where ort is not null;

/*
***** Veri Modifikasyonu *****
*/

-- 45. Veri ekleme
insert into okullar values ('Selçuk', 'Konya', 30000);

-- 46. Hiçbir başvuruda bulunmamış öğrenciler
select *
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);

-- 47. Insert için veri hazırlama
select ogr_id, 'Selçuk', 'Bilg. Müh.', null
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);
					
-- 48. Hiçbir yere başvuruda bulunmamış öğrencileri
-- otomatik olarak Selçuk Bilg Mühe başvurdurtma sorgusu
insert into basvurular
select ogr_id, 'Selçuk', 'Bilg. Müh.', null
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);

select * from basvurular;

-- 49. UPDATE Sorgusu: Selçuk üniversitesi Bilg Mühe yapılan tüm başvuruları
-- Selçuk Elk Müh'e yönlendirme ve kabul etme
update basvurular
set ana_dal = 'Elk. Müh.', sonuc = 'K'
where okul_adi = 'Selçuk' and ana_dal = 'Bilg. Müh.';

-- 50. DELETE Sorgusu: Selçuk üniversitesine yapılan tüm başvuruları silme sorgusu
delete
from basvurular
where okul_adi = 'Selçuk';

/*
***** 51. Satranç Müsabakaları *****
*/

create table maclar(
	mac_id serial, -- Otomatik olarak PostgreSQL id'leri verir.
	p1 integer,
	p2 integer,
	kazanan integer,
	tarih date
);

-- mac_id sütunlarını girmeyeceğiz.
insert into maclar(p1, p2, kazanan, tarih) values
(100, 101, 100, '2024-03-15'),
(100, 102, 100, '2024-03-15'),
(101, 102, 102, '2024-03-15'),
(103, 101, 103, '2024-03-15'),
(103, 102, 103, '2024-03-15'),
(103, 100, 103, '2024-03-15'),
(104, 101, 101, '2024-03-16'),
(104, 102, 102, '2024-03-16'),
(104, 103, 104, '2024-03-16'),
(105, 100, 100, '2024-03-16'),
(105, 101, 101, '2024-03-17'),
(105, 102, 105, '2024-03-17'),
(106, 100, 100, '2024-03-18'),
(106, 105, 105, '2024-03-18');

-- 52. yeniden eskiye doğru tüm maçların listesi
select *
from maclar
order by tarih desc;

-- 53. 17 Mart 2024 ve sonrasında yapılan maçların listesi
select *
from maclar
where tarih >= '2024-03-17';

-- 54. BETWEEN .. AND .. Sorgusu: 16 Mart - 18 Mart arasında yapılan maçların listesi
select *
from maclar
where tarih between '2024-03-16' and '2024-03-18';

-- 55. NOW Sorgusu:. tüm maçlar ve şu anki zamandan ne kadar önce yapıldıklarının listesi
select *, NOW() - tarih as fark
from maclar;

-- 56.  EXTRACT Sorgusu: tüm maçlar ve şu anki zamandan ne kadar gün önce yapıldıklarının listesi
select *, extract(day from NOW() - tarih) as fark -- PSQL ile ilgili farklı DBMS ile farklı şeyler olabilir
from maclar;

-- 57. tüm maçlar ve şu anki zamandan ne kadar ay önce yapıldıklarının listesi
select *, extract(month from NOW() - tarih) as fark
from maclar;

-- 58. maç kazanan oyuncuların kazandıkları maç sayılarına göre azalan sıralaması
select * from maclar order by kazanan;

select kazanan as oyuncu, count(*) as kazanma_sayisi
from maclar
group by kazanan
order by kazanma_sayisi desc;

-- 59. tüm oyuncuların kazandıkları maç sayılarına göre azalan sıralaması
select * from maclar;

select kazanan as oyuncu, count(*) as kazanma_sayisi
from maclar
group by kazanan
union
select distinct p1 as oyuncu, 0 as kazanma_sayisi
from maclar
where p1 not in (select kazanan from maclar)
union
select distinct p2 as oyuncu, 0 as kazanma_sayisi
from maclar
where p2 not in (select kazanan from maclar)
order by kazanma_sayisi desc;

-- 60. tarihlere göre oynanan maç sayıları
select tarih, count(*) as mac_sayisi
from maclar
group by tarih
order by tarih;

-- 61. en çok maç yapılan tarih ve o günde yapılmış maç sayısı
select tarih, count(*) as mac_sayisi
from maclar
group by tarih
order by mac_sayisi desc
limit 1;

select tarih, count(*) as mac_sayisi
from maclar
group by tarih
having count(*) >= all (select count(*)
						from maclar
						group by tarih);