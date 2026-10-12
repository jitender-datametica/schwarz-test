create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;

DELETE FROM DBP_DATA.sortiment_leistung
WHERE kl_owg_id NOT IN (SELECT wg_id
                        FROM DBP_DATA.wg_filter_zu
                        WHERE wg_filter_id = 11) AND
      wg_id NOT IN (146,147,185,186)
;

DELETE FROM DBP_DATA.sortiment_leistung
WHERE gtin IS NOT NULL AND
      art_id IS NULL AND
      umsatz_artikel = 0 AND
      absatz_artikel = 0 AND
     (umsatz_hr = 0 OR
      umsatz_hr IS NULL) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      wg_id NOT IN (146,147,185,186)
;

UPDATE DBP_DATA.sortiment_leistung 
SET art_bez = b.art_gruppe_bez

FROM (SELECT a.art_matching_id,
                                                MAX(c.art_gruppe_bez) AS art_gruppe_bez
                                         FROM DBP_ETL.art_matching_nielsen_per a
                                         JOIN DBP_DATA.art_gruppe_art_zu b
                                           ON a.art_id = b.art_id
                                         JOIN DBP_DATA.art_gruppe c
                                           ON b.art_gruppe_id = c.art_gruppe_id
                                         WHERE a.status = 'G'
                                         GROUP BY 1) b
 WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

DELETE FROM DBP_DATA.sortiment_leistung
WHERE art_id IN (SELECT art_id
                 FROM DBP_DATA.sortiment_leistung
                 WHERE art_id IS NOT NULL AND
                       mandant_id = 1 AND
                       kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                 GROUP BY 1
                 HAVING COUNT(*) > 1) AND
      gtin IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      wg_id NOT IN (146,147,185,186)
;

DELETE FROM DBP_DATA.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
                      FROM DBP_DATA.sortiment_leistung
                      WHERE mandant_id = 1 AND
                            kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                      GROUP BY 1
                      HAVING COUNT(*) > 1) AND
      gtin IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      wg_id NOT IN (146,147,185,186)
;

CREATE OR REPLACE VOLATILE TABLE _dups AS (
SELECT mandant_id,
       kjwo_update,
       matching_id,
       COUNT(*) AS anz
FROM DBP_DATA.sortiment_leistung
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
GROUP BY 1,2,3
HAVING COUNT(*) > 1
);

DELETE FROM DBP_DATA.sortiment_leistung
WHERE (mandant_id,kjwo_update,matching_id) IN (SELECT mandant_id,kjwo_update,matching_id FROM _dups) AND
       art_id IS NULL AND
       mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _dups1 AS (
SELECT mandant_id,
       kjwo_update,
       matching_id,
       COUNT(*) AS anz
FROM DBP_DATA.sortiment_leistung
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
GROUP BY 1,2,3
HAVING COUNT(*) > 1
);

DELETE FROM DBP_DATA.sortiment_leistung
WHERE (mandant_id,kjwo_update,matching_id) IN (SELECT mandant_id,kjwo_update,matching_id FROM _dups1) AND
       mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _summary_potentials AS (
SELECT mandant_id,
       kjwo_update,
       matching_id,
       gtin
FROM DBP_DATA.sortiment_leistung
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      art_id IS NULL AND
      gtin NOT IN (-9999,-9998)
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _summary_kl AS (
SELECT a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       b.gtin_id
FROM DBP_DATA.sortiment_leistung a
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.art_matching_id
WHERE a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      a.art_id IS NOT NULL
GROUP BY 1,2,3,4
);

DELETE FROM DBP_DATA.sortiment_leistung
WHERE (mandant_id,kjwo_update,matching_id,gtin) IN (SELECT mandant_id,kjwo_update,matching_id,gtin 
                                                    FROM _summary_potentials
                                                    WHERE (mandant_id,kjwo_update,Cast(gtin AS BIGINT)) IN (SELECT mandant_id,kjwo_update,gtin_id FROM _summary_kl)) AND
      wg_id NOT IN (146,147,185,186)
;

CREATE OR REPLACE VOLATILE TABLE _summary_potentials_1 AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       b.gtin_id
FROM DBP_DATA.art_nielsen_wug_zu_pflege a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.mandant_id = 1 AND
      b.gtin_id NOT IN (-9999,-9998)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _summary_kl_1 AS (
SELECT a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       b.gtin_id
FROM DBP_DATA.sortiment_leistung a
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.art_matching_id
WHERE a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      a.art_id IS NOT NULL
GROUP BY 1,2,3,4
);

DELETE FROM DBP_DATA.art_nielsen_wug_zu_pflege
WHERE (mandant_id,art_nielsen_id) IN (SELECT mandant_id,art_nielsen_id
                                      FROM _summary_potentials_1
                                      WHERE (mandant_id,gtin_id) IN (SELECT mandant_id,gtin_id FROM _summary_kl_1)) AND
      fb_pflege_wg_id NOT IN (146,147,185,186)
;

DELETE FROM DBP_DATA.sortiment_leistung
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
     (mandant_id,art_id) IN (SELECT mandant_id,art_id FROM DBP_DATA.art_gp_zu_per WHERE mandant_id = 1 AND gp_id = 5059720 AND dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank AS(
SELECT matching_id,
       kl_owg_id,
       rang_umsatz_uwg,
       rang_absatz_uwg,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_umsatz_uwg) AS rang_umsatz_uwg_,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_absatz_uwg) AS rang_absatz_uwg_
FROM DBP_DATA.sortiment_leistung
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE DBP_DATA.sortiment_leistung 
SET rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_

FROM (SELECT *
      FROM _upd_rank) b

WHERE DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND
      DBP_DATA.sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank_wg AS(
SELECT matching_id,
       kl_wg_id,
       rang_umsatz_wg,
       ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY rang_umsatz_wg) AS rang_umsatz_wg_
FROM DBP_DATA.sortiment_leistung
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE DBP_DATA.sortiment_leistung 
SET rang_umsatz_wg = b.rang_umsatz_wg_

FROM (SELECT *
      FROM _upd_rank_wg) b
WHERE DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       MAX(b.art_nielsen_id) AS art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       c.art_id,
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
             art_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6,7) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN DBP_DATA.sortiment_leistung zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
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
GROUP BY 1,3,4,5,6,7,8
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       c.art_id,
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
             art_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6,7) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN DBP_DATA.sortiment_leistung zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
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
GROUP BY 1,2,3,4,5,6,7,8
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

CREATE OR REPLACE VOLATILE TABLE _murks AS (
SELECT mandant_id,
       matching_id,
       gtin,
       kjwo_update,
       umsatz_artikel,
       kl_wg_id,
       kl_owg_id,
       kl_uwg_id,
       rang_umsatz_wg,
       rang_umsatz_uwg,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_gesamt,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_anteil_uwg,
       CAST(100 AS DECIMAL(18,4)) AS umsatz_anteil_kum_uwg
FROM DBP_DATA.sortiment_leistung
WHERE kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      mandant_id = 1 AND
      gtin IS NOT NULL
);

CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT kl_owg_id,
       kl_uwg_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

UPDATE _murks 
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = ROUND(CAST(_murks.umsatz_artikel AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,16)    
	
FROM (SELECT kl_owg_id,
                           kl_uwg_id,
                           umsatz
                    FROM _gesamt_uwg
                    GROUP BY 1,2,3) b
												 WHERE _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id
;

UPDATE _artikel_anteil_uwg_ranking 
SET umsatz_anteil_kum_uwg = ROUND(CAST(_artikel_anteil_uwg_ranking.umsatz__ AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,5)
	
FROM (SELECT kl_owg_id,
                                                kl_uwg_id,
                                                umsatz
                                         FROM _gesamt_uwg
                                         GROUP BY 1,2,3) b
												 WHERE _artikel_anteil_uwg_ranking.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_ranking.kl_owg_id = b.kl_owg_id
;

UPDATE _murks 
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

FROM (SELECT art_matching_id,
                           kl_owg_id,
                           kl_uwg_id,
                           SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY kl_owg_id,kl_uwg_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
                    FROM _artikel_anteil_uwg_ranking) b
												 WHERE _murks.matching_id = b.art_matching_id AND
      _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id
;

UPDATE DBP_DATA.sortiment_leistung 
SET umsatz_anteil_uwg = b.umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert = b.umsatz_anteil_kum_uwg

FROM (SELECT mandant_id,
                                                matching_id,
                                                kjwo_update,
                                                MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                                                MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg
                                         FROM _murks
                                         GROUP BY 1,2,3) b
 WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update AND
      DBP_DATA.sortiment_leistung.matching_id = b.matching_id
;

UPDATE DBP_DATA.sortiment_leistung SET ost_basis = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(ost_basis, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET ost_gross = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(ost_gross, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET sued_west = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(sued_west, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET sued_ost = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(sued_ost, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET west = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(west, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET nord = 'X'
WHERE mandant_id = 1 AND
      REGEXP_COUNT(nord, '^[0-9]+$') > 0
;

UPDATE DBP_DATA.sortiment_leistung SET bonreichweite_af = 0,
                                                     bonreichweite_sa = 0,
                                                     cherrypicker_quote = 0,
                                                     restbon = 0

WHERE mandant_id = 1 AND
     (absatz_total IS NULL OR
      absatz_total = 0) AND
     (restbon IS NOT NULL AND
      restbon <> 0) AND
      art_id IS NOT NULL
;

DELETE FROM DBP_ETL.not_listed_basis
WHERE art_matching_id IN (SELECT a.art_matching_id
                          FROM DBP_ETL.not_listed_basis a
                          JOIN (SELECT art_id,
                                       MIN(list_kz) AS list_kz
                                FROM DBP_ETL.art_matching_nielsen_per
                                GROUP BY 1) b
                            ON a.art_id = b.art_id
                          WHERE b.list_kz = 'A')
;

DELETE FROM DBP_ETL.not_listed_basis
WHERE art_id IN (SELECT art_id
                 FROM DBP_DATA.sortiment_leistung
                 WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
                       mandant_id = 1 AND
                       art_id IS NOT NULL AND
                       gtin IS NOT NULL AND
                     ((listung_sst_mvke <> 'N/A' AND
                       listung_sst_mvke IS NOT NULL) OR
                     ((listung_sst_mvke = 'N/A' OR
                       listung_sst_mvke IS NULL) AND
                       GREATEST(COALESCE(ost_basis,''),COALESCE(ost_gross,''),COALESCE(sued_ost,''),COALESCE(sued_west,''),COALESCE(west,''),COALESCE(nord,'')) = 'X')))
;

UPDATE DBP_DATA.sortiment_leistung SET listungsaktion = 'Keine Veränderung'
WHERE mandant_id = 1 AND 
      kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      gtin IN (-9999,-9998)
;

CREATE OR REPLACE VOLATILE TABLE _art_bez1 AS (
SELECT c.status,
       a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       CAST(a.art_bez AS VARCHAR(255)) AS art_bez_alt,
       CAST(b.art_bez AS VARCHAR(255)) AS art_bez_neu
FROM DBP_DATA.sortiment_leistung a
JOIN DBP_DATA.art_spr_zu b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.spr_id = 22
JOIN (SELECT art_matching_id,
             status
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2) c
  ON a.matching_id = c.art_matching_id
WHERE ((a.art_bez <> b.art_bez) OR
       (a.art_bez IS NULL AND
        b.art_bez IS NOT NULL)) AND
        a.mandant_id = 1 AND
        a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
        c.status <> 'G'
);

INSERT INTO _art_bez1 (status
                      ,mandant_id
                      ,kjwo_update
                      ,matching_id
                      ,art_bez_alt
                      ,art_bez_neu)
SELECT 'G' AS status,
       a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       a.art_bez AS art_bez_alt,
       c.art_gruppe_bez AS art_bez_neu
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT a.art_matching_id,
             Max(c.art_gruppe_bez) AS art_gruppe_bez
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN DBP_DATA.art_gruppe_art_zu b
        ON a.art_id = b.art_id
      JOIN DBP_DATA.art_gruppe c
        ON b.art_gruppe_id = c.art_gruppe_id
      WHERE a.status = 'G'
      GROUP BY 1) c
  ON a.matching_id = c.art_matching_id
WHERE ((a.art_bez <> c.art_gruppe_bez) OR
       (a.art_bez IS NULL AND
        c.art_gruppe_bez IS NOT NULL)) AND
        a.mandant_id = 1 AND
        a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET art_bez = b.art_bez_neu

FROM (SELECT mandant_id,
             kjwo_update,
             matching_id,
             max(art_bez_alt) as art_bez_alt,
             max(art_bez_neu) as art_bez_neu
      FROM _art_bez1
      group by 1,2,3) b
 WHERE DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update AND
      COALESCE(DBP_DATA.sortiment_leistung.art_bez,'murks') = COALESCE(b.art_bez_alt,'murks')
;



