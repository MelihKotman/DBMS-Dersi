

-- 1. Ortalaması 3.0'dan yüksek öğrenciler
select ogr_id, ogr_adi, ort
from ogrenciler
where ort > 3.0;

-- 2. Başvuru yapan öğrencilerin adı ve başvurdukları ana dallar
select ogr_adi, ana_dal
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id;

-- 3. DISTINCT Sorgusu: Tekrarlamayan (unique) başvuru yapan öğrebcilerin adı ve başvurdukları ana dallar
select distinct ogr_adi, ana_dal
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id;

/* 
4. Lise mevcudu 400'den büyük olan ve Ankara Üniversitesi Bilgisayar Mühendisliği
bölümüne başvuran öğrencilerin adları, ortalamaları ve basvuru sonuçlarının oldugu liste 
*/
select ogr_adi, ort, sonuc
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id -- Belirtmeliyiz
	and lis_mev > 400 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/* 
5. Kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının listesi (HATALI)
*/
select okul_adi -- Belirtmemiz gerekiyor
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';

/* 
5. Kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının listesi (DOĞRU)
*/
select okullar.okul_adi
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';
	
/* 
6. Kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının TEKRARSIZ listesi
*/
select distinct okullar.okul_adi
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';
	
/*
7. Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi;

/*
8. ORDER BY Sorgusu: Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi. Liste, ortalamaya göre azalan şekilde sıralı olmalıdır.
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi
order by ort desc; -- desc = azalan, adc

/*
9. Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi. Liste, ortamaya göre azalan şekilde ve 
kayit_sayisina göre artan şekilde sıralı olmalıdır.
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi
order by ort desc, kayit_sayisi;

/*
10. LIKE Sorgusu: İçinde "Müh" geçen bölümlere başvuran öğrencilerin ID'si ve 
başvurdukları bölümlerin adlarının listesi
*/
select ogr_id, ana_dal 
from basvurular 
where ana_dal like '%Müh%';

/*
11. İçinde "Müh" geçen başvurulara ait tüm bilgilerin listesi
*/
select * 
from basvurular 
where ana_dal like '%Müh%'; 

-- ILIKE Sorgusu: İçinde "Müh" geçen başvurulara ait tüm bilgilerin listesi
select * 
from basvurular 
where ana_dal ilike '%müh%'; 
-- Küçük m ile yazarsak bize geri dönüt vermeyebilir ama 'ilike' kullanırsan sıkıntı yapmaz
-- Ya da "where lower(ana_dal) like '%Müh%';"

/*
12. Tüm öğrencilerin ID'si, adı, ortalaması, lise mevcudu, ve ağırlıklı ortalaması
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0)
from ogrenciler;

/*
13. AS Sorgusu: Tüm öğrencilerin ID'si, adı, ortalaması, lise mevcudu, ve ağırlıklı ortalaması
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler;

/*
******************************************
********* Tablo Değişkenleri *************
********* Table Variables ****************
******************************************
*/

/*
14. WHERE Sorgusu: Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi 
from ogrenciler og, okullar ok, basvurular b 
where og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi;

/*
15. Aynı ortalamaya sahip tüm öğrencilerin ID, ad ve ortalamalarının listesi
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1, ogrenciler o2
where o1.ort = o2.ort;
-- and o1.ogr_id <> o2.ogr_id; -- herkesin kendiyle eşleşmesini istemiyorsak eşit değil deriz '!='de çalışır.
-- and o1.ogr_id < o2.ogr_id; -- aynı bilginin tekrarını engellemek istiyorsak

/* 
16. UNION ve UNION ALL Sorgusu: Tüm okul ve öğrenci adlarının listesi 
*/
select ogr_adi
from ogrenciler
union
select okul_adi 
from okullar;

select ogr_adi as ad
from ogrenciler
union
select okul_adi as ad
from okullar
order by ad;

select ogr_adi as ad
from ogrenciler
union all
select okul_adi as ad
from okullar
order by ad;

-- 17. INSERT INTO ... VALUES() Sorgusu: Yeni kayıtlar
insert into ogrenciler values(120, 'Ayşe', 2.9, 500);
insert into basvurular values(120, 'Gazi', 'Elk. Müh.', 'K');

/*
18. INTERSECT Sorgusu: Hem 'Bilg. Müh.' hem de 'Elk. Müh.'e başvuran öğrencilerin ID'lerinin listesi
*/
select ogr_id
from basvurular
where ana_dal = 'Bilg. Müh.'
intersect
select ogr_id
from basvurular
where ana_dal = 'Elk. Müh.';

/*
19. EXCEPT Sorgusu: 'Bilg. Müh.'e başvurup 'Elk. Müh.'e başvurMAYAN öğrencilerin ID'lerinin listesi
*/
select ogr_id
from basvurular
where ana_dal = 'Bilg. Müh.'
except
select ogr_id
from basvurular
where ana_dal = 'Elk. Müh.';

/*
************************************************
********* Where kısmındaki iç sorgular *********
************************************************
*/

/*
20. WHERE ... IN Sorgusu: 'Elk. Müh.'e başvuran öğrencilerin adlarının listesi
*/
select ogr_adi
from ogrenciler
where ogr_id in (select ogr_id 
				 from basvurular
				 where ana_dal = 'Elk. Müh.');
				 -- İç sorguda eğer aynı sonuçlar geliyorsa eğer dışta aynılık yoksa tek id verir
				 -- Tekrar eden sonucu tekrardan göremeyiz dışta

/*
21. 'Elk Müh.'e başvuran öğrencilerin adlarının listesi
*/ -- DISTINCT olmazsa aynı öğrencinin adı birden fazla kez listelenebilir
-- çünkü aynı öğrenci birden fazla okula başvurmuş olabilir ve
-- her başvurusunda 'Elk. Müh.'e başvurmuş olabilir.
-- Bu durumda 1 öğrenci için 1'den fazla kayıt oluşabilir.
select distinct o.ogr_adi -- distinct ile silersek yanlış sonuç alabiliriz (SINAVDA 1 tane çıkabilir)
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id and b.ana_dal = 'Elk. Müh.';

/*
22. WHERE ... NOT IN Sorgusu: 'Bilg. Müh.'e başvurup 'Elk. Müh.'e başvurMAYAN öğrencilerin ID ve adlarının listesi
*/
select ogr_id, ogr_adi
from ogrenciler
where ogr_id in (select ogr_id 
				 from basvurular where 
				 ana_dal = 'Bilg. Müh.')
   and ogr_id not in (select ogr_id 
				      from basvurular where 
				      ana_dal = 'Elk. Müh.');

-- 23. 'Elk Müh.'e başvuran öğrencilerin ortalamaları
select ort from ogrenciler
where ogr_id in
	(select ogr_id from basvurular
	 where ana_dal = 'Elk. Müh.');

-- VS (distinct ile düzeltilemez!)
select ort
from ogrenciler o, basvurular b 
where o.ogr_id = b.ogr_id and b.ana_dal = 'Elk. Müh.'; 

/*
24. EXISTS Sorgusu: Bulunduğu şehirde 1'den fazla okul bulunan okulların listesi (HATALI)
*/
select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir);
			 
/*
25. Bulunduğu şehirde 1'den fazla okul bulunan okulların listesi (DOĞRU)
*/
select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir and o1.okul_adi <> o2.okul_adi);

-- VS

select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir and o1.okul_adi != o2.okul_adi);

/*
26. NOT EXISTS Sorgusu: Kayıt sayısı en fazla olan okul
*/
select o1.okul_adi, o1.kayit_sayisi
from okullar o1 
where not exists (select * 
				 from okullar o2
				 where o2.kayit_sayisi > o1.kayit_sayisi);
				 
/*
27. Ortalaması en yüksek olan öğrenci listesi
*/
select o1.ogr_adi
from ogrenciler o1
where not exists (select * from ogrenciler o2
				 where o2.ort > o1.ort);

-- VS (HATALI)
select o1.ogr_adi, o1.ort
from ogrenciler o1, ogrenciler o2 
where o1.ort > o2.ort;

-- ALL Sorgusu: Alternatif (DOĞRU)
select ogr_adi, ort
from ogrenciler
where ort >= all (select max(ort) from ogrenciler);

/*
28. ANY Sorgusu: Lise mevcudu en düşük olmayan tüm öğrencilerin listesi
*/
select ogr_id, ogr_adi, lis_mev
from ogrenciler
where lis_mev > any (select lis_mev from ogrenciler);

-- Alternatif
select o1.ogr_id, o1.ogr_adi, o1.lis_mev
from ogrenciler o1
where exists (select * from ogrenciler o2
			 where o2.lis_mev < o1.lis_mev);

/*
************************************************
********* FROM kısmındaki iç sorgular **********
************************************************
*/

/*
29. Ortalaması ile ağırlıklı ortalaması arasındaki fark 1'den büyük olan öğrenciler
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler
where ort * (lis_mev / 1000.0) - ort > 1
	or ort - ort * (lis_mev / 1000.0) > 1;

select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler
where abs(ort * (lis_mev / 1000.0) - ort) > 1;

select * from
(select ogr_id, ogr_adi from ogrenciler);

select *
from ogrenciler og, basvurular b
where og.ogr_id = b.ogr_id;

select *
from (select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
	  from ogrenciler) O
where abs(O.agirlikli_ort - ort) > 1;

/*
***********************************************************
********* WITH ile isimlendirilmiş alt query'ler **********
***********************************************************
*/

/*
30. WITH Sorgusu: Ortalaması ile ağırlıklı ortalaması arasındaki fark 1'den büyük olan öğrenciler
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
CTE: Common Table Expression
*/

with aort_tablosu as (
	select ogr_id, round((ort * (lis_mev / 1000.0))::numeric, 2) as agirlikli_ort
	from ogrenciler
)
select O.ogr_id, ogr_adi, ort, lis_mev, agirlikli_ort
from ogrenciler O, aort_tablosu Ali
where O.ogr_id = Ali.ogr_id
	and abs(ort - agirlikli_ort) > 1;

-- Alternatif

with aort_tablosu(ogr_id, agirlikli_ort) as (
	select ogr_id, round((ort * (lis_mev / 1000.0))::numeric, 2)
	from ogrenciler
)
select O.ogr_id, ogr_adi, ort, lis_mev, agirlikli_ort
from ogrenciler O, aort_tablosu A
where O.ogr_id = A.ogr_id
	and abs(ort - agirlikli_ort) > 1;