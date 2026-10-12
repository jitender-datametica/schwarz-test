-- start --

-- correct product groups before transformation

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(d.owg_id) as kl_wg_id,
       max(c.wg_id) as kl_owg_id,
       min(c.wug_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
join dbp_data.art_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.wg_per d
  on a.mandant_id = d.mandant_id and
     c.wg_id = d.wg_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
where c.wg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 47 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.kl_owg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 47 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;

-- end --

create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;

create or replace volatile table _sort_matching_copy as (
select a.*,
       '-' as potential_article
from dbp_etl.art_matching_nielsen_per_kmo a
);

update _sort_matching_copy from (select mandant_id,
                                        art_matching_id
                                 from dbp_etl.art_matching_nielsen_per_kmo
                                 group by 1,2
                                 having count(distinct case when art_id = -1 then null else art_id end) = 0) b

set potential_article = 'x' 

where _sort_matching_copy.mandant_id = b.mandant_id and
      _sort_matching_copy.art_matching_id = b.art_matching_id
;

CREATE OR REPLACE TABLE DBP_ETL.sortiment_potenziale_kmo  (
      mandant_id BYTEINT,
      art_matching_id INTEGER,
      kjmo INTEGER,
      art_nielsen_id INTEGER,
      art_id INTEGER,
      kl_wg_id INTEGER,
      kl_owg_id INTEGER,
      kl_uwg_id INTEGER,
      rang_umsatz_wg INTEGER,
      rang_umsatz_uwg INTEGER,
      rang_absatz_uwg INTEGER,
      art_nielsen_bez VARCHAR(300) COLLATE 'de-ci',
      gtin_id VARCHAR(300) COLLATE 'de-ci',
      distr_gew DECIMAL(18,4),
      umsatz_anteil_uwg DECIMAL(18,4),
      umsatz_anteil_uwg_kumuliert DECIMAL(18,4),
      durchschnitt_anz_maerkte INTEGER,
      durchschnitt_preis DECIMAL(18,4),
      kl_markt_anteil_owg DECIMAL(18,4),
      umsatz_artikel DECIMAL(18,4),
      absatz_artikel DECIMAL(18,4),
      anz_monate INTEGER,
      anz_wochen INTEGER,
      eigenmarke_fg BYTEINT)
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       MAX(b.art_nielsen_id) AS art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjmo a
JOIN (SELECT kjmo AS kjmo
	  FROM DBP_DATA.tag
	  GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      b.gtin_id NOT IN (-9999,-9998)
GROUP BY 1,3,4,5,6,7
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjmo a
JOIN (SELECT kjmo AS kjmo
	  FROM DBP_DATA.tag
	  GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_matching_id,
             art_nielsen_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      b.gtin_id IN (-9999,-9998)
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(a.anz) AS anz,
       SUM(a.distr_gew_) AS distr_gew_,
       SUM(a.menge_) AS menge__,
       SUM(a.umsatz_) AS umsatz__,
       SUM(a.menge_af_) AS menge_af_,
       SUM(a.umsatz_af_) AS umsatz_af_,
       SUM(a.menge_sa_) AS menge_sa_,
       SUM(a.umsatz_sa_) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY a.kl_owg_id ORDER BY umsatz__ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY a.kl_owg_id ORDER BY menge__ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking_1st_base a
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_potenzial_base AS (
SELECT a.mandant_id,
       c.art_matching_id,
       a.art_nielsen_id,
       c.art_id,
       c.list_kz,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       a.gtin_id,
       CAST(0 AS DECIMAL(18,4)) AS distr_gew,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_artikel,
       CAST(0 AS DECIMAL(18,4)) AS absatz_artikel,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_gesamt,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_anteil_uwg,
       CAST(100 AS DECIMAL(18,4)) AS umsatz_anteil_kum_uwg,
       CAST(0 AS INTEGER) AS anz_maerkte,
       CAST(0 AS DECIMAL(18,4)) AS durchschnitt_preis,
       CAST(0 AS DECIMAL(18,4)) AS kl_markt_anteil_owg,
       CAST(0 AS INTEGER) AS anz_monate,
       CAST(0 AS INTEGER) AS anz_wochen,
       NULL AS rang_umsatz_wg,
       NULL AS rang_umsatz_uwg,
       NULL AS rang_absatz_uwg
FROM _art_nielsen a
JOIN (SELECT mandant_id,
             art_matching_id,
             art_nielsen_id,
	     art_id,
	     '  ' AS list_kz,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM _sort_matching_copy
      WHERE potential_article = 'x'
      GROUP BY 1,2,3,4,5,6,7,8) c
  ON a.art_nielsen_id = c.art_nielsen_id AND
     a.mandant_id = c.mandant_id
WHERE a.mandant_id = ${mandant_id}
GROUP BY 1,2,3,4,5,6,7,8,9
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_wg_ranking AS (
SELECT mandant_id,
       art_matching_id,
       MIN(kl_wg_id) AS kl_wg_id_,
       SUM(umsatz__) AS umsatz___,
       DENSE_RANK() OVER (PARTITION BY kl_wg_id_ ORDER BY umsatz___ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

DELETE FROM _artikel_anteil_uwg_ranking
WHERE (mandant_id,art_matching_id,kl_owg_id) IN (SELECT mandant_id,
                                                        art_matching_id,
                                                        kl_owg_id
                                                 FROM _artikel_anteil_uwg_ranking
                                                 GROUP BY 1,2,3
                                                 HAVING COUNT(*) > 1)
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET umsatz_artikel = b.umsatz__,
    absatz_artikel = b.menge__,
    anz_monate = b.anz,
    anz_wochen = b.anz,
    distr_gew = b.distr_gew_,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg

FROM (SELECT *
      FROM _artikel_anteil_uwg_ranking) b

WHERE _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id AND
      _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
      FROM _artikel_anteil_wg_ranking) b

WHERE _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_ranking 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
      FROM _artikel_anteil_wg_ranking) b

WHERE _artikel_anteil_uwg_ranking.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_ranking.mandant_id = b.mandant_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                                       kl_owg_id,
                                                       MAX(rang_umsatz_wg) AS next_rang_ums_wg,
                                                       MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
          		                               MAX(rang_absatz_uwg) AS next_rang_abs_uwg
				                FROM _artikel_anteil_uwg_ranking
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT mandant_id,
                                                       kl_wg_id,
                                                       MAX(rang_umsatz_wg)+1 AS next_rang_ums_wg
						FROM _artikel_anteil_uwg_ranking
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_wg_id = b.kl_wg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                                       kl_owg_id,
                                                       COALESCE(MAX(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
						       COALESCE(MAX(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
						FROM _artikel_anteil_uwg_potenzial_base a
						WHERE a.rang_umsatz_uwg IS NULL
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT mandant_id,
                                                       kl_wg_id,
                                                       MAX(COALESCE(rang_umsatz_wg,0))+1 AS next_rang_ums_wg
						FROM _artikel_anteil_uwg_potenzial_base
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_wg_id = b.kl_wg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                                       kl_owg_id,
                                                       MAX(COALESCE(rang_umsatz_uwg,0))+1 AS next_rang_ums_uwg,
						       MAX(COALESCE(rang_absatz_uwg,0))+1 AS next_rang_abs_uwg
						FROM _artikel_anteil_uwg_potenzial_base
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT mandant_id,
       kl_owg_id,
       kl_uwg_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2,3
);

UPDATE _artikel_anteil_uwg_potenzial_base 
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = _artikel_anteil_uwg_potenzial_base.umsatz_artikel/NULLIFZERO(b.umsatz)*100.00    
	
FROM (SELECT mandant_id,
                                                       kl_owg_id,
                                                       SUM(umsatz) AS umsatz
						FROM _gesamt_uwg
						GROUP BY 1,2) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_ranking 
SET umsatz_anteil_kum_uwg = _artikel_anteil_uwg_ranking.umsatz__/NULLIFZERO(b.umsatz)*100.00    
	
FROM (SELECT mandant_id,
                                                kl_owg_id,
                                                kl_uwg_id,
                                                umsatz
                                         FROM _gesamt_uwg
                                         GROUP BY 1,2,3,4) b
WHERE _artikel_anteil_uwg_ranking.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_ranking.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_ranking.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

FROM (SELECT mandant_id,
                                                       art_matching_id,
                                                       kl_owg_id,
                                                       kl_uwg_id,
                                                       SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY kl_owg_id,kl_uwg_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
                                                FROM _artikel_anteil_uwg_ranking) b
WHERE _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _kl_owg_umsatz AS (
SELECT a.mandant_id,
       b.kl_owg_id,
       SUM(a.total_umsatz_netto) AS ums_netto,
       SUM(a.anz_wup_listung) AS anz_listung,
       SUM(a.total_umsatz_netto*a.anz_wup_listung) AS gew_netto,
       ZEROIFNULL(gew_netto/NULLIFZERO(ums_netto)) AS anz_maerkte
FROM DBP_DATA.sal_kmo a
JOIN (SELECT mandant_id,
             art_id,
	     kl_owg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo
      WHERE mandant_id = ${mandant_id} AND
            art_id <> -1 AND
            kl_owg_id <> -3
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE (a.mandant_id,a.kjmo) IN (SELECT mandant_id,
                                       MAX(kjmo)
                                FROM DBP_DATA.sal_kmo
                                WHERE mandant_id = ${mandant_id}
                                GROUP BY 1)
AND TRIM(a.eigenmarke_id) = ''
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _kl_owg_umsatz_2 AS (
SELECT a.mandant_id,
       b.wg_id AS kl_owg_id,
       SUM(umsatz_netto+umsatz_mwst_betrag) AS umsatz_netto
FROM DBP_DATA.artbew_mo_sum a
JOIN DBP_DATA.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1)
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _nielsen_owg_umsatz AS (
SELECT mandant_id,
       kl_owg_id,
       SUM(umsatz__) AS umsatz___
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _nielsen_owg_umsatz_kl AS (
SELECT a.mandant_id,
       c.kl_owg_id,
       SUM(a.umsatz_brutto) AS umsatz_
FROM DBP_DATA.art_nielsen_fakten_kjmo a
JOIN (SELECT kjmo AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo
     WHERE kl_owg_id <> -3 AND
           mandant_id = ${mandant_id}
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 2
GROUP BY 1,2
);

UPDATE _artikel_anteil_uwg_potenzial_base 
SET anz_maerkte = b.anz_maerkte

FROM (SELECT *
      FROM _kl_owg_umsatz) b
WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_potenzial_base 
SET kl_markt_anteil_owg = b.anteil

FROM (SELECT a.mandant_id,
                                                       a.kl_owg_id,
                                                       CASE
                                                         WHEN ZEROIFNULL(CAST(a.umsatz_netto AS DECIMAL(18,4))/NULLIFZERO(CAST(b.umsatz___ AS DECIMAL(18,4))))*100.0000 > 100
                                                         THEN UNIFORM(85,100, RANDOM())
                                                         ELSE ZEROIFNULL(CAST(a.umsatz_netto AS DECIMAL(18,4))/NULLIFZERO(CAST(b.umsatz___ AS DECIMAL(18,4))))*100.0000
                                                       END AS anteil
                                                FROM _kl_owg_umsatz_2 a
                                                JOIN _nielsen_owg_umsatz b
                                                  ON a.kl_owg_id = b.kl_owg_id AND 
                                                     a.mandant_id = b.mandant_id) b
 WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = ${mandant_id}
;

CREATE OR REPLACE VOLATILE TABLE _nielsen_preise_1 AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       SUM(a.menge) AS menge,
       SUM(a.menge_af) AS menge_af,
       SUM(a.menge_sa) AS menge_sa,
       SUM(a.umsatz_brutto) AS umsatz_brutto,
       SUM(a.umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(a.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM DBP_DATA.art_nielsen_fakten_kjmo a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _nielsen_preise2 AS (
SELECT mandant_id,
       art_nielsen_id,
       umsatz_brutto/NULLIFZERO(menge) AS durchschnitt_preis_kasse
FROM _nielsen_preise_1
WHERE umsatz_brutto > 0 AND
      menge > 0
);

UPDATE _artikel_anteil_uwg_potenzial_base 
SET durchschnitt_preis = b.durchschnitt_preis_kasse

FROM (SELECT mandant_id,
                                                       art_nielsen_id,
                                                       durchschnitt_preis_kasse
                                                FROM _nielsen_preise2) b
WHERE _artikel_anteil_uwg_potenzial_base.art_nielsen_id = b.art_nielsen_id AND
      _artikel_anteil_uwg_potenzial_base.mandant_id = b.mandant_id
;

INSERT INTO DBP_ETL.sortiment_potenziale_kmo (mandant_id
                                                            ,art_matching_id
                                                            ,kjmo
                                                            ,art_nielsen_id
							    ,art_id
                                                            ,kl_wg_id
                                                            ,kl_owg_id
                                                            ,kl_uwg_id
                                                            ,rang_umsatz_wg
                                                            ,rang_umsatz_uwg
                                                            ,rang_absatz_uwg
                                                            ,art_nielsen_bez
                                                            ,gtin_id
                                                            ,distr_gew
                                                            ,umsatz_anteil_uwg
                                                            ,umsatz_anteil_uwg_kumuliert
                                                            ,durchschnitt_anz_maerkte
                                                            ,durchschnitt_preis
                                                            ,kl_markt_anteil_owg
                                                            ,umsatz_artikel
                                                            ,absatz_artikel
                                                            ,anz_monate
                                                            ,anz_wochen
                                                            ,eigenmarke_fg)
SELECT a.mandant_id,
       a.art_matching_id,
       d.kjmo_sort AS kjmo,
       a.art_nielsen_id,
       a.art_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       a.rang_umsatz_wg,
       a.rang_umsatz_uwg,
       a.rang_absatz_uwg,
       b.art_nielsen_bez,
       CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30)) AS gtin_id,
       a.distr_gew,
       a.umsatz_anteil_uwg,
       a.umsatz_anteil_kum_uwg AS umsatz_anteil_uwg_kumuliert,
       a.anz_maerkte AS durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.kl_markt_anteil_owg,
       a.umsatz_artikel,
       a.absatz_artikel,
       a.anz_monate,
       a.anz_wochen,
       0 AS eigenmarke_fg
FROM _artikel_anteil_uwg_potenzial_base a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT MAX(kjmo) AS max_kjmo
      FROM DBP_DATA.art_nielsen_fakten_kjmo
      WHERE mandant_id = ${mandant_id}) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM d
  ON c.max_kjmo = d.kjmo_sort
;

-- 18.01.2022, -dbay-
--
-- proper handling of duplicates

delete from dbp_etl_process.matching_art_nielsen_zu
where mandant_id = ${mandant_id} and
      kjwo_update in (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per where mandant_id = ${mandant_id})
;

insert into dbp_etl_process.matching_art_nielsen_zu
select mandant_id,
       kjwo_update,
       art_matching_id,
       art_nielsen_id,
       gtin_id
from dbp_etl.art_matching_nielsen_per_kmo
where (mandant_id,art_matching_id) in (SELECT mandant_id,
                                              art_matching_id
                                       FROM dbp_etl.sortiment_potenziale_kmo
                                       WHERE mandant_id = ${mandant_id}
                                       GROUP BY 1,2
                                       HAVING COUNT(*) > 1) and
       art_nielsen_id <> -1
group by 1,2,3,4,5
;

create or replace volatile table _sorti_agg as (
select mandant_id
,art_matching_id
,kjmo
,MAX(art_nielsen_id               ) art_nielsen_id             
,MAX(art_id                       ) art_id                     
,MAX(kl_wg_id                     ) kl_wg_id                   
,MAX(kl_owg_id                    ) kl_owg_id                  
,MAX(kl_uwg_id                    ) kl_uwg_id                  
,MAX(rang_umsatz_wg               ) rang_umsatz_wg             
,MAX(rang_umsatz_uwg              ) rang_umsatz_uwg            
,MAX(rang_absatz_uwg              ) rang_absatz_uwg            
,MAX(art_nielsen_bez              ) art_nielsen_bez            
,MAX(gtin_id                      ) gtin_id                    
,MAX(distr_gew                    ) distr_gew                  
,MAX(umsatz_anteil_uwg            ) umsatz_anteil_uwg          
,MAX(umsatz_anteil_uwg_kumuliert  ) umsatz_anteil_uwg_kumuliert
,MAX(durchschnitt_anz_maerkte     ) durchschnitt_anz_maerkte   
,MAX(durchschnitt_preis           ) durchschnitt_preis         
,MAX(kl_markt_anteil_owg          ) kl_markt_anteil_owg        
,MAX(umsatz_artikel               ) umsatz_artikel             
,MAX(absatz_artikel               ) absatz_artikel             
,MAX(anz_monate                   ) anz_monate                 
,MAX(anz_wochen                   ) anz_wochen                 
,MAX(eigenmarke_fg                ) eigenmarke_fg              
from dbp_etl.sortiment_potenziale_kmo
where (mandant_id,art_matching_id) in (select mandant_id,art_matching_id
                                       from dbp_etl_process.matching_art_nielsen_zu
                                       where mandant_id = ${mandant_id} and
                                             kjwo_update in (select max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per where mandant_id = ${mandant_id}))
group by 1,2,3
);

delete from dbp_etl.sortiment_potenziale_kmo
where (mandant_id,art_matching_id) in (select mandant_id,art_matching_id from _sorti_agg)
;

insert into dbp_etl.sortiment_potenziale_kmo
select a.*
from _sorti_agg a
;

DELETE FROM DBP_ETL.sortiment_potenziale_kmo_all where mandant_id = ${mandant_id} and kjwo_update = (select max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per where mandant_id = ${mandant_id}) ;

INSERT INTO DBP_ETL.sortiment_potenziale_kmo_all (mandant_id
                                                            ,art_matching_id
                                                            ,kjwo_update
                                                            ,kjmo
                                                            ,art_nielsen_id
							    ,art_id
                                                            ,kl_wg_id
                                                            ,kl_owg_id
                                                            ,kl_uwg_id
                                                            ,rang_umsatz_wg
                                                            ,rang_umsatz_uwg
                                                            ,rang_absatz_uwg
                                                            ,art_nielsen_bez
                                                            ,gtin_id
                                                            ,distr_gew
                                                            ,umsatz_anteil_uwg
                                                            ,umsatz_anteil_uwg_kumuliert
                                                            ,durchschnitt_anz_maerkte
                                                            ,durchschnitt_preis
                                                            ,kl_markt_anteil_owg
                                                            ,umsatz_artikel
                                                            ,absatz_artikel
                                                            ,anz_monate
                                                            ,anz_wochen
                                                            ,eigenmarke_fg)
SELECT
mandant_id
                                                            ,art_matching_id
                                                            ,(select max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per where mandant_id = ${mandant_id})
                                                            ,kjmo
                                                            ,art_nielsen_id
							    ,art_id
                                                            ,kl_wg_id
                                                            ,kl_owg_id
                                                            ,kl_uwg_id
                                                            ,rang_umsatz_wg
                                                            ,rang_umsatz_uwg
                                                            ,rang_absatz_uwg
                                                            ,art_nielsen_bez
                                                            ,gtin_id
                                                            ,distr_gew
                                                            ,umsatz_anteil_uwg
                                                            ,umsatz_anteil_uwg_kumuliert
                                                            ,durchschnitt_anz_maerkte
                                                            ,durchschnitt_preis
                                                            ,kl_markt_anteil_owg
                                                            ,umsatz_artikel
                                                            ,absatz_artikel
                                                            ,anz_monate
                                                            ,anz_wochen
                                                            ,eigenmarke_fg
FROM DBP_ETL.sortiment_potenziale_kmo ;

