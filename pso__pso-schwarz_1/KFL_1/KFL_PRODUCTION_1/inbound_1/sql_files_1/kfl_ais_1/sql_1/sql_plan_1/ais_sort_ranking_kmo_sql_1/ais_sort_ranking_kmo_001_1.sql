create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_1 where DAT_BIS='9999-12-31'
) ;


CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id,c.kl_owg_id ORDER BY a.mandant_id,c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id,c.kl_owg_id ORDER BY a.mandant_id,c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id  ORDER BY a.mandant_id,c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a

JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjmo = x.kjmo

JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id

JOIN (SELECT mandant_id,
             gtin_id,
             art_matching_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3 AND
            mandant_id = ${mandant_id} 
      GROUP BY 1,2,3,4,5,6,7) c
  ON b.gtin_id = c.gtin_id AND
     b.mandant_id = c.mandant_id AND b.art_nielsen_id = c.art_nielsen_id

JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id

WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      b.gtin_id NOT IN (-9999,-9998) AND
      d.nielsen_market_cluster_id = ${nielsen_market_id}
GROUP BY 1,2,3,4,5
);

INSERT INTO _artikel_anteil_uwg_ranking
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id,c.kl_owg_id ORDER BY a.mandant_id,c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id,c.kl_owg_id ORDER BY a.mandant_id,c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       RANK() OVER (PARTITION BY a.mandant_id,c.kl_wg_id  ORDER BY a.mandant_id,c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a

JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
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
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3 AND
            mandant_id = ${mandant_id}
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id

JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id

WHERE a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = ${nielsen_market_id} AND
      b.gtin_id IN (-9999,-9998)
      
GROUP BY 1,2,3,4,5
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking2 AS (
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
       RANK() OVER (PARTITION BY a.kl_wg_id,a.kl_owg_id ORDER BY a.kl_wg_id,a.kl_owg_id,umsatz__ DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY a.kl_wg_id,a.kl_owg_id ORDER BY a.kl_wg_id,a.kl_owg_id,menge__ DESC) AS rang_absatz_uwg,
       RANK() OVER (PARTITION BY a.kl_wg_id  ORDER BY a.kl_wg_id,umsatz__ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking a
GROUP BY 1,2,3,4,5
);

UPDATE dbp_data.sortiment_leistung_1 SET rang_umsatz_wg  = NULL,
                                       rang_umsatz_uwg = NULL,
                                       rang_absatz_uwg = NULL
WHERE mandant_id = ${mandant_id} AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT a.*
                                         FROM _artikel_anteil_uwg_ranking2 a
                                         JOIN (SELECT mandant_id,
                                                      art_matching_id
                                               FROM _artikel_anteil_uwg_ranking2
                                               GROUP BY 1,2
                                               HAVING COUNT(*) = 1) b
                                           ON a.mandant_id = b.mandant_id AND
                                              a.art_matching_id = b.art_matching_id) b
                                                     
SET rang_umsatz_wg  = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg
    
WHERE dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.matching_id = b.art_matching_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank AS(
SELECT matching_id,
       kl_owg_id,
       rang_umsatz_uwg,
       rang_absatz_uwg,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY kl_owg_id,rang_umsatz_uwg) AS rang_umsatz_uwg_,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY kl_owg_id,rang_absatz_uwg) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung_1
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
      rang_umsatz_uwg IS NOT NULL
);

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT *
                                         FROM _upd_rank) b
										 
SET rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_

WHERE dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND
      dbp_data.sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank_wg AS (
SELECT matching_id,
       kl_wg_id,
       rang_umsatz_wg,
       ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY kl_wg_id,rang_umsatz_wg) AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung_1
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
      rang_umsatz_wg IS NOT NULL
);

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT *
                                         FROM _upd_rank_wg) b
										 
SET rang_umsatz_wg = b.rang_umsatz_wg_

WHERE dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT kl_owg_id,
                                                MAX(rang_umsatz_uwg)+1 AS next_rang_ums_uwg,
                                                MAX(rang_absatz_uwg)+1 AS next_rang_abs_uwg
                                         FROM dbp_data.sortiment_leistung_1
                                         WHERE rang_umsatz_uwg IS NOT NULL AND
                                               mandant_id = ${mandant_id} AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
                                         GROUP BY 1) b
												
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

WHERE dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.rang_absatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT kl_wg_id,
                                                MAX(rang_umsatz_wg)+1 AS next_rang_ums_wg
                                         FROM dbp_data.sortiment_leistung_1
                                         WHERE rang_umsatz_wg IS NOT NULL AND
                                               mandant_id = ${mandant_id} AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
                                         GROUP BY 1) b
												
SET rang_umsatz_wg = b.next_rang_ums_wg

WHERE dbp_data.sortiment_leistung.kl_wg_id = b.kl_wg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT kl_owg_id,
                                                COALESCE(MAX(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
                                                COALESCE(MAX(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
                                         FROM dbp_data.sortiment_leistung_1
                                         WHERE mandant_id = ${mandant_id} AND
                                               kl_owg_id IN (SELECT x.kl_owg_id
                                                             FROM (SELECT kl_owg_id,
                                                                          MAX(CASE
                                                                                WHEN rang_umsatz_uwg IS NULL
                                                                                THEN 1
                                                                                ELSE 2
                                                                              END) AS rang_xxx
                                                                   FROM dbp_data.sortiment_leistung_1
                                                                   WHERE mandant_id = ${mandant_id} AND
                                                                         kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
                                                                   GROUP BY 1
                                                                   HAVING rang_xxx = 1) x
                                                             GROUP BY 1) AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
                                         GROUP BY 1) b
												
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

WHERE dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT kl_wg_id,
                                                COALESCE(MAX(rang_umsatz_wg),0)+1 AS next_rang_ums_wg
                                         FROM dbp_data.sortiment_leistung_1
                                         WHERE mandant_id = ${mandant_id} AND
                                               kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
                                         GROUP BY 1) b
												
SET rang_umsatz_wg = b.next_rang_ums_wg

WHERE dbp_data.sortiment_leistung.kl_wg_id = b.kl_wg_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg IS NULL AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_kl AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       COUNT(DISTINCT a.kjmo) AS anz_wochen,
       SUM(a.distr_gew)/anz_wochen AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.anz_maerkte) AS anz_maerkte,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
	  FROM dbp_data.tag_1
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
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = ${nielsen_market_id} AND
      a.mandant_id = ${mandant_id}
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_x AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
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
	   DENSE_RANK() OVER (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
	   DENSE_RANK() OVER (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
	   CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
	  FROM dbp_data.tag_1
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
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = ${mandant_id}
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_owg_1 AS (
SELECT a.mandant_id,
       a.kl_owg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
       ZEROIFNULL((umsatz_kl_x/NULLIFZERO(umsatz_x))) * 100.00 AS marktanteil_owg
FROM (SELECT mandant_id,
             kl_owg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1,2) a
JOIN (SELECT mandant_id,
             kl_owg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_uwg_1 AS (
SELECT a.mandant_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
       ZEROIFNULL((umsatz_kl_x/NULLIFZERO(umsatz_x))) * 100.00 AS marktanteil_uwg
FROM (SELECT mandant_id,
             kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1,2,3) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT a.mandant_id,
                                                b.kl_owg_id,
                                                b.kl_uwg_id,
                                                a.marktanteil_owg,
                                                b.marktanteil_uwg,
                                                ZEROIFNULL(b.marktanteil_uwg/NULLIFZERO(a.marktanteil_owg)) AS indexpunkt
                                         FROM _kl_ma_owg_1 a
                                         JOIN _kl_ma_uwg_1 b
                                           ON a.kl_owg_id = b.kl_owg_id AND
                                              a.mandant_id = b.mandant_id) b

SET marktanteilbewertung = b.indexpunkt

WHERE dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kl_uwg_id = b.kl_uwg_id AND
      dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.mandant_id = ${mandant_id} AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _fix_it AS (
SELECT mandant_id,
       wg_id,
       wug_id,
       COUNT(DISTINCT marktanteilbewertung) AS anz
FROM dbp_data.sortiment_leistung_1
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      marktanteilbewertung IS NOT NULL AND
      mandant_id = ${mandant_id}
GROUP BY 1,2,3
HAVING anz > 1
);

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT a.mandant_id,
                                                a.wg_id,
                                                a.wug_id,
                                                MAX(a.marktanteilbewertung) AS marktanteilbewertung
                                         FROM dbp_data.sortiment_leistung_1 a
                                         JOIN _fix_it b
                                           ON a.mandant_id = b.mandant_id AND
                                              a.wg_id = b.wg_id AND
                                              a.wug_id = b.wug_id
                                         GROUP BY 1,2,3) b
                                         
SET marktanteilbewertung = b.marktanteilbewertung

WHERE dbp_data.sortiment_leistung.wug_id = b.wug_id AND
      dbp_data.sortiment_leistung.wg_id = b.wg_id AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT a.mandant_id,
                                                a.kjwo_update,
                                                a.wg_id,
                                                a.wug_id,
                                                MAX(COALESCE(a.marktanteilbewertung,0)) AS marktanteilbewertung
                                         FROM dbp_data.sortiment_leistung_1 a
                                         WHERE a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
                                               a.mandant_id = ${mandant_id}
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
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a

JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
  
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id

JOIN (SELECT mandant_id,
             gtin_id,
             art_matching_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6,7) c
  ON b.gtin_id = c.gtin_id AND
     b.mandant_id = c.mandant_id AND b.art_nielsen_id = c.art_nielsen_id

JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id

JOIN dbp_data.sortiment_leistung_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})

WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = ${nielsen_market_id} AND
      a.mandant_id = ${mandant_id} AND
      b.gtin_id NOT IN (-9999,-9998)
      
GROUP BY 1,2,3,4,5
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,umsatz_ DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id,c.kl_owg_id ORDER BY c.kl_wg_id,c.kl_owg_id,menge_ DESC) AS rang_absatz_uwg,
       RANK() OVER (PARTITION BY c.kl_wg_id  ORDER BY c.kl_wg_id,umsatz_ DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a

JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
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
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id

JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id

JOIN dbp_data.sortiment_leistung_1 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id})

WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = ${nielsen_market_id} AND
      b.gtin_id IN (-9999,-9998) AND
      a.mandant_id = ${mandant_id}
      
GROUP BY 1,2,3,4,5
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking2 AS (
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
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,matching_id FROM dbp_data.sortiment_leistung_1 
                                       WHERE mandant_id = ${mandant_id} AND 
                                             kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}))
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _murks_1 AS (
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
FROM dbp_data.sortiment_leistung_1
WHERE kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
);

UPDATE _murks_1 FROM (SELECT mandant_id,
                           art_matching_id,
                           SUM(umsatz__) AS umsatz_artikel
                    FROM _artikel_anteil_uwg_ranking2
                    GROUP BY 1,2) b
                    
SET umsatz_artikel = b.umsatz_artikel

WHERE _murks.mandant_id = b.mandant_id AND
      _murks.matching_id = b.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT mandant_id,
       kl_owg_id,
       kl_uwg_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking2
GROUP BY 1,2,3
);

UPDATE _murks_1 FROM (SELECT mandant_id,
                           kl_owg_id,
                           kl_uwg_id,
                           umsatz
                    FROM _gesamt_uwg
                    GROUP BY 1,2,3,4) b
												
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = ROUND(CAST(_murks.umsatz_artikel AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,16)    
	
WHERE _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id AND
      _murks.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_ranking2 FROM (SELECT mandant_id,
                                                kl_owg_id,
                                                kl_uwg_id,
                                                umsatz
                                         FROM _gesamt_uwg
                                         GROUP BY 1,2,3,4) b
												
SET umsatz_anteil_kum_uwg = ROUND(CAST(_artikel_anteil_uwg_ranking2.umsatz__ AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,5)
	
WHERE _artikel_anteil_uwg_ranking2.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_ranking2.kl_owg_id = b.kl_owg_id AND
      _artikel_anteil_uwg_ranking2.mandant_id = b.mandant_id
;

UPDATE _murks_1 FROM (SELECT mandant_id,
                           art_matching_id,
                           kl_owg_id,
                           kl_uwg_id,
                           SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY kl_owg_id,kl_uwg_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
                    FROM _artikel_anteil_uwg_ranking2) b
												
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

WHERE _murks.matching_id = b.art_matching_id AND
      _murks.kl_uwg_id = b.kl_uwg_id AND
      _murks.kl_owg_id = b.kl_owg_id AND
      _murks.mandant_id = b.mandant_id
;

UPDATE dbp_data.sortiment_leistung_1 FROM (SELECT mandant_id,
                                                matching_id,
                                                kjwo_update,
                                                MAX(umsatz_artikel) AS umsatz_artikel,
                                                MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                                                MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg
                                         FROM _murks_1
                                         GROUP BY 1,2,3) b

SET umsatz_artikel = b.umsatz_artikel,
    umsatz_anteil_uwg = b.umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert = b.umsatz_anteil_kum_uwg

WHERE dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kjwo_update = b.kjwo_update AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id
;

CREATE OR REPLACE VOLATILE TABLE _kill_wge AS (
SELECT a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       a.art_id
FROM dbp_data.sortiment_leistung_1 a
JOIN dbp_data.art_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
WHERE a.art_id <> -1 AND
      a.mandant_id = ${mandant_id} AND
     (b.wg_art_fg = 1 OR
      b.artikeltyp_id = 12)
);

DELETE FROM dbp_data.sortiment_leistung_1
WHERE (mandant_id,kjwo_update,matching_id,art_id) IN (SELECT mandant_id,kjwo_update,matching_id,art_id FROM _kill_wge) AND
       mandant_id = ${mandant_id} AND
      (umsatz_artikel = 0 OR
       umsatz_artikel IS NULL)
;

-- dbay, 31.01.2022
-- missing entries from the past week

create or replace volatile table _nl_facts as (
select a.mandant_id,
       a.art_nielsen_id,
       c.gtin_id,
       sum(a.umsatz_brutto) as umsatz_brutto
from dbp_data.art_nielsen_fakten_kjmo_1 a
join dbp_data.nielsen_market_1 b
  on a.mandant_id = b.mandant_id and 
     a.nielsen_market_id = b.nielsen_market_id
join _art_nielsen c
  on a.mandant_id = c.mandant_id and
     a.art_nielsen_id = c.art_nielsen_id
where (a.mandant_id,a.kjmo) in (select x.mandant_id,
                                       x.kjmo
                                from (select mandant_id,
                                             kjmo,
                                             rank() over (partition by mandant_id order by mandant_id,kjmo desc) * (-1) as akt_mo
                                      from dbp_data.art_nielsen_fakten_kjmo_1
                                      where mandant_id = ${mandant_id}
                                      group by 1,2) x
                                where akt_mo between -12 and -1) and
      b.nielsen_market_cluster_id = 1 and
      a.mandant_id = ${mandant_id} and 
      a.umsatz_brutto > 0
group by 1,2,3
);

create or replace volatile table _track as (
select a.mandant_id,
       a.art_nielsen_id,
       b.art_matching_id
from _nl_facts a
left join dbp_etl.art_matching_nielsen_per_kmo_1 b
  on a.mandant_id = b.mandant_id and 
     a.art_nielsen_id = b.art_nielsen_id
group by 1,2,3
);

create or replace volatile table _misses as (
select a.mandant_id,
       a.art_matching_id
from _track a

left join (select mandant_id,
                  matching_id
           from dbp_data.sortiment_leistung_1
           where mandant_id = ${mandant_id} and
                 kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung_1)
           group by 1,2) b
  on a.mandant_id = b.mandant_id and 
     a.art_matching_id = b.matching_id
     
join dbp_etl.art_matching_nielsen_per_kmo_1 c
  on a.mandant_id = c.mandant_id and 
     a.art_matching_id = c.art_matching_id
     
join dbp_data.art_wg_zu_per_1 d
  on a.mandant_id = d.mandant_id and 
     d.art_id = c.art_id and 
     d.arthiertyp_id = 2 and 
     d.dat_bis = '9999-12-31'

join dbp_data.wg_filter_zu_1 wfz
  on d.wg_id = wfz.wg_id and 
     a.mandant_id = wfz.mandant_id and 
     wfz.wg_filter_id = 47 and 
     wfz.arthiertyp_id = 2

where b.matching_id is null
group by 1,2
);

create or replace volatile table _sl as (
select *
from dbp_data.sortiment_leistung_1
where kjwo_update in (select c.kjwo
                      from dbp_data.woche_1 a
                      join (select max(kjwo_update) as kjwo
                            from dbp_data.sortiment_leistung_1
                            where mandant_id = ${mandant_id}) b
                        on a.kjwo = b.kjwo
                      join dbp_data.woche_1 c
                        on a.akt_wo-1 = c.akt_wo) and
      mandant_id = ${mandant_id} and
     (mandant_id,matching_id) in (select mandant_id,art_matching_id from _misses)
);

update _sl from (select mandant_id,
                        max(kjmo) as kjmo,
                        max(kjwo_update) as kjwo_update
                 from dbp_data.sortiment_leistung_1
                 where mandant_id = ${mandant_id}
                 group by 1) b
                                         
set kjwo_update = b.kjwo_update,
    kjmo = b.kjmo
    
where _sl.mandant_id = b.mandant_id
;

insert into dbp_data.sortiment_leistung_1
select distinct *
from _sl
where (mandant_id,matching_id,kjwo_update) not in (select mandant_id,matching_id,kjwo_update from dbp_data.sortiment_leistung_1)
;
