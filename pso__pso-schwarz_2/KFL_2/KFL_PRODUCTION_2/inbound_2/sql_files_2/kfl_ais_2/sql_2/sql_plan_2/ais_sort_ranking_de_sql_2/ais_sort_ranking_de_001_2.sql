create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       Count(DISTINCT x.kjwo) AS anz,
       Sum(a.distr_gew)/anz AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.menge_af) AS menge_af_,
       Sum(a.umsatz_brutto_af) AS umsatz_af_,
       Sum(a.menge_sa) AS menge_sa_,
       Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             Min(kjmo) AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             gtin_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5,6) c
  ON b.gtin_id = c.gtin_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              Rank() Over (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id NOT IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       Count(DISTINCT x.kjwo) AS anz,
       Sum(a.distr_gew)/anz AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.menge_af) AS menge_af_,
       Sum(a.umsatz_brutto_af) AS umsatz_af_,
       Sum(a.menge_sa) AS menge_sa_,
       Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             Min(kjmo) AS kjmo
      FROM dbp_data.tag_2
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
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              Rank() Over (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Max(a.anz) AS anz,
       Sum(a.distr_gew_) AS distr_gew_,
       Sum(a.menge_) AS menge__,
       Sum(a.umsatz_) AS umsatz__,
       Sum(a.menge_af_) AS menge_af_,
       Sum(a.umsatz_af_) AS umsatz_af_,
       Sum(a.menge_sa_) AS menge_sa_,
       Sum(a.umsatz_sa_) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Rank() Over (PARTITION BY a.kl_wg_id,a.kl_owg_id ORDER BY a.kl_wg_id,a.kl_owg_id,umsatz__ DESC) AS rang_umsatz_uwg,
       Rank() Over (PARTITION BY a.kl_wg_id,a.kl_owg_id ORDER BY a.kl_wg_id,a.kl_owg_id,menge__ DESC) AS rang_absatz_uwg,
       Rank() Over (PARTITION BY a.kl_wg_id  ORDER BY a.kl_wg_id,umsatz__ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking_1st_base a
GROUP BY 1,2,3,4,5
);

UPDATE dbp_data.sortiment_leistung_2 SET rang_umsatz_wg  = NULL,
                                       rang_umsatz_uwg = NULL,
                                       rang_absatz_uwg = NULL
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT a.*
                                         FROM _artikel_anteil_uwg_ranking a
                                         JOIN (SELECT mandant_id,
                                                      art_matching_id
                                               FROM _artikel_anteil_uwg_ranking
                                               GROUP BY 1,2
                                               HAVING Count(*) = 1) b
                                           ON a.mandant_id = b.mandant_id AND
                                              a.art_matching_id = b.art_matching_id) b
                                                     
SET rang_umsatz_wg  = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg
    
WHERE dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.matching_id = b.art_matching_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank AS(
SELECT matching_id,
       kl_owg_id,
       rang_umsatz_uwg,
       rang_absatz_uwg,
       Row_Number() Over (PARTITION BY kl_owg_id ORDER BY kl_owg_id,rang_umsatz_uwg) AS rang_umsatz_uwg_,
       Row_Number() Over (PARTITION BY kl_owg_id ORDER BY kl_owg_id,rang_absatz_uwg) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1 AND
      rang_umsatz_uwg IS NOT NULL
);

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT *
                                         FROM _upd_rank) b
										 
SET rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_

WHERE dbp_data.sortiment_leistung.kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND
      dbp_data.sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank_wg AS (
SELECT matching_id,
       kl_wg_id,
       rang_umsatz_wg,
       Row_Number() Over (PARTITION BY kl_wg_id ORDER BY kl_wg_id,rang_umsatz_wg) AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1 AND
      rang_umsatz_wg IS NOT NULL
);

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT *
                                         FROM _upd_rank_wg) b
										 
SET rang_umsatz_wg = b.rang_umsatz_wg_

WHERE dbp_data.sortiment_leistung.kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT kl_owg_id,
                                                Max(rang_umsatz_uwg)+1 AS next_rang_ums_uwg,
                                                Max(rang_absatz_uwg)+1 AS next_rang_abs_uwg
                                         FROM dbp_data.sortiment_leistung_2
                                         WHERE rang_umsatz_uwg IS NOT NULL AND
                                               mandant_id = 1 AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1) b
												
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

WHERE dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.rang_absatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT kl_wg_id,
                                                Max(rang_umsatz_wg)+1 AS next_rang_ums_wg
                                         FROM dbp_data.sortiment_leistung_2
                                         WHERE rang_umsatz_wg IS NOT NULL AND
                                               mandant_id = 1 AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1) b
												
SET rang_umsatz_wg = b.next_rang_ums_wg

WHERE dbp_data.sortiment_leistung.kl_wg_id = b.kl_wg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT owg_id,
                                                COALESCE(MAX(rang_umsatz_wg),0)+1 AS next_rang_ums_wg
                                         FROM dbp_data.sortiment_leistung_2
                                         WHERE mandant_id = 1 AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1) b
												
SET rang_umsatz_wg = b.next_rang_ums_wg

WHERE dbp_data.sortiment_leistung.owg_id = b.owg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT wg_id,
                                                COALESCE(MAX(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
                                                COALESCE(MAX(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
                                         FROM dbp_data.sortiment_leistung_2
                                         WHERE mandant_id = 1 AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1) b
												
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

WHERE dbp_data.sortiment_leistung.wg_id = b.wg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_kl AS (
SELECT b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       COUNT(DISTINCT a.kjwo) AS anz_wochen,
       SUM(a.distr_gew)/anz_wochen AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.anz_maerkte) AS anz_maerkte,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_2
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
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id 
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
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_x AS (
SELECT b.art_nielsen_id,
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
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_2
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
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
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
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_owg_1 AS (
SELECT a.kl_owg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
      (ZEROIFNULL(umsatz_kl_x/NULLIFZERO(umsatz_x))) * 100.00 AS marktanteil_owg
FROM (SELECT kl_owg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1) a
JOIN (SELECT kl_owg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_uwg_1 AS (
SELECT a.kl_owg_id,
       a.kl_uwg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
      (ZEROIFNULL(umsatz_kl_x/NULLIFZERO(umsatz_x))) * 100.00 AS marktanteil_uwg
FROM (SELECT kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1,2) a
JOIN (SELECT kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id
GROUP BY 1,2
);

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT b.kl_owg_id,
                                                b.kl_uwg_id,
                                                a.marktanteil_owg,
                                                b.marktanteil_uwg,
												zeroifnull(b.marktanteil_uwg/nullifzero(a.marktanteil_owg)) AS indexpunkt
                                         FROM _kl_ma_owg_1 a
                                         JOIN _kl_ma_uwg_1 b
                                           ON a.kl_owg_id = b.kl_owg_id) b

SET marktanteilbewertung = b.indexpunkt

WHERE dbp_data.sortiment_leistung.kl_uwg_id = b.kl_uwg_id AND
      dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.mandant_id = 1 AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fix_it AS (
SELECT mandant_id,
       wg_id,
       wug_id,
       COUNT(DISTINCT marktanteilbewertung) AS anz
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      marktanteilbewertung IS NOT NULL AND
      mandant_id = 1
GROUP BY 1,2,3
HAVING anz > 1
);

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT a.mandant_id,
                                                a.wg_id,
                                                a.wug_id,
                                                MAX(a.marktanteilbewertung) AS marktanteilbewertung
                                         FROM dbp_data.sortiment_leistung_2 a
                                         JOIN _fix_it b
                                           ON a.mandant_id = b.mandant_id AND
                                              a.wg_id = b.wg_id AND
                                              a.wug_id = b.wug_id
                                         GROUP BY 1,2,3) b
                                         
SET marktanteilbewertung = b.marktanteilbewertung

WHERE dbp_data.sortiment_leistung.wug_id = b.wug_id AND
      dbp_data.sortiment_leistung.wg_id = b.wg_id AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT a.mandant_id,
                                                a.kjwo_update,
                                                a.wg_id,
                                                a.wug_id,
                                                MAX(COALESCE(a.marktanteilbewertung,0)) AS marktanteilbewertung
                                         FROM dbp_data.sortiment_leistung_2 a
                                         WHERE a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
                                               a.mandant_id = 1
                                         GROUP BY 1,2,3,4) b
                                         
SET marktanteilbewertung = b.marktanteilbewertung

WHERE dbp_data.sortiment_leistung.wug_id = b.wug_id AND
      dbp_data.sortiment_leistung.wg_id = b.wg_id AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kjwo_update = b.kjwo_update
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       Count(DISTINCT x.kjwo) AS anz,
       Sum(a.distr_gew)/anz AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.menge_af) AS menge_af_,
       Sum(a.umsatz_brutto_af) AS umsatz_af_,
       Sum(a.menge_sa) AS menge_sa_,
       Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             Min(kjmo) AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             gtin_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5,6) c
  ON b.gtin_id = c.gtin_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              Rank() Over (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id NOT IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       Count(DISTINCT x.kjwo) AS anz,
       Sum(a.distr_gew)/anz AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.menge_af) AS menge_af_,
       Sum(a.umsatz_brutto_af) AS umsatz_af_,
       Sum(a.menge_sa) AS menge_sa_,
       Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       Rank() Over (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             Min(kjmo) AS kjmo
      FROM dbp_data.tag_2
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
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              Rank() Over (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Max(a.anz) AS anz,
       Sum(a.distr_gew_) AS distr_gew_,
       Sum(a.menge_) AS menge__,
       Sum(a.umsatz_) AS umsatz__,
       Sum(a.menge_af_) AS menge_af_,
       Sum(a.umsatz_af_) AS umsatz_af_,
       Sum(a.menge_sa_) AS menge_sa_,
       Sum(a.umsatz_sa_) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Dense_Rank() Over (PARTITION BY a.kl_owg_id ORDER BY umsatz__ DESC) AS rang_umsatz_uwg,
       Dense_Rank() Over (PARTITION BY a.kl_owg_id ORDER BY menge__ DESC) AS rang_absatz_uwg,
       Cast(0 AS INTEGER) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking_1st_base a
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,matching_id FROM dbp_data.sortiment_leistung_2 
                                       WHERE mandant_id = 1 AND 
                                             kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1))
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _murks_2 AS (
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
       Cast(0 AS DECIMAL(18,4)) AS umsatz_gesamt,
       Cast(0 AS DECIMAL(18,4)) AS umsatz_anteil_uwg,
       Cast(100 AS DECIMAL(18,4)) AS umsatz_anteil_kum_uwg
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE _murks_2 FROM (SELECT mandant_id,
                           art_matching_id,
                           Sum(umsatz__) AS umsatz_artikel
                    FROM _artikel_anteil_uwg_ranking
                    GROUP BY 1,2) b
                    
SET umsatz_artikel = b.umsatz_artikel

WHERE _murks.mandant_id = b.mandant_id AND
      _murks.matching_id = b.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT kl_owg_id,
       kl_uwg_id,
       Sum(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

UPDATE _murks_2 FROM (SELECT kl_owg_id,
                           kl_uwg_id,
                           umsatz
                    FROM _gesamt_uwg
                    GROUP BY 1,2,3) b
												
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = Round(Cast(_murks.umsatz_artikel AS FLOAT)/NullIfZero(Cast(b.umsatz AS FLOAT))*100.00,16)    
	
WHERE _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id
;

UPDATE _artikel_anteil_uwg_ranking FROM (SELECT kl_owg_id,
                                                kl_uwg_id,
                                                umsatz
                                         FROM _gesamt_uwg
                                         GROUP BY 1,2,3) b
												
SET umsatz_anteil_kum_uwg = Round(Cast(_artikel_anteil_uwg_ranking.umsatz__ AS FLOAT)/NullIfZero(Cast(b.umsatz AS FLOAT))*100.00,5)
	
WHERE _artikel_anteil_uwg_ranking.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_ranking.kl_owg_id = b.kl_owg_id
;

UPDATE _murks_2 FROM (SELECT art_matching_id,
                           kl_owg_id,
                           kl_uwg_id,
                           Sum(umsatz_anteil_kum_uwg) Over (PARTITION BY kl_owg_id,kl_uwg_id ORDER BY rang_umsatz_uwg ROWS Unbounded Preceding) AS umsatz_anteil_kum   
                    FROM _artikel_anteil_uwg_ranking) b
												
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

WHERE _murks.matching_id = b.art_matching_id AND
      _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id
;

UPDATE dbp_data.sortiment_leistung_2 FROM (SELECT mandant_id,
                                                matching_id,
                                                kjwo_update,
                                                Max(umsatz_artikel) AS umsatz_artikel,
                                                Max(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                                                Max(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg
                                         FROM _murks_2
                                         GROUP BY 1,2,3) b

SET umsatz_artikel = b.umsatz_artikel,
    umsatz_anteil_uwg = b.umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert = b.umsatz_anteil_kum_uwg

WHERE dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kjwo_update = b.kjwo_update AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id
;
