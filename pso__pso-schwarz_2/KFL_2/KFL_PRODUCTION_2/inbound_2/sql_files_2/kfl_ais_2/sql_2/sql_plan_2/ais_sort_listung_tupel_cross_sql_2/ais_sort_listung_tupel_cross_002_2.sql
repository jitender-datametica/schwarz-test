CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per AS (
SELECT a.*
FROM DBP_DATA.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.arthiertyp_id = 2 AND
	 b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      trim(a.list_quelle_id) IN ('1','3','7','C') AND
      floor(a.art_id/100) = a.struktur_art_id AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE 
);

CREATE OR REPLACE VOLATILE TABLE _fall1 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per_2 a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.herst_id > -2 AND
      b.status_2 = 'G'
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
      FROM DBP_ETL.art_matching_nielsen_per_2 a
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

CREATE OR REPLACE VOLATILE TABLE _x1_fall1 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       b.art_id
FROM _fall1_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _x2_fall1 AS (
SELECT a.mandant_id,
       b.art_id,
       a.sm_id
FROM _fall1_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

UPDATE DBP_MSI_DATA.kl_listung_2 

SET erweiterung_fg = 0,
    reduktion_fg = 0

FROM (SELECT mandant_id,
             art_id
      FROM _x1_fall1
      GROUP BY 1,2) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 

SET erweiterung_fg = 1

FROM (SELECT *
      FROM _x2_fall1) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected < b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung erweitern' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 

SET reduktion_fg = 1

FROM (SELECT *
      FROM _x2_fall1) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected > b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung reduzieren' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall2 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per_2 a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN (SELECT x.mandant_id,
             x.art_matching_id
      FROM (SELECT mandant_id,
                   art_matching_id,
                   umrech_faktor,
                   COUNT(*) AS anzahl
            FROM DBP_ETL.art_matching_nielsen_per_2
            WHERE status_2 = 'G'
            GROUP BY 1,2,3) x
      GROUP BY 1,2
      HAVING MAX(anzahl) = 1) c
  ON b.mandant_id = c.mandant_id AND
     b.art_matching_id = c.art_matching_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.status_2 = 'G'
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
      FROM DBP_ETL.art_matching_nielsen_per_2 a
      JOIN _fall2 b
        ON a.art_matching_id = b.art_matching_id
      JOIN DBP_ETL_PROCESS.art_sm_vw_zu_per_2 c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id
      WHERE c.mandant_id = 1 AND
            CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      GROUP BY 1,2,3) x
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _x1_fall2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       b.art_id
FROM _fall2_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _x2_fall2 AS (
SELECT a.mandant_id,
       b.art_id,
       a.sm_id
FROM _fall2_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

UPDATE DBP_MSI_DATA.kl_listung_2 

SET erweiterung_fg = 0,
    reduktion_fg = 0

FROM (SELECT mandant_id,
             art_id
      FROM _x1_fall2
      GROUP BY 1,2) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 

SET erweiterung_fg = 1

FROM (SELECT *
      FROM _x2_fall2) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected < b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung erweitern' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 

SET reduktion_fg = 1

FROM (SELECT *
      FROM _x2_fall2) b

WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected > b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung reduzieren' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall3 AS (
SELECT b.art_matching_id
FROM DBP_DATA.art_gp_zu_per_2 a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN (SELECT x.mandant_id,
             x.art_matching_id
      FROM (SELECT mandant_id,
                   art_matching_id,
                   umrech_faktor,
                   COUNT(*) AS anzahl
            FROM DBP_ETL.art_matching_nielsen_per_2
            WHERE status_2 = 'G'
            GROUP BY 1,2,3) x
      GROUP BY 1,2
      HAVING MAX(anzahl) > 1) c
  ON b.mandant_id = c.mandant_id AND
     b.art_matching_id = c.art_matching_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      b.status_2 = 'G'
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
FROM DBP_ETL.art_matching_nielsen_per_2 a
JOIN _fall3 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.art_wg_zu_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per_2 e
  ON a.mandant_id = e.mandant_id AND
     d.wg_id = e.wg_id AND
     c.wup_id = e.wup_id
JOIN DBP_DATA.wup_2 f
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
FROM DBP_ETL.art_matching_nielsen_per_2 a
JOIN _fall3 b
  ON a.art_matching_id = b.art_matching_id
JOIN DBP_DATA.art_wg_zu_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per_2 e
  ON a.mandant_id = e.mandant_id AND
	 d.wg_id = e.wg_id
JOIN DBP_DATA.wup_2 f
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

CREATE OR REPLACE VOLATILE TABLE _x1_fall3 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       b.art_id
FROM _fall3_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _x2_fall3 AS (
SELECT a.mandant_id,
       b.art_id,
       a.sm_id
FROM _fall3_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

UPDATE DBP_MSI_DATA.kl_listung_2 
SET erweiterung_fg = 0,
    reduktion_fg = 0

FROM (SELECT mandant_id,
                                                          art_id
                                                   FROM _x1_fall3
                                                   GROUP BY 1,2) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 
SET erweiterung_fg = 1

FROM (SELECT *
                                                   FROM _x2_fall3) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected < b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung erweitern' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 
SET reduktion_fg = 1

FROM (SELECT *
                                                   FROM _x2_fall3) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected > b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung reduzieren' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _fall4 AS (
SELECT b.art_matching_id
FROM DBP_ETL.art_matching_nielsen_per_2 b
WHERE b.status_2 = 'T'
);

CREATE OR REPLACE VOLATILE TABLE _fall4_upd_sst1 AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.art_id,
	   e.wg_id,
	   c.wup_id,
	   f.kreistyp_gruppe_id,
	   e.sm_id
FROM DBP_ETL.art_matching_nielsen_per_2 a
JOIN _fall4 b
  ON a.art_matching_id = b.art_matching_id
JOIN _art_list_wup_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN DBP_DATA.art_wg_zu_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per_2 e
  ON a.mandant_id = e.mandant_id AND
     d.wg_id = e.wg_id AND
	 c.wup_id = e.wup_id
JOIN DBP_DATA.wup_2 f
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

CREATE OR REPLACE VOLATILE TABLE _fall4_upd_sst2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
	   a.art_id,
	   e.wg_id,
	   e.wup_id,
	   f.kreistyp_gruppe_id,
	   e.sm_id
FROM DBP_ETL.art_matching_nielsen_per_2 a
JOIN _fall4 b
  ON a.art_matching_id = b.art_matching_id
JOIN DBP_DATA.art_wg_zu_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     d.arthiertyp_id = 2 AND
     d.dat_bis = '9999-12-31'
JOIN DBP_DATA.sm_wup_wg_zu_per_2 e
  ON a.mandant_id = e.mandant_id AND
	 d.wg_id = e.wg_id
JOIN DBP_DATA.wup_2 f
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

CREATE OR REPLACE VOLATILE TABLE _x1_fall4 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       b.art_id
FROM _fall4_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _x2_fall4 AS (
SELECT a.mandant_id,
       b.art_id,
       MIN(a.sm_id) AS sm_id
FROM _fall4_update_sst a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_matching_id = b.art_matching_id
GROUP BY 1,2
);

UPDATE DBP_MSI_DATA.kl_listung_2 
SET erweiterung_fg = 0,
    reduktion_fg = 0

FROM (SELECT mandant_id,
                                                          art_id
                                                   FROM _x1_fall4
                                                   GROUP BY 1,2) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 
SET erweiterung_fg = 1

FROM (SELECT *
                                                   FROM _x2_fall4) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected < b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung erweitern' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_2 
SET reduktion_fg = 1

FROM (SELECT *
                                                   FROM _x2_fall4) b
                                    WHERE DBP_MSI_DATA.kl_listung.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung.sm_id_selected > b.sm_id AND
      DBP_MSI_DATA.kl_listung.listung_art = 'Listung reduzieren' AND
      DBP_MSI_DATA.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;
