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

CREATE OR REPLACE TABLE dbp_etl.anzeige_artikel_2  (
      mandant_id BYTEINT,
      art_matching_id INTEGER,
      art_a INTEGER,
      art_b INTEGER,
      art_c1 INTEGER,
      art_c2 INTEGER,
      art_d1 INTEGER,
      art_d2 INTEGER,
      fg_a BYTEINT,
      fg_b BYTEINT,
      fg_c1 BYTEINT,
      fg_c2 BYTEINT,
      fg_d1 BYTEINT,
      fg_d2 BYTEINT,
      status_a VARCHAR(2) COLLATE 'en-ci',
      status_b VARCHAR(2) COLLATE 'en-ci',
      status_c1 VARCHAR(2) COLLATE 'en-ci',
      status_c2 VARCHAR(2) COLLATE 'en-ci',
      status_d1 VARCHAR(2) COLLATE 'en-ci',
      status_d2 VARCHAR(2) COLLATE 'en-ci')
;

CREATE OR REPLACE TABLE dbp_etl.sort_ist_2  (
      wup_id INTEGER,
      kreistyp_gruppe_id CHAR(1) COLLATE 'en-ci',
      mandant_id BYTEINT,
      wg_id INTEGER,
      art_id INTEGER,
      kassenumsatz FLOAT,
      anz_tage INTEGER,
      preis FLOAT,
      list_kz VARCHAR(2) COLLATE 'en-ci')
;

DELETE FROM dbp_data.art_list_wup_zu_per_2
WHERE (mandant_id,art_id) IN (SELECT mandant_id,art_id
                              FROM dbp_data.art_gp_zu_per_2
                              WHERE mandant_id = 1 AND
                                    gp_id = 5059720 AND
                                    dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
                              GROUP BY 1,2)
;

--- new list_kz logic

create or replace volatile table _art_nielsen as (
select *
from dbp_data.art_nielsen_2
where dat_bis = '9999-12-31' and mandant_id = 1 
);

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id
from _art_nielsen a
where a.mandant_id = 1
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
      where mandant_id = 1 and
           (mandant_id,art_id) not in (select mandant_id,art_id
                                       from dbp_data.art_gp_zu_per_2
                                       where mandant_id = 1 and
                                             gp_id = 5059720 and
                                             dat_bis = '9999-12-31'
                                       group by 1,2)) b
  on a.gtin_id = b.gtin_id and
     a.mandant_id = b.mandant_id
group by 1,2,3,4
);


CREATE OR REPLACE TABLE dbp_etl.kl_basis_listung_2 (
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

CREATE OR REPLACE VOLATILE TABLE _kl_basis_alle_gelistet AS (
SELECT a.mandant_id,
       a.art_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
     b.arthiertyp_id = 2
JOIN dbp_data.wg_filter_zu_2 wfz
  ON b.wg_id = wfz.wg_id AND 
     b.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
WHERE a.list_quelle_id NOT IN ('2') AND
      a.list_komponente_fg = 0 AND
      a.nb_id = 0 AND
      a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.art_id > 0
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _kl_basis_nicht_gelistet AS (
SELECT a.mandant_id,
       a.art_id
FROM dbp_data.art_wup_zu_per_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
     b.arthiertyp_id = 2
JOIN dbp_data.wg_filter_zu_2 wfz
  ON b.wg_id = wfz.wg_id AND 
     b.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.art_id > 0
GROUP BY 1,2
HAVING Max(a.listung_id) = 0
);

create or replace volatile table _kl_basis_a
as
(SELECT a.mandant_id,
       a.art_id,
      'A' AS list_kz
FROM dbp_data.artbew_wo_sum_2 a
JOIN DBP_DATA.WOCHE_KJ_KL_2 X
  ON A.KJWO_KL = X.KJWO_KL
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.MANDANT_ID = 1 AND X.KJWO IN (SELECT X.KJWO
               FROM (SELECT KJWO,
                            RANK() OVER (ORDER BY KJWO DESC) * (-1) AS AKT_WO
                     FROM DBP_DATA.ART_NIELSEN_FAKTEN_KJWO_2
                     WHERE MANDANT_ID = 1
                     GROUP BY 1) X
               WHERE AKT_WO BETWEEN -52 AND -1) AND
     b.wg_id in (select wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 11 group by 1) AND
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
(SELECT a.mandant_id,
       a.art_id,
      'B' AS list_kz
FROM dbp_data.artbew_wo_sum_2 a
JOIN DBP_DATA.WOCHE_KJ_KL_2 X
  ON A.KJWO_KL = X.KJWO_KL
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.MANDANT_ID = 1 AND X.KJWO IN (SELECT X.KJWO
               FROM (SELECT KJWO,
                            RANK() OVER (ORDER BY KJWO DESC) * (-1) AS AKT_WO
                     FROM DBP_DATA.ART_NIELSEN_FAKTEN_KJWO_2
                     WHERE MANDANT_ID = 1
                     GROUP BY 1) X
               WHERE AKT_WO BETWEEN -52 AND -1) AND
     b.wg_id in (select wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 11 group by 1) AND
     (a.mandant_id,a.art_id) NOT IN (SELECT distinct mandant_id,art_id FROM _kl_basis_alle_gelistet)
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
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
  JOIN (SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4
      UNION
      SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_2
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_2 where mandant_id = 1 group by 1)
      GROUP BY 1,2,3,4) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
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

INSERT INTO dbp_etl.kl_basis_listung_2 (mandant_id
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


DELETE FROM dbp_etl.kl_basis_listung_2
WHERE (mandant_id,art_id) IN (SELECT mandant_id,art_id
                              FROM dbp_data.art_gp_zu_per_2
                              WHERE mandant_id = 1 AND
                                    gp_id = 5059720 AND
                                    dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
                              GROUP BY 1,2)
;


CREATE OR REPLACE VOLATILE TABLE _sort_ist1  (
	wup_id	INTEGER,
	kreistyp_gruppe_id CHAR(1),
	mandant_id BYTEINT,
	wg_id INTEGER,
	art_id INTEGER,
	kassenumsatz FLOAT, 
	anz_tage INTEGER,
	preis FLOAT,
	list_kz VARCHAR(2) COLLATE 'en-cs'
) ;

INSERT INTO _sort_ist1 
SELECT a11.wup_id,
       c.kreistyp_gruppe_id,
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
JOIN (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) x
  ON a11.mandant_id = x.mandant_id AND
     a11.art_id = x.art_id AND
     x.list_kz = 'A'
JOIN dbp_data.art_wg_zu_per_2 a12
  ON a11.mandant_id = a12.mandant_id AND
     a11.art_id = a12.art_id AND
     a12.arthiertyp_id = 2 AND
     a12.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN dbp_data.wg_filter_zu_2 wfz
  ON a12.wg_id = wfz.wg_id AND 
     a12.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
JOIN dbp_data.wup_2 c
  ON a11.wup_id = c.wup_id AND
     a11.mandant_id = c.mandant_id
WHERE a11.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1 AND
      a11.mandant_id = 1 AND
      a11.bewart_id IN (1001,1002)
GROUP BY 1,2,3,4,5,9
;

INSERT INTO _sort_ist1 
SELECT a11.wup_id,
       c.kreistyp_gruppe_id,
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
JOIN (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) x
  ON a11.mandant_id = x.mandant_id AND
     a11.art_id = x.art_id AND
     x.list_kz = 'B'
JOIN dbp_data.art_wg_zu_per_2 a12
  ON a11.mandant_id = a12.mandant_id AND
     a11.art_id = a12.art_id AND
     a12.arthiertyp_id = 2 AND
     a12.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN dbp_data.wg_filter_zu_2 wfz
  ON a12.wg_id = wfz.wg_id AND 
     a12.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
JOIN dbp_data.wup_2 c
  ON a11.wup_id = c.wup_id AND
     a11.mandant_id = c.mandant_id
WHERE a11.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1 AND
      a11.mandant_id = 1 AND
      a11.bewart_id IN (1001,1002)
GROUP BY 1,2,3,4,5,9
;

CREATE OR REPLACE VOLATILE TABLE _anzeige_artikel AS (
SELECT a.mandant_id,
       d.art_matching_id,
       Max(CASE WHEN a.list_kz = 'A'  THEN a.art_id ELSE 0 END) AS art_a,
       Max(CASE WHEN a.list_kz = 'B'  THEN a.art_id ELSE 0 END) AS art_b,
       Max(CASE WHEN a.list_kz = 'C1' THEN a.art_id ELSE 0 END) AS art_c1,
       Max(CASE WHEN a.list_kz = 'C2' THEN a.art_id ELSE 0 END) AS art_c2,
       Max(CASE WHEN a.list_kz = 'D1' THEN a.art_id ELSE 0 END) AS art_d1,
       Max(CASE WHEN a.list_kz = 'D2' THEN a.art_id ELSE 0 END) AS art_d2,
       Max(CASE WHEN a.list_kz = 'A'  THEN 1 ELSE 0 END) AS fg_a,
       Max(CASE WHEN a.list_kz = 'B'  THEN 1 ELSE 0 END) AS fg_b,
       Max(CASE WHEN a.list_kz = 'C1' THEN 1 ELSE 0 END) AS fg_c1,
       Max(CASE WHEN a.list_kz = 'C2' THEN 1 ELSE 0 END) AS fg_c2,
       Max(CASE WHEN a.list_kz = 'D1' THEN 1 ELSE 0 END) AS fg_d1,
       Max(CASE WHEN a.list_kz = 'D2' THEN 1 ELSE 0 END) AS fg_d2,
       Max(CASE WHEN a.list_kz = 'A'  THEN c.art_status ELSE '' END) AS status_a,
       Max(CASE WHEN a.list_kz = 'B'  THEN c.art_status ELSE '' END) AS status_b,
       Max(CASE WHEN a.list_kz = 'C1' THEN c.art_status ELSE '' END) AS status_c1,
       Max(CASE WHEN a.list_kz = 'C2' THEN c.art_status ELSE '' END) AS status_c2,
       Max(CASE WHEN a.list_kz = 'D1' THEN c.art_status ELSE '' END) AS status_d1,
       Max(CASE WHEN a.list_kz = 'D2' THEN c.art_status ELSE '' END) AS status_d2
FROM (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) a
JOIN dbp_etl.art_matching_nielsen_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
JOIN dbp_etl.bf_sort_sal_export_2 c
  ON a.art_id/100 = Cast(c.art_nr AS INTEGER)
GROUP BY 1,2
HAVING Count(*) > 1 AND
       fg_a+fg_b+fg_c1+fg_c2+fg_d1+fg_d2 > 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO dbp_etl.anzeige_artikel_2 (mandant_id
                                    ,art_matching_id
                                    ,art_a
                                    ,art_b
                                    ,art_c1
                                    ,art_c2
                                    ,art_d1
                                    ,art_d2
                                    ,fg_a
                                    ,fg_b
                                    ,fg_c1
                                    ,fg_c2
                                    ,fg_d1
                                    ,fg_d2
                                    ,status_a
                                    ,status_b
                                    ,status_c1
                                    ,status_c2
                                    ,status_d1
                                    ,status_d2)
SELECT mandant_id
      ,art_matching_id
      ,art_a
      ,art_b
      ,art_c1
      ,art_c2
      ,art_d1
      ,art_d2
      ,fg_a
      ,fg_b
      ,fg_c1
      ,fg_c2
      ,fg_d1
      ,fg_d2
      ,status_a
      ,status_b
      ,status_c1
      ,status_c2
      ,status_d1
      ,status_d2
FROM _anzeige_artikel
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO dbp_etl.sort_ist_2 (wup_id
                            ,kreistyp_gruppe_id
                            ,mandant_id
                            ,wg_id
                            ,art_id
                            ,kassenumsatz
                            ,anz_tage
                            ,preis
                            ,list_kz)
SELECT wup_id
      ,kreistyp_gruppe_id
      ,mandant_id
      ,wg_id
      ,art_id
      ,kassenumsatz
      ,anz_tage
      ,preis
      ,list_kz
FROM _sort_ist1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO dbp_etl.sort_ist_2 (wup_id
                                            ,kreistyp_gruppe_id
                                            ,mandant_id
                                            ,wg_id
                                            ,art_id
                                            ,kassenumsatz
                                            ,anz_tage
                                            ,preis
                                            ,list_kz)
SELECT a.wup_id,
       d.kreistyp_gruppe_id,
       a.mandant_id,
       c.wg_id,
       a.art_id,
       0 AS kassenumsatz,
       0 AS anz_tage,
       0 AS preis,
       b.list_kz
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN dbp_data.art_wg_zu_per_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     c.arthiertyp_id = 2 AND
     c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN dbp_data.wg_per_2 e
  ON a.mandant_id = e.mandant_id AND
     c.wg_id = e.wg_id AND
     e.arthiertyp_id = 2 AND
     e.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN dbp_data.wg_filter_zu_2 wfz
  ON c.wg_id = wfz.wg_id AND 
     c.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
JOIN dbp_etl_process.sort_tool_owg_de_2 f
  ON e.owg_id = f.owg_id
JOIN dbp_data.wup_2 d
  ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     CURRENT_DATE BETWEEN d.dat_von AND d.dat_bis AND
     d.nb_id = 0 AND
     d.wup_id >= 1300
WHERE (a.mandant_id,a.art_id,a.wup_id) NOT IN (SELECT mandant_id,art_id,wup_id FROM _sort_ist1) AND
       a.nb_id = 0 AND
       a.list_quelle_id NOT IN ('2') AND
       CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
       a.list_komponente_fg = 0
GROUP BY 1,2,3,4,5,6,7,8,9
;

