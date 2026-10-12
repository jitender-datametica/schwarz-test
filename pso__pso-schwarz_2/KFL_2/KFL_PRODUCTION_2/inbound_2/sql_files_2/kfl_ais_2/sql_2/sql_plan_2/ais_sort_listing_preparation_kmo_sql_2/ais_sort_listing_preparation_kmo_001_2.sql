create or replace volatile table _art_matching_nielsen_per_kmo as (
select * 
from dbp_etl.art_matching_nielsen_per_kmo_2
where kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2)
);

delete from dbp_etl_process.art_gtin_2;
insert into dbp_etl_process.art_gtin_2
select art_id,
       mandant_id,
       gtin_id,
       gtin_typ_kz,
       haupt_gtin_fg,
       td_insert,
       td_update
from dbp_data.art_gtin_zu_2
;

CREATE OR REPLACE VOLATILE TABLE _schrott_1 AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       b.gtin_id AS gtin_alt,
       max(a.gtin_id) AS gtin_neu
FROM _art_matching_nielsen_per_kmo a
JOIN dbp_data.art_nielsen_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.gtin_id <> b.gtin_id AND
      b.gtin_id IN (-9999,-9998)  AND b.DAT_BIS='9999-12-31'
group by 1,2,3
);

UPDATE dbp_data.art_nielsen_2 FROM (SELECT DISTINCT *
                                  FROM _schrott_1) b
                                                  
SET gtin_id = b.gtin_neu

WHERE dbp_data.art_nielsen.mandant_id = b.mandant_id AND
      dbp_data.art_nielsen.art_nielsen_id = b.art_nielsen_id AND
      dbp_data.art_nielsen.gtin_id = b.gtin_alt AND
      dbp_data.art_nielsen.DAT_BIS='9999-12-31'
;
--_gtin_mix_up must be done before update dbp_etl.art_matching_nielsen_per_kmo_2
CREATE OR REPLACE VOLATILE TABLE _gtin_mix_up AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id AS gtin_alt,
       b.gtin_id AS gtin_neu
FROM _art_matching_nielsen_per_kmo a
JOIN dbp_data.art_nielsen_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.gtin_id <> b.gtin_id AND
      a.mandant_id = b.mandant_id AND
      b.gtin_id NOT IN (-9999,-9998) AND b.DAT_BIS='9999-12-31'
);

UPDATE dbp_etl_process.art_art_nielsen_prepare_kmo_2 FROM (SELECT *
                                                         FROM _gtin_mix_up
                                                         GROUP BY 1,2,3,4) b
                                                  
SET gtin_id = b.gtin_neu

WHERE dbp_etl_process.art_art_nielsen_prepare_kmo.mandant_id = b.mandant_id AND
      dbp_etl_process.art_art_nielsen_prepare_kmo.art_nielsen_id = b.art_nielsen_id AND
      dbp_etl_process.art_art_nielsen_prepare_kmo.gtin_id = b.gtin_alt
;

CREATE OR REPLACE VOLATILE TABLE _schrott_2 AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id AS gtin_alt,
       b.gtin_id AS gtin_neu
FROM _art_matching_nielsen_per_kmo a
JOIN dbp_data.art_nielsen_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.gtin_id <> b.gtin_id AND
      b.gtin_id NOT IN (-9999,-9998) AND b.DAT_BIS='9999-12-31'
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT DISTINCT *
                                                  FROM _schrott_2) b
                                                  
SET gtin_id = b.gtin_neu

WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo.art_nielsen_id = b.art_nielsen_id AND
      dbp_etl.art_matching_nielsen_per_kmo.gtin_id = b.gtin_alt AND 
      dbp_etl.art_matching_nielsen_per_kmo.kjwo_update = (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2)
;

CREATE OR REPLACE TABLE dbp_etl.sort_wg_liste_2 AS (
SELECT a.wg_id
FROM dbp_data.wg_per_2 a
JOIN dbp_data.owg_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.owg_id = b.owg_id
JOIN dbp_data.hwg_per_2 c
  ON a.mandant_id = c.mandant_id AND
     b.hwg_id = c.hwg_id
JOIN dbp_data.abt_2 d
  ON a.mandant_id = d.mandant_id AND
     c.abt_id = d.abt_id
WHERE a.dat_bis = '9999-12-31' AND
      b.dat_bis = '9999-12-31' AND
      c.dat_bis = '9999-12-31' AND
      d.abt_id <> 8
GROUP BY 1
);

CREATE OR REPLACE TABLE dbp_etl.sort_ist_kmo_2 (
      wup_id INTEGER,
      mandant_id BYTEINT,
      wg_id INTEGER,
      art_id INTEGER,
      kassenumsatz FLOAT,
      anz_tage INTEGER,
      preis FLOAT,
      list_kz VARCHAR(2) collate 'en-ci'
);

----

create or replace volatile table _art_nielsen_mgtin as 
(
select distinct mandant_id,art_nielsen_id,gtin_id from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
union
select distinct mandant_id,art_nielsen_id,gtin_ref_id as gtin_id from dbp_etl_process.art_nielsen_gtin_zu_2
) ;

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id
from _art_nielsen_mgtin a
where a.mandant_id in (2,3,5,6,7,8)
group by 1,2,3
);

create or replace volatile table _article_matching0 as (
select a.mandant_id,
       a.art_nielsen_id,
       b.art_id,
       a.gtin_id
from _distinct_nl_arts a
join (select *
      from dbp_etl_process.art_gtin_2 a
      where mandant_id in (2,3,5,6,7,8)) b
  on a.gtin_id = b.gtin_id and
     a.mandant_id = b.mandant_id
group by 1,2,3,4
);

CREATE OR REPLACE TABLE dbp_etl.kl_basis_listung_kmo_2 (
      mandant_id BYTEINT,
      art_id INTEGER,
      ART_NIELSEN_ID NUMBER(38,0),
      list_kz VARCHAR(10) collate 'en-ci'
);

CREATE OR REPLACE VOLATILE TABLE _kl_basis_listung (
      mandant_id BYTEINT,
      art_id INTEGER,
      ART_NIELSEN_ID NUMBER(38,0),
      list_kz VARCHAR(10) collate 'en-ci'
);

--listed
CREATE OR REPLACE VOLATILE TABLE _kl_basis_alle_gelistet AS (
SELECT a.mandant_id,
       a.art_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.mandant_id in (2,3,5,6,7,8) AND
      a.nb_id = 0 AND
      a.list_komponente_fg = 0 AND
      a.list_quelle_id NOT IN ('2') AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2) AND
      a.art_id > 0
GROUP BY 1,2
);

--not listed

CREATE OR REPLACE VOLATILE TABLE _kl_basis_nicht_gelistet AS (
SELECT a.mandant_id,
       a.art_id
FROM dbp_data.art_wup_zu_per_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.mandant_id in (2,3,5,6,7,8) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2) AND
      a.art_id > 0
GROUP BY 1,2
HAVING Max(a.listung_id) = 0
);

create or replace volatile table _kl_basis_a
as
(SELECT a.mandant_id,
       a.art_id,
      'A' AS list_kz
FROM dbp_data.artbew_mo_sum_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.mandant_id in (2,3,5,6,7,8) AND
     (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                      x.kjmo
                               FROM (SELECT mandant_id,
                                            kjmo,
                                            Rank() Over (PARTITION BY mandant_id ORDER BY kjmo DESC) * (-1) AS akt_mo
                                     FROM dbp_data.art_nielsen_fakten_kjmo_2
		                             WHERE mandant_id in (2,3,5,6,7,8)
                                     GROUP BY 1,2) x
                               WHERE x.akt_mo BETWEEN -12 AND -1) AND
      b.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2) AND
     (a.mandant_id,a.art_id) IN (SELECT distinct mandant_id,art_id FROM _kl_basis_alle_gelistet)
GROUP BY 1,2
HAVING Sum(a.menge) > 0)
;

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_a a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID ;


create or replace volatile table _kl_basis_b
as
(
SELECT a.mandant_id,
       a.art_id,
      'B' AS list_kz
FROM dbp_data.artbew_mo_sum_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.mandant_id in (2,3,5,6,7,8) AND
     (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                      x.kjmo
                               FROM (SELECT mandant_id,
                                            kjmo,
                                            Rank() Over (PARTITION BY mandant_id ORDER BY kjmo DESC) * (-1) AS akt_mo
                                     FROM dbp_data.art_nielsen_fakten_kjmo_2
		                             WHERE mandant_id in (2,3,5,6,7,8)
                                     GROUP BY 1,2) x
                               WHERE x.akt_mo BETWEEN -12 AND -1) AND
      b.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2) AND
     (a.mandant_id,a.art_id) IN (SELECT distinct mandant_id,art_id FROM _kl_basis_nicht_gelistet)
      AND (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,art_id FROM _kl_basis_listung) 
GROUP BY 1,2
HAVING Sum(a.menge) > 0)
;

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_b a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID ;

CREATE OR REPLACE VOLATILE TABLE _artikel_nielsen_agg AS (
SELECT a.mandant_id,
       c.art_nielsen_id,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjmo_2 a
JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
  JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2 where art_nielsen_id >-1 
      GROUP BY 1,2,3) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                       x.kjmo
                                FROM (SELECT mandant_id,
                                             kjmo,
                                             RANK() OVER (PARTITION BY mandant_id ORDER BY mandant_id,kjmo DESC) * (-1) AS akt_mo
                                      FROM dbp_data.art_nielsen_fakten_kjmo_2
                                      WHERE mandant_id > 1
                                      GROUP BY 1,2) x
                                WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id > 1
GROUP BY 1,2
);

create or replace volatile table _kl_basis_c1
as
(
SELECT a.mandant_id,
       a.art_id,
      'C1' AS list_kz
FROM _kl_basis_alle_gelistet a
WHERE  
       (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,art_id FROM _kl_basis_listung) 
GROUP BY 1,2
)
;

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_c1 a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID 
left join _artikel_nielsen_agg c
on 
b.mandant_id = c.mandant_id AND
b.art_nielsen_id = c.art_nielsen_id
where c.umsatz_ is not null and c.umsatz_ > 0 ;

create or replace volatile table _kl_basis_c2
as
(
SELECT a.mandant_id,
       a.art_id,
      'C2' AS list_kz
FROM _kl_basis_alle_gelistet a
WHERE  
       (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,art_id FROM _kl_basis_listung)
GROUP BY 1,2
);

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_c2 a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID 
left join _artikel_nielsen_agg c
on 
b.mandant_id = c.mandant_id AND
b.art_nielsen_id = c.art_nielsen_id
where c.umsatz_ is null  ;

create or replace volatile table _kl_basis_d1
as
(
SELECT a.mandant_id,
       a.art_id,
      'D1' AS list_kz
FROM _kl_basis_nicht_gelistet a
WHERE  
       (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,art_id FROM _kl_basis_listung) 
  GROUP BY 1,2
);

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_d1 a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID 
left join _artikel_nielsen_agg c
on 
b.mandant_id = c.mandant_id AND
b.art_nielsen_id = c.art_nielsen_id
where c.umsatz_ is not null and c.umsatz_ > 0 ;


create or replace volatile table _kl_basis_d2
as
(SELECT a.mandant_id,
       a.art_id,
      'D2' AS list_kz
FROM _kl_basis_nicht_gelistet a
WHERE  
       (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,art_id FROM _kl_basis_listung)
GROUP BY 1,2
);

INSERT INTO _kl_basis_listung
select distinct
a.MANDANT_ID,a.ART_ID,b.art_nielsen_id,a.LIST_KZ
from _kl_basis_d2 a
left join _article_matching0 b
on 
a.mandant_id = b.mandant_id AND
a.ART_ID = b.ART_ID 
left join _artikel_nielsen_agg c
on 
b.mandant_id = c.mandant_id AND
b.art_nielsen_id = c.art_nielsen_id
where c.umsatz_ is null  ;

--gaps
create or replace volatile table _gaps
as
(select distinct a.MANDANT_ID,a.ART_NIELSEN_ID,a.ART_ID from _article_matching0 a
join _artikel_nielsen_agg b
on
a.MANDANT_ID = b. MANDANT_ID and
a.ART_NIELSEN_ID = b.ART_NIELSEN_ID
where 
b.umsatz_ > 0)
;

insert into _kl_basis_listung
select distinct
   mandant_id,
   art_id,
   art_nielsen_id,
   'D1' AS list_kz
from _gaps 
where  
(mandant_id,art_id) not in (select mandant_id,art_id from _kl_basis_listung) ;

insert into _kl_basis_listung
select distinct
   mandant_id,
   art_id,
   art_nielsen_id,
   'D2' AS list_kz
from _article_matching0 
where  
(mandant_id,art_id) not in (select mandant_id,art_id from _kl_basis_listung) ;

INSERT INTO dbp_etl.kl_basis_listung_kmo_2 (mandant_id
                                                        ,art_id
                                                        ,art_nielsen_id
                                                        ,list_kz)
SELECT mandant_id
      ,art_id
      ,art_nielsen_id
      ,list_kz
FROM _kl_basis_listung
GROUP BY 1,2,3,4
;


/*
_------------------------------------------------------------------------------
_ 3.) Die Kalkulation und Differenzierung fuer Artikel_2, die ueber Nielsen-CURRENT_DATEn
_     abgebildet werden muessen, erfolgt in den naechsten Schritten. 
_------------------------------------------------------------------------------
*/

CREATE OR REPLACE VOLATILE TABLE _sort_ist1 (
	wup_id	INTEGER,
	mandant_id BYTEINT,
	wg_id INTEGER,
	art_id INTEGER,
	kassenumsatz FLOAT, 
	anz_tage INTEGER,
	preis FLOAT,
	list_kz CHAR(2)
);

-- (1) Kz. A (alle Artikel_2 aus Historie uebernehmen)

INSERT INTO _sort_ist1 (wup_id
	               ,mandant_id
	               ,wg_id
	               ,art_id
	               ,kassenumsatz
	               ,anz_tage
	               ,preis
	               ,list_kz)
SELECT a11.wup_id,
       a11.mandant_id,
       a12.wg_id,
       a11.art_id,
       Sum(a11.umsatz_netto+a11.umsatz_mwst_betrag) kassenumsatz,
       Count(DISTINCT a11.dat) anz_tage,
       ZeroIfNull(Sum(a11.umsatz_netto+a11.umsatz_mwst_betrag)/NullIfZero(Sum(a11.menge))) AS preis,
       x.list_kz
FROM dbp_data.artbew_2 a11
JOIN dbp_data.tag_2 y
  ON a11.dat = y.dat
JOIN _kl_basis_listung x
  ON a11.mandant_id = x.mandant_id AND
     a11.art_id = x.art_id AND
     x.list_kz = 'A'
JOIN dbp_data.art_wg_zu_per_2 a12
  ON a11.mandant_id = a12.mandant_id AND
     a11.art_id = a12.art_id AND
     a12.dat_bis = '9999-12-31' AND
     a12.arthiertyp_id = 2
JOIN dbp_data.wup_2 c
  ON a11.wup_id = c.wup_id AND
     a11.mandant_id = c.mandant_id
WHERE a11.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE AND
      a11.mandant_id in (2,3,5,6,7,8) AND
      a11.bewart_id IN (1001,1002) AND
      a12.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2)
GROUP BY 1,2,3,4,8
;

-- (2) Kz. B (alle Artikel_2 aus Historie uebernehmen)

INSERT INTO _sort_ist1 (wup_id
	               ,mandant_id
	               ,wg_id
	               ,art_id
	               ,kassenumsatz
	               ,anz_tage
	               ,preis
	               ,list_kz)
SELECT a11.wup_id,
       a11.mandant_id,
       a12.wg_id,
       a11.art_id,
       Sum(a11.umsatz_netto+a11.umsatz_mwst_betrag) kassenumsatz,
       Count(DISTINCT a11.dat) anz_tage,
       ZeroIfNull(Sum(a11.umsatz_netto+a11.umsatz_mwst_betrag)/NullIfZero(Sum(a11.menge))) AS preis,
       x.list_kz
FROM dbp_data.artbew_2 a11
JOIN dbp_data.tag_2 y
  ON a11.dat = y.dat
JOIN _kl_basis_listung x
  ON a11.mandant_id = x.mandant_id AND
     a11.art_id = x.art_id AND
     x.list_kz = 'B'
JOIN dbp_data.art_wg_zu_per_2 a12
  ON a11.mandant_id = a12.mandant_id AND
     a11.art_id = a12.art_id AND
     a12.dat_bis = '9999-12-31' AND
     a12.arthiertyp_id = 2
JOIN dbp_data.wup_2 c
  ON a11.wup_id = c.wup_id AND
     a11.mandant_id = c.mandant_id
WHERE a11.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE AND
      a11.mandant_id in (2,3,5,6,7,8) AND
      a11.bewart_id IN (1001,1002) AND
      a12.wg_id IN (SELECT wg_id FROM dbp_etl.sort_wg_liste_2)
GROUP BY 1,2,3,4,8
;

/*
_------------------------------------------------------------------------------
_ 4.) Ueberfuehrung der Artikel_2 fuer Folgeprozesse.
_------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.sort_ist_kmo_2 (wup_id
                                            ,mandant_id
                                            ,wg_id
                                            ,art_id
                                            ,kassenumsatz
                                            ,anz_tage
                                            ,preis
                                            ,list_kz)
SELECT wup_id
      ,mandant_id
      ,wg_id
      ,art_id
      ,kassenumsatz
      ,anz_tage
      ,preis
      ,list_kz
FROM _sort_ist1
;


-- 16.03.2019, -dbay-
--
-- Ausgewaehlte OWGs, die von den ZEKs zum Zeitpunkt der Erstellung des MATs
-- in Verwendung sind, werden ueber die Pflegetabelle angezogen und hier die
-- Artikel_2, die nicht in der originaeren Listungstabelle drin sind, mit abge-
-- bildet, um selbige spaeter in die Kreuztabelle ueberfuehren zu koennen.
-- Wichtig fuer die Marktzaehlungen!

INSERT INTO dbp_etl.sort_ist_kmo_2 (wup_id 
                                                ,mandant_id
                                                ,wg_id
                                                ,art_id
                                                ,kassenumsatz
                                                ,anz_tage
                                                ,preis
                                                ,list_kz)
SELECT a.wup_id,
       a.mandant_id,
       c.wg_id,
       a.art_id,
       0 AS kassenumsatz,
       0 AS anz_tage,
       0 AS preis,
       b.list_kz
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN _kl_basis_listung b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN dbp_data.art_wg_zu_per_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     c.arthiertyp_id = 2 AND
     c.dat_bis = '9999-12-31'
JOIN dbp_data.wg_per_2 e
  ON a.mandant_id = e.mandant_id AND
     c.wg_id = e.wg_id AND
     e.arthiertyp_id = 2 AND
     e.dat_bis = '9999-12-31'
JOIN dbp_etl_process.sort_tool_owg_de_2 f
  ON e.owg_id = f.owg_id
JOIN dbp_data.wup_2 d
  ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     CURRENT_DATE BETWEEN d.dat_von AND d.dat_bis AND
     d.nb_id = 0 AND
     d.wup_id >= 1000
WHERE (a.mandant_id,a.art_id,a.wup_id) NOT IN (SELECT mandant_id,art_id,wup_id FROM _sort_ist1) AND
       a.nb_id = 0 AND
       a.list_quelle_id NOT IN ('2') AND
       CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
       a.list_komponente_fg = 0 AND
       a.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2,3,4,5,6,7,8
;

