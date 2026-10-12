CREATE OR REPLACE VOLATILE TABLE _list_enlisted1 AS (
SELECT 1 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
                   gtin_id
            FROM DBP_ETL.art_matching_nielsen_per
            GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
           c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
           b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
	   a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 1 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
);

INSERT INTO _list_enlisted1
SELECT 1 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
	       a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 1 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 2 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
            a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 2 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 3 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 3 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 4 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 4 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 5 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT a.wg_id,
             a.sm_id,
             COUNT(DISTINCT a.wup_id) AS anz_maerkte
      FROM DBP_DATA.sm_wup_wg_zu_per a
      JOIN DBP_DATA.wup b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      JOIN DBP_DATA.wg_filter_zu wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 5 AND 5 AND
            b.nb_id = 0
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _enlistment_potential AS (
SELECT b.kreistyp_gruppe_id,
       a.wg_id,
       a.wup_id,
       a.sm_id
FROM DBP_DATA.sm_wup_wg_zu_per a
JOIN DBP_DATA.wup b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
JOIN DBP_DATA.wg_filter_zu wfz
  ON a.wg_id = wfz.wg_id AND 
     a.mandant_id = wfz.mandant_id AND 
     wfz.wg_filter_id = 11 AND 
     wfz.arthiertyp_id = 2
WHERE a.mandant_id = 1 AND
      a.spr_id = 22 AND
      a.arthiertyp_id = 2 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
      a.sm_id BETWEEN 1 AND 5 AND
      b.nb_id = 0
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _list_enlisted1_region_only AS (
SELECT 0 AS sm_id_selected,
       sm_id,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'N' THEN 'x' ELSE '-' END AS nord,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'M' THEN 'x' ELSE '-' END AS sued_west,
       CASE WHEN trim(x.kreistyp_gruppe_id) = 'W' THEN 'x' ELSE '-' END AS west,
       a.kl_owg_id,
       a.wg_id,
       a.gtin,
       a.nielsen_art_bez,
       a.umsatz_artikel,
       a.kl_markt_anteil_owg,
       a.durchschnitt_anz_maerkte,
       a.durchschnitt_preis,
       a.anz_wochen,
       x.anz_maerkte 
FROM _list_enlisted1 a
JOIN (SELECT wg_id,
             kreistyp_gruppe_id,
             COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
      WHERE trim(kreistyp_gruppe_id) IN ('O','G','M','N','Q','W')
      GROUP BY 1,2) x
  ON a.wg_id = x.wg_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
);

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
             COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
      WHERE trim(kreistyp_gruppe_id) = 'N' AND
            sm_id < 2
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
             COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
	   'x' AS nord,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'N' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   'x' AS ost_basis,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'O' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
       c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
             sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 2
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 3
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 4
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'Q' AND
	        sm_id < 5
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 2
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND 
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 3
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
                   kl_owg_id
	    FROM DBP_ETL.art_matching_nielsen_per
	    GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	   c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	   b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 4
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'G' AND
	        sm_id < 5
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 2
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 3
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 4
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'M' AND
	        sm_id < 5
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
 WHERE a.gtin IS NOT NULL AND
       a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 2
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 2 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 2
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 3
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 3 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 3
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 4
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 4 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 4
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT b.gtin_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
				   gtin_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON CAST(a.gtin AS DECIMAL(18,0)) = b.gtin_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 5
	  GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.art_id IS NOT NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT 5 AS sm_id_selected,
c.sm_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
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
FROM DBP_DATA.sortiment_leistung a
JOIN (SELECT kl_owg_id,
             MAX(c.wg_id) AS wg_id
      FROM DBP_ETL.bf_sort_sal_export a
      JOIN (SELECT art_id,
	   		       kl_owg_id
	        FROM DBP_ETL.art_matching_nielsen_per
	        GROUP BY 1,2) b
        ON cast(a.art_nr as int) = floor(b.art_id/100)
      JOIN DBP_DATA.art_wg_zu_per c
        ON c.mandant_id = 1 AND
           c.arthiertyp_id = 2 AND
	       c.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
	       b.art_id = c.art_id
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
JOIN (SELECT wg_id,
       sm_id,
			 COUNT(DISTINCT wup_id) AS anz_maerkte
      FROM _enlistment_potential
	  WHERE trim(kreistyp_gruppe_id) = 'W' AND
	        sm_id < 5
      GROUP BY 1,2) c
  ON b.wg_id = c.wg_id
WHERE a.gtin IS NOT NULL AND
      a.art_id IS NULL AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1) AND
      a.mandant_id = 1
;

INSERT INTO _list_enlisted1
SELECT *
FROM _list_enlisted1_region_only
;

CREATE OR REPLACE VOLATILE TABLE _list_enlisted2 AS (
SELECT sm_id_selected,
       sm_id,
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
       erg3*anz_maerkte*52 AS umsatz,
       ZEROIFNULL(umsatz/NULLIFZERO(durchschnitt_preis)) AS absatz
FROM _list_enlisted1
);

DELETE FROM dbp_msi_data.nl_listung
WHERE kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

INSERT INTO dbp_msi_data.nl_listung (nl_listung_id
                                 ,mandant_id
                                 ,listung_art
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
       ORDER BY 
       sm_id_selected
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
      		) + COALESCE((SELECT MAX(nl_listung_id) FROM dbp_msi_data.nl_listung WHERE nl_listung_id <> 0),0) ) AS nl_listung_id
      ,1 AS mandant_id
      ,'Listung erweitern' AS listung_art
      ,a.sm_id_selected
      ,a.sm_id
      ,a.gtin
      ,a.ost_basis
      ,a.ost_gross
      ,a.sued_ost
      ,a.sued_west
      ,a.west
      ,a.nord
      ,a.kl_owg_id
      ,a.wg_id
      ,a.nielsen_art_bez
      ,a.umsatz_artikel
      ,a.durchschnitt_anz_maerkte
      ,a.durchschnitt_preis
      ,a.anz_wochen
      ,a.anz_maerkte
      ,a.umsatz
      ,a.absatz
      ,b.kjwo AS kjwo_update
FROM _list_enlisted2 a
JOIN DBP_DATA.woche b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

INSERT INTO dbp_msi_data.nl_listung (nl_listung_id
                                 ,mandant_id
                                 ,listung_art
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
       ORDER BY 
       sm_id_selected
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
      		) + COALESCE((SELECT MAX(nl_listung_id) FROM dbp_msi_data.nl_listung WHERE nl_listung_id <> 0),0) ) AS nl_listung_id
      ,1 AS mandant_id
      ,'Einlistung Potenzialartikel' AS listung_art
      ,a.sm_id_selected
      ,a.sm_id
      ,a.gtin
      ,a.ost_basis
      ,a.ost_gross
      ,a.sued_ost
      ,a.sued_west
      ,a.west
      ,a.nord
      ,a.kl_owg_id
      ,a.wg_id
      ,a.nielsen_art_bez
      ,a.umsatz_artikel
      ,a.durchschnitt_anz_maerkte
      ,a.durchschnitt_preis
      ,a.anz_wochen
      ,a.anz_maerkte
      ,a.umsatz
      ,a.absatz
      ,b.kjwo AS kjwo_update
FROM _list_enlisted2 a
JOIN DBP_DATA.woche b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;
