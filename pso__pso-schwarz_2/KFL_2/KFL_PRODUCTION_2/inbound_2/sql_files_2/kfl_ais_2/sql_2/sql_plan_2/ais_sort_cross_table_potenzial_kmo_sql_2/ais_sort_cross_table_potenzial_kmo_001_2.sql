--PARAMS
select ${mandant_id} as mandant_id;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _soll_kategorien_maerkte_1 AS (
SELECT a.mandant_id,
       a.art_id,
       c.wup_id,
       c.sm_id,
       c.ksm_id,
       c.kreistyp_gruppe_id
FROM DBP_DATA.art_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN (SELECT DISTINCT
             a.mandant_id,
             a.wup_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             b.kreistyp_gruppe_id
	  FROM DBP_DATA.sm_wup_wg_zu_per_2 a
	  JOIN DBP_DATA.wup_2 b
	    ON a.mandant_id = b.mandant_id AND
		   a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
           (a.sm_id BETWEEN 1 AND 5 OR a.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) AND
            b.nb_id = 0
      GROUP BY 1,2,3,4,5,6) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.mandant_id = ${mandant_id} AND
      a.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
GROUP BY 1,2,3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _list_enlisted1_1 AS (
SELECT 1 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 1 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 1 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 1 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 2 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
      '-' AS nord,
      '-' AS ost_basis,
      '-' AS ost_gross,
      '-' AS sued_ost,
      '-' AS sued_west,
      '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 2 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 2 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
	           gtin_id
	    FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
	    GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 2 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 3 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
      '-' AS nord,
      '-' AS ost_basis,
      '-' AS ost_gross,
      '-' AS sued_ost,
      '-' AS sued_west,
      '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 3 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 3 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
	           gtin_id
	    FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
	    GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 3 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 4 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
      '-' AS nord,
      '-' AS ost_basis,
      '-' AS ost_gross,
      '-' AS sued_ost,
      '-' AS sued_west,
      '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 4 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 4 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
	           gtin_id
	    FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
	    GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 4 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 5 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
      '-' AS nord,
      '-' AS ost_basis,
      '-' AS ost_gross,
      '-' AS sued_ost,
      '-' AS sued_west,
      '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 5 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT 5 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
	           gtin_id
	    FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
	    GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.sm_id BETWEEN 5 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K1' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K1' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K2' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K2','K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K2' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K2','K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K3' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K3' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K3','K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K4' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K4' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K4','K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K5' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K5' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K5','K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K6' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K6' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K6','K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K7' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K7' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K7','K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K8' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K8' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K8','K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K9' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      WHERE a.mandant_id = ${mandant_id}
      GROUP BY 1,2) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id})
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _list_enlisted1_1
SELECT NULL AS sm_id_selected,
       'K9' AS ksm_id_selected,
       c.sm_id,
       c.ksm_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.kl_owg_id,
       b.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       CAST(a.kl_markt_anteil_owg AS FLOAT)/100.0000 AS kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       c.anz_maerkte
FROM DBP_DATA.sortiment_leistung_2 a
JOIN (SELECT a.mandant_id,
             b.wg_id
      FROM DBP_DATA.sal_kmo_2 a
      JOIN (SELECT mandant_id,
                   art_id,
                   kl_owg_id AS wg_id
            FROM DBP_ETL.art_matching_nielsen_per_kmo_2
            WHERE mandant_id = ${mandant_id}
            GROUP BY 1,2,3) b
        ON a.art_id = b.art_id AND
           a.mandant_id = b.mandant_id
      JOIN DBP_DATA.art_wg_zu_per_2 c
        ON c.mandant_id = ${mandant_id} AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
           b.art_id = c.art_id
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.wg_id AND
     a.mandant_id = b.mandant_id
JOIN (SELECT a.mandant_id,
             a.wg_id,
             a.sm_id,
             a.ksm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            a.ksm_id IN ('K9') AND
            b.nb_id = 0
      GROUP BY 1,2,3,4) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.art_id IS NULL AND
      a.gtin IS NOT NULL AND
      a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
                 FROM DBP_DATA.sortiment_leistung_2
                 WHERE mandant_id = ${mandant_id}) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE VOLATILE TABLE schema.table ...)
CREATE OR REPLACE VOLATILE TABLE _list_enlisted2_1 AS (
SELECT sm_id_selected,
       ksm_id_selected,
       sm_id,
       ksm_id,
       nord,
       ost_basis,
       ost_gross,
       sued_ost,
       sued_west,
       west,
       kl_owg_id,
       wg_id,
       gtin,
       nielsen_art_bez,
       umsatz_artikel,
       kl_markt_anteil_owg,
       durchschnitt_anz_maerkte,
       durchschnitt_preis,
       anz_wochen,
       anz_maerkte,
       umsatz_artikel*kl_markt_anteil_owg AS erg1,
       ZEROIFNULL(erg1/NULLIFZERO(durchschnitt_anz_maerkte)) AS erg2,
       ZEROIFNULL(erg2/NULLIFZERO(anz_wochen)) AS erg3,
       erg3*anz_maerkte*12 AS umsatz,
       ZEROIFNULL(umsatz/NULLIFZERO(durchschnitt_preis)) AS absatz
FROM _list_enlisted1_1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_MSI_DATA.nl_listung_kmo_2 
WHERE mandant_id = ${mandant_id} AND 
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1);

INSERT INTO DBP_MSI_DATA.nl_listung_kmo_2 (nl_listung_kmo_id
                                 ,mandant_id
                                 ,listung_art
                                 ,sm_id_selected
                                 ,ksm_id_selected
                                 ,sm_id
                                 ,ksm_id
                                 ,gtin
                                 ,ost_basis
                                 ,ost_gross
                                 ,sued_ost
                                 ,sued_west
                                 ,west
                                 ,nord
                                 ,kl_owg_id
                                 ,wg_id
                                 ,art_nielsen_bez
                                 ,umsatz_artikel
                                 ,durchschnitt_anz_maerkte
                                 ,durchschnitt_preis
                                 ,anz_wochen
                                 ,anz_maerkte
                                 ,umsatz_hr
                                 ,absatz_hr
                                 ,kjwo_update)
SELECT (ROW_NUMBER() OVER (
		ORDER BY ${mandant_id}
	,'Listung erweitern'
	,sm_id_selected
	,sm_id
	,gtin
	,ost_basis
	,ost_gross
	,sued_ost
	,sued_west
	,west
	,nord
	,kl_owg_id
	,wg_id
	,nielsen_art_bez
	,umsatz_artikel
	,durchschnitt_anz_maerkte
	,durchschnitt_preis
	,anz_wochen
	,anz_maerkte
	,umsatz
	,absatz
	,b.kjwo
		) + COALESCE((SELECT MAX(nl_listung_kmo_id) FROM dbp_msi_data.nl_listung_kmo_2 WHERE nl_listung_kmo_id <> 0),0) ) AS nl_listung_kmo_id
      ,${mandant_id} as mandant_id
      ,'Listung erweitern' AS listung_art
      ,sm_id_selected
      ,ksm_id_selected
      ,sm_id
      ,ksm_id
      ,gtin
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,nord
      ,kl_owg_id
      ,wg_id
      ,nielsen_art_bez
      ,umsatz_artikel
      ,durchschnitt_anz_maerkte
      ,durchschnitt_preis
      ,anz_wochen
      ,anz_maerkte
      ,umsatz
      ,absatz
      ,b.kjwo AS kjwo_update
FROM _list_enlisted2_1
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_MSI_DATA.nl_listung_kmo_2 (nl_listung_kmo_id
                                 ,mandant_id
                                 ,listung_art
                                 ,sm_id_selected
                                 ,ksm_id_selected
                                 ,sm_id
                                 ,ksm_id
                                 ,gtin
                                 ,ost_basis
                                 ,ost_gross
                                 ,sued_ost
                                 ,sued_west
                                 ,west
                                 ,nord
                                 ,kl_owg_id
                                 ,wg_id
                                 ,art_nielsen_bez
                                 ,umsatz_artikel
                                 ,durchschnitt_anz_maerkte
                                 ,durchschnitt_preis
                                 ,anz_wochen
                                 ,anz_maerkte
                                 ,umsatz_hr
                                 ,absatz_hr
                                 ,kjwo_update)
SELECT (ROW_NUMBER() OVER (
		ORDER BY ${mandant_id}
	,'Einlistung Potenzialartikel'
	,sm_id_selected
	,sm_id
	,gtin
	,ost_basis
	,ost_gross
	,sued_ost
	,sued_west
	,west
	,nord
	,kl_owg_id
	,wg_id
	,nielsen_art_bez
	,umsatz_artikel
	,durchschnitt_anz_maerkte
	,durchschnitt_preis
	,anz_wochen
	,anz_maerkte
	,umsatz
	,absatz
	,b.kjwo
		) + COALESCE((SELECT MAX(nl_listung_kmo_id) FROM dbp_msi_data.nl_listung_kmo_2 WHERE nl_listung_kmo_id <> 0),0) ) AS nl_listung_kmo_id
      ,${mandant_id} as mandant_id
      ,'Einlistung Potenzialartikel' AS listung_art
      ,sm_id_selected
      ,ksm_id_selected
      ,sm_id
      ,ksm_id
      ,gtin
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,nord
      ,kl_owg_id
      ,wg_id
      ,nielsen_art_bez
      ,umsatz_artikel
      ,durchschnitt_anz_maerkte
      ,durchschnitt_preis
      ,anz_wochen
      ,anz_maerkte
      ,umsatz
      ,absatz
      ,b.kjwo AS kjwo_update
FROM _list_enlisted2_1
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;
