CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per AS (
SELECT a.*
FROM DBP_DATA.art_list_wup_zu_per_1 a
JOIN DBP_DATA.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_1 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      trim(a.list_quelle_id) IN ('1','3','7','C') AND
      floor(a.art_id/100) = a.struktur_art_id AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE 
);

CREATE OR REPLACE VOLATILE TABLE _sst_plus_regio AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE trim(a.list_quelle_id) IN ('1','7') AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE 
GROUP BY 1,2,3
UNION
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE trim(a.list_quelle_id) IN ('3') AND
      a.baustein_id NOT IN (SELECT baustein_id
                            FROM DBP_ETL.baustein_wsop_1
                            WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
UNION
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE trim(a.list_quelle_id) IN ('3') AND
      a.baustein_id  IN (SELECT baustein_id
                         FROM DBP_ETL.baustein_region_zu_1) AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _sonstige_bst AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE trim(a.list_quelle_id) IN ('3') AND
      a.baustein_id IN (SELECT baustein_id
	                FROM DBP_ETL.baustein_wsop_1
                        WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis AND
			      mandant_id = 1) AND
      a.baustein_id NOT IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_region_zu_1) AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _einzel_markt AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE trim(a.list_quelle_id) IN ('C') AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
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

UPDATE DBP_DATA.sortiment_leistung_1 SET listung_sst_mvke = NULL
WHERE TRIM(listung_sst_mvke) = '-1' AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET anz_maerkte_sst = 0
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET anz_maerkte_listung_einzel = 0
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET anz_maerkte_baustein_sonstige = 0
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET anz_maerkte_listung_gesamt = 0
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET ost_basis = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET ost_gross = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET sued_ost = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET sued_west = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET nord = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 SET west = ''
WHERE art_id IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT *
                                         FROM _sst
					 WHERE art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')) b

SET anz_maerkte_sst = b.anz_markt

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT *
                                         FROM _bst
                                         WHERE art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')) b

SET anz_maerkte_baustein_sonstige = b.anz_markt

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT *
                                         FROM _mkt
					 WHERE art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')) b
                                         
SET anz_maerkte_listung_einzel = b.anz_markt


WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT *
                                         FROM _gesamt_sicht
					 WHERE art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')) b

SET anz_maerkte_listung_gesamt = b.anz_markt

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT a.art_id,
                                                MAX(CASE WHEN TRIM(b.region_1) = 'N'  THEN 'X' ELSE '' END) AS nord_neu,
	                                        MAX(CASE WHEN TRIM(b.region_1) = 'W'  THEN 'X' ELSE '' END) AS west_neu,
	                                        MAX(CASE WHEN TRIM(b.region_1) = 'OB' THEN 'X' ELSE '' END) AS ost_basis_neu,
	                                        MAX(CASE WHEN TRIM(b.region_1) = 'OG' THEN 'X' ELSE '' END) AS ost_gross_neu,
	                                        MAX(CASE WHEN TRIM(b.region_1) = 'SO' THEN 'X' ELSE '' END) AS sued_ost_neu,
	                                        MAX(CASE WHEN TRIM(b.region_1) = 'SW' THEN 'X' ELSE '' END) AS sued_west_neu
                                         FROM DBP_ETL.baustein_wsop_1 a
                                         JOIN DBP_ETL.baustein_region_zu_1 b
                                           ON a.mandant_id = b.mandant_id AND
                                              a.baustein_id = b.baustein_id
                                         WHERE a.mandant_id = 1 AND
                                               CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
	                                       a.art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')
                                         GROUP BY 1) x
SET nord = x.nord_neu,
    west = x.west_neu,
    ost_basis = x.ost_basis_neu,
    ost_gross = x.ost_gross_neu,
    sued_ost = x.sued_ost_neu,
    sued_west = x.sued_west_neu

WHERE DBP_DATA.sortiment_leistung.art_id = x.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 FROM (SELECT mandant_id,
                                                art_id,
                                                MIN(sm_id) AS sm_id
                                         FROM DBP_ETL_PROCESS.art_sm_vw_zu_per_1
					 WHERE mandant_id = 1 AND
					       CURRENT_DATE BETWEEN dat_von AND dat_bis AND
					       art_id IN (SELECT art_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE status_1 = 'N')
                                         GROUP BY 1,2) b

SET listung_sst_mvke = CAST(b.sm_id AS VARCHAR(2))

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)
;
