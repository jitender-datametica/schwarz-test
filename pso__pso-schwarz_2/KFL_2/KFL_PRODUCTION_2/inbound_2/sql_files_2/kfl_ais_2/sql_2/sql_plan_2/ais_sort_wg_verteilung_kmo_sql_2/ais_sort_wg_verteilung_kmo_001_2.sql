create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_base1 AS (
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
FROM DBP_DATA.art_nielsen_fakten_kjmo_2 a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN (SELECT a.mandant_id,
             a.art_nielsen_id,
             a.kl_wg_id,
             a.kl_owg_id,
             a.kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo_2 a
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_cluster_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo_2
		       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND  -- muss angepasst werden, wenn Wessam die Maerkte bzw. Custer hat!
      a.mandant_id = ${mandant_id}
GROUP BY 1,2,3,4,5,6
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_gesamt_nielsen AS (
SELECT a.mandant_id,
       d.nielsen_market_cluster_id,
       c.kl_wg_id,
       CAST(COUNT(DISTINCT b.art_nielsen_id) AS FLOAT) AS anz_artikel_,
       SUM(CAST(a.umsatz_brutto AS FLOAT)) AS umsatz_
FROM DBP_DATA.art_nielsen_fakten_kjmo_2 a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per_kmo_2
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_cluster_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo_2
					   WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND  -- muss angepasst werden, wenn Wessam die Maerkte bzw. Custer hat!
      a.mandant_id = ${mandant_id}
GROUP BY 1,2,3
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_base2 AS (
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       ZEROIFNULL(MAX(a.umsatz_owg_)/NULLIFZERO(MAX(b.umsatz_))) AS umsatz_anteil_owg,
       ZEROIFNULL(MAX(a.umsatz_uwg_)/NULLIFZERO(MAX(b.umsatz_))) AS umsatz_anteil_uwg,
       ZEROIFNULL(MAX(CAST(a.anz_artikel_owg_ AS FLOAT))/NULLIFZERO(MAX(b.anz_artikel_))) AS artikel_anteil_owg,
       ZEROIFNULL(MAX(CAST(a.anz_artikel_uwg_ AS FLOAT))/NULLIFZERO(MAX(b.anz_artikel_))) AS artikel_anteil_uwg
FROM _wg_verteilung_base1 a
JOIN _wg_verteilung_gesamt_nielsen b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3,4
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base1 AS (
SELECT mandant_id,
       art_id,
       MAX(kl_wg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_uwg_id) AS kl_uwg_id
FROM DBP_ETL.art_matching_nielsen_per_kmo_2
WHERE (mandant_id,art_id) IN (SELECT mandant_id,art_id
	                      FROM DBP_DATA.sal_kmo_2
			      WHERE TRIM(eigenmarke_id) = ''
		              GROUP BY 1,2
		              HAVING SUM(total_artbew_menge) > 0) AND
      art_id <> -1 AND
      mandant_id = ${mandant_id}
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base2 AS (
SELECT a.mandant_id,
       b.art_id,
       b.kl_wg_id,
       b.kl_owg_id,
       b.kl_uwg_id,
       SUM((a.total_rohertrag_af )+(a.total_rohertrag_sa )) AS ertrag_,
       SUM(a.total_umsatz_netto) AS umsatz_,
       SUM(CAST(ertrag_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id) AS ertrag_owg_,
       SUM(CAST(ertrag_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id,b.kl_uwg_id) AS ertrag_uwg_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id) AS umsatz_owg_,
       SUM(CAST(umsatz_ AS FLOAT)) OVER (PARTITION BY b.kl_owg_id,b.kl_uwg_id) AS umsatz_uwg_,
       COUNT(b.art_id) OVER (PARTITION BY b.kl_owg_id) AS anz_artikel_owg_,
       COUNT(b.art_id) OVER (PARTITION BY b.kl_owg_id,b.kl_uwg_id) AS anz_artikel_uwg_
FROM DBP_DATA.sal_kmo_2 a
JOIN (SELECT mandant_id,
             art_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM _wg_verteilung_kl_base1
      GROUP BY 1,2,3,4,5) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE a.mandant_id = ${mandant_id}
AND TRIM(a.eigenmarke_id) = ''
GROUP BY 1,2,3,4,5
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_kl_gesamt AS (
SELECT a.mandant_id,
       b.kl_wg_id,
       SUM((a.total_rohertrag_af )+(a.total_rohertrag_sa )) AS ertrag_,
       SUM(a.total_umsatz_netto) AS umsatz_,
       CAST(COUNT(DISTINCT b.art_id) AS FLOAT) AS anz_artikel_
FROM DBP_DATA.sal_kmo_2 a
JOIN (SELECT mandant_id,
             art_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM _wg_verteilung_kl_base1
      GROUP BY 1,2,3,4,5) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE a.mandant_id = ${mandant_id}
AND TRIM(a.eigenmarke_id) = ''
GROUP BY 1,2
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_kl_base3 AS (
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       ZEROIFNULL(MAX(a.ertrag_owg_)/NULLIFZERO(MAX(b.ertrag_))) AS ertrag_anteil_owg,
       ZEROIFNULL(MAX(a.ertrag_uwg_)/NULLIFZERO(MAX(b.ertrag_))) AS ertrag_anteil_uwg,
       ZEROIFNULL(MAX(a.umsatz_owg_)/NULLIFZERO(MAX(b.umsatz_))) AS umsatz_anteil_owg,
       ZEROIFNULL(MAX(a.umsatz_uwg_)/NULLIFZERO(MAX(b.umsatz_))) AS umsatz_anteil_uwg,
       ZEROIFNULL(MAX(CAST(a.anz_artikel_owg_ AS FLOAT))/NULLIFZERO(MAX(b.anz_artikel_))) AS artikel_anteil_owg,
       ZEROIFNULL(MAX(CAST(a.anz_artikel_uwg_ AS FLOAT))/NULLIFZERO(MAX(b.anz_artikel_))) AS artikel_anteil_uwg
FROM _wg_verteilung_kl_base2 a
JOIN _wg_verteilung_kl_gesamt b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3,4
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _wg_verteilung_final AS (
SELECT y.kjmo,
       COALESCE(x.mandant_id,a.mandant_id) AS mandant_id,
       COALESCE(x.kl_wg_id,a.kl_wg_id) AS kl_wg_id,
       COALESCE(x.kl_owg_id,a.kl_owg_id) AS kl_owg_id,
       COALESCE(x.kl_uwg_id,a.kl_uwg_id) AS kl_uwg_id,
       COALESCE(a.umsatz_anteil_owg,0) AS nielsen_umsatz_anteil_owg,
       COALESCE(a.umsatz_anteil_uwg,0) AS nielsen_umsatz_anteil_uwg,
       COALESCE(a.artikel_anteil_owg,0) AS nielsen_artikel_anteil_owg,
       COALESCE(a.artikel_anteil_uwg,0) AS nielsen_artikel_anteil_uwg,
       COALESCE(b.umsatz_anteil_owg,0) AS kl_umsatz_anteil_owg,
       COALESCE(c.umsatz_anteil_uwg,0) AS kl_umsatz_anteil_uwg,
       COALESCE(b.artikel_anteil_owg,0) AS kl_artikel_anteil_owg,
       COALESCE(c.artikel_anteil_uwg,0) AS kl_artikel_anteil_uwg,
       COALESCE(b.ertrag_anteil_owg,0) AS kl_ertrag_anteil_owg,
       COALESCE(c.ertrag_anteil_uwg,0) AS kl_ertrag_anteil_uwg
FROM _wg_verteilung_kl_base3 x
LEFT JOIN _wg_verteilung_base2 a
  ON a.kl_owg_id = x.kl_owg_id AND
     a.kl_wg_id = x.kl_wg_id AND
     a.mandant_id = x.mandant_id AND
	 a.kl_uwg_id = x.kl_uwg_id
LEFT JOIN (SELECT mandant_id,
                  kl_owg_id,
                  MAX(ertrag_anteil_owg) AS ertrag_anteil_owg,
                  MAX(umsatz_anteil_owg) AS umsatz_anteil_owg,
                  MAX(artikel_anteil_owg) AS artikel_anteil_owg
           FROM _wg_verteilung_kl_base3
           GROUP BY 1,2) b
  ON x.kl_owg_id = b.kl_owg_id AND
     x.mandant_id = b.mandant_id
LEFT JOIN (SELECT mandant_id,
                  kl_owg_id,
                  kl_uwg_id,
                  MAX(ertrag_anteil_uwg) AS ertrag_anteil_uwg,
                  MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                  MAX(artikel_anteil_uwg) AS artikel_anteil_uwg
           FROM _wg_verteilung_kl_base3
           GROUP BY 1,2,3) c
  ON x.kl_uwg_id = c.kl_uwg_id AND
     x.kl_owg_id = c.kl_owg_id AND
     x.mandant_id = c.mandant_id
 JOIN (SELECT MAX(kjmo) AS kjmo
             FROM DBP_DATA.art_nielsen_fakten_kjmo_2
             WHERE mandant_id = ${mandant_id}) y
   ON 1 = 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_kl_wg_verteilung_2
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo_2
                       WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
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
      ,kl_owg_id
      ,kl_wg_id
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
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo_2
                       WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.sortiment_wg_verteilung_2 (mandant_id
                                                ,kjmo
                                                ,wg_id
                                                ,wug_id
                                                ,hwg_id
                                                ,owg_id
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
      ,kl_owg_id
      ,kl_uwg_id
      ,0
      ,kl_wg_id
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

