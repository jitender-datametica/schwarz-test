----------------
---PREPARATION--
----------------

CREATE OR REPLACE TABLE dbp_etl.sal_wochen as
(
SELECT X.MANDANT_ID,
       X.KJWO
FROM (SELECT B.MANDANT_ID,
             C.KJWO,
             RANK() OVER (PARTITION BY B.MANDANT_ID ORDER BY B.MANDANT_ID,C.KJWO DESC) * (-1) AS AKT_WO
      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM A
      JOIN (SELECT MANDANT_ID,
                   MAX(KJMO) AS KJMO
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE MANDANT_ID > 1
            GROUP BY 1) B
        ON A.KJMO_SORT = B.KJMO
      JOIN DBP_DATA.WOCHE C
        ON C.KJWO <= A.KJWO_BIS) X
WHERE X.AKT_WO BETWEEN -52 AND -1
GROUP BY 1,2
);


CREATE OR REPLACE TABLE dbp_etl.sal_monat as
(
SELECT MANDANT_ID,
       MAX(KJMO) AS KJMO
FROM dbp_data.art_nielsen_fakten_kjmo
WHERE MANDANT_ID > 1
GROUP BY 1
);

CREATE OR REPLACE TABLE dbp_etl.st_ab_wg_art_wo_sum_kmo AS 
(
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
FROM dbp_data.artbew_wo_sum a
JOIN dbp_data.woche_kj_kl c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND b.arthiertyp_id = 2
AND b.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
JOIN dbp_etl.sal_wochen d
  on a.mandant_id = d.mandant_id and 
  c.kjwo = d.kjwo
); 

CREATE OR REPLACE TABLE dbp_etl.st_listung_kw_kmo AS (
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
FROM dbp_etl.st_ab_wg_art_wo_sum_kmo v01
  JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
GROUP BY 1,2,3,4,5,6,7
) ;

CREATE OR REPLACE TABLE dbp_etl.st_listung_sm_kw_kmo AS (
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
FROM dbp_data.artbew_wo_sum a
 JOIN dbp_data.woche_kj_kl c
  ON a.kjwo_kl = c.kjwo_kl
 JOIN dbp_data.art_wg_zu_per b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND b.arthiertyp_id = 2
AND b.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
 JOIN dbp_etl_process.sm_wup_wg_zu_per s
  ON s.mandant_id = a.mandant_id
 AND s.wg_id = b.wg_id
 AND s.wup_id = a.wup_id
 AND s.nb_id = a.nb_id
 AND s.nb_id <> 99
 AND s.arthiertyp_id = 2
 AND s.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
 JOIN dbp_etl.sal_wochen d
  on a.mandant_id = d.mandant_id and 
  c.kjwo = d.kjwo
WHERE
(s.sm_id BETWEEN 1 AND 5 OR s.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) 
GROUP BY 1,2,3,4,5,6,7,8,9
)
; 

CREATE OR REPLACE TABLE dbp_etl.st_listung_markt_tag_kmo AS 
(
  SELECT
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
  FROM dbp_data.artbew v01
    JOIN dbp_data.tag v02
    ON v01.dat = v02.dat
  JOIN dbp_data.art_wg_zu_per v03
    ON v01.mandant_id = v03.mandant_id
    AND v01.art_id = v03.art_id
    AND v03.arthiertyp_id = 2
    AND v03.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
  JOIN dbp_data.wup v04
    ON v01.wup_id = v04.wup_id  
    AND v01.nb_id = v04.nb_id  
    AND v01.mandant_id = v04.mandant_id
  JOIN dbp_etl.sal_wochen d
  on v01.mandant_id = d.mandant_id and 
  v02.kjwo = d.kjwo
  GROUP BY 1,2,3,4,5,6
) ;


CREATE OR REPLACE TABLE dbp_etl.anz_wo_absatz_pre (
	art_id	INTEGER, 
	mandant_id BYTEINT, 
        kjwo INTEGER,
	wup_id INTEGER,
	anz_maerkte INTEGER,
	absatz_gesamt	FLOAT, 
	anz_wo_mit_absatz	FLOAT,
        absatz_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_af_sk1_bis6 FLOAT,
	anz_wo_mit_abs_tot_sk1_bis6 FLOAT
) ;


CREATE OR REPLACE TABLE dbp_etl.anz_wo_listung_pre (
	art_id	INTEGER, 
	mandant_id BYTEINT,
        kjwo INTEGER,
	wup_id INTEGER,
	anz_wo_listung	FLOAT
)
;

INSERT INTO dbp_etl.anz_wo_absatz_pre (art_id,
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
FROM dbp_etl.st_listung_kw_kmo a
JOIN dbp_etl.sal_wochen b
  on a.mandant_id = b.mandant_id and 
  a.kjwo = b.kjwo
GROUP BY 1,2,3,4
;


INSERT INTO dbp_etl.anz_wo_listung_pre (art_id,
                                                       mandant_id,
                                                       kjwo,
                                                       wup_id,
                                                       anz_wo_listung)
SELECT	a.art_id,
	a.mandant_id,
        a.kjwo,
	a.wup_id,
	SUM(a.listung_id) anz_wo_listung
FROM dbp_data.art_wup_listung_kjwo a
JOIN dbp_etl.sal_wochen b
  on a.mandant_id = b.mandant_id and 
  a.kjwo = b.kjwo
GROUP BY 1,2,3,4
;

CREATE OR REPLACE TABLE dbp_etl.mm AS (
SELECT a.art_id,
       a.mandant_id,
       a.kjwo,
       a.wup_id,
       a.anz_wo_listung,
       b.anz_maerkte,
       b.absatz_gesamt,
       b.anz_wo_mit_absatz,
       b.absatz_af_sk1_bis6,
       b.anz_wo_mit_abs_af_sk1_bis6,
       b.anz_wo_mit_abs_tot_sk1_bis6
FROM dbp_etl.anz_wo_listung_pre a
JOIN dbp_etl.anz_wo_absatz_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

INSERT INTO dbp_etl.mm
SELECT art_id,
       mandant_id,
       kjwo,
       wup_id,
       anz_wo_listung,
       0,
       0,
       0,
       0,
       0,
       0
FROM dbp_etl.anz_wo_listung_pre
WHERE (art_id,mandant_id,kjwo,wup_id) NOT IN (SELECT art_id,mandant_id,kjwo,wup_id FROM dbp_etl.mm )
;

--

CREATE OR REPLACE TABLE dbp_etl.anz_wo_absatz (
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

INSERT INTO dbp_etl.anz_wo_absatz (art_id,
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
FROM dbp_etl.mm a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2,3
;

CREATE OR REPLACE TABLE dbp_etl.anz_wo_listung (
	art_id	INTEGER, 
	mandant_id INTEGER, 
        kjwo INTEGER,
	anz_wo_listung	FLOAT
);

INSERT INTO dbp_etl.anz_wo_listung
SELECT a11.art_id ,
       a11.mandant_id,
       a11.kjwo,
       SUM(a11.anz_wo_listung) AS anz_wo_listung
FROM dbp_etl.mm a11
GROUP BY 1,2,3
;

-----------
--LOOKUPS--
-----------

CREATE OR REPLACE VOLATILE TABLE _lkp_lieferant as (
SELECT
v01.mandant_id
,v01.art_id
,v01.gp_id
,v02.gp_name
,COUNT(*) AS anz_lief
FROM dbp_data.art_gp_nm_zu_per v01
JOIN dbp_data.gp v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
WHERE v01.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
AND v01.gp_id <> -1
and v01.mandant_id in (2,3,5,6,7,8)
GROUP BY 1, 2, 3, 4
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, art_id ORDER BY anz_lief DESC) = 1
); 


CREATE OR REPLACE VOLATILE TABLE _lkp_wg as ( 
select distinct
a1.mandant_id, a1.art_id, a1.wg_id, a1.wug_id, w1.owg_id
FROM dbp_data.art_wg_zu_per a1
INNER JOIN dbp_data.wg_per w1
ON w1.wg_id = a1.wg_id
AND w1.mandant_id = a1.mandant_id
AND w1.arthiertyp_id = 2
AND w1.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
WHERE a1.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD') and a1.mandant_id in (2,3,5,6,7,8)
);

CREATE OR REPLACE VOLATILE TABLE _lkp_kol as ( 
SELECT
v02.mandant_id
, v02.art_id
, COALESCE(v03.umrech_faktor, 1) AS kolli_faktor
, v02.bezugsweg_id
FROM
(
SELECT
art_id
, mandant_id
, best_menge_einh_id AS menge_einh_id
, 1 AS bezugsweg_id
FROM dbp_data.art
WHERE dat_bis = '9999-12-31' and mandant_id in (2,3,5,6,7,8)
) v02

LEFT OUTER JOIN
(
SELECT
art_id
, mandant_id
, altnv_menge_einh_id
, umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per
WHERE dat_bis = '9999-12-31'
) v03
ON v02.art_id = v03.art_id
AND v02.mandant_id = v03.mandant_id
AND v02.menge_einh_id = v03.altnv_menge_einh_id
and v02.mandant_id in (2,3,5,6,7,8)

union

SELECT
v02.mandant_id
, v02.art_id
, COALESCE(v03.umrech_faktor, 1) AS kolli_faktor
, v02.bezugsweg_id
FROM
(
SELECT
art_id
, mandant_id
, ausg_menge_einh_id AS menge_einh_id
, 4 AS bezugsweg_id
FROM dbp_data.art_vorschlagswert_per
WHERE dat_bis = '9999-12-31' and mandant_id in (2,3,5,6,7,8)
) v02

LEFT OUTER JOIN
(
SELECT
art_id
, mandant_id
, altnv_menge_einh_id
, umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per
WHERE dat_bis = '9999-12-31'
) v03
ON v02.art_id = v03.art_id
AND v02.mandant_id = v03.mandant_id
AND v02.menge_einh_id = v03.altnv_menge_einh_id and v02.mandant_id in (2,3,5,6,7,8)
);


CREATE OR REPLACE VOLATILE TABLE _lkp_durchg_listung as ( 
SELECT a.art_id,
       a.mandant_id,
       MIN(a.sm_id) AS min_durchg_gelistet_sst
FROM (SELECT v01.mandant_id
           , v01.art_id
           , v01.sm_id
           , v01.list_durchg_fg
      FROM dbp_data.sternchen_logik v01
      JOIN dbp_data.l_sternchen v02
      ON v01.mandant_id = v02.mandant_id AND 
         v01.list_durchg_fg = v02.list_durchg_fg AND 
         v01.bezugsweg1_fg = v02.bezugsweg1_fg AND 
         v01.bezugsweg4_fg = v02.bezugsweg4_fg AND 
         v01.kdis0_fg = v02.kdis0_fg AND 
         v01.kdis1_fg = v02.kdis1_fg) a
WHERE a.list_durchg_fg = 1 and a.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2 ) ;

CREATE OR REPLACE VOLATILE TABLE _lkp_vk_pk as ( 
SELECT
art_id,
mandant_id,
MAX(CASE  WHEN  pm_id = 1 THEN vk_brutto END)  AS VKPK1,
MAX(CASE  WHEN  pm_id = 4 THEN vk_brutto END)  AS VKPK4
FROM  dbp_data.art_pm_vw_zu_per
WHERE  CURRENT_DATE BETWEEN dat_von AND dat_bis
AND preistyp_id = 0 and mandant_id in (2,3,5,6,7,8)
GROUP BY art_id, mandant_id);

/*
CREATE OR REPLACE VOLATILE TABLE _lkp_stk_ek_kb_stamm as ( 
SELECT a.mandant_id
      ,a.art_id
      ,MAX(CAST((a.einstandspreis ) AS DECIMAL(18,4))) AS einstandspreis
FROM dbp_data.art_gp_wup_zu_per a
JOIN (SELECT mandant_id,
             art_id,
             gp_id, 
             COUNT(*) anz_wup
      FROM dbp_data.art_gp_nm_zu_per
      WHERE dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
      GROUP BY 1,2,3
      QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,art_id  ORDER BY anz_wup DESC) = 1) b
  ON a.art_id = b.art_id AND 
     a.mandant_id = b.mandant_id AND 
     a.gp_id = b.gp_id
WHERE a.wup_id = -1 and
      a.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD') and a.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2);
*/

CREATE OR REPLACE VOLATILE TABLE _lkp_stk_ek_kb_stamm as ( 
SELECT mandant_id
      ,art_id
      ,MAX(CAST((einstandspreis ) AS DECIMAL(18,4))) AS einstandspreis
FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_EINKAUFSPREISSTAMM_AKT WHERE mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2);


CREATE OR REPLACE VOLATILE TABLE _lkp_spanne as ( 
SELECT a.mandant_id,
       a.art_id,
       MAX(CASE WHEN b.einstandspreis IS NULL THEN NULL ELSE (1.0 - ZEROIFNULL((b.einstandspreis/NULLIFZERO((c.VKPK1/NULLIFZERO(d.mwst)))))) END)  Sp_EKKB_01,
       MAX(CASE WHEN b.einstandspreis IS NULL THEN NULL ELSE (1.0 - ZEROIFNULL((b.einstandspreis/NULLIFZERO((c.VKPK4/NULLIFZERO(d.mwst)))))) END)  Sp_EKKB_04
FROM dbp_data.art a
LEFT JOIN (SELECT a.mandant_id
                 ,a.art_id
                 ,MAX(CAST((a.einstandspreis ) AS DECIMAL(18,4))) AS einstandspreis
           FROM dbp_data.art_gp_wup_zu_per a
           JOIN (SELECT mandant_id,
                        art_id,
                        gp_id, 
                        COUNT(*) anz_wup
                 FROM dbp_data.art_gp_nm_zu_per
                 WHERE dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
                 GROUP BY 1,2,3
                 QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,art_id  ORDER BY anz_wup DESC) = 1) b
             ON a.art_id = b.art_id AND 
                a.mandant_id = b.mandant_id AND 
                a.gp_id = b.gp_id
           WHERE a.wup_id = -1 AND
                 a.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
           GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN (SELECT art_id,
                  mandant_id,
                  MAX(CASE  WHEN  pm_id = 1 THEN vk_brutto END)  AS VKPK1,
                  MAX(CASE  WHEN  pm_id = 4 THEN vk_brutto END)  AS VKPK4
           FROM dbp_data.art_pm_vw_zu_per
           WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis AND 
		 preistyp_id = 0
           GROUP BY art_id, mandant_id) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN (SELECT b.art_id,
	              b.mandant_id,
	             (ZEROIFNULL((MAX(a.mwst) / 100.0)) + 1.0) AS mwst
           FROM (SELECT mandant_id
                       ,mwst_id
                       ,mwst
                 FROM dbp_data.mwst_per
                 WHERE 
		       CURRENT_DATE BETWEEN dat_von AND dat_bis) a
           JOIN dbp_data.art b
             ON a.mandant_id = b.mandant_id AND
                a.mwst_id = b.mwst_id
	   GROUP BY 1,2) d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id 
     where a.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2);


CREATE OR REPLACE VOLATILE TABLE _lkp_absatz_listung_woche as (  
SELECT a.art_id,
       a.mandant_id,
       b.absatz_gesamt,
       c.anz_wo_listung,
       b.anz_wo_mit_absatz,
       b.anz_maerkte,
       b.absatz_af_sk1_bis6,
       b.anz_wo_mit_abs_af_sk1_bis6,
       b.anz_wo_mit_abs_tot_sk1_bis6
FROM (SELECT art_id,
             mandant_id,
             kjwo
      FROM dbp_etl.anz_wo_absatz
      GROUP BY 1,2,3
      UNION
      SELECT art_id,
             mandant_id,
             kjwo
      FROM dbp_etl.anz_wo_listung
      GROUP BY 1,2,3) a
LEFT JOIN dbp_etl.anz_wo_absatz b
  ON a.art_id = b.art_id AND 
     a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo
LEFT JOIN dbp_etl.anz_wo_listung c
  ON a.art_id = c.art_id AND 
     a.mandant_id = c.mandant_id AND
     a.kjwo = c.kjwo
WHERE a.mandant_id in (2,3,5,6,7,8)
);


CREATE OR REPLACE VOLATILE TABLE _lkp_abschriften as ( 
SELECT a.mandant_id,
       a.art_id,
       SUM(a.abschriftbetrag_netto) AS abschriftbetrag_netto
FROM dbp_data.marktabschriften a
JOIN dbp_data.tag b
  ON a.dat = b.dat
JOIN dbp_etl.sal_wochen d
  on a.mandant_id = d.mandant_id and 
  b.kjwo = d.kjwo
JOIN (SELECT mandant_id,
             art_id
      FROM dbp_etl.st_listung_sm_kw_kmo
      GROUP BY 1,2) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.abschriftart_id BETWEEN 905 AND 994 AND a.mandant_id in (2,3,5,6,7,8) AND 
      NOT (a.abschriftart_id = 955 AND a.mandant_id = 2)
  GROUP BY 1,2
);


CREATE OR REPLACE VOLATILE TABLE _lkp_absatz_sa_tag as ( 
SELECT a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       SUM(a11.absatz_sa) AS absatz_sa_sk1_bis6,
       SUM(a11.anzahl_tage_mit_absatz_sa) AS anz_tage_mit_abs_sa_sk1_bis6
FROM dbp_etl.st_listung_markt_tag_kmo a11
WHERE a11.mandant_id in (2,3,5,6,7,8)
GROUP BY a11.art_id,a11.mandant_id);

CREATE OR REPLACE VOLATILE TABLE _lkp_absatz_vj as ( 
SELECT a11.art_id,
       a11.mandant_id,
       SUM(a11.absatz) absatz_vj_sk1_bis_6
FROM dbp_etl.st_listung_kw_kmo a11
JOIN dbp_data.woche a12
  ON a11.kjwo = a12.kjwo_vj
WHERE a11.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2
);


CREATE OR REPLACE VOLATILE TABLE _lkp_kassenumsatz1 as (  
SELECT	a.art_id  art_id,
	a.mandant_id  mandant_id,
	SUM(a.umsatz_netto)  kassenumsatz_sk_1_bis_6,
	SUM(a.ek_mep)  ek_mep_ums_sk1_bis_6,
	SUM(a.einstandspreis)  einstandspreis_ums_sk1_bis_6,
	SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto end) AS kassenumsatz_af_sk_1_bis_6,
	SUM(CASE WHEN a.bewart_id = 1002 THEN a.ek_mep end) AS ek_mep_ums_sa_sk1_bis_6,
	SUM(CASE WHEN a.bewart_id = 1002 THEN a.einstandspreis end) AS einstandspreis_ums_sa_sk1_bis_6,
	SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto end) AS kassenumsatz_sa_sk_1_bis_6
FROM dbp_etl.st_listung_sm_kw_kmo a
WHERE a.mandant_id in (2,3,5,6,7,8) 
GROUP BY 1,2);


CREATE OR REPLACE VOLATILE TABLE _lkp_absatz as (  
SELECT a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       SUM((CASE WHEN a11.sm_id = 1 THEN a11.absatz ELSE NULL end))  absatz_sk1,
       SUM((CASE WHEN a11.sm_id = 1 THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk1,
       SUM((CASE WHEN a11.sm_id = 2 THEN a11.absatz ELSE NULL end))  absatz_sk2,
       SUM((CASE WHEN a11.sm_id = 2 THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk2,
       SUM((CASE WHEN a11.sm_id = 3 THEN a11.absatz ELSE NULL end))  absatz_sk3,
       SUM((CASE WHEN a11.sm_id = 3 THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk3,
       SUM((CASE WHEN a11.sm_id = 4 THEN a11.absatz ELSE NULL end))  absatz_sk4,
       SUM((CASE WHEN a11.sm_id = 4 THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk4,
       SUM((CASE WHEN a11.sm_id = 5 THEN a11.absatz ELSE NULL end))  absatz_sk5,
       SUM((CASE WHEN a11.sm_id = 5 THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk5,
       SUM(a11.absatz_af) absatz_af_sk1_bis6,
       SUM(a11.absatz_sa) absatz_sa_sk1_bis6,
       SUM(a11.absatz) absatz_gesamt
FROM dbp_etl.st_listung_sm_kw_kmo a11
WHERE a11.mandant_id in (2,3,5,6,7,8) 
GROUP BY 1,2
);


CREATE OR REPLACE VOLATILE TABLE _lkp_umsatz_vj as ( 
SELECT a11.art_id,
       a11.mandant_id,
       SUM(a11.ek_mep)  ek_mep_ums_sk1_bis_6_vj,
       SUM(a11.einstandspreis)  einstandspreis_ums_sk1_bis_6_vj,
       SUM(a11.umsatz_netto)  kassenumsatz_sk_1_bis_6_vj
FROM dbp_etl.st_listung_sm_kw_kmo a11
JOIN dbp_data.woche a12
  ON a11.kjwo = a12.kjwo_vj
WHERE a11.mandant_id in (2,3,5,6,7,8)
GROUP BY a11.art_id,a11.mandant_id
);


CREATE OR REPLACE VOLATILE TABLE _lkp_ek_mep as ( 
SELECT a11.art_id  art_id,
       a11.mandant_id  mandant_id,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep END)))  mep_af,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep END)))  mep_sa,
      (ZEROIFNULL(SUM(a11.umsatz_netto)) - ZEROIFNULL(SUM(a11.ek_mep)))  mep_tot,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.einstandspreis END)))  einstandspreis_af,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.einstandspreis END)))  einstandspreis_sa,
      (ZEROIFNULL(SUM(a11.umsatz_netto)) - ZEROIFNULL(SUM(a11.einstandspreis)))  einstandspreis_tot,
      (ZEROIFNULL(SUM(a11.umsatz_netto))) umsatz_brutto_tot,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END))) umsatz_brutto_af,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END))) umsatz_brutto_sa
FROM dbp_etl.st_ab_wg_art_wo_sum_kmo a11
WHERE a11.mandant_id in (2,3,5,6,7,8)
GROUP BY 1,2
);

-----------------
--TRANSORMATION--
-----------------

CREATE OR REPLACE TABLE dbp_etl.sal_aggregat_kmo
     (
      wg_id INTEGER,
      temp_wg_id INTEGER,
      temp_owg_id INTEGER,
      temp_wug_id INTEGER,
      mandant_id INTEGER,
      wg_bez VARCHAR(100),
      wug_id INTEGER,
      wug_bez VARCHAR(40),
      art_nr VARCHAR(10),
      art_id INTEGER,
      art_bez VARCHAR(50),
      loesch_id CHAR(2),
      zek VARCHAR(3),
      zek_lang_bez VARCHAR(36),
      eigenmarke_id CHAR(2),
      bio_fg VARCHAR(1),
      tierwohl_kz VARCHAR(9),
      vegan_fg VARCHAR(1),
      posten_food VARCHAR(1),
      posten_nonfood VARCHAR(1),
      gluten_fg VARCHAR(1),
      mwst DECIMAL(12,2),
      aldi_id INTEGER,
      discount_id INTEGER,
      discount_bez VARCHAR(40),
      kol_bst FLOAT,
      kol_la FLOAT,
      mhd_zeitraum_dz INTEGER,
      mhd_zeitraum INTEGER,
      VKPK1 DECIMAL(18,4),
      akt_gp_id INTEGER,
      akt_gp_name VARCHAR(40),
      lactose_fg VARCHAR(1),
      VKPK4 DECIMAL(18,4),
      kreistyp_gruppe_id CHAR(2) ,
      typ_ost_basis CHAR(2) ,
      typ_ost_gross CHAR(2) ,
      typ_sued_ost CHAR(2) ,
      typ_sued_west CHAR(2) ,
      typ_west CHAR(2) ,
      typ_nord CHAR(2) ,
      Sp_EKKB_01 DECIMAL(18,4),
      stk_ek_kb_stamm DECIMAL(18,4),
      WJXBFS1 FLOAT,
      absatz_gesamt FLOAT,
      max_kjwo INTEGER,
      min_kjwo INTEGER,
      min_durchg_gelistet_sst INTEGER,
      Sp_EKKB_04 DECIMAL(18,4),
      kassenumsatz_sk_1_bis_6 FLOAT,
      absatz_sk1 FLOAT,
      absatz_sk2 FLOAT,
      absatz_sk3 FLOAT,
      absatz_sk4 FLOAT,
      absatz_sk5 FLOAT,
      absatz_af_sk1_bis6 FLOAT,
      anz_wo_mit_abs_af_sk1_bis6 FLOAT,
      abschr_vk_o_werbung FLOAT,
      absatz_nord FLOAT,
      absatz_ost_basis FLOAT,
      absatz_ost_gross FLOAT,
      absatz_sued_ost FLOAT,
      absatz_sued_west FLOAT,
      absatz_west FLOAT,
      absatz_sa_sk1_bis6 FLOAT,
      anz_tage_mit_abs_sa_sk1_bis6 FLOAT,
      kassenumsatz_af_sk_1_bis_6 FLOAT,
      anz_wo_mit_abs_ost_basis FLOAT,
      anz_wo_mit_abs_sued_west FLOAT,
      ek_mep_ums_sa_sk1_bis_6 FLOAT,
      einstandspreis_ums_sa_sk1_bis_6 FLOAT,
      anz_wo_listung FLOAT,
      ek_mep_ums_sk1_bis_6_vj FLOAT,
      einstandspreis_ums_sk1_bis_6_vj FLOAT,
      anz_wo_mit_abs_west FLOAT,
      absatz_vj_sk1_bis_6 FLOAT,
      anz_wo_mit_abs_sk2 FLOAT,
      kassenumsatz_sk_1_bis_6_vj FLOAT,
      anz_wo_mit_abs_nord FLOAT,
      mep_tot FLOAT,
      mep_af FLOAT,
      mep_sa FLOAT,
      einstandspreis_tot FLOAT,
      einstandspreis_af FLOAT,
      einstandspreis_sa FLOAT,
      anz_wo_mit_absatz FLOAT,
      anz_wo_mit_abs_sk4 FLOAT,
      anz_wo_mit_abs_sk1 FLOAT,
      ek_mep_ums_sk1_bis_6 FLOAT,
      einstandspreis_ums_sk1_bis_6 FLOAT,
      kassenumsatz_sa_sk_1_bis_6 FLOAT,
      anz_wo_mit_abs_sk3 FLOAT,
      anz_wo_mit_abs_sued_ost FLOAT,
      anz_wo_mit_abs_sk5 FLOAT,
      anz_wo_mit_abs_ost_gross FLOAT,
      umsatz_brutto_tot FLOAT,
      umsatz_brutto_af FLOAT,
      umsatz_brutto_sa FLOAT,
      anz_wo_mit_abs_tot_sk1_bis6 FLOAT,
      anz_maerkte INTEGER
);

CREATE OR REPLACE TABLE dbp_etl.prep_sal_aggregat_kmo as ( 
SELECT a.mandant_id
, a.art_id
, a.kl_art_id
, a.zek_id
, a.eigenmarke_id
, a.bio_fg
, a.loesch_id
, a.vegan_fg
, a.posten_id
, a.gluten_fg
, a.mhd_zeitraum
, a.tierwohl_kz
, a.aldi_id
, COALESCE(c.wug_bez,'k.A.') AS wug_bez
, COALESCE(d.wg_bez,'k.A.') AS wg_bez
, COALESCE(e.zek_name,'k.A.') AS zek_name
, COALESCE(f.art_bez,'k.A.') AS art_bez
, a.discount_id AS disc_marke
, COALESCE(h.mhd_zeitraum_dz,0) AS mhd_zeitraum_dz
, a.lactose_fg
, COALESCE(g.mwst,0.00) AS mwst
, COALESCE(CASE
             WHEN SUM(v02.anzahl_markt_listung) = 0 THEN ' '
             WHEN SUM(v02.anzahl_markt_listung) > 0 THEN 'X'
           END,'k.A') AS aktiv_kz
FROM dbp_data.art a

INNER JOIN dbp_data.art_wg_zu_per b
ON a.mandant_id = b.mandant_id 
AND a.art_id = b.art_id
AND b.arthiertyp_id = 2
AND b.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')

LEFT JOIN (SELECT v01.mandant_id
           , v01.wg_id
           , v01.wug_id
           , v01.wug_bez
      FROM dbp_data.wug_spr_zu v01
      JOIN dbp_data.mandant_spr_zu v02
        ON v01.mandant_id = v02.mandant_id AND
           v01.spr_id = v02.spr_id
      WHERE v01.mandant_id in (2,3,5,6,7,8) AND
            v01.arthiertyp_id = 2) c
  ON a.mandant_id = c.mandant_id AND
     b.wg_id = c.wg_id AND
     b.wug_id = c.wug_id

LEFT JOIN (SELECT v01.mandant_id
           , v01.wg_id
           , v01.wg_bez
      FROM dbp_data.wg_spr_zu v01
      JOIN dbp_data.mandant_spr_zu v02
        ON v01.mandant_id = v02.mandant_id AND
           v01.spr_id = v02.spr_id
      WHERE v01.mandant_id in (2,3,5,6,7,8) AND 
            v01.arthiertyp_id = 2) d
  ON a.mandant_id = d.mandant_id AND
     b.wg_id = d.wg_id

LEFT JOIN (SELECT v01.mandant_id
                , v01.zek_id
                , v01.zek_name
           FROM dbp_data.zek v01
           WHERE v01.mandant_id in (2,3,5,6,7,8) AND 
                 v01.zek_id <> '-1' AND 
                 v01.wbl_id > 0) e
  ON a.mandant_id = e.mandant_id AND
     a.zek_id = e.zek_id

LEFT JOIN (SELECT v01.mandant_id
                , v01.art_id
                , v01.art_bez
           FROM dbp_data.art_spr_zu v01
           JOIN dbp_data.mandant_spr_zu v02
             ON v01.mandant_id = v02.mandant_id AND
                v01.spr_id = v02.spr_id
           WHERE v01.mandant_id in (2,3,5,6,7,8)) f
  ON a.mandant_id = f.mandant_id AND
     a.art_id = f.art_id

LEFT JOIN (SELECT 
           mandant_id
           ,mwst_id
                 ,mwst
           FROM dbp_data.mwst_per
           WHERE mandant_id in (2,3,5,6,7,8) AND
                 dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')) g
  ON a.mwst_id = g.mwst_id and a.mandant_id=g.mandant_id

LEFT JOIN (SELECT mandant_id
            ,art_id
            ,mhd_zeitraum_dz
      FROM dbp_data.art_gp_zu_per
      WHERE mandant_id in (2,3,5,6,7,8) AND 
            dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')) h
  ON a.mandant_id = h.mandant_id AND
     a.art_id = h.art_id

LEFT JOIN dbp_data.sternchen_logik v02
ON v02.mandant_id = a.mandant_id
AND v02.art_id = a.art_id

WHERE a.mandant_id in (2,3,5,6,7,8) and a.art_id > 0

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
);


INSERT INTO dbp_etl.sal_aggregat_kmo
SELECT
      -1 as wg_id ,
      -1 as temp_wg_id ,
      -1 as temp_owg_id ,
      -1 as temp_wug_id ,
      mandant_id ,
      wg_bez ,
      -1 as wug_id ,
      wug_bez ,
      kl_art_id as art_nr ,
      art_id ,
      art_bez ,
      loesch_id ,
      zek_id as zek ,
      zek_name as zek_lang_bez ,
      eigenmarke_id ,
      bio_fg ,
      tierwohl_kz ,
      vegan_fg ,
      CASE WHEN posten_id = 'PF' THEN 'X' ELSE ' ' END AS posten_food ,
      CASE WHEN posten_id = 'PN' THEN 'X' ELSE ' ' END AS posten_nonfood ,
      gluten_fg ,
      mwst ,
      aldi_id ,
      disc_marke as discount_id ,
      ' ' as discount_bez ,
      -1 as kol_bst ,
      -1 as kol_la ,
      mhd_zeitraum_dz ,
      mhd_zeitraum ,
      -1 as VKPK1 ,
      -1 as akt_gp_id ,
      '' as akt_gp_name ,
      lactose_fg ,
      -1 as VKPK4 ,
      ' ' as kreistyp_gruppe_id ,
      ' ' as typ_ost_basis ,
      ' ' as typ_ost_gross ,
      ' ' as typ_sued_ost ,
      ' ' as typ_sued_west ,
      ' ' as typ_west ,
      ' ' as typ_nord ,
      0 as Sp_EKKB_01 ,
      -1 as stk_ek_kb_stamm ,
      1 as WJXBFS1 ,
      0 as absatz_gesamt ,
      0 as max_kjwo ,
      0 as min_kjwo ,
      0 as min_durchg_gelistet_sst ,
      0 as Sp_EKKB_04 ,
      0 as kassenumsatz_sk_1_bis_6 ,
      0 as absatz_sk1 ,
      0 as absatz_sk2 ,
      0 as absatz_sk3 ,
      0 as absatz_sk4 ,
      0 as absatz_sk5 ,
      0 as absatz_af_sk1_bis6 ,
      0 as anz_wo_mit_abs_af_sk1_bis6 ,
      0 as abschr_vk_o_werbung ,
      0 as absatz_nord ,
      0 as absatz_ost_basis ,
      0 as absatz_ost_gross ,
      0 as absatz_sued_ost ,
      0 as absatz_sued_west ,
      0 as absatz_west ,
      0 as absatz_sa_sk1_bis6 ,
      0 as anz_tage_mit_abs_sa_sk1_bis6 ,
      0 as kassenumsatz_af_sk_1_bis_6 ,
      0 as anz_wo_mit_abs_ost_basis ,
      0 as anz_wo_mit_abs_sued_west ,
      0 as ek_mep_ums_sa_sk1_bis_6 ,
      0 as einstandspreis_ums_sa_sk1_bis_6 ,
      0 as anz_wo_listung ,
      0 as ek_mep_ums_sk1_bis_6_vj ,
      0 as einstandspreis_ums_sk1_bis_6_vj ,
      0 as anz_wo_mit_abs_west ,
      0 as absatz_vj_sk1_bis_6 ,
      0 as anz_wo_mit_abs_sk2 ,
      0 as kassenumsatz_sk_1_bis_6_vj ,
      0 as anz_wo_mit_abs_nord ,
      0 as mep_tot ,
      0 as mep_af ,
      0 as mep_sa ,
      0 as einstandspreis_tot ,
      0 as einstandspreis_af ,
      0 as einstandspreis_sa ,
      0 as anz_wo_mit_absatz ,
      0 as anz_wo_mit_abs_sk4 ,
      0 as anz_wo_mit_abs_sk1 ,
      0 as ek_mep_ums_sk1_bis_6 ,
      0 as einstandspreis_ums_sk1_bis_6 ,
      0 as kassenumsatz_sa_sk_1_bis_6 ,
      0 as anz_wo_mit_abs_sk3 ,
      0 as anz_wo_mit_abs_sued_ost ,
      0 as anz_wo_mit_abs_sk5 ,
      0 as anz_wo_mit_abs_ost_gross ,
      0 as umsatz_brutto_tot ,
      0 as umsatz_brutto_af ,
      0 as umsatz_brutto_sa ,
      0 as anz_wo_mit_abs_tot_sk1_bis6 ,
      0 as anz_maerkte 
FROM dbp_etl.prep_sal_aggregat_kmo ;

 

UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,gp_id,gp_name FROM _lkp_lieferant) b 
SET 
akt_gp_id = b.gp_id,
akt_gp_name = b.gp_name
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,wg_id,wug_id,owg_id FROM _lkp_wg) b 
SET 
wg_id = b.wg_id,
wug_id = b.wug_id,
temp_wg_id = b.wg_id,
temp_wug_id = b.wug_id,
temp_owg_id = b.owg_id
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,kolli_faktor,BEZUGSWEG_ID FROM _lkp_kol) b 
SET 
kol_bst = b.kolli_faktor
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id AND b.BEZUGSWEG_ID=1
;

UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,kolli_faktor,BEZUGSWEG_ID FROM _lkp_kol) b 
SET 
kol_la = b.kolli_faktor
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id AND b.BEZUGSWEG_ID=4
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,vkpk1,vkpk4 FROM _lkp_vk_pk) b 
SET 
vkpk1 = b.vkpk1,
vkpk4 = b.vkpk4
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,einstandspreis FROM _lkp_stk_ek_kb_stamm) b 
SET 
stk_ek_kb_stamm = b.einstandspreis
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;



UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT 
                                    mandant_id,
                                    art_id,
                                    SUM(anz_maerkte) as anz_maerkte,
                                    SUM(anz_wo_listung) as anz_wo_listung,
                                    SUM(anz_wo_mit_absatz) as anz_wo_mit_absatz,
                                    SUM(anz_wo_mit_abs_af_sk1_bis6) as anz_wo_mit_abs_af_sk1_bis6,
                                    SUM(anz_wo_mit_abs_tot_sk1_bis6) as anz_wo_mit_abs_tot_sk1_bis6
                                    FROM _lkp_absatz_listung_woche
                                    group by 1,2) b 
SET 
anz_wo_listung = b.anz_wo_listung,
anz_wo_mit_absatz = b.anz_wo_mit_absatz,
anz_maerkte = b.anz_maerkte,
anz_wo_mit_abs_af_sk1_bis6 = b.anz_wo_mit_abs_af_sk1_bis6,
anz_wo_mit_abs_tot_sk1_bis6 = b.anz_wo_mit_abs_tot_sk1_bis6
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;



UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT 
                                   mandant_id,
                                   art_id,
                                   kassenumsatz_sk_1_bis_6,
                                   ek_mep_ums_sk1_bis_6,
                                   einstandspreis_ums_sk1_bis_6 as einstandspreis_ums_sk1_bis_6,
                                   kassenumsatz_af_sk_1_bis_6,
                                   ek_mep_ums_sa_sk1_bis_6,
                                   einstandspreis_ums_sa_sk1_bis_6,
                                   kassenumsatz_sa_sk_1_bis_6  
                                   FROM _lkp_kassenumsatz1) b 
SET 
kassenumsatz_sk_1_bis_6 = b.kassenumsatz_sk_1_bis_6,
ek_mep_ums_sk1_bis_6 = b.ek_mep_ums_sk1_bis_6,
einstandspreis_ums_sk1_bis_6 = b.einstandspreis_ums_sk1_bis_6,
kassenumsatz_af_sk_1_bis_6 = b.kassenumsatz_af_sk_1_bis_6,
ek_mep_ums_sa_sk1_bis_6 = b.ek_mep_ums_sa_sk1_bis_6,
einstandspreis_ums_sa_sk1_bis_6 = b.einstandspreis_ums_sa_sk1_bis_6,
kassenumsatz_sa_sk_1_bis_6 = b.kassenumsatz_sa_sk_1_bis_6
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;




UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT * FROM _lkp_absatz) b 
SET 
absatz_gesamt = b.absatz_gesamt,
absatz_af_sk1_bis6 = b.absatz_af_sk1_bis6,
absatz_sk1 = b.absatz_sk1,
absatz_sk2 = b.absatz_sk2,
absatz_sk3 = b.absatz_sk3,
absatz_sk4 = b.absatz_sk4,
absatz_sk5 = b.absatz_sk5,
anz_wo_mit_abs_sk1 = b.anz_wo_mit_abs_sk1,
anz_wo_mit_abs_sk2 = b.anz_wo_mit_abs_sk2,
anz_wo_mit_abs_sk3 = b.anz_wo_mit_abs_sk3,
anz_wo_mit_abs_sk4 = b.anz_wo_mit_abs_sk4,
anz_wo_mit_abs_sk5 = b.anz_wo_mit_abs_sk5,
absatz_sa_sk1_bis6 = b.absatz_sa_sk1_bis6
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;



UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,anz_tage_mit_abs_sa_sk1_bis6 FROM _lkp_absatz_sa_tag) b 
SET 
anz_tage_mit_abs_sa_sk1_bis6 = b.anz_tage_mit_abs_sa_sk1_bis6
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;



UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,ek_mep_ums_sk1_bis_6_vj,einstandspreis_ums_sk1_bis_6_vj,kassenumsatz_sk_1_bis_6_vj FROM _lkp_umsatz_vj) b 
SET 
ek_mep_ums_sk1_bis_6_vj = b.ek_mep_ums_sk1_bis_6_vj,
einstandspreis_ums_sk1_bis_6_vj = b.einstandspreis_ums_sk1_bis_6_vj,
kassenumsatz_sk_1_bis_6_vj = b.kassenumsatz_sk_1_bis_6_vj
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,absatz_vj_sk1_bis_6 FROM _lkp_absatz_vj) b 
SET 
absatz_vj_sk1_bis_6 = b.absatz_vj_sk1_bis_6
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT * FROM _lkp_ek_mep) b 
SET 
mep_af = b.mep_af,
mep_sa = b.mep_sa,
mep_tot = b.mep_tot,
einstandspreis_af = b.einstandspreis_af,
einstandspreis_sa = b.einstandspreis_sa,
einstandspreis_tot = b.einstandspreis_tot,
umsatz_brutto_af = b.umsatz_brutto_af,
umsatz_brutto_sa = b.umsatz_brutto_sa,
umsatz_brutto_tot = b.umsatz_brutto_tot
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;

UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,sp_ekkb_01,sp_ekkb_04 FROM _lkp_spanne) b 
SET 
sp_ekkb_01 = b.sp_ekkb_01,
sp_ekkb_04 = b.sp_ekkb_04
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;

UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,min_durchg_gelistet_sst FROM _lkp_durchg_listung) b 
SET 
min_durchg_gelistet_sst = b.min_durchg_gelistet_sst
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;


UPDATE dbp_etl.sal_aggregat_kmo FROM (SELECT mandant_id,art_id,abschriftbetrag_netto FROM _lkp_abschriften) b 
SET 
abschr_vk_o_werbung = b.abschriftbetrag_netto
WHERE dbp_etl.sal_aggregat_kmo.mandant_id = b.mandant_id AND dbp_etl.sal_aggregat_kmo.art_id = b.art_id 
;

--------
--LOAD--
--------

DELETE FROM dbp_data.sal_kmo where (mandant_id,kjmo) in (select mandant_id,kjmo from dbp_etl.sal_monat) ; 

INSERT INTO dbp_data.sal_kmo (mandant_id
                                           ,art_id
                                           ,kjmo
                                           ,wrg_id
                                           ,arthiertyp_id
                                           ,wg_id
                                           ,wug_id
                                           ,art_status
                                           ,gp_id
                                           ,gp_name
                                           ,zek_id
                                           ,eigenmarke_id
                                           ,bio_fg
                                           ,vegan_fg
                                           ,posten_food
                                           ,posten_nonfood
                                           ,gluten_fg
                                           ,mwst
                                           ,disc_pe
                                           ,disc_marke
                                           ,lactose_fg
                                           ,k_listung
                                           ,umrech_faktor_best
                                           ,umrech_faktor_ausg
                                           ,mhd_zeitraum
                                           ,mhd_zeitraum_dz
                                           ,k1_artbew_menge
                                           ,k1_anz_kjwo_wug_absatz
                                           ,k2_artbew_menge
                                           ,k2_anz_kjwo_wug_absatz
                                           ,k3_artbew_menge
                                           ,k3_anz_kjwo_wug_absatz
                                           ,k4_artbew_menge
                                           ,k4_anz_kjwo_wug_absatz
                                           ,k5_artbew_menge
                                           ,k5_anz_kjwo_wug_absatz
                                           ,total_artbew_menge
                                           ,total_anz_kjwo_wug_absatz
                                           ,total_artbew_menge_vj
                                           ,total_artbew_menge_sa
                                           ,total_anz_kjwo_wug_absatz_sa
                                           ,total_anz_tage_wug_absatz_sa
                                           ,total_artbew_menge_af
                                           ,total_anz_kjwo_wug_absatz_af
                                           ,schnelldreherquote
                                           ,prozentual_absatz_sa
                                           ,total_rohertrag
                                           ,total_rohertrag_vj
                                           ,total_rohertrag_af
                                           ,total_rohertrag_sa
                                           ,rohertrag_einheit
                                           ,rohertrag_einheit_af
                                           ,rohertrag_einheit_sa
                                           ,abschriftbetrag_netto_oWerbung
                                           ,ek_kb_stamm
                                           ,vk_brutto_pk1
                                           ,vk_brutto_pk4
                                           ,vk_netto_pk1
                                           ,vk_netto_pk4
                                           ,total_umsatz_netto
                                           ,total_umsatz_netto_af
                                           ,total_umsatz_netto_sa
                                           ,total_anz_markt
                                           ,anz_kjwo_wup_listung
                                           ,anz_wup_listung
                                           ,lager_prozent
                                           ,kol_la_bzw
                                           ,kol_bst_bzw
                                           ,spanne_ek1
                                           ,spanne_ek4)
SELECT a.mandant_id
      ,a.art_id
      ,x.kjmo
      ,d.default_wrg AS wrg_id
      ,2 AS arthiertyp_id
      ,a.wg_id
      ,a.wug_id
      ,a.loesch_id AS art_status
      ,a.akt_gp_id AS gp_id
      ,a.akt_gp_name AS gp_name
      ,a.zek AS zek_id
      ,COALESCE(a.eigenmarke_id,'') AS eigenmarke_id
      ,COALESCE(a.bio_fg,0) AS bio_fg
      ,COALESCE(a.vegan_fg,0) AS vegan_fg
      ,COALESCE(a.posten_food,'') AS posten_food
      ,COALESCE(a.posten_nonfood,'') AS posten_nonfood
      ,COALESCE(a.gluten_fg,0) AS gluten_fg
      ,COALESCE(a.mwst,0) AS mwst
      ,a.aldi_id AS disc_pe
      ,a.discount_id AS disc_marke
      ,COALESCE(a.lactose_fg,0) AS lactose_fg
      ,COALESCE(CAST(a.min_durchg_gelistet_sst AS VARCHAR(4)),'N/A') AS k_listung
      ,ZEROIFNULL(a.kol_bst) AS umrech_faktor_best
      ,ZEROIFNULL(a.kol_la) AS umrech_faktor_ausg
      ,a.mhd_zeitraum
      ,a.mhd_zeitraum_dz
      ,SUM(a.absatz_sk1) AS k1_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk1)) AS k1_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk2) AS k2_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk2)) AS k2_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk3) AS k3_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk3)) AS k3_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk4) AS k4_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk4)) AS k4_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk5) AS k5_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk5)) AS k5_anz_kjwo_wug_absatz
      ,SUM(a.absatz_gesamt) AS total_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_tot_sk1_bis6)) AS total_anz_kjwo_wug_absatz
      ,SUM(a.absatz_vj_sk1_bis_6) AS total_artbew_menge_vj
      ,SUM(a.absatz_sa_sk1_bis6) AS total_artbew_menge_sa
      ,NULLIFZERO(SUM(anz_tage_mit_abs_sa_sk1_bis6)) AS total_anz_kjwo_wug_absatz_sa
      ,NULLIFZERO(SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS total_anz_tage_wug_absatz_sa
      ,SUM(a.absatz_af_sk1_bis6) AS total_artbew_menge_af
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS total_anz_kjwo_wug_absatz_af
      ,ZEROIFNULL(ROUND((SUM(a.anz_wo_mit_absatz)/NULLIFZERO(SUM(a.anz_wo_listung)))*100,1)) AS schnelldreherquote
      ,ZEROIFNULL(ROUND(SUM(a.absatz_sa_sk1_bis6)/NULLIFZERO(SUM(a.absatz_gesamt))*100,1)) AS prozentual_absatz_sa
      ,(ZEROIFNULL(SUM(a.einstandspreis_tot)) ) AS total_rohertrag
      ,(ZEROIFNULL(SUM(a.einstandspreis_ums_sk1_bis_6_vj)) ) AS total_rohertrag_vj
      ,(ZEROIFNULL(SUM(a.einstandspreis_af)) ) AS total_rohertrag_af
      ,(ZEROIFNULL(SUM(a.einstandspreis_sa)) ) AS total_rohertrag_sa
      ,(ZEROIFNULL(SUM(a.einstandspreis_tot)/NULLIFZERO(SUM(a.absatz_gesamt))) ) AS rohertrag_einheit
      ,(ZEROIFNULL(SUM(a.einstandspreis_af)/NULLIFZERO(SUM(a.absatz_af_sk1_bis6))) ) AS rohertrag_einheit_af
      ,(ZEROIFNULL(SUM(a.einstandspreis_sa)/NULLIFZERO(SUM(a.absatz_sa_sk1_bis6))) ) AS rohertrag_einheit_sa
      ,ZEROIFNULL(ROUND(SUM(a.abschr_vk_o_werbung),1)) AS abschriftbetrag_netto_oWerbung
      ,(ZEROIFNULL(ROUND(AVG(a.stk_ek_kb_stamm),2)) ) AS ek_kb_stamm
      ,ROUND(AVG(a.vkpk1),2) AS vk_brutto_pk1
      ,ROUND(AVG(a.vkpk4),2) AS vk_brutto_pk4
      ,ROUND(AVG(a.vkpk1/(CAST(f.mwst/100 + 1 AS FLOAT))),2) AS vk_netto_pk1
      ,ROUND(AVG(a.vkpk4/(CAST(f.mwst/100 + 1 AS FLOAT))),2) AS vk_netto_pk4
      ,ZEROIFNULL(SUM(a.umsatz_brutto_tot)) AS total_umsatz_netto
      ,ZEROIFNULL(SUM(a.umsatz_brutto_af)) AS total_umsatz_netto_af
      ,ZEROIFNULL(SUM(a.umsatz_brutto_sa)) AS total_umsatz_netto_sa
      ,SUM(0) AS total_anz_markt
      ,ZEROIFNULL(SUM(a.anz_wo_listung)) AS anz_kjwo_wup_listung
      ,SUM(0) AS anz_wup_listung 
      ,COALESCE(MAX(CAST(c.lager_prozent AS DECIMAL(18,3))),1) AS lager_prozent
      ,COALESCE(MAX(CASE 
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz  = 0 THEN a.kol_la
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz <> 0 THEN NULL
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz <> 0 THEN a.kol_la
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz  = 0 THEN a.kol_la
           END),0) AS kol_la_bzw
      ,COALESCE(MAX(CASE 
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz  = 0 THEN NULL
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz <> 0 THEN a.kol_bst
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz <> 0 THEN NULL
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz  = 0 THEN NULL
           END),0) AS kol_bst_bzw
      ,COALESCE(ROUND(AVG(a.sp_ekkb_01)*100,1),0) AS spanne_ek1
      ,COALESCE(ROUND(AVG(a.sp_ekkb_04)*100,1),0) AS spanne_ek4
FROM dbp_etl.sal_aggregat_kmo a
JOIN dbp_data.art c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id
JOIN dbp_data.mandant d
  ON a.mandant_id = d.mandant_id
JOIN dbp_data.mwst_per f
  ON a.mandant_id = f.mandant_id AND
     c.mwst_id = f.mwst_id AND
     CURRENT_DATE BETWEEN f.dat_von AND f.dat_bis
JOIN dbp_etl.sal_monat x
  ON a.mandant_id = x.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
         21,22,23,24,25,26
;


UPDATE dbp_data.sal_kmo FROM (SELECT a.mandant_id,
                                                   a.art_id,
						   SUM(a.listung_id) AS anz_listung_as_is
					    FROM dbp_data.art_wup_zu_per a
					    JOIN dbp_data.wup b
					      ON a.mandant_id = b.mandant_id AND
						 a.wup_id = b.wup_id AND
						 a.mandant_id = b.mandant_id AND
						 CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
                          JOIN dbp_data.art_wg_zu_per c
					      ON a.mandant_id = c.mandant_id AND
						 a.art_id = c.art_id AND
						 c.arthiertyp_id = 2 AND
						 c.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
					    WHERE a.mandant_id in (2,3,5,6,7,8) AND
						  a.listung_id = 1 AND
						  CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
					    GROUP BY 1,2) b
									 
SET anz_wup_listung = b.anz_listung_as_is

WHERE dbp_data.sal_kmo.art_id = b.art_id AND
      dbp_data.sal_kmo.mandant_id = b.mandant_id and 
     (dbp_data.sal_kmo.kjmo,dbp_data.sal_kmo.mandant_id) in (select kjmo,mandant_id from dbp_etl.sal_monat)
;

UPDATE dbp_data.sal_kmo FROM (SELECT x.mandant_id,
                             x.art_id,
                             COUNT(DISTINCT x.wup_id) AS anz_maerkte
                             FROM (SELECT a.mandant_id,
							 a.art_id,
                          a.wup_id,
                          SUM(a.menge) AS menge
						  FROM dbp_data.artbew a
                          JOIN dbp_data.tag v02
                          ON a.dat = v02.dat
						  JOIN dbp_etl.sal_wochen d
                          on a.mandant_id = d.mandant_id and 
                          v02.kjwo = d.kjwo
						  JOIN dbp_data.art_wg_zu_per b
						    ON a.mandant_id = b.mandant_id AND
						       a.art_id = b.art_id AND
						       b.arthiertyp_id = 2 AND
						       b.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
						  GROUP BY 1,2,3
						  HAVING SUM(a.menge) > 0) x
				            GROUP BY 1,2) b
									 
SET total_anz_markt = b.anz_maerkte

WHERE dbp_data.sal_kmo.art_id = b.art_id AND
      dbp_data.sal_kmo.mandant_id = b.mandant_id and 
     (dbp_data.sal_kmo.kjmo,dbp_data.sal_kmo.mandant_id) in (select kjmo,mandant_id from dbp_etl.sal_monat)
;
