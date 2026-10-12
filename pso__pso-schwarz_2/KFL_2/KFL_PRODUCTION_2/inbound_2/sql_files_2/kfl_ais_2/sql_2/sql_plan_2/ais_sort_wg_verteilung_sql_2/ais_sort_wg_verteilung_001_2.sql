create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_base1 AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY c.kl_owg_id) AS umsatz_owg_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY c.kl_owg_id,c.kl_uwg_id) AS umsatz_uwg_,
       COUNT(b.art_nielsen_id) OVER (PARTITION BY c.kl_owg_id) AS anz_artikel_owg_,
       COUNT(b.art_nielsen_id) OVER (PARTITION BY c.kl_owg_id,c.kl_uwg_id) AS anz_artikel_uwg_
FROM DBP_DATA.art_nielsen_fakten_kjwo_2 a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN (SELECT a.mandant_id,
             a.art_nielsen_id,
             a.kl_wg_id,
             a.kl_owg_id,
             a.kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_2 a
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_gesamt_nielsen AS (
SELECT a.mandant_id,
       d.nielsen_market_id,
       c.kl_wg_id,
       CAST(COUNT(DISTINCT b.art_nielsen_id) AS FLOAT) AS anz_artikel_,
       SUM(CAST(a.umsatz_brutto AS FLOAT)) AS umsatz_
FROM DBP_DATA.art_nielsen_fakten_kjwo_2 a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_2
      WHERE kl_wg_id <> -3
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2,3
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_base2 AS (
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(a.umsatz_owg_)/MAX(b.umsatz_) AS umsatz_anteil_owg,
       MAX(a.umsatz_uwg_)/MAX(b.umsatz_) AS umsatz_anteil_uwg,
       MAX(CAST(a.anz_artikel_owg_ AS FLOAT))/MAX(b.anz_artikel_) AS artikel_anteil_owg,
       MAX(CAST(a.anz_artikel_uwg_ AS FLOAT))/MAX(b.anz_artikel_) AS artikel_anteil_uwg
FROM _wg_verteilung_base1 a
JOIN _wg_verteilung_gesamt_nielsen b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3,4
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base1 AS (
SELECT mandant_id,
       art_id,
       MAX(kl_wg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_owg_id,kl_uwg_id) AS kl_uwg_id
FROM DBP_ETL.art_matching_nielsen_per_2
WHERE floor(art_id/100) IN (SELECT CAST(art_nr AS INTEGER)
	                    FROM DBP_ETL.bf_sort_sal_export_2
		            GROUP BY 1
		            HAVING SUM(total_absatz) > 0) AND
      art_id <> -1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base2 AS (
SELECT 1 AS mandant_id,
       b.art_id,
       b.kl_art_id,
       b.kl_wg_id,
       b.kl_owg_id,
       b.kl_uwg_id,
       SUM(a.af_re_mep_mt_wo+a.sa_re_mep) AS ertrag_,
       SUM(a.kassenumsatz) AS umsatz_,
       SUM(CAST(ertrag_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id) AS ertrag_owg_,
       SUM(CAST(ertrag_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id,b.kl_uwg_id) AS ertrag_uwg_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id) AS umsatz_owg_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id,b.kl_uwg_id) AS umsatz_uwg_,
       COUNT(b.art_id) OVER (PARTITION BY b.kl_owg_id) AS anz_artikel_owg_,
       COUNT(b.art_id) OVER (PARTITION BY b.kl_uwg_id) AS anz_artikel_uwg_
FROM DBP_ETL.bf_sort_sal_export_2 a
JOIN (SELECT mandant_id,
             floor(art_id/100) AS kl_art_id,
             art_id,
	     kl_wg_id,
	     kl_owg_id,
	     kl_uwg_id
      FROM _wg_verteilung_kl_base1
      GROUP BY 1,2,3,4,5,6) b
  ON CAST(a.art_nr AS INTEGER) = b.kl_art_id
GROUP BY 1,2,3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_kl_gesamt AS (
SELECT 1 AS mandant_id,
       b.kl_wg_id,
       SUM(a.af_re_mep_mt_wo+a.sa_re_mep) AS ertrag_,
       SUM(a.kassenumsatz) AS umsatz_,
       CAST(COUNT(DISTINCT b.art_id) AS FLOAT) AS anz_artikel_
FROM DBP_ETL.bf_sort_sal_export_2 a
JOIN (SELECT mandant_id,
             floor(art_id/100) AS kl_art_id,
             art_id,
	     kl_wg_id,
	     kl_owg_id,
	     kl_uwg_id
      FROM _wg_verteilung_kl_base1
      GROUP BY 1,2,3,4,5,6) b
  ON CAST(a.art_nr AS INTEGER) = b.kl_art_id
GROUP BY 1,2
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base3 AS (
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(a.ertrag_owg_)/MAX(b.ertrag_) AS ertrag_anteil_owg,
       MAX(a.ertrag_uwg_)/MAX(b.ertrag_) AS ertrag_anteil_uwg,
       MAX(a.umsatz_owg_)/MAX(b.umsatz_) AS umsatz_anteil_owg,
       MAX(a.umsatz_uwg_)/MAX(b.umsatz_) AS umsatz_anteil_uwg,
       MAX(CAST(a.anz_artikel_owg_ AS FLOAT))/MAX(b.anz_artikel_) AS artikel_anteil_owg,
       MAX(CAST(a.anz_artikel_uwg_ AS FLOAT))/MAX(b.anz_artikel_) AS artikel_anteil_uwg
FROM _wg_verteilung_kl_base2 a
JOIN _wg_verteilung_kl_gesamt b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3,4
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _wg_verteilung_final AS (
SELECT x.kjmo,
       a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       a.umsatz_anteil_owg AS nielsen_umsatz_anteil_owg,
       a.umsatz_anteil_uwg AS nielsen_umsatz_anteil_uwg,
       a.artikel_anteil_owg AS nielsen_artikel_anteil_owg,
       a.artikel_anteil_uwg AS nielsen_artikel_anteil_uwg,
       COALESCE(b.umsatz_anteil_owg,0) AS kl_umsatz_anteil_owg,
       COALESCE(c.umsatz_anteil_uwg,0) AS kl_umsatz_anteil_uwg,
       COALESCE(b.artikel_anteil_owg,0) AS kl_artikel_anteil_owg,
       COALESCE(c.artikel_anteil_uwg,0) AS kl_artikel_anteil_uwg,
       COALESCE(b.ertrag_anteil_owg,0) AS kl_ertrag_anteil_owg,
       COALESCE(c.ertrag_anteil_uwg,0) AS kl_ertrag_anteil_uwg
FROM _wg_verteilung_base2 a
LEFT JOIN (SELECT mandant_id,
                  kl_owg_id,
                  MAX(ertrag_anteil_owg) AS ertrag_anteil_owg,
                  MAX(umsatz_anteil_owg) AS umsatz_anteil_owg,
                  MAX(artikel_anteil_owg) AS artikel_anteil_owg
           FROM _wg_verteilung_kl_base3
           GROUP BY 1,2) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.mandant_id = b.mandant_id
LEFT JOIN (SELECT mandant_id,
                  kl_owg_id,
                  kl_uwg_id,
                  MAX(ertrag_anteil_uwg) AS ertrag_anteil_uwg,
                  MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                  MAX(artikel_anteil_uwg) AS artikel_anteil_uwg
           FROM _wg_verteilung_kl_base3
           GROUP BY 1,2,3) c
  ON a.kl_uwg_id = c.kl_uwg_id AND
     a.kl_owg_id = c.kl_owg_id AND
     a.mandant_id = c.mandant_id
JOIN (SELECT MIN(b.kjmo) AS kjmo
      FROM (SELECT MAX(kjwo) AS kjwo
            FROM DBP_DATA.art_nielsen_fakten_kjwo_2
			WHERE mandant_id = 1) a
	  JOIN DBP_DATA.tag_2 b
	    ON a.kjwo = b.kjwo) x
  ON 1 = 1
WHERE a.kl_wg_id <> -1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_kl_wg_verteilung_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.sortiment_kl_wg_verteilung_2 (mandant_id
                                                ,kjmo
                                                ,kl_uwg_id
                                                ,kl_wg_id
                                                ,kl_owg_id
                                                ,nielsen_umsatz_anteil_owg
                                                ,nielsen_umsatz_anteil_uwg
                                                ,nielsen_artikel_anteil_owg
                                                ,nielsen_artikel_anteil_uwg
                                                ,kl_umsatz_anteil_owg
                                                ,kl_umsatz_anteil_uwg
                                                ,kl_artikel_anteil_owg
                                                ,kl_artikel_anteil_uwg
                                                ,kl_ertrag_anteil_owg
                                                ,kl_ertrag_anteil_uwg)
SELECT mandant_id
      ,kjmo
      ,kl_uwg_id
      ,kl_wg_id
      ,kl_owg_id
      ,nielsen_umsatz_anteil_owg
      ,nielsen_umsatz_anteil_uwg
      ,nielsen_artikel_anteil_owg
      ,nielsen_artikel_anteil_uwg
      ,kl_umsatz_anteil_owg
      ,kl_umsatz_anteil_uwg
      ,kl_artikel_anteil_owg
      ,kl_artikel_anteil_uwg
      ,kl_ertrag_anteil_owg
      ,kl_ertrag_anteil_uwg
FROM _wg_verteilung_final
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_wg_verteilung_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.sortiment_wg_verteilung_2 (mandant_id
                                                ,kjmo
                                                ,hwg_id
                                                ,owg_id
                                                ,wg_id
						,wug_id
                                                ,nielsen_umsatz_anteil_owg
                                                ,nielsen_umsatz_anteil_uwg
                                                ,nielsen_artikel_anteil_owg
                                                ,nielsen_artikel_anteil_uwg
                                                ,kl_umsatz_anteil_owg
                                                ,kl_umsatz_anteil_uwg
                                                ,kl_artikel_anteil_owg
                                                ,kl_artikel_anteil_uwg
                                                ,kl_ertrag_anteil_owg
                                                ,kl_ertrag_anteil_uwg)
SELECT mandant_id
      ,kjmo
      ,0 AS hwg_id
      ,kl_wg_id AS owg_id
      ,kl_owg_id AS wg_id
      ,kl_uwg_id AS wug_id
      ,nielsen_umsatz_anteil_owg
      ,nielsen_umsatz_anteil_uwg
      ,nielsen_artikel_anteil_owg
      ,nielsen_artikel_anteil_uwg
      ,kl_umsatz_anteil_owg
      ,kl_umsatz_anteil_uwg
      ,kl_artikel_anteil_owg
      ,kl_artikel_anteil_uwg
      ,kl_ertrag_anteil_owg
      ,kl_ertrag_anteil_uwg
FROM _wg_verteilung_final
;

