update dbp_etl_process.tupel_mat_etl_1 set A61_muki_vk_kl_art_id_verkettung = null
where A61_muki_vk_kl_art_id_verkettung = '-0.100000'
;

create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_1 where DAT_BIS='9999-12-31'
) ;

CREATE OR REPLACE VOLATILE TABLE _tupel_bez1 AS (
SELECT a.mandant_id,
       a.matching_id,
       a.A500_kjwo_update,
       b.spr_id,
       a.art_bez_deutsch AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.mandant_spr_zu_1 b
  ON a.mandant_id = b.mandant_id
WHERE a.mandant_id > 1 AND
      a.art_id IS NOT NULL 
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _tupel_bez2 AS (
SELECT a.mandant_id,
       a.matching_id,
       a.A500_kjwo_update,
       b.spr_id,
       b.art_bez AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.art_spr_zu_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.spr_id = 22
WHERE a.mandant_id > 1 AND
      a.art_id IS NOT NULL 
GROUP BY 1,2,3,4,5
);

DELETE FROM dbp_data.tupel_spr_zu_1;
INSERT INTO dbp_data.tupel_spr_zu_1
SELECT distinct
       x.*,
       current_timestamp,
       current_timestamp
from (
SELECT *
FROM _tupel_bez1
WHERE tupel_bez IS NOT NULL
UNION
SELECT *
FROM _tupel_bez2
WHERE tupel_bez IS NOT NULL
UNION
SELECT a.mandant_id,
       a.matching_id,
       a.A500_kjwo_update,
       b.spr_id,
       a.art_bez_deutsch AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.mandant_spr_zu_1 b
  ON a.mandant_id = b.mandant_id
WHERE a.mandant_id = 1 AND
      a.art_id IS NOT NULL AND
      a.art_bez_deutsch IS NOT NULL
GROUP BY 1,2,3,4,5) x
;

CREATE OR REPLACE VOLATILE TABLE _gp_bez1 AS (
SELECT a.mandant_id,
       a.A500_kjwo_update,
       A16_akt_lieferant_id,
       b.spr_id,
       MAX(c.gp_name) AS akt_lieferant_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.gp_1 c
  on a.mandant_id = c.mandant_id and
     a.A16_akt_lieferant_id = c.gp_id
JOIN dbp_data.mandant_spr_zu_1 b
  ON a.mandant_id = b.mandant_id
WHERE a.mandant_id > 1 AND
      a.art_id IS NOT NULL
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _gp_bez2 AS (
SELECT a.mandant_id,
       a.A500_kjwo_update,
       A16_akt_lieferant_id,
       22 AS spr_id,
       MAX(dbp_etl_process.TRANSCRIPTC(a.A446_lieferant_bez_latein)) AS akt_lieferant_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
WHERE a.mandant_id > 1 AND
      a.art_id IS NOT NULL
GROUP BY 1,2,3,4
);

DELETE FROM dbp_data.sort_lieferant_spr_zu_1;
INSERT INTO dbp_data.sort_lieferant_spr_zu_1
SELECT distinct
       x.*,
       current_timestamp,
       current_timestamp
from (
SELECT *
FROM _gp_bez1
WHERE akt_lieferant_bez IS NOT NULL AND
      A16_akt_lieferant_id IS NOT NULL AND
      A16_akt_lieferant_id NOT IN (-1,9999)
UNION
SELECT *
FROM _gp_bez2
WHERE akt_lieferant_bez IS NOT NULL AND
      A16_akt_lieferant_id IS NOT NULL AND
      A16_akt_lieferant_id NOT IN (-1,9999)
UNION
SELECT a.mandant_id,
       a.A500_kjwo_update,
       a.A16_akt_lieferant_id,
       b.spr_id,
       MAX(dbp_etl_process.TRANSCRIPTC(a.A446_lieferant_bez_latein)) AS akt_lieferant_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.mandant_spr_zu_1 b
  ON a.mandant_id = b.mandant_id
WHERE a.mandant_id = 1 AND
      a.art_id IS NOT NULL AND
      a.A446_lieferant_bez_latein IS NOT NULL AND
      a.A16_akt_lieferant_id IS NOT NULL AND
      a.A16_akt_lieferant_id NOT IN (-1,9999)
GROUP BY 1,2,3,4) x
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT mandant_id,
                                                  kjwo_update,
                                                  akt_lieferant_id,
                                                  MAX(akt_lieferant_bez) as akt_lieferant_bez
                                           FROM dbp_data.sort_lieferant_spr_zu_1
                                           WHERE spr_id = 22 AND
                                                 mandant_id > 1
                                           GROUP BY 1,2,3) b
                                       
SET A446_lieferant_bez_latein = b.akt_lieferant_bez
    
WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND
      Cast(dbp_etl_process.tupel_mat_etl.A16_akt_lieferant_id AS INT) = b.akt_lieferant_id AND
      TRIM(dbp_etl_process.tupel_mat_etl.A446_lieferant_bez_latein) <> TRIM(b.akt_lieferant_bez)
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT mandant_id,
                                                  matching_id,
                                                  kjwo_update,
                                                  MAX(tupel_bez) AS tupel_bez
                                           FROM dbp_data.tupel_spr_zu_1
                                           WHERE spr_id = 22 AND
                                                 mandant_id > 1
                                           GROUP BY 1,2,3) b
                                       
SET art_bez_deutsch = b.tupel_bez
    
WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id AND
      TRIM(dbp_etl_process.tupel_mat_etl.art_bez_deutsch) <> TRIM(b.tupel_bez)
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT a.mandant_id
                                                 ,a.a500_kjwo_update
                                                 ,a.matching_id
                                                 ,max(b.gp_name) as gp_name
                                           FROM dbp_etl_process.tupel_mat_etl_1 a
                                           JOIN dbp_data.gp_1 b
                                             ON a.mandant_id = b.mandant_id AND 
                                                a.a16_akt_lieferant_id = b.gp_id
                                           WHERE a.mandant_id > 1 AND 
                                                 a.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1) AND 
                                                 a.a16_akt_lieferant_id > 0
                                           group by 1,2,3) b

SET a446_lieferant_bez_latein = b.gp_name
      
WHERE dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

CREATE OR REPLACE VOLATILE TABLE _fix_it AS (
SELECT a.mandant_id,
       a.matching_id,
       a.a500_kjwo_update,
       b.spr_id,
       b.art_bez AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 a
JOIN dbp_data.mandant_spr_zu_1 x
  ON a.mandant_id = x.mandant_id  
JOIN dbp_data.art_spr_zu_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.spr_id = x.spr_id
WHERE a.mandant_id > 1 AND
      a.art_id IS NOT NULL 
GROUP BY 1,2,3,4,5
);

UPDATE dbp_data.tupel_spr_zu_1 FROM (SELECT mandant_id,
                                          matching_id,
                                          a500_kjwo_update,
                                          spr_id,
                                          max(tupel_bez) as tupel_bez
                                   FROM _fix_it
                                   group by 1,2,3,4) b
                                   
SET tupel_bez = b.tupel_bez

WHERE dbp_data.tupel_spr_zu.mandant_id = b.mandant_id AND
      dbp_data.tupel_spr_zu.matching_id = b.matching_id AND
      dbp_data.tupel_spr_zu.kjwo_update = b.a500_kjwo_update AND
      dbp_data.tupel_spr_zu.spr_id = b.spr_id
;

CREATE OR REPLACE VOLATILE TABLE _step11 AS (
SELECT b.kjwo,
       c.art_matching_id,
       a.mandant_id,
       MIN(a.sm_id) AS sm_id
FROM dbp_etl_process.art_sm_vw_zu_per_1 a
JOIN dbp_data.woche_1 b
  ON 1 = 1
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
      WHERE art_id <> -1
      GROUP BY 1,2,3) c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.kjwo IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
GROUP BY 1,2,3
);

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT *
                                           FROM _step11) b
                                                
SET a39_listung_sst_mvke = b.sm_id

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.A500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1) AND
      dbp_etl_process.tupel_mat_etl.mandant_id IN (1)
;

-- texts for article groupings at the very end

create or replace volatile table _murks_1 as (
SELECT a.art_gruppe_id,
       b.art_id,
       a.art_gruppe_bez
FROM dbp_data.art_gruppe_1 a
JOIN dbp_data.art_gruppe_art_zu_1 b
  ON a.art_gruppe_id = b.art_gruppe_id
WHERE a.art_gruppe_kategorie = 'Sortimentstool' AND
      b.mandant_id = 1 AND
      a.art_gruppe_id IN (SELECT b.art_gruppe_id
                          FROM dbp_data.art_gruppe_1 a
                          JOIN dbp_data.art_gruppe_art_zu_1 b
                            ON a.art_gruppe_id = b.art_gruppe_id
                          WHERE a.art_gruppe_kategorie = 'Sortimentstool' AND
                                b.mandant_id = 1 
                          GROUP BY 1)
group by 1,2,3
);

create or replace volatile table _murks2 as (
select a.mandant_id,
       a.matching_id,
       a.a500_kjwo_update,
       b.art_gruppe_bez
from dbp_etl_process.tupel_mat_etl_1 a
join _murks_1 b
  on a.mandant_id = 1 and
     a.art_id = b.art_id
where a500_kjwo_update in (SELECT Max(a500_kjwo_update) FROM dbp_etl_process.tupel_mat_etl_1 WHERE mandant_id = 1)
group by 1,2,3,4
);

update dbp_etl_process.tupel_mat_etl_1 from (select * from _murks2) b

set art_bez_deutsch = b.art_gruppe_bez

where dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update and
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

update dbp_data.tupel_spr_zu_1 from (select * from _murks2) b

set tupel_bez = b.art_gruppe_bez

where dbp_data.tupel_spr_zu.kjwo_update = b.a500_kjwo_update and
      dbp_data.tupel_spr_zu.mandant_id = b.mandant_id and
      dbp_data.tupel_spr_zu.matching_id = b.matching_id
;

update dbp_etl_process.tupel_mat_etl_1 from (select mandant_id,
                                                art_nielsen_id,
                                                hersteller_bez
                                                from _art_nielsen
                                                where mandant_id > 1
                                                group by 1,2,3) b

set a446_lieferant_bez_latein = b.hersteller_bez

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
dbp_etl_process.tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id and
dbp_etl_process.tupel_mat_etl.art_id is null and
dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1)
;

update dbp_etl_process.tupel_mat_etl_1 from (select mandant_id,
                                                art_nielsen_id,
                                                hersteller_bez
                                                from _art_nielsen
                                                where mandant_id = 1
                                                group by 1,2,3) b

set a446_lieferant_bez_latein = b.hersteller_bez

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
dbp_etl_process.tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id and
dbp_etl_process.tupel_mat_etl.art_id is null and
dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1)
;

update dbp_etl_process.tupel_mat_etl_1 from (select mandant_id,
                                                  matching_id,
                                                  a500_kjwo_update,
                                                  REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(floor(A61_muki_vk_kl_art_id_verkettung) AS VARCHAR(600)),8,'0') as int) as varchar(8)),8,'0'), ',') within group (ORDER BY A61_muki_vk_kl_art_id_verkettung) ), ','),' ', '') AS mutter_wb_id
                                           from dbp_etl_process.tupel_mat_etl_1
                                           where mandant_id > 1 and
                                                 a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_1) and
                                                 charindex('.',A61_muki_vk_kl_art_id_verkettung) > 0 and
                                                 charindex(',',A61_muki_vk_kl_art_id_verkettung) = 0
                                           group by 1,2,3) b

set A61_muki_vk_kl_art_id_verkettung = mutter_wb_id

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update
;

update dbp_etl_process.tupel_mat_etl_1
SET     tupel_typ =  CASE  
                         WHEN ART_ID > 0 THEN 'KAUFLAND' 
                         WHEN ART_ID IS NULL THEN 'NIELSEN'  
                      END 
WHERE   dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1)
;

--KL_OLD

--de

create or replace volatile table _sales_data_10m_de as
(
select
 a.mandant_id
,c.art_matching_id
,sum(umsatz_netto) as umsatz_netto_10m
from dbp_data.artbew_wo_sum_1 a
join dbp_data.woche_kj_kl_1 b
  on a.kjwo_kl = b.kjwo_kl
join (select mandant_id, art_matching_id, art_id from dbp_etl.art_matching_nielsen_per_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_1) and art_id <> -1 group by 1,2,3) c
  on a.art_id = c.art_id and
     a.mandant_id = c.mandant_id
where (a.mandant_id,b.kjwo) in (select x.mandant_id,
                                       x.kjwo
                                from (select b.mandant_id,
                                             c.kjwo,
                                             rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                      from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 a
                                      join (select mandant_id,
                                                   max(kjmo) as kjmo
                                            from dbp_data.sortiment_leistung_1
                                            where mandant_id = 1
                                            group by 1) b
                                        on a.kjmo_sort = b.kjmo
                                      join dbp_data.woche_1 c
                                        on c.kjwo <= a.kjwo_bis) x
                                where x.akt_wo between -43 and -1
                                group by 1,2) and
      a.mandant_id=1
      group by 1,2
      having umsatz_netto_10m > 0
);

create or replace volatile table _tupel_sales_data_10m_de as
(
select 
a.mandant_id,
a.a500_kjwo_update,
a.matching_id,
a.art_id,
a.a450_art_nielsen_nr,
a.a14_art_status_de,
from dbp_etl_process.tupel_mat_etl_1 a 
where
a.mandant_id = 1 and 
a.a14_art_status_de = 'L' and 
a450_art_nielsen_nr is not null and 
a.a500_kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_1) and
(mandant_id,matching_id) not in (select mandant_id,art_matching_id as matching_id from _sales_data_10m_de group by 1,2)
);

--de
update dbp_etl_process.tupel_mat_etl_1 from (select * from _tupel_sales_data_10m_de) b
set     tupel_typ = 'KL_OLD'
where
dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and 
dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update and
dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

create or replace volatile table _sales_data_10m_kmo as
(
select
 a.mandant_id
,c.art_matching_id
,sum(umsatz_netto) as umsatz_netto_10m
from dbp_data.artbew_wo_sum_1 a
join dbp_data.woche_kj_kl_1 b
  on a.kjwo_kl = b.kjwo_kl
join (select mandant_id, art_matching_id, art_id from dbp_etl.art_matching_nielsen_per_kmo_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_1) and art_id <> -1 group by 1,2,3) c
  on a.art_id = c.art_id and
     a.mandant_id = c.mandant_id
where (a.mandant_id,b.kjwo) in (select x.mandant_id,
                                       x.kjwo
                                from (select b.mandant_id,
                                             c.kjwo,
                                             rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                      from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 a
                                      join (select mandant_id,
                                                   max(kjmo) as kjmo
                                            from dbp_data.sortiment_leistung_1
                                            where mandant_id > 1
                                            group by 1) b
                                        on a.kjmo_sort = b.kjmo
                                      join dbp_data.woche_1 c
                                        on c.kjwo <= a.kjwo_bis) x
                                where x.akt_wo between -43 and -1
                                group by 1,2) and
      a.mandant_id>1
      group by 1,2
      having umsatz_netto_10m > 0
);

create or replace volatile table _tupel_sales_data_10m_kmo as
(
select 
a.mandant_id,
a.a500_kjwo_update,
a.matching_id,
a.art_id,
a.a450_art_nielsen_nr,
a.a14_art_status_de,
from dbp_etl_process.tupel_mat_etl_1 a 
where
a.mandant_id > 1 and 
a.a14_art_status_de = 'L' and 
a450_art_nielsen_nr is not null and 
a.a500_kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_1) and
(mandant_id,matching_id) not in (select mandant_id,art_matching_id as matching_id from _sales_data_10m_kmo group by 1,2)
);

--kmo
update dbp_etl_process.tupel_mat_etl_1 from (select * from _tupel_sales_data_10m_kmo) b
set     tupel_typ = 'KL_OLD'
where
dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and 
dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update and
dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

--DE
CREATE OR REPLACE VOLATILE TABLE _nielsen_based_data_de AS (
SELECT a.mandant_id,
       c.art_nielsen_id,
       count(DISTINCT x.kjwo )as anz_weeks
FROM dbp_data.art_nielsen_fakten_kjwo_1 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
  JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_1
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3
      UNION
      SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_1
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1 group by 1)
      GROUP BY 1,2,3) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_1
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2
);

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _nielsen_based_data_de) b

SET anz_wochen_de_anz_monate_kmo_nielsen = anz_weeks

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.A450_ART_NIELSEN_NR = b.art_nielsen_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
;

--KMO

CREATE OR REPLACE VOLATILE TABLE _nielsen_based_data AS (
SELECT a.mandant_id,
       c.art_nielsen_id,
       count(DISTINCT x.kjmo )as anz_months
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
  JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3
      UNION
      SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_1
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_1 where mandant_id > 1 group by 1)
      GROUP BY 1,2,3) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
WHERE (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                       x.kjmo
                                FROM (SELECT mandant_id,
                                             kjmo,
                                             RANK() OVER (PARTITION BY mandant_id ORDER BY mandant_id,kjmo DESC) * (-1) AS akt_mo
                                      FROM dbp_data.art_nielsen_fakten_kjmo_1
                                      WHERE mandant_id > 1
                                      GROUP BY 1,2) x
                                WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id > 1
GROUP BY 1,2
);

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _nielsen_based_data) b

SET anz_wochen_de_anz_monate_kmo_nielsen = anz_months

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.A450_ART_NIELSEN_NR = b.art_nielsen_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
;


--new nielsen data --de
create or replace volatile table _update_de
as
(
select 
a.mandant_id,
b.art_matching_id,
a.ART_NIELSEN_ID,
NULLIF(a.MARKE_BEZ,'') as MARKE_BEZ,
NULLIF(a.BIO_ORGANIC_KZ,'') as BIO_ORGANIC_KZ,
NULLIF(a.VEGGY_SPLIT_KZ,'') as VEGGY_SPLIT_KZ,
NULLIF(a.LAKTOSEFREI_KZ,'') as LAKTOSEFREI_KZ,
NULLIF(a.GLUTENFREI_KZ,'') as GLUTENFREI_KZ,
NULLIF(a.DUFT_GESCHMACK_BEZ,'') as DUFT_GESCHMACK_BEZ,
NULLIF(a.INHALT_MENGE,'') as INHALT_MENGE
from dbp_data.art_nielsen_1 a
join dbp_etl.art_matching_nielsen_per_1 b
on a.mandant_id=b.mandant_id 
and a.art_nielsen_id=b.art_nielsen_id 
where a.mandant_id = 1 and a.DAT_BIS='9999-12-31'
and b.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung_1 where mandant_id = 1)
);

create or replace volatile table _update_de_agg
as
(
select
mandant_id,
art_matching_id,
listagg(DISTINCT BIO_ORGANIC_KZ,', ') WITHIN GROUP (ORDER BY BIO_ORGANIC_KZ) AS kombi_BIO_ORGANIC_KZ,
listagg(DISTINCT VEGGY_SPLIT_KZ,', ') WITHIN GROUP (ORDER BY VEGGY_SPLIT_KZ) AS kombi_VEGGY_SPLIT_KZ,
listagg(DISTINCT LAKTOSEFREI_KZ,', ') WITHIN GROUP (ORDER BY LAKTOSEFREI_KZ) AS kombi_LAKTOSEFREI_KZ,
listagg(DISTINCT GLUTENFREI_KZ,', ') WITHIN GROUP (ORDER BY GLUTENFREI_KZ) AS kombi_GLUTENFREI_KZ,
listagg(DISTINCT INHALT_MENGE,', ') WITHIN GROUP (ORDER BY INHALT_MENGE) AS kombi_INHALT_MENGE
from _update_de
GROUP BY 1,2
);

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _update_de_agg) b

SET
a515_bio_organic_nielsen_kz = b.kombi_BIO_ORGANIC_KZ,
a516_veggy_split_nielsen_kz = b.kombi_VEGGY_SPLIT_KZ,
a517_laktosefrei_nielsen_kz = b.kombi_LAKTOSEFREI_KZ,
a518_glutenfrei_nielsen_kz = b.kombi_GLUTENFREI_KZ,
A386_INHALTSMENGEN_NIELSEN = b.kombi_INHALT_MENGE

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.sortiment_leistung_1 where mandant_id = 1)
;

--new nielsen data --kmo

create or replace volatile table _update_kmo
as
(
select 
a.mandant_id,
b.art_matching_id,
a.ART_NIELSEN_ID,
NULLIF(a.MARKE_BEZ,'') as MARKE_BEZ,
NULLIF(a.BIO_ORGANIC_KZ,'') as BIO_ORGANIC_KZ,
NULLIF(a.VEGGY_SPLIT_KZ,'') as VEGGY_SPLIT_KZ,
NULLIF(a.LAKTOSEFREI_KZ,'') as LAKTOSEFREI_KZ,
NULLIF(a.GLUTENFREI_KZ,'') as GLUTENFREI_KZ,
NULLIF(a.DUFT_GESCHMACK_BEZ,'') as DUFT_GESCHMACK_BEZ,
NULLIF(a.INHALT_MENGE,'') as INHALT_MENGE,
NULLIF(a.INHALT_EINHEIT,'') as INHALT_EINHEIT
from dbp_data.art_nielsen_1 a
join dbp_etl.art_matching_nielsen_per_kmo_1 b
on a.mandant_id=b.mandant_id 
and a.art_nielsen_id=b.art_nielsen_id 
where a.mandant_id > 1 and a.DAT_BIS='9999-12-31'
and b.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung_1 where mandant_id > 1)
);

create or replace volatile table _update_kmo_agg
as
(
select
mandant_id,
art_matching_id,
listagg(DISTINCT MARKE_BEZ,', ') WITHIN GROUP (ORDER BY MARKE_BEZ) AS kombi_MARKE_BEZ,
listagg(DISTINCT BIO_ORGANIC_KZ,', ') WITHIN GROUP (ORDER BY BIO_ORGANIC_KZ) AS kombi_BIO_ORGANIC_KZ,
listagg(DISTINCT DUFT_GESCHMACK_BEZ,', ') WITHIN GROUP (ORDER BY DUFT_GESCHMACK_BEZ) AS kombi_DUFT_GESCHMACK_BEZ,
listagg(DISTINCT INHALT_MENGE,', ') WITHIN GROUP (ORDER BY INHALT_MENGE) AS kombi_INHALT_MENGE,
listagg(DISTINCT INHALT_EINHEIT,', ') WITHIN GROUP (ORDER BY INHALT_EINHEIT) AS kombi_INHALT_EINHEIT
from _update_kmo
GROUP BY 1,2
);


UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _update_kmo_agg) b

SET
a471_marke_nielsen_bez = b.kombi_MARKE_BEZ ,
a515_bio_organic_nielsen_kz = b.kombi_BIO_ORGANIC_KZ ,
A387_DUFT_GESCHMACK_NIELSEN = b.kombi_DUFT_GESCHMACK_BEZ,
A386_INHALTSMENGEN_NIELSEN = b.kombi_INHALT_MENGE ,
A388_EINHEIT_NIELSEN = b.kombi_INHALT_EINHEIT

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.sortiment_leistung_1 where mandant_id > 1)
;

--new nielsen data , art_matching_id based --de with new market_tag

CREATE OR REPLACE VOLATILE TABLE _art_matching_id_based_de AS (
SELECT a.mandant_id,
       c.art_matching_id,
       zz.a5_owg_id,
       zz.a7_wg_id,
       zz.wug_id,
       COUNT(DISTINCT c.art_nielsen_id||x.kjwo) AS anz,
       SUM(a.DISTR_GEW_4_WO)/anz AS DISTR_GEW_4_WO,
       SUM(a.DISTR_NUM_4_WO)/anz AS DISTR_NUM_4_WO
FROM dbp_data.art_nielsen_fakten_kjwo_1 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN (SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_1
      GROUP BY 1,2,3,4
      UNION
      SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_1
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1 group by 1)
      GROUP BY 1,2,3,4) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_1
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _art_matching_id_based_de_agg AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.a5_owg_id,
       a.a7_wg_id,
       a.wug_id,
       MAX(a.anz) AS anz,
       SUM(a.DISTR_GEW_4_WO) AS DISTR_GEW_4_WO,
       SUM(a.DISTR_NUM_4_WO) AS DISTR_NUM_4_WO
FROM _art_matching_id_based_de a
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,matching_id FROM dbp_etl_process.tupel_mat_etl_1
                                       WHERE mandant_id = 1 AND 
                                             a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1))
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _base_de AS (
SELECT mandant_id,
       matching_id,
       a500_kjwo_update,
       A36_gewichtete_distribution_nielsen,
       A385_NUMERISCHE_DISTRIBUTION_NIELSEN
FROM dbp_etl_process.tupel_mat_etl_1
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE _base_de FROM (SELECT mandant_id,
                           art_matching_id,
                           SUM(DISTR_GEW_4_WO) AS DISTR_GEW_4_WO,
                           SUM(DISTR_NUM_4_WO) as DISTR_NUM_4_WO
                    FROM _art_matching_id_based_de_agg
                    GROUP BY 1,2) b
                    
SET A36_gewichtete_distribution_nielsen = b.DISTR_GEW_4_WO,
    A385_NUMERISCHE_DISTRIBUTION_NIELSEN = b.DISTR_NUM_4_WO

WHERE _base_de.mandant_id = b.mandant_id AND
      _base_de.matching_id = b.art_matching_id
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT mandant_id,
                                           matching_id,
                                           a500_kjwo_update,
                                           MAX(A36_gewichtete_distribution_nielsen) AS gewichtete_distribution,
                                           MAX(A385_NUMERISCHE_DISTRIBUTION_NIELSEN) as NUMERISCHE_DISTRIBUTION
                                    FROM _base_de
                                    GROUP BY 1,2,3) b

SET A36_gewichtete_distribution_nielsen = b.gewichtete_distribution,
    A385_NUMERISCHE_DISTRIBUTION_NIELSEN = b.NUMERISCHE_DISTRIBUTION

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

--new nielsen data , art_matching_id based --kmo

CREATE OR REPLACE VOLATILE TABLE _art_matching_id_based_kmo AS (
SELECT a.mandant_id,
       c.art_matching_id,
       SUM(a.menge) AS menge,
       SUM(a.umsatz_brutto) AS umsatz_brutto,
       SUM(COALESCE(MENGE_VERKAUFSEINHEITEN_NORMIERT, 0)) AS MENGE_VERKAUFSEINHEITEN_NORMIERT,
       CASE 
         WHEN a.mandant_id NOT IN (2,3,5,6)
         THEN Count(DISTINCT a.mandant_id||c.art_nielsen_id||x.kjmo)
         ELSE Count(a.mandant_id||c.art_nielsen_id||x.kjmo)
       END AS anz,
       SUM(a.DISTR_NUM)/anz AS DISTR_NUM
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
  JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3
      UNION
      SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_1
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_1 where mandant_id > 1 group by 1)
      GROUP BY 1,2,3) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
WHERE (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                       x.kjmo
                                FROM (SELECT mandant_id,
                                             kjmo,
                                             RANK() OVER (PARTITION BY mandant_id ORDER BY mandant_id,kjmo DESC) * (-1) AS akt_mo
                                      FROM dbp_data.art_nielsen_fakten_kjmo_1
                                      WHERE mandant_id > 1
                                      GROUP BY 1,2) x
                                WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id > 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _art_matching_id_based_kmo_agg AS (
SELECT a.mandant_id,
       a.art_matching_id,
       SUM(a.DISTR_NUM) AS DISTR_NUM
FROM _art_matching_id_based_kmo a
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,matching_id FROM dbp_etl_process.tupel_mat_etl_1
                                       WHERE mandant_id > 1 AND 
                                             a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1))
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _base_kmo AS (
SELECT mandant_id,
       matching_id,
       a500_kjwo_update,
       A385_NUMERISCHE_DISTRIBUTION_NIELSEN
FROM dbp_etl_process.tupel_mat_etl_1
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1) AND
      mandant_id > 1
);

UPDATE _base_kmo FROM (SELECT mandant_id,
                           art_matching_id,
                           SUM(DISTR_NUM) AS DISTR_NUM
                    FROM _art_matching_id_based_kmo_agg
                    GROUP BY 1,2) b
                    
SET A385_NUMERISCHE_DISTRIBUTION_NIELSEN = b.DISTR_NUM

WHERE _base_kmo.mandant_id = b.mandant_id AND
      _base_kmo.matching_id = b.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _nielsen_preis AS (
SELECT mandant_id,
       art_matching_id,
       umsatz_brutto/NULLIFZERO(menge) AS durchschnitt_preis
FROM _art_matching_id_based_kmo
WHERE umsatz_brutto > 0 AND
      menge > 0
);

CREATE OR REPLACE VOLATILE TABLE _durchschn_preis AS 
(
SELECT mandant_id,
       art_matching_id,
       umsatz_brutto/MENGE_VERKAUFSEINHEITEN_NORMIERT AS DURCHSCHN_PREIS_EINHEIT
FROM _art_matching_id_based_kmo
WHERE umsatz_brutto > 0 AND
      MENGE_VERKAUFSEINHEITEN_NORMIERT > 0
) ;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _nielsen_preis) b

SET A34_vk_brutto_durchschnitt_nielsen = b.durchschnitt_preis

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _art_matching_id_based_kmo) b

SET A383_SALES_UNITS_VERKAUFSEINHEITEN_GL_IN_1000_NORMIERT_NIELSEN = b.MENGE_VERKAUFSEINHEITEN_NORMIERT

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _durchschn_preis) b

SET A384_DURCHSCHN_PREIS_EINHEIT_GL_NORMIERT_NIELSEN = b.DURCHSCHN_PREIS_EINHEIT

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT mandant_id,
                                           matching_id,
                                           a500_kjwo_update,
                                           MAX(A385_NUMERISCHE_DISTRIBUTION_NIELSEN) AS DISTR_NUM
                                    FROM _base_kmo
                                    GROUP BY 1,2,3) b

SET A385_NUMERISCHE_DISTRIBUTION_NIELSEN = b.DISTR_NUM

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

--new nielsen data , art_matching_id based --de 

CREATE OR REPLACE VOLATILE TABLE _art_matching_id_based_de AS (
SELECT a.mandant_id,
       c.art_matching_id,
       SUM(a.menge) AS menge,
       SUM(a.menge_af) AS menge_af,
       SUM(a.menge_sa) AS menge_sa,
       SUM(a.umsatz_brutto) AS umsatz_brutto,
       SUM(a.umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(a.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM dbp_data.art_nielsen_fakten_kjwo_1 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN (SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_1
      GROUP BY 1,2,3,4
      UNION
      SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_1
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1 group by 1)
      GROUP BY 1,2,3,4) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_1
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _nielsen_preis_de AS (
SELECT mandant_id,
       art_matching_id,
       CASE
         WHEN umsatz_brutto_af > 0
         THEN umsatz_brutto_af/NULLIFZERO(menge_af)
         WHEN umsatz_brutto_af = 0 AND umsatz_brutto_sa > 0
         THEN umsatz_brutto_sa/NULLIFZERO(menge_sa)
         ELSE 0
       END AS durchschnitt_preis
FROM _art_matching_id_based_de
WHERE umsatz_brutto > 0 AND
      menge > 0
);

UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (SELECT * FROM _nielsen_preis_de) b

SET A34_vk_brutto_durchschnitt_nielsen = durchschnitt_preis

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
;


--restbon + cherrypicker de

create or replace volatile table _bons_art_de as (
select 
	a.mandant_id,
	b.art_id,
	sum(a.art_ums_af) as art_umsatz_af,
	sum(a.art_ums_sa) as art_umsatz_sa,
	sum(a.bon_ums_af) as bon_umsatz_af,
	sum(a.bon_ums_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_af)+sum(a.restbon_sa) as restbon_summe,
	sum(a.art_bons_af) as anz_bons_af,
	sum(a.art_bons_sa) as anz_bons_sa,
	sum(a.art_bons_af) + sum(a.art_bons_sa) as anz_bons,
        SUM(a.cp_bons_sa) as cpsa_fg
from dbp_etl.bf_bons_sort_sum_1 a
join dbp_data.art_1 b
on   
	a.mandant_id = b.mandant_id and
	a.kl_art_id = b.kl_art_id and
	b.dat_bis = '9999-12-31'
join dbp_data.tag_1 c
	on a.dat=c.dat
where 
a.mandant_id = 1 and
(a.mandant_id,c.kjwo) in (select x.mandant_id,
                                 x.kjwo
                                 from (select 
				       b.mandant_id,
                                       c.kjwo,
                                       rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                       from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 a
                                       join (select mandant_id,
                                             max(kjmo) as kjmo
                                             from dbp_data.sortiment_leistung_1
                                             where mandant_id = 1
                                             group by 1) b
                                       on a.kjmo_sort = b.kjmo
                                       join dbp_data.woche_1 c
                                       on c.kjwo <= a.kjwo_bis) x
                          where x.akt_wo between -52 and -1
                          group by 1,2)
  group by 1,2
);

create or replace volatile table _bons_matching_de as
(
select 
	a.mandant_id,
	b.art_matching_id,
	sum(a.art_umsatz_af) as art_umsatz_af,
	sum(a.art_umsatz_sa) as art_umsatz_sa,
	sum(a.bon_umsatz_af) as bon_umsatz_af,
	sum(a.bon_umsatz_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_summe) as restbon_summe,
	sum(a.anz_bons_af) as anz_bons_af,
	sum(a.anz_bons_sa) as anz_bons_sa,
	sum(a.anz_bons) as anz_bons,
        SUM(a.cpsa_fg) as cpsa_fg
	from _bons_art_de a
join (
      select distinct mandant_id,art_matching_id,art_id from 
      dbp_etl.art_matching_nielsen_per_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_1) 
	  and art_id <> -1
	  ) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_etl_process.tupel_mat_etl_1 from (select * from _bons_matching_de) b

set 
restbon_summe = b.restbon_summe,
anz_bons_gesamt = b.anz_bons,
anz_bons_af =  b.anz_bons_af,
anz_bons_sa = b.anz_bons_sa,
cp_bons_sa = b.cpsa_fg



where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1)
;

--restbon + cherrypicker kmo

create or replace volatile table _bons_art_kmo as (
select 
	a.mandant_id,
	b.art_id,
	sum(a.art_ums_af) as art_umsatz_af,
	sum(a.art_ums_sa) as art_umsatz_sa,
	sum(a.bon_ums_af) as bon_umsatz_af,
	sum(a.bon_ums_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_af)+sum(a.restbon_sa) as restbon_summe,
	sum(a.art_bons_af) as anz_bons_af,
	sum(a.art_bons_sa) as anz_bons_sa,
	sum(a.art_bons_af) + sum(a.art_bons_sa) as anz_bons,
        sum(a.cp_bons_sa) as cp_bons_sa
from dbp_etl.bf_bons_sort_sum_1 a
join dbp_data.art_1 b
on   
	a.mandant_id = b.mandant_id and
	a.kl_art_id = b.kl_art_id and
	b.dat_bis = '9999-12-31'
join dbp_data.tag_1 c
	on a.dat=c.dat
where a.mandant_id>1 and
(a.mandant_id,c.kjwo) in (select x.mandant_id,
                                 x.kjwo
                                 from (select 
				       b.mandant_id,
                                       c.kjwo,
                                       rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                       from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 a
                                       join (select mandant_id,
                                             max(kjmo) as kjmo
                                             from dbp_data.sortiment_leistung_1
                                             where mandant_id <> 1
                                             group by 1) b
                                       on a.kjmo_sort = b.kjmo
                                       join dbp_data.woche_1 c
                                       on c.kjwo <= a.kjwo_bis) x
                          where x.akt_wo between -52 and -1
                          group by 1,2)
  group by 1,2
);

create or replace volatile table _bons_matching_kmo as
(
select 
	a.mandant_id,
	b.art_matching_id,
	sum(a.art_umsatz_af) as art_umsatz_af,
	sum(a.art_umsatz_sa) as art_umsatz_sa,
	sum(a.bon_umsatz_af) as bon_umsatz_af,
	sum(a.bon_umsatz_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_summe) as restbon_summe,
	sum(a.anz_bons_af) as anz_bons_af,
	sum(a.anz_bons_sa) as anz_bons_sa,
	sum(a.anz_bons) as anz_bons,
        SUM(a.cp_bons_sa) as cp_bons_sa
	from _bons_art_kmo a
join (
      select distinct mandant_id,art_matching_id,art_id from 
      dbp_etl.art_matching_nielsen_per_kmo_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_1) 
	  and art_id <> -1
	  ) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_etl_process.tupel_mat_etl_1 from (select * from _bons_matching_kmo) b

set 
restbon_summe = b.restbon_summe,
anz_bons_gesamt = b.anz_bons,
anz_bons_af =  b.anz_bons_af,
anz_bons_sa = b.anz_bons_sa,
cp_bons_sa = b.cp_bons_sa



where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id > 1)
;


---------------------------
--de Bonreichweite
create or replace table dbp_etl_process.sort_bon_receipt_agg_sa_de_1 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_de_1  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_1
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_1
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_1 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) and anz_bons_sa_fg>0
group by 1,2
) ;

create or replace table dbp_etl_process.sort_bon_receipt_agg_af_de_1 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_de_1  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_1
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_1
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_1 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) and anz_bons_af_fg>0
group by 1,2
) ;

create or replace volatile table _sort_bon_receipt_agg_de_lvl2_af as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_af_de_1 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_1) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

create or replace volatile table _sort_bon_receipt_agg_de_lvl2_sa as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_sa_de_1 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_1) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_etl_process.tupel_mat_etl_1 from (select * from _sort_bon_receipt_agg_de_lvl2_af) b

set 
ANZ_BONS_AF_MARKT_TAG = b.sum_total_receipt

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1)
;

update dbp_etl_process.tupel_mat_etl_1 from (select * from _sort_bon_receipt_agg_de_lvl2_sa) b

set 
ANZ_BONS_SA_MARKT_TAG = b.sum_total_receipt

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id = 1)
;


--kmo Bonreichweite
create or replace table dbp_etl_process.sort_bon_receipt_agg_kmo_af_1 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_kmo_1  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_1
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_1
                                                WHERE mandant_id > 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_1 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) and anz_bons_af_fg>0
group by 1,2
) ;

create or replace table dbp_etl_process.sort_bon_receipt_agg_kmo_sa_1 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_kmo_1  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_1
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_1
                                                WHERE mandant_id > 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_1 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) and anz_bons_sa_fg>0
group by 1,2
) ;

create or replace volatile table _sort_bon_receipt_agg_kmo_lvl2_af as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_kmo_af_1 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_kmo_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_1) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

create or replace volatile table _sort_bon_receipt_agg_kmo_lvl2_sa as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_kmo_sa_1 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_kmo_1 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_1) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_etl_process.tupel_mat_etl_1 from (select * from _sort_bon_receipt_agg_kmo_lvl2_af) b

set 
ANZ_BONS_AF_MARKT_TAG = b.sum_total_receipt

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id > 1)
;

update dbp_etl_process.tupel_mat_etl_1 from (select * from _sort_bon_receipt_agg_kmo_lvl2_sa) b

set 
ANZ_BONS_SA_MARKT_TAG = b.sum_total_receipt

where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_1 where mandant_id > 1)
;

