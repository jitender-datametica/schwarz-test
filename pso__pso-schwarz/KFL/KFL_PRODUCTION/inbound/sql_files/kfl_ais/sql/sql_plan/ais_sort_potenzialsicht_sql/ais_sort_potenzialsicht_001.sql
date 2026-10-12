create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;

create or replace volatile table _sort_matching_copy as (
select a.*,
       '-' as potential_article
from dbp_etl.art_matching_nielsen_per a
);

update _sort_matching_copy from (select mandant_id,
                                        art_matching_id
                                 from dbp_etl.art_matching_nielsen_per
                                 group by 1,2
                                 having count(distinct case when art_id = -1 then null else art_id end) = 0) b

set potential_article = 'x' 

where _sort_matching_copy.mandant_id = b.mandant_id and
      _sort_matching_copy.art_matching_id = b.art_matching_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.sortiment_potenziale;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.sortiment_potenziale  (
      art_matching_id INTEGER,
      kjmo INTEGER,
      art_nielsen_id INTEGER,
      art_id INTEGER,
      kl_art_id VARCHAR(300),
      kl_wg_id INTEGER,
      kl_owg_id INTEGER,
      kl_uwg_id INTEGER,
      rang_umsatz_wg INTEGER,
      rang_umsatz_uwg INTEGER,
      rang_absatz_uwg INTEGER,
      art_nielsen_bez VARCHAR(300) COLLATE 'en-ci',
      gtin_id VARCHAR(300) COLLATE 'en-ci',
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

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       MAX(b.art_nielsen_id) AS art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjwo) AS anz,
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
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id NOT IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,3,4,5,6,7
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjwo) AS anz,
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
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_matching_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id IN (-9999,-9998) AND
      a.mandant_id = 1
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
       CAST(NULL AS VARCHAR(300)) AS kl_art_id,
       CAST(c.list_kz AS VARCHAR(4)) AS list_kz,
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
             ' ' AS list_kz,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM _sort_matching_copy
      WHERE potential_article = 'x'
      GROUP BY 1,2,3,4,5,6,7,8) c
  ON a.art_nielsen_id = c.art_nielsen_id AND
     a.mandant_id = c.mandant_id
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
);

INSERT INTO _artikel_anteil_uwg_potenzial_base
SELECT a.mandant_id,
       c.art_matching_id,
       MAX(a.art_nielsen_id) AS art_nielsen_id,
       MAX(c.art_id) AS art_id,
       REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(c.kl_art_id AS VARCHAR(600)),8,'0') as int) as varchar(8)),8,'0'), ',') within group (ORDER BY c.kl_art_id) ), ','),' ', '') AS kl_art_id,
       MAX(TRIM(c.list_kz)) AS list_kz,
       MAX(c.kl_wg_id) AS kl_wg_id,
       MAX(c.kl_owg_id) AS kl_owg_id,
       MAX(c.kl_uwg_id) AS kl_uwg_id,
       MAX(a.gtin_id) AS gtin_id,
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
JOIN (SELECT a.mandant_id,
             a.art_matching_id,
             a.art_nielsen_id,
             a.art_id,
             floor(a.art_id/100) as kl_art_id,
             b.list_kz,
             a.kl_wg_id,
             a.kl_owg_id,
             a.kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN DBP_ETL.not_listed_basis b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.gtin_id = b.gtin_id
      WHERE a.status NOT IN ('G') AND
            a.kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6,7,8,9) c
  ON a.art_nielsen_id = c.art_nielsen_id AND
     a.mandant_id = c.mandant_id
WHERE a.mandant_id = 1 and
     (a.mandant_id,c.art_matching_id) not in (select mandant_id,art_matching_id from _artikel_anteil_uwg_potenzial_base)
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_wg_ranking AS (
SELECT art_matching_id,
       MIN(kl_wg_id) AS kl_wg_id_,
       SUM(umsatz__) AS umsatz___,
       DENSE_RANK() OVER (PARTITION BY kl_wg_id_ ORDER BY umsatz___ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking
GROUP BY 1
);

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

WHERE _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_potenzial_base.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
      FROM _artikel_anteil_wg_ranking) b

WHERE _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_ranking 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
      FROM _artikel_anteil_wg_ranking) b

WHERE _artikel_anteil_uwg_ranking.art_matching_id = b.art_matching_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
             MAX(rang_umsatz_wg) AS next_rang_ums_wg,
             MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
             MAX(rang_absatz_uwg) AS next_rang_abs_uwg
      FROM _artikel_anteil_uwg_ranking
      GROUP BY 1) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT kl_wg_id,
             MAX(rang_umsatz_wg)+1 AS next_rang_ums_wg
      FROM _artikel_anteil_uwg_ranking
      GROUP BY 1) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_wg_id = b.kl_wg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
             COALESCE(MAX(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
             COALESCE(MAX(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
      FROM _artikel_anteil_uwg_potenzial_base a
      WHERE a.rang_umsatz_uwg IS NULL
      GROUP BY 1) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT kl_wg_id,
             MAX(COALESCE(rang_umsatz_wg,0))+1 AS next_rang_ums_wg
      FROM _artikel_anteil_uwg_potenzial_base
      GROUP BY 1) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_wg_id = b.kl_wg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_wg IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
             MAX(COALESCE(rang_umsatz_uwg,0))+1 AS next_rang_ums_uwg,
             MAX(COALESCE(rang_absatz_uwg,0))+1 AS next_rang_abs_uwg
      FROM _artikel_anteil_uwg_potenzial_base
      GROUP BY 1) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_potenzial_base.rang_umsatz_uwg IS NULL AND
      _artikel_anteil_uwg_potenzial_base.rang_absatz_uwg IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT kl_owg_id,
       kl_uwg_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = _artikel_anteil_uwg_potenzial_base.umsatz_artikel/NULLIFZERO(b.umsatz)*100.00    
	
FROM (SELECT kl_owg_id,
             kl_uwg_id,
             umsatz
      FROM _gesamt_uwg
      GROUP BY 1,2,3) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_ranking 
SET umsatz_anteil_kum_uwg = _artikel_anteil_uwg_ranking.umsatz__/NULLIFZERO(b.umsatz)*100.00    
	
FROM (SELECT kl_owg_id,
             kl_uwg_id,
             umsatz
      FROM _gesamt_uwg
      GROUP BY 1,2,3) b

WHERE _artikel_anteil_uwg_ranking.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_ranking.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

FROM (SELECT art_matching_id,
             kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY kl_owg_id,kl_uwg_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
      FROM _artikel_anteil_uwg_ranking) b

WHERE _artikel_anteil_uwg_potenzial_base.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_potenzial_base.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _kl_owg_umsatz AS (
SELECT kl_owg_id,
       SUM(total_umsatz_netto) AS ums_netto,
       SUM(anz_listung_as_is) AS anz_listung,
       SUM(total_umsatz_netto*anz_listung_as_is) AS gew_netto,
       gew_netto/ums_netto AS anz_maerkte
FROM DBP_ETL.bf_sort_sal_export a
JOIN (SELECT art_id,
             kl_owg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2) b
  ON CAST(a.art_nr AS INTEGER) = floor(b.art_id/100)
GROUP BY 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _nielsen_owg_umsatz AS (
SELECT kl_owg_id,
       SUM(umsatz__) AS umsatz___
FROM _artikel_anteil_uwg_ranking
GROUP BY 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _nielsen_owg_umsatz_kl AS (
SELECT c.kl_owg_id,
       SUM(a.umsatz_brutto) AS umsatz_
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id = 1
GROUP BY 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET anz_maerkte = b.anz_maerkte

FROM (SELECT *
      FROM _kl_owg_umsatz) b

WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET kl_markt_anteil_owg = b.anteil

FROM (SELECT a.kl_owg_id,
             ZEROIFNULL(CAST(umsatz_ AS DECIMAL(18,4))/CAST(b.umsatz___ AS DECIMAL(18,4))*100) AS anteil
      FROM _nielsen_owg_umsatz_kl a
      JOIN _nielsen_owg_umsatz b
        ON a.kl_owg_id = b.kl_owg_id) b
 WHERE _artikel_anteil_uwg_potenzial_base.kl_owg_id = b.kl_owg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _nielsen_preise_1 AS (
SELECT b.art_nielsen_id,
       SUM(a.menge) AS menge,
       SUM(a.menge_af) AS menge_af,
       SUM(a.menge_sa) AS menge_sa,
       SUM(a.umsatz_brutto) AS umsatz_brutto,
       SUM(a.umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(a.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _nielsen_preise2 AS (
SELECT art_nielsen_id,
       CASE
         WHEN umsatz_brutto_af > 0
         THEN umsatz_brutto_af/NULLIFZERO(menge_af)
         WHEN umsatz_brutto_af = 0 AND umsatz_brutto_sa > 0
         THEN umsatz_brutto_sa/NULLIFZERO(menge_sa)
         ELSE 0
       END AS durchschnitt_preis_kasse
FROM _nielsen_preise_1
WHERE umsatz_brutto > 0 AND
      menge > 0
);

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE _artikel_anteil_uwg_potenzial_base 
SET durchschnitt_preis = b.durchschnitt_preis_kasse

FROM (SELECT art_nielsen_id,
             durchschnitt_preis_kasse
      FROM _nielsen_preise2) b

WHERE _artikel_anteil_uwg_potenzial_base.art_nielsen_id = b.art_nielsen_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.sortiment_potenziale (art_matching_id
                                                        ,kjmo
                                                        ,art_nielsen_id
                                                        ,art_id
                                                        ,kl_art_id
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
SELECT a.art_matching_id,
       d.kjmo_sort AS kjmo,
       a.art_nielsen_id,
       a.art_id,
       a.kl_art_id,
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
       CASE
         WHEN a.gtin_id IN (-9999,-9998)
         THEN 1
         ELSE 0
       END AS eigenmarke_fg
FROM _artikel_anteil_uwg_potenzial_base a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT MAX(kjwo) AS max_kjwo
      FROM DBP_DATA.art_nielsen_fakten_kjwo
	  WHERE mandant_id = 1) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM d
  ON c.max_kjwo = d.kjwo_bis
;

-- 18.01.2022, -dbay-
--
-- proper handling of duplicates

delete from dbp_etl_process.matching_art_nielsen_zu
where mandant_id = 1 and
      kjwo_update in (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per where mandant_id = 1)
;

insert into dbp_etl_process.matching_art_nielsen_zu
select mandant_id,
       kjwo_update,
       art_matching_id,
       art_nielsen_id,
       gtin_id
from dbp_etl.art_matching_nielsen_per
where (art_matching_id) in (SELECT art_matching_id
                            FROM dbp_etl.sortiment_potenziale
                            WHERE mandant_id = 1
                            GROUP BY 1
                            HAVING COUNT(*) > 1) and
       art_nielsen_id <> -1
group by 1,2,3,4,5
;

create or replace volatile table _sorti_agg as (
select art_matching_id
,kjmo
,max(art_nielsen_id              ) art_nielsen_id             
,max(art_id                      ) art_id                     
,max(kl_art_id                   ) kl_art_id                  
,max(kl_wg_id                    ) kl_wg_id                   
,max(kl_owg_id                   ) kl_owg_id                  
,max(kl_uwg_id                   ) kl_uwg_id                  
,max(rang_umsatz_wg              ) rang_umsatz_wg             
,max(rang_umsatz_uwg             ) rang_umsatz_uwg            
,max(rang_absatz_uwg             ) rang_absatz_uwg            
,max(art_nielsen_bez             ) art_nielsen_bez            
,max(gtin_id                     ) gtin_id                    
,max(distr_gew                   ) distr_gew                  
,max(umsatz_anteil_uwg           ) umsatz_anteil_uwg          
,max(umsatz_anteil_uwg_kumuliert ) umsatz_anteil_uwg_kumuliert
,max(durchschnitt_anz_maerkte    ) durchschnitt_anz_maerkte   
,max(durchschnitt_preis          ) durchschnitt_preis         
,max(kl_markt_anteil_owg         ) kl_markt_anteil_owg        
,max(umsatz_artikel              ) umsatz_artikel             
,max(absatz_artikel              ) absatz_artikel             
,max(anz_monate                  ) anz_monate                 
,max(anz_wochen                  ) anz_wochen                 
,max(eigenmarke_fg               ) eigenmarke_fg             
from dbp_etl.sortiment_potenziale
where (art_matching_id) in (select art_matching_id
                            from dbp_etl_process.matching_art_nielsen_zu
                            where mandant_id = 1 and
                                  kjwo_update in (select max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per where mandant_id = 1))
group by 1,2
);

delete from dbp_etl.sortiment_potenziale
where (art_matching_id) in (select art_matching_id from _sorti_agg)
;

insert into dbp_etl.sortiment_potenziale
select a.*
from _sorti_agg a
;
