/* translated to SF by konopkaw / 2021-06-03 */

DROP TABLE IF EXISTS DBP_ETL.anz_wo_listung_pre_1;

DROP TABLE IF EXISTS DBP_ETL.st_ab_wg_art_wo_sum_kmo_1;

CREATE TABLE DBP_ETL.st_ab_wg_art_wo_sum_kmo_1 AS (
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.ek_mep,
       a.einstandspreis
FROM DBP_DATA.artbew_wo_sum_1 a
JOIN DBP_DATA.woche_kj_kl_1 c
  ON a.kjwo_kl = c.kjwo_kl

INNER JOIN DBP_DATA.art_wg_zu_per_1 b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND b.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')

INNER JOIN DBP_DATA.wg_filter_zu_1 wfz
ON b.wg_id = wfz.wg_id 
AND a.mandant_id = wfz.mandant_id
AND wfz.wg_filter_id = 47
AND wfz.arthiertyp_id = 2

WHERE a.mandant_id = ${MANDANT_ID}
);

DROP TABLE IF EXISTS DBP_ETL.st_listung_kw_kmo_1;

CREATE TABLE DBP_ETL.st_listung_kw_kmo_1 AS (
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM DBP_ETL.st_ab_wg_art_wo_sum_kmo_1 v01

INNER JOIN DBP_DATA.wup_1 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id

GROUP BY 1,2,3,4,5,6,7
);

DROP TABLE IF EXISTS DBP_ETL.st_listung_sm_kw_kmo_1;

CREATE TABLE DBP_ETL.st_listung_sm_kw_kmo_1 AS (
SELECT a.mandant_id,
       c.kjwo,
       s.sm_id,
       s.ksm_id,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       SUM(a.menge) AS menge,
       SUM(a.umsatz_netto) AS umsatz_netto,
       SUM(a.ek_mep) AS ek_mep,
       SUM(a.einstandspreis) AS einstandspreis
      ,ZEROIFNULL(SUM(a.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.menge end)) AS absatz_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT c.kjwo) END) AS anz_wo_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN a.bewart_id = 1002 THEN c.kjwo end) end) AS anz_wo_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN a.bewart_id = 1001 THEN c.kjwo end) end) AS anz_wo_mit_absatz_af
FROM DBP_DATA.artbew_wo_sum_1 a
INNER JOIN DBP_DATA.woche_kj_kl_1 c
  ON a.kjwo_kl = c.kjwo_kl
  --AND c.akt_wo between -52 and 0
INNER JOIN DBP_DATA.art_wg_zu_per_1 b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND b.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')

INNER JOIN DBP_DATA.wg_filter_zu_1 wfz
ON b.wg_id = wfz.wg_id 
AND a.mandant_id = wfz.mandant_id
AND wfz.wg_filter_id = 47
AND wfz.arthiertyp_id = 2

INNER JOIN DBP_ETL_PROCESS.sm_wup_wg_zu_per_1 s
ON s.mandant_id = a.mandant_id
AND s.wg_id = b.wg_id
AND s.wup_id = a.wup_id
AND s.nb_id = a.nb_id
AND s.nb_id <> 99
AND s.arthiertyp_id = 2
AND s.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')
WHERE a.mandant_id = ${MANDANT_ID} AND
      (s.sm_id BETWEEN 1 AND 5 OR s.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) 
GROUP BY 1,2,3,4,5,6,7,8,9
);

DROP TABLE IF EXISTS DBP_ETL.st_listung_markt_tag_kmo_1;

CREATE TABLE DBP_ETL.st_listung_markt_tag_kmo_1 AS (SELECT
v01.mandant_id
,v03.wg_id
,v01.art_id
,v01.dat
,v02.kjwo
,v01.wup_id
,ZEROIFNULL(SUM(v01.menge)) AS absatz
,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v02.dat) END) AS anzahl_tage_mit_absatz
,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.dat end) end) AS anzahl_tage_mit_absatz_sa
,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.dat end) end) AS anzahl_tage_mit_absatz_af

FROM DBP_DATA.artbew_1 v01

INNER JOIN DBP_DATA.tag_1 v02
ON v01.dat = v02.dat

INNER JOIN DBP_DATA.art_wg_zu_per_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id
AND v03.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')

INNER JOIN DBP_DATA.wg_filter_zu_1 wfz
ON v03.wg_id = wfz.wg_id 
AND v01.mandant_id = wfz.mandant_id
AND wfz.wg_filter_id = 47
AND wfz.arthiertyp_id = 2

INNER JOIN DBP_DATA.wup_1 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id

WHERE v01.mandant_id = ${MANDANT_ID}
GROUP BY 1,2,3,4,5,6
);

--- 

DROP TABLE IF EXISTS DBP_ETL.anz_wo_absatz_pre_1;

CREATE TABLE DBP_ETL.anz_wo_absatz_pre_1 (
	art_id	INTEGER, 
	mandant_id INTEGER, 
        kjwo INTEGER,
	wup_id INTEGER,
	anz_maerkte INTEGER,
	absatz_gesamt	FLOAT, 
	anz_wo_mit_absatz	FLOAT,
        absatz_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_tot_sk1_bis6 FLOAT
);

CREATE TABLE DBP_ETL.anz_wo_listung_pre_1 (
	art_id	INTEGER, 
	mandant_id INTEGER,
        kjwo INTEGER,
	wup_id INTEGER,
	anz_wo_listung_1	FLOAT
);

INSERT INTO DBP_ETL.anz_wo_absatz_pre_1 (art_id,
                                                      mandant_id,
                                                      kjwo,
                                                      wup_id,
                                                      anz_maerkte,
                                                      absatz_gesamt,
                                                      anz_wo_mit_absatz,
                                                      absatz_af_sk1_bis6,
                                                      anz_wo_mit_abs_af_sk1_bis6,
                                                      anz_wo_mit_abs_tot_sk1_bis6)
SELECT a.art_id,
       a.mandant_id,
       a.kjwo,
       a.wup_id,
       COUNT(DISTINCT a.wup_id) AS anz_maerkte,
       SUM(a.absatz)  absatz_gesamt,
       SUM(a.anzahl_wochen_mit_absatz)  anz_wo_mit_absatz,
       SUM(a.absatz_af) absatz_af_sk1_bis6,
       SUM(a.anzahl_wochen_mit_absatz_af) anz_wo_mit_abs_af_sk1_bis6,
       SUM(a.anzahl_wochen_mit_absatz) anz_wo_mit_abs_tot_sk1_bis6
FROM DBP_ETL.st_listung_kw_kmo_1 a
JOIN (SELECT kjwo_sort_von,
             kjwo_sort_bis
      FROM DBP_ETL_PROCESS.sort_monat_woche_1 a
      JOIN DBP_DATA.monat_1 b
        ON a.kjmo_sort = b.kjmo
      WHERE b.akt_mo = -1) b
  ON a.kjwo BETWEEN b.kjwo_sort_von AND b.kjwo_sort_bis
WHERE a.mandant_id = ${MANDANT_ID}
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.anz_wo_listung_pre_1 (art_id,
                                                       mandant_id,
                                                       kjwo,
                                                       wup_id,
                                                       anz_wo_listung_1)
SELECT	a.art_id,
	a.mandant_id,
        a.kjwo,
	a.wup_id,
	SUM(a.listung_id) anz_wo_listung_1
FROM DBP_DATA.art_wup_listung_kjwo_1 a
JOIN (SELECT kjwo_sort_von,
             kjwo_sort_bis
      FROM DBP_ETL_PROCESS.sort_monat_woche_1 a
      JOIN DBP_DATA.monat_1 b
        ON a.kjmo_sort = b.kjmo
      WHERE b.akt_mo = -1) b
  ON a.kjwo BETWEEN b.kjwo_sort_von AND b.kjwo_sort_bis
WHERE a.mandant_id = ${MANDANT_ID}
GROUP BY 1,2,3,4
;

-- 23.03.2018, -dbay-
--
-- Neue Tabelle, um die SDQs nach neuer Definition zu erzeugen.

CREATE OR REPLACE TRANSIENT TABLE _mm_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.art_id,
       a.mandant_id,
       a.kjwo,
       a.wup_id,
       a.anz_wo_listung_1,
       b.anz_maerkte,
       b.absatz_gesamt,
       b.anz_wo_mit_absatz,
       b.absatz_af_sk1_bis6,
       b.anz_wo_mit_abs_af_sk1_bis6,
       b.anz_wo_mit_abs_tot_sk1_bis6
FROM DBP_ETL.anz_wo_listung_pre_1 a
JOIN DBP_ETL.anz_wo_absatz_pre_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

INSERT INTO _mm_${TRANSIENT_TABLE_SUFFIX}
SELECT art_id,
       mandant_id,
       kjwo,
       wup_id,
       anz_wo_listung_1,
       0,
       0,
       0,
       0,
       0,
       0
FROM DBP_ETL.anz_wo_listung_pre_1
WHERE (art_id,mandant_id,kjwo,wup_id) NOT IN (SELECT art_id,mandant_id,kjwo,wup_id FROM _mm_${TRANSIENT_TABLE_SUFFIX})
;

-- 23.03.2018, -dbay-
--
-- Ab hier die urspruenglichen Tabellen, um den Folgeprozess nicht
-- anpassen zu muessen. Allerdings mit der neuen Logik.


DROP TABLE IF EXISTS DBP_ETL.anz_wo_absatz_1;

CREATE TABLE DBP_ETL.anz_wo_absatz_1 (
	art_id	INTEGER, 
	mandant_id	INTEGER, 
        kjwo INTEGER,
	anz_maerkte INTEGER, 
	absatz_gesamt	FLOAT, 
	anz_wo_mit_absatz	FLOAT,
        absatz_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_tot_sk1_bis6 FLOAT
);

INSERT INTO DBP_ETL.anz_wo_absatz_1 (art_id,
                                                  mandant_id,
                                                  kjwo,
                                                  anz_maerkte,
                                                  absatz_gesamt,
                                                  anz_wo_mit_absatz,
                                                  absatz_af_sk1_bis6,
                                                  anz_wo_mit_abs_af_sk1_bis6,
                                                  anz_wo_mit_abs_tot_sk1_bis6)
SELECT a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       a11.kjwo,
       COUNT(DISTINCT a11.wup_id) AS anz_maerkte,
       SUM(a11.absatz_gesamt)  absatz_gesamt,
       SUM(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz,
       SUM(a11.absatz_af_sk1_bis6) absatz_af_sk1_bis6,
       SUM(a11.anz_wo_mit_abs_af_sk1_bis6) anz_wo_mit_abs_af_sk1_bis6,
       SUM(a11.anz_wo_mit_abs_tot_sk1_bis6) anz_wo_mit_abs_tot_sk1_bis6
FROM _mm_${TRANSIENT_TABLE_SUFFIX} a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2,3
;

DROP TABLE IF EXISTS DBP_ETL.anz_wo_listung_1;

CREATE TABLE DBP_ETL.anz_wo_listung_1 (
	art_id	INTEGER, 
	mandant_id INTEGER, 
        kjwo INTEGER,
	anz_wo_listung_1	FLOAT
);

INSERT INTO DBP_ETL.anz_wo_listung_1
SELECT a11.art_id ,
       a11.mandant_id,
       a11.kjwo,
       SUM(a11.anz_wo_listung_1) AS anz_wo_listung_1
FROM _mm_${TRANSIENT_TABLE_SUFFIX} a11
GROUP BY 1,2,3
;
