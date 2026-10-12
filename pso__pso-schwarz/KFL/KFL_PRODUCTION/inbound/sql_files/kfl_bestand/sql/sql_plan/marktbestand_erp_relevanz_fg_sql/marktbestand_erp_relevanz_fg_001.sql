CREATE OR REPLACE TRANSIENT TABLE _subset_01_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bezugsweg_id,
       CAST(CURRENT_DATE- ${LOOP_ID} AS date) dat
FROM DBP_DATA.art_wup_zu_per a
WHERE CURRENT_DATE- ${LOOP_ID} BETWEEN a.dat_von AND a.dat_bis AND
      a.listung_id = 1 AND
      a.dat_von < CURRENT_DATE- ${LOOP_ID}-28 AND
      COALESCE(a.kdis,0) = 0 AND
      a.nb_id = 0
);

CREATE OR REPLACE TRANSIENT TABLE _subset_01a_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT t21.dat
      ,t21.mandant_id
      ,t21.art_id
      ,t21.wup_id
      ,t21.nb_id
      ,t21.bezugsweg_id
      ,CASE
         WHEN t25.dispomerkmal = '01' 
         THEN 3
         ELSE 2
       END AS relevant_fg
FROM _subset_01_${TRANSIENT_TABLE_SUFFIX} t21

JOIN DBP_DATA.art t23
ON t21.mandant_id = t23.mandant_id
AND t21.art_id = t23.art_id

JOIN DBP_DATA.wup t24
ON t21.mandant_id = t24.mandant_id
AND t21.wup_id = t24.wup_id
AND t21.nb_id = t24.nb_id
AND t21.dat BETWEEN t24.dat_von AND t24.dat_bis

JOIN DBP_DATA.art_wup_status_per t25
ON t21.mandant_id = t25.mandant_id
AND t21.art_id = t25.art_id
AND t21.wup_id = t25.wup_id
AND t21.nb_id = t25.nb_id
AND t21.dat BETWEEN t25.dat_von AND t25.dat_bis

WHERE t23.loesch_id <> 'L' AND 
      t25.loesch_id NOT IN ('F1','F2','L') AND 
     (t23.display_id NOT IN (1,2,3) OR t23.display_id IS NULL) AND 
      NOT t23.wg_art_fg = 1 AND 
     ((t21.mandant_id <> 1 AND t25.dispomerkmal IN ('S2')) ---KMO: nur 'S2'---
     OR (t21.mandant_id = 1 AND t25.dispomerkmal IN ('01','11','ZZ'))) ---DE: '01,'11','ZZ'---
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE TRANSIENT TABLE _subset_03_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bezugsweg_id,
       a.dat_von,
       a.dat_bis,
       CAST(CURRENT_DATE- ${LOOP_ID} AS date) dat
FROM DBP_DATA.art_wup_zu_per a
WHERE CURRENT_DATE- ${LOOP_ID} BETWEEN a.dat_von AND a.dat_bis AND
      a.listung_id = 1 AND
      a.dat_von >= CURRENT_DATE- ${LOOP_ID}-28 AND
      COALESCE(a.kdis,0) = 0 AND
      a.nb_id = 0
);

CREATE OR REPLACE TRANSIENT TABLE _subset_03a_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT t21.dat
      ,t21.mandant_id
      ,t21.art_id
      ,t21.wup_id
      ,t21.nb_id
      ,t21.bezugsweg_id
      ,t21.dat_von
      ,t21.dat_bis
      ,CASE
         WHEN t25.dispomerkmal = '01' 
         THEN 3
         ELSE 2
       END AS relevant_fg
FROM _subset_03_${TRANSIENT_TABLE_SUFFIX} t21

JOIN DBP_DATA.art t23
ON t21.mandant_id = t23.mandant_id
AND t21.art_id = t23.art_id

JOIN DBP_DATA.wup t24
ON t21.mandant_id = t24.mandant_id
AND t21.wup_id = t24.wup_id
AND t21.nb_id = t24.nb_id
AND t21.dat BETWEEN t24.dat_von AND t24.dat_bis

JOIN DBP_DATA.art_wup_status_per t25
ON t21.mandant_id = t25.mandant_id
AND t21.art_id = t25.art_id
AND t21.wup_id = t25.wup_id
AND t21.nb_id = t25.nb_id
AND t21.dat BETWEEN t25.dat_von AND t25.dat_bis

WHERE t23.loesch_id <> 'L' AND 
      t25.loesch_id NOT IN ('F1','F2','L') AND 
     (t23.display_id NOT IN (1,2,3) OR t23.display_id IS NULL) AND 
      NOT t23.wg_art_fg = 1 AND 
     ((t21.mandant_id <> 1 AND t25.dispomerkmal IN ('S2')) ---KMO: nur 'S2'---
     OR (t21.mandant_id = 1 AND t25.dispomerkmal IN ('01','11','ZZ'))) ---DE: '01,'11','ZZ'---
GROUP BY 1,2,3,4,5,6,7,8,9
);

CREATE OR REPLACE TRANSIENT TABLE _ueberpruefung01_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT b.dat
      ,b.mandant_id
      ,b.art_id
      ,b.wup_id
      ,b.nb_id
      ,b.bezugsweg_id
      ,b.relevant_fg
FROM DBP_DATA.art_wup_zu_per a
JOIN _subset_03a_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat_bis = b.dat_von-1
WHERE a.listung_id = 1 AND
     COALESCE(a.kdis,0) = 0 AND
      a.nb_id = 0
);

DELETE FROM _subset_03a_${TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,art_id,wup_id,dat) IN (SELECT mandant_id,art_id,wup_id,dat FROM _ueberpruefung01_${TRANSIENT_TABLE_SUFFIX})
;

CREATE OR REPLACE TRANSIENT TABLE _subset_02_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT x1.dat,
       x1.mandant_id,
       x1.wup_id,
       x1.nb_id,
       x1.art_id
FROM (SELECT b.dat,
             a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             SUM(CASE 
                   WHEN a.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND a.nb_id IN (0) 
                   THEN a.menge_rech 
                   ELSE 0
                 END) AS Bsch_Menge_dz
      FROM DBP_DATA.bsch_rech_det a
      JOIN _subset_03a_${TRANSIENT_TABLE_SUFFIX} b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.art_id = b.art_id
      WHERE a.dat BETWEEN b.dat-28 AND b.dat AND
            a.dat BETWEEN CURRENT_DATE- ${LOOP_ID}-28 AND CURRENT_DATE- ${LOOP_ID} AND
            a.mandant_id = 1 AND 
            a.nb_id NOT IN (2,6,7) AND 
            a.status <> 2
      GROUP BY 1,2,3,4,5
      HAVING Bsch_Menge_dz <> 0) x1
UNION
SELECT x1.dat,
       x1.mandant_id,
       x1.wup_id,
       x1.nb_id,
       x1.art_id
FROM (SELECT b.dat,
             v01.mandant_id,
             v01.art_id,
             v03.wup_id,
             v03.nb_id,
             SUM(CAST(CASE 
                        WHEN v02.faktura_typ_id IN ('O','N') 
                        THEN v01.menge_faktura_bme * -1 
                        ELSE v01.menge_faktura_bme 
                      END AS DECIMAL(18,3))) AS faktura_menge_bme
      FROM DBP_DATA.besch_faktura_det v01
      JOIN _subset_03a_${TRANSIENT_TABLE_SUFFIX} b
        ON v01.mandant_id = b.mandant_id AND
           v01.wup_id = b.wup_id AND
           v01.art_id = b.art_id
      JOIN DBP_DATA.besch_faktura v02
        ON v01.faktura_beleg_id=v02.faktura_beleg_id AND 
           v01.mandant_id = v02.mandant_id AND 
           v01.dat_faktura_sap = v02.dat_faktura_sap AND 
           v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'
      JOIN DBP_DATA.wup v03
        ON CAST(try_to_number(v02.auftraggeber_id) AS INTEGER) = v03.wup_id AND 
           v01.mandant_id = v03.mandant_id
      JOIN DBP_DATA.art_gp_zu_per v04
        ON v01.art_id = v04.art_id AND 
           v01.mandant_id = v04.mandant_id AND 
           v01.dat_faktura BETWEEN v04.dat_von AND v04.dat_bis
      WHERE v01.mandant_id = 1
            -- 20100330 Filterung der IWT Fakturen
        AND v02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
        AND v01.nb_id <> 99 
        AND v01.dat_faktura BETWEEN b.dat-28 AND b.dat
        AND v01.dat_faktura BETWEEN CURRENT_DATE- ${LOOP_ID}-28 AND CURRENT_DATE- ${LOOP_ID}
      GROUP BY 1,2,3,4,5
      HAVING faktura_menge_bme <> 0) x1
UNION
SELECT x1.dat,
       x1.mandant_id,
       x1.wup_id,
       x1.nb_id,
       x1.art_id
FROM (SELECT x.dat,
             a.mandant_id,
             a.empfaenger_id AS wup_id,
             b.nb_id,
             a.art_id,
             SUM(CASE
                   WHEN a.lager_bewart_id IN ('641', '647') THEN ABS(a.menge_lagerbew_bme)
                   WHEN a.lager_bewart_id IN ('642', '648') THEN -1 * ABS(a.menge_lagerbew_bme)
                   ELSE 0
                 END) AS wa_vz_menge
      FROM DBP_DATA.lagerbew_det a
      JOIN _subset_03a_${TRANSIENT_TABLE_SUFFIX} x
        ON a.mandant_id = x.mandant_id AND
           a.wup_id = x.wup_id AND
           a.art_id = x.art_id
      JOIN DBP_DATA.wup b
        ON a.mandant_id_empfaenger = b.mandant_id AND 
           a.empfaenger_id = b.wup_id
      WHERE a.mandant_id <> 1 AND 
           (a.nb_id = -111 OR b.nb_id = -111) /* Absender oder Empfaenger muss VZ sein */ AND 
           (a.lager_bewart_id IN ('641', '642', '647', '648') OR 
           (a.lager_bewart_id IN ('301', '302', '311', '312') AND 
            a.lagerort_id = '0019')) AND
            a.dat_buch BETWEEN x.dat-28 AND x.dat AND
            a.dat_buch BETWEEN CURRENT_DATE- ${LOOP_ID}-28 AND CURRENT_DATE- ${LOOP_ID}
      GROUP BY 1,2,3,4,5
      HAVING wa_vz_menge <> 0) x1
UNION 
SELECT x1.dat,
       x1.mandant_id,
       x1.wup_id,
       x1.nb_id,
       x1.art_id
FROM (SELECT b.dat,
             a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             SUM(CASE 
                   WHEN a.lager_bewart_id IN ('101', '102', '901', '902') AND a.nb_id = 0
                   THEN a.menge_basis
                   ELSE 0
                 END) AS wewa_menge_dz
      FROM DBP_DATA.wewa a
      JOIN _subset_03a_${TRANSIENT_TABLE_SUFFIX} b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id > 1 AND
            a.lager_bewart_id IN ('101', '102', '901', '902') AND 
            a.nb_id = 0 AND
            a.dat_buch BETWEEN b.dat-28 AND b.dat AND
            a.dat_buch BETWEEN CURRENT_DATE- ${LOOP_ID}-28 AND CURRENT_DATE- ${LOOP_ID}
      GROUP BY 1,2,3,4,5
      HAVING wewa_menge_dz <> 0) x1
);

CREATE OR REPLACE TRANSIENT TABLE _subset_02a_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.*,
       b.bezugsweg_id,
       CASE
         WHEN c.dispomerkmal = '01'
         THEN 3
         ELSE 2
       END AS relevant_fg
FROM _subset_02_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.art_wup_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis
JOIN DBP_DATA.art_wup_status_per c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat BETWEEN c.dat_von AND c.dat_bis
);

DELETE FROM _subset_02a_${TRANSIENT_TABLE_SUFFIX}
WHERE (dat,mandant_id,wup_id,nb_id,art_id) NOT IN (SELECT dat,mandant_id,wup_id,nb_id,art_id FROM _subset_03a_${TRANSIENT_TABLE_SUFFIX});

CREATE OR REPLACE TRANSIENT TABLE _subset_final_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT dat,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       bezugsweg_id,
       relevant_fg
FROM _subset_01a_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6,7
UNION
SELECT dat,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       bezugsweg_id,
       relevant_fg
FROM _subset_02a_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6,7
UNION
SELECT dat,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       bezugsweg_id,
       relevant_fg
FROM _ueberpruefung01_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6,7
);

UPDATE DBP_ETL.marktbestand_erp_tmp

SET relevant_fg = _relevant_fg
FROM
(
SELECT
 mandant_id _mandant_id
,wup_id _wup_id
,art_id _art_id
,bezugsweg_id _bezugsweg_id
,min(relevant_fg) as _relevant_fg
FROM _subset_final_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4
)dt1 WHERE mandant_id=_mandant_id
AND       wup_id = _wup_id
AND       art_id=_art_id
AND       bezugsweg_id=_bezugsweg_id
;

UPDATE DBP_ETL.marktbestand_erp_tmp

SET relevant_fg = 1
FROM
(
SELECT
 t01.mandant_id _mandant_id
,t01.wup_id _wup_id
,t01.art_id _art_id
,t04.bezugsweg_id _bezugsweg_id
FROM DBP_ETL.marktbestand_erp_tmp t01
INNER JOIN DBP_DATA.art t02
ON t01.mandant_id = t02.mandant_id
AND t01.art_id = t02.art_id
INNER JOIN DBP_DATA.wup t03
ON t01.mandant_id = t03.mandant_id
AND t01.wup_id = t03.wup_id
INNER JOIN DBP_DATA.art_wup_status_per t04
ON t01.mandant_id = t04.mandant_id
AND t01.wup_id = t04.wup_id
AND t01.art_id = t04.art_id
WHERE t01.listung_id = 1
AND t01.kdis = 0
AND t02.loesch_id <> 'L'
AND (t02.display_id NOT IN (1,2,3) OR t02.display_id IS NULL)
AND NOT t02.wg_art_fg = 1
AND ((t04.mandant_id <> 1 AND t04.dispomerkmal IN ('S2')) ---KMO: nur 'S2'---
OR (t04.mandant_id = 1 AND t04.dispomerkmal IN ('11','ZZ'))) ---DE: '11','ZZ'---
AND  CURRENT_DATE- ${LOOP_ID} between t03.dat_von and t03.dat_bis
AND CURRENT_DATE- ${LOOP_ID} between t04.dat_von and t04.dat_bis
)dt1 WHERE mandant_id=_mandant_id
AND       wup_id = _wup_id
AND       art_id=_art_id
AND       bezugsweg_id=_bezugsweg_id
AND       relevant_fg = 0
;
