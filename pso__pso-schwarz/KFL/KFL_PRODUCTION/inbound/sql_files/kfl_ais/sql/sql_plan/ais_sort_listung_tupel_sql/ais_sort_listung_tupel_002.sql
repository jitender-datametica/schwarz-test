CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per AS (
SELECT a.*
FROM DBP_DATA.art_list_wup_zu_per a
JOIN DBP_DATA.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      trim(a.list_quelle_id) IN ('1','3','7','C') AND
      floor(a.art_id/100) = a.struktur_art_id AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE 
);

CREATE OR REPLACE VOLATILE TABLE _fall1 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per a
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
	  CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
	  a.herst_id > -2 AND
	  b.status = 'G'
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _fall1_update_sst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.sm_id) AS anz,
	   MIN(x.sm_id) AS sm_id
FROM (SELECT a.mandant_id,
             a.art_matching_id,
	         a.art_id,
	        MIN(d.sm_id) AS sm_id
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN _fall1 b
        ON a.art_matching_id = b.art_matching_id
      JOIN _art_list_wup_zu_per c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id AND
		   trim(c.list_quelle_id) = '3'
      JOIN DBP_ETL.baustein_tupel_region_zu d
        ON c.baustein_id = d.baustein_id AND
           a.mandant_id = d.mandant_id
      WHERE d.sm_id IS NOT NULL
      GROUP BY 1,2,3) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall1_update_regio AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   MAX(x.nord_neu) AS nord_neu,
	   MAX(x.west_neu) AS west_neu,
	   MAX(x.ost_basis_neu) AS ost_basis_neu,
	   MAX(x.ost_gross_neu) AS ost_gross_neu,
	   MAX(x.sued_ost_neu) AS sued_ost_neu,
	   MAX(x.sued_west_neu) AS sued_west_neu
FROM (SELECT a.mandant_id,
             a.art_matching_id,
	         a.art_id,
	         MAX(CASE WHEN TRIM(d.region) = 'N'  THEN 'X' ELSE '' END) AS nord_neu,
	         MAX(CASE WHEN TRIM(d.region) = 'W'  THEN 'X' ELSE '' END) AS west_neu,
	         MAX(CASE WHEN TRIM(d.region) = 'OB' THEN 'X' ELSE '' END) AS ost_basis_neu,
	         MAX(CASE WHEN TRIM(d.region) = 'OG' THEN 'X' ELSE '' END) AS ost_gross_neu,
	         MAX(CASE WHEN TRIM(d.region) = 'SO' THEN 'X' ELSE '' END) AS sued_ost_neu,
	         MAX(CASE WHEN TRIM(d.region) = 'SW' THEN 'X' ELSE '' END) AS sued_west_neu
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN _fall1 b
        ON a.art_matching_id = b.art_matching_id
      JOIN _art_list_wup_zu_per c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id  AND
		   trim(c.list_quelle_id) = '3'
      JOIN DBP_ETL.baustein_tupel_region_zu d
        ON c.baustein_id = d.baustein_id AND
           a.mandant_id = d.mandant_id
      WHERE d.sm_id IS NULL AND
            d.sm_id_sst IS NULL
      GROUP BY 1,2,3) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall1_sst_regio AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall1 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE AND
	  c.baustein_id IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_tupel_region_zu)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall1_sonstige_bst AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall1 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_wsop
						WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      c.baustein_id NOT IN (SELECT baustein_id
	                        FROM DBP_ETL.baustein_tupel_region_zu) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall1_einzel_markt AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall1 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('C') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall1_gesamt_sicht AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM (SELECT *
      FROM _fall1_sst_regio
      UNION ALL
      SELECT *
      FROM _fall1_sonstige_bst
      UNION ALL
      SELECT *
      FROM _fall1_einzel_markt) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall1_sst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall1_sst_regio x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall1_bst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall1_sonstige_bst x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall1_mkt AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall1_einzel_markt x
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_sst = b.anz_markt

FROM (SELECT *
      FROM _fall1_sst) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_baustein_sonstige = b.anz_markt

FROM (SELECT *
      FROM _fall1_bst) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_einzel = b.anz_markt

FROM (SELECT *
      FROM _fall1_mkt) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_gesamt = b.anz_markt

FROM (SELECT *
      FROM _fall1_gesamt_sicht) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

FROM (SELECT *
      FROM _fall1_update_sst) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET nord = x.nord_neu,
    west = x.west_neu,
	ost_basis = x.ost_basis_neu,
	ost_gross = x.ost_gross_neu,
	sued_ost = x.sued_ost_neu,
	sued_west = x.sued_west_neu

FROM (SELECT *
      FROM _fall1_update_regio) x

WHERE DBP_DATA.sortiment_leistung.mandant_id = x.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = x.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall2 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per a
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN (SELECT x.mandant_id,
             x.art_matching_id
      FROM (SELECT mandant_id,
                   art_matching_id,
                   umrech_faktor,
                   COUNT(*) AS anzahl
            FROM DBP_ETL.art_matching_nielsen_per
	    WHERE status = 'G'
	    GROUP BY 1,2,3) x
	  GROUP BY 1,2
	  HAVING MAX(anzahl) = 1) c
  ON b.mandant_id = c.mandant_id AND
     b.art_matching_id = c.art_matching_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.status = 'G'
GROUP BY 1
HAVING MAX(a.herst_id) = -2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_update_sst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.sm_id) AS anz,
	   MIN(x.sm_id) AS sm_id
FROM (SELECT a.mandant_id,
             a.art_matching_id,
	         a.art_id,
	        MIN(c.sm_id) AS sm_id
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN _fall2 b
        ON a.art_matching_id = b.art_matching_id
      JOIN DBP_ETL_PROCESS.art_sm_vw_zu_per c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id
      WHERE c.mandant_id = 1 AND
			CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      GROUP BY 1,2,3) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_update_regio AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   MIN(x.nord_neu) AS nord_neu,
	   MIN(x.west_neu) AS west_neu,
	   MIN(x.ost_basis_neu) AS ost_basis_neu,
	   MIN(x.ost_gross_neu) AS ost_gross_neu,
	   MIN(x.sued_ost_neu) AS sued_ost_neu,
	   MIN(x.sued_west_neu) AS sued_west_neu
FROM (SELECT a.mandant_id,
             a.art_matching_id,
	         a.art_id,
	         MAX(CASE WHEN TRIM(e.region) = 'N'  THEN 'X' ELSE '' END) AS nord_neu,
	         MAX(CASE WHEN TRIM(e.region) = 'W'  THEN 'X' ELSE '' END) AS west_neu,
	         MAX(CASE WHEN TRIM(e.region) = 'OB' THEN 'X' ELSE '' END) AS ost_basis_neu,
	         MAX(CASE WHEN TRIM(e.region) = 'OG' THEN 'X' ELSE '' END) AS ost_gross_neu,
	         MAX(CASE WHEN TRIM(e.region) = 'SO' THEN 'X' ELSE '' END) AS sued_ost_neu,
	         MAX(CASE WHEN TRIM(e.region) = 'SW' THEN 'X' ELSE '' END) AS sued_west_neu
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN _fall2 b
        ON a.art_matching_id = b.art_matching_id
      JOIN _art_list_wup_zu_per c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id  AND
		   trim(c.list_quelle_id) = '3'
      JOIN DBP_ETL.baustein_wsop d
	    ON a.mandant_id = d.mandant_id AND
		   c.baustein_id = d.baustein_id AND
		   c.art_id = d.art_id
      JOIN DBP_ETL.baustein_region_zu e
        ON a.mandant_id = e.mandant_id AND
           d.baustein_id = e.baustein_id
      WHERE CURRENT_DATE BETWEEN d.dat_von AND d.dat_bis
      GROUP BY 1,2,3) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_sst_regio AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall2 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('1','7') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE 
GROUP BY 1,2,3
UNION
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall2 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id NOT IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_wsop
                            WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      d.nb_id = 0 AND
      d.dat_eroeffnung < CURRENT_DATE 
GROUP BY 1,2,3
UNION
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall2 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id IN (SELECT baustein_id
	                     FROM DBP_ETL.baustein_region_zu) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE 
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall2_sonstige_bst AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall2 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_wsop
						WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      c.baustein_id NOT IN (SELECT baustein_id
	                        FROM DBP_ETL.baustein_region_zu) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall2_einzel_markt AS (
SELECT c.mandant_id,
       a.art_matching_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall2 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('C') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall2_gesamt_sicht AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM (SELECT *
      FROM _fall2_sst_regio
      UNION ALL
      SELECT *
      FROM _fall2_sonstige_bst
      UNION ALL
      SELECT *
      FROM _fall2_einzel_markt) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_sst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall2_sst_regio x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_bst AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall2_sonstige_bst x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall2_mkt AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _fall2_einzel_markt x
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_sst = b.anz_markt

FROM (SELECT *
      FROM _fall2_sst) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_baustein_sonstige = b.anz_markt

FROM (SELECT *
      FROM _fall2_bst) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_einzel = b.anz_markt

FROM (SELECT *
      FROM _fall2_mkt) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;


UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_gesamt = b.anz_markt

FROM (SELECT *
      FROM _fall2_gesamt_sicht) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

FROM (SELECT *
      FROM _fall2_update_sst) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET nord = x.nord_neu,
    west = x.west_neu,
	ost_basis = x.ost_basis_neu,
	ost_gross = x.ost_gross_neu,
	sued_ost = x.sued_ost_neu,
	sued_west = x.sued_west_neu

FROM (SELECT *
      FROM _fall2_update_regio) x

WHERE DBP_DATA.sortiment_leistung.mandant_id = x.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = x.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall3 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per a
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN (SELECT x.mandant_id,
             x.art_matching_id
      FROM (SELECT mandant_id,
                   art_matching_id,
			       umrech_faktor,
				   COUNT(*) AS anzahl
            FROM DBP_ETL.art_matching_nielsen_per
	        WHERE status = 'G'
	        GROUP BY 1,2,3) x
	  GROUP BY 1,2
	  HAVING MAX(anzahl) > 1) c
  ON b.mandant_id = c.mandant_id AND
     b.art_matching_id = c.art_matching_id
WHERE a.mandant_id = 1 AND
	  CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
	  b.status = 'G'
GROUP BY 1
HAVING MAX(a.herst_id) = -2
);

CREATE OR REPLACE VOLATILE TABLE _fall3_upd_sst1 AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.art_id,
	   e.wg_id,
	   c.wup_id,
	   f.kreistyp_gruppe_id,
	   e.sm_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall3 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.art_wg_zu_per d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per e
  ON a.mandant_id = e.mandant_id AND
     d.wg_id = e.wg_id AND
	 c.wup_id = e.wup_id
JOIN DBP_DATA.wup f
  ON a.mandant_id = f.mandant_id AND
     e.wup_id = f.wup_id AND
     f.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1 AND
      e.spr_id = 22 AND
      e.arthiertyp_id = 2 AND
      CURRENT_DATE BETWEEN e.dat_von AND e.dat_bis AND
      e.sm_id BETWEEN 1 AND 5 AND
      f.nb_id = 0 AND
      f.dat_von <= CURRENT_DATE
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _fall3_upd_sst2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.art_id,
	   e.wg_id,
	   e.wup_id,
	   f.kreistyp_gruppe_id,
	   e.sm_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall3 b
  ON a.art_matching_id = b.art_matching_id
JOIN DBP_DATA.art_wg_zu_per d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per e
  ON a.mandant_id = e.mandant_id AND
	 d.wg_id = e.wg_id
JOIN DBP_DATA.wup f
  ON a.mandant_id = f.mandant_id AND
     e.wup_id = f.wup_id AND
     f.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1 AND
      e.spr_id = 22 AND
      e.arthiertyp_id = 2 AND
      CURRENT_DATE BETWEEN e.dat_von AND e.dat_bis AND
      e.sm_id BETWEEN 1 AND 5 AND
      f.nb_id = 0 AND
      f.dat_von <= CURRENT_DATE
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _fall3_ist_listung AS (
SELECT mandant_id,
       art_matching_id,
	   wg_id,
	   sm_id,
       wup_id
FROM _fall3_upd_sst1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _fall3_soll_listung AS (
SELECT mandant_id,
       art_matching_id,
	   wg_id,
	   sm_id,
       wup_id
FROM _fall3_upd_sst2
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _fall3_update_sst AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   MIN(a.sm_id) AS sm_id
FROM (SELECT mandant_id,
             art_matching_id,
	         sm_id,
	         COUNT(DISTINCT wup_id) AS anz_ist
      FROM _fall3_ist_listung
      GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             art_matching_id,
	         sm_id,
	         COUNT(DISTINCT wup_id) AS anz_soll
      FROM _fall3_soll_listung
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
	 a.sm_id = b.sm_id AND
	 a.anz_ist = b.anz_soll
GROUP BY 1,2
);

INSERT INTO _fall3_update_sst
SELECT mandant_id,
       art_matching_id,
	   NULL AS sm_id
FROM _fall3_ist_listung
WHERE art_matching_id NOT IN (SELECT art_matching_id FROM _fall3_update_sst)
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE _fall3_ist_listung_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.kreistyp_gruppe_id,
       a.wup_id
FROM _fall3_upd_sst1 a
JOIN (SELECT *
      FROM _fall3_update_sst
	  WHERE sm_id IS NULL OR
	        sm_id <> 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _fall3_soll_listung_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.kreistyp_gruppe_id,
       a.wup_id
FROM _fall3_upd_sst2 a
JOIN (SELECT *
      FROM _fall3_update_sst
	  WHERE sm_id IS NULL OR
	        sm_id <> 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _fall3_update_sst_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kreistyp_gruppe_id
FROM (SELECT mandant_id,
             art_matching_id,
	     kreistyp_gruppe_id,
	     COUNT(DISTINCT wup_id) AS anz_ist
      FROM _fall3_ist_listung_region
      GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             kreistyp_gruppe_id,
	     COUNT(DISTINCT wup_id) AS anz_soll
      FROM DBP_DATA.wup
      WHERE mandant_id = 1 AND
	    nb_id = 0 AND
	    dat_bis = '9999-12-31' AND
            kreistyp_gruppe_id IS NOT NULL
      GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.kreistyp_gruppe_id = b.kreistyp_gruppe_id AND
     a.anz_ist = b.anz_soll
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall3_update_regio AS (
SELECT mandant_id,
       art_matching_id,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'N' THEN 'X' ELSE '' END) AS nord_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'W' THEN 'X' ELSE '' END) AS west_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'O' THEN 'X' ELSE '' END) AS ost_basis_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'Q' THEN 'X' ELSE '' END) AS ost_gross_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'G' THEN 'X' ELSE '' END) AS sued_ost_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'M' THEN 'X' ELSE '' END) AS sued_west_pflege_neu
FROM _fall3_update_sst_region
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall3_sst_regio AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz
FROM (
SELECT mandant_id,
       art_matching_id,
	   wup_id
FROM _fall3_ist_listung
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,art_matching_id
                                       FROM _fall3_update_sst
									   WHERE sm_id IS NOT NULL)
UNION ALL
SELECT mandant_id,
       art_matching_id,
	   wup_id
FROM _fall3_ist_listung_region
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,art_matching_id
                                       FROM _fall3_update_sst_region)) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall3_gesamt_sicht AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM (SELECT *
      FROM _fall3_ist_listung) x
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_sst = b.anz

FROM (SELECT *
      FROM _fall3_sst_regio) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_gesamt = b.anz_markt

FROM (SELECT *
      FROM _fall3_gesamt_sicht) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

FROM (SELECT *
      FROM _fall3_update_sst) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET nord = x.nord_pflege_neu,
    west = x.west_pflege_neu,
	ost_basis = x.ost_basis_pflege_neu,
	ost_gross = x.ost_gross_pflege_neu,
	sued_ost = x.sued_ost_pflege_neu,
	sued_west = x.sued_west_pflege_neu

FROM (SELECT *
      FROM _fall3_update_regio) x

WHERE DBP_DATA.sortiment_leistung.mandant_id = x.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = x.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall4 AS (
SELECT b.art_matching_id
FROM DBP_ETL.art_matching_nielsen_per b
WHERE b.status = 'T' 
);

CREATE OR REPLACE VOLATILE TABLE _fall4_tracking_single AS (
SELECT a.art_matching_id,
       COUNT(DISTINCT a.art_id) AS anzahl
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall4 c
  ON a.art_matching_id = c.art_matching_id
JOIN DBP_DATA.art b
  ON a.art_id = b.art_id AND
     b.mandant_id = 1 AND
     TRIM(b.loesch_id) NOT IN ('L','R')
GROUP BY 1
HAVING anzahl = 1
);

DELETE FROM _fall4
WHERE art_matching_id IN (SELECT art_matching_id FROM _fall4_tracking_single)
;

CREATE OR REPLACE VOLATILE TABLE _fall4_upd_sst1 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.art_id,
       e.wg_id,
       c.wup_id,
       f.kreistyp_gruppe_id,
       e.sm_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall4 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.art_wg_zu_per d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per e
  ON a.mandant_id = e.mandant_id AND
     d.wg_id = e.wg_id AND
	 c.wup_id = e.wup_id
JOIN DBP_DATA.wup f
  ON a.mandant_id = f.mandant_id AND
     e.wup_id = f.wup_id AND
     f.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1 AND
      e.spr_id = 22 AND
      e.arthiertyp_id = 2 AND
      CURRENT_DATE BETWEEN e.dat_von AND e.dat_bis AND
      e.sm_id BETWEEN 1 AND 5 AND
      f.nb_id = 0 AND
      f.dat_von <= CURRENT_DATE AND
      a.art_id NOT IN (SELECT art_id FROM DBP_DATA.art WHERE mandant_id = 1 AND TRIM(loesch_id) IN ('L','R'))
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _fall4_upd_sst2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.art_id,
       e.wg_id,
       e.wup_id,
       f.kreistyp_gruppe_id,
       e.sm_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall4 b
  ON a.art_matching_id = b.art_matching_id
JOIN DBP_DATA.art_wg_zu_per d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per e
  ON a.mandant_id = e.mandant_id AND
	 d.wg_id = e.wg_id
JOIN DBP_DATA.wup f
  ON a.mandant_id = f.mandant_id AND
     e.wup_id = f.wup_id AND
     f.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1 AND
      e.spr_id = 22 AND
      e.arthiertyp_id = 2 AND
      CURRENT_DATE BETWEEN e.dat_von AND e.dat_bis AND
      e.sm_id BETWEEN 1 AND 5 AND
      f.nb_id = 0 AND
      f.dat_von <= CURRENT_DATE AND
      a.art_id NOT IN (SELECT art_id FROM DBP_DATA.art WHERE mandant_id = 1 AND TRIM(loesch_id) IN ('L','R'))
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _fall4_ist_listung AS (
SELECT mandant_id,
       art_matching_id,
       wg_id,
       sm_id,
       wup_id
FROM _fall4_upd_sst1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _fall4_soll_listung AS (
SELECT mandant_id,
       art_matching_id,
       wg_id,
       sm_id,
       wup_id
FROM _fall4_upd_sst2
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _fall4_update_sst AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   MIN(a.sm_id) AS sm_id
FROM (SELECT mandant_id,
             art_matching_id,
	         sm_id,
	         COUNT(DISTINCT wup_id) AS anz_ist
      FROM _fall4_ist_listung
      GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             art_matching_id,
	         sm_id,
	         COUNT(DISTINCT wup_id) AS anz_soll
      FROM _fall4_soll_listung
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
	 a.sm_id = b.sm_id AND
	 a.anz_ist = b.anz_soll
GROUP BY 1,2
);

INSERT INTO _fall4_update_sst
SELECT mandant_id,
       art_matching_id,
	   NULL AS sm_id
FROM _fall4_ist_listung
WHERE art_matching_id NOT IN (SELECT art_matching_id FROM _fall4_update_sst)
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE _fall4_ist_listung_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.kreistyp_gruppe_id,
       a.wup_id
FROM _fall4_upd_sst1 a
JOIN (SELECT *
      FROM _fall4_update_sst
	  WHERE sm_id IS NULL OR
	        sm_id <> 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _fall4_soll_listung_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.kreistyp_gruppe_id,
       a.wup_id
FROM _fall4_upd_sst2 a
JOIN (SELECT *
      FROM _fall4_update_sst
	  WHERE sm_id IS NULL OR
	        sm_id <> 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _fall4_update_sst_region AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.kreistyp_gruppe_id
FROM (SELECT mandant_id,
             art_matching_id,
	         kreistyp_gruppe_id,
	         COUNT(DISTINCT wup_id) AS anz_ist
      FROM _fall4_ist_listung_region
      GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             kreistyp_gruppe_id,
	         COUNT(DISTINCT wup_id) AS anz_soll
      FROM DBP_DATA.wup
	  WHERE mandant_id = 1 AND
	        nb_id = 0 AND
			dat_bis = '9999-12-31' AND
			kreistyp_gruppe_id IS NOT NULL
      GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
	 a.kreistyp_gruppe_id = b.kreistyp_gruppe_id AND
	 a.anz_ist = b.anz_soll
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _fall4_update_regio AS (
SELECT mandant_id,
       art_matching_id,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'N' THEN 'X' ELSE '' END) AS nord_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'W' THEN 'X' ELSE '' END) AS west_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'O' THEN 'X' ELSE '' END) AS ost_basis_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'Q' THEN 'X' ELSE '' END) AS ost_gross_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'G' THEN 'X' ELSE '' END) AS sued_ost_pflege_neu,
	   MAX(CASE WHEN TRIM(kreistyp_gruppe_id) = 'M' THEN 'X' ELSE '' END) AS sued_west_pflege_neu
FROM _fall4_update_sst_region
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall4_sst_regio AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz
FROM (
SELECT mandant_id,
       art_matching_id,
	   wup_id
FROM _fall4_ist_listung
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,art_matching_id
                                       FROM _fall4_update_sst
									   WHERE sm_id IS NOT NULL)
UNION ALL
SELECT mandant_id,
       art_matching_id,
	   wup_id
FROM _fall4_ist_listung_region
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,art_matching_id
                                       FROM _fall4_update_sst_region)) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _fall4_gesamt_sicht AS (
SELECT x.mandant_id,
       x.art_matching_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM (SELECT *
      FROM _fall4_ist_listung) x
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_sst = b.anz

FROM (SELECT *
      FROM _fall4_sst_regio) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_gesamt = b.anz_markt

FROM (SELECT *
      FROM _fall4_gesamt_sicht) b

WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

FROM (SELECT *
      FROM _fall4_update_sst) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET nord = x.nord_pflege_neu,
    west = x.west_pflege_neu,
	ost_basis = x.ost_basis_pflege_neu,
	ost_gross = x.ost_gross_pflege_neu,
	sued_ost = x.sued_ost_pflege_neu,
	sued_west = x.sued_west_pflege_neu

FROM (SELECT *
      FROM _fall4_update_regio) x

WHERE DBP_DATA.sortiment_leistung.mandant_id = x.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = x.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall5 AS (
SELECT b.art_matching_id,
       b.art_id
FROM DBP_ETL.art_matching_nielsen_per b
WHERE b.status = 'N'
GROUP BY 1,2
UNION
SELECT b.art_matching_id,
       b.art_id
FROM DBP_ETL.art_matching_nielsen_per b
JOIN _fall4_tracking_single c
  ON b.art_matching_id = c.art_matching_id
JOIN DBP_DATA.art a
  ON b.art_id = a.art_id AND
     a.mandant_id = 1 AND
     TRIM(a.loesch_id) NOT IN ('L','R')
);

CREATE OR REPLACE VOLATILE TABLE _sst_plus_regio AS (
SELECT a.mandant_id,
       c.art_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall5 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('1','7') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE 
GROUP BY 1,2,3
UNION
SELECT a.mandant_id,
       c.art_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall5 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id NOT IN (SELECT baustein_id
	                        FROM DBP_ETL.baustein_wsop
							WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
UNION
SELECT a.mandant_id,
       c.art_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall5 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id  IN (SELECT baustein_id
	                     FROM DBP_ETL.baustein_region_zu) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _sonstige_bst AS (
SELECT a.mandant_id,
       c.art_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall5 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('3') AND
      c.baustein_id IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_wsop
						WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      c.baustein_id NOT IN (SELECT baustein_id
	                        FROM DBP_ETL.baustein_region_zu) AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _einzel_markt AS (
SELECT a.mandant_id,
       c.art_id,
       c.wup_id
FROM DBP_ETL.art_matching_nielsen_per a
JOIN _fall5 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.art_id = c.art_id
JOIN DBP_DATA.wup d
  ON c.mandant_id = d.mandant_id AND
     c.wup_id = d.wup_id
WHERE trim(c.list_quelle_id) IN ('C') AND
      d.nb_id = 0 AND
	  d.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _gesamt_sicht AS (
SELECT x.mandant_id,
       x.art_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM (SELECT *
      FROM _sst_plus_regio
      UNION ALL
      SELECT *
      FROM _sonstige_bst
      UNION ALL
      SELECT *
      FROM _einzel_markt) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _sst AS (
SELECT x.mandant_id,
       x.art_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _sst_plus_regio x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _bst AS (
SELECT x.mandant_id,
       x.art_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _sonstige_bst x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mkt AS (
SELECT x.mandant_id,
       x.art_id,
	   COUNT(DISTINCT x.wup_id) AS anz_markt
FROM _einzel_markt x
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_sst = b.anz_markt

FROM (SELECT *
      FROM _sst) b

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.anz_maerkte_sst = 0  AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_baustein_sonstige = b.anz_markt

FROM (SELECT *
      FROM _bst) b

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.anz_maerkte_baustein_sonstige = 0 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_einzel = b.anz_markt

FROM (SELECT *
      FROM _mkt) b

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.anz_maerkte_listung_einzel = 0 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET anz_maerkte_listung_gesamt = b.anz_markt

FROM (SELECT *
      FROM _gesamt_sicht) b

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.anz_maerkte_listung_gesamt = 0 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET nord = x.nord_neu,
    west = x.west_neu,
	ost_basis = x.ost_basis_neu,
	ost_gross = x.ost_gross_neu,
	sued_ost = x.sued_ost_neu,
	sued_west = x.sued_west_neu
	
FROM (
SELECT a.art_id,
       MAX(CASE WHEN TRIM(b.region) = 'N'  THEN 'X' ELSE '' END) AS nord_neu,
	   MAX(CASE WHEN TRIM(b.region) = 'W'  THEN 'X' ELSE '' END) AS west_neu,
	   MAX(CASE WHEN TRIM(b.region) = 'OB' THEN 'X' ELSE '' END) AS ost_basis_neu,
	   MAX(CASE WHEN TRIM(b.region) = 'OG' THEN 'X' ELSE '' END) AS ost_gross_neu,
	   MAX(CASE WHEN TRIM(b.region) = 'SO' THEN 'X' ELSE '' END) AS sued_ost_neu,
	   MAX(CASE WHEN TRIM(b.region) = 'SW' THEN 'X' ELSE '' END) AS sued_west_neu
FROM DBP_ETL.baustein_wsop a
JOIN DBP_ETL.baustein_region_zu b
  ON a.mandant_id = b.mandant_id AND
     a.baustein_id = b.baustein_id
JOIN (SELECT art_id
      FROM _fall5
	  GROUP BY 1) c
  ON a.art_id = c.art_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1
) x
 WHERE DBP_DATA.sortiment_leistung.art_id = x.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

FROM (SELECT a.mandant_id,
                                                              a.art_id,
                                                              MIN(a.sm_id) AS sm_id
                                                       FROM DBP_ETL_PROCESS.art_sm_vw_zu_per a
						       JOIN (SELECT art_id
                                                             FROM _fall5
	                                                     GROUP BY 1) c
                                                         ON a.art_id = c.art_id
						       WHERE a.mandant_id = 1 AND
							     CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
                                                       GROUP BY 1,2) b
												 WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;
