CREATE OR REPLACE TABLE DBP_ETL.fur_woche_sum_1
    (
      wup_id            INTEGER NOT NULL
     ,art_id            INTEGER NOT NULL
     ,mandant_id        BYTEINT NOT NULL
     ,kjwo              INTEGER NOT NULL
     ,menge             DECIMAL (13,6)
     )
;


CREATE OR REPLACE TABLE DBP_ETL.d_fur_woche_sum_1 (
  wup_id    INTEGER NOT NULL
 ,art_id     INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,kjwo   INTEGER NOT NULL
 ,menge   DECIMAL (13,6)
) 
;

/*
#------------------------------------------------------------------------------
# 3) Daten für den gewünschten Zeitraum für die ausgewählte Artikeln summiert in 
#     berichtswesen_sum ablegen. Keine OuG-Artikel_1!!!
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE DBP_ETL.d_fur_exp_1 AS (
SELECT  b.art_id
FROM    DBP_DATA.art_1 b
JOIN    DBP_ETL.d_fur_1 c
  ON    b.kl_art_id = c.artikelnummer 
 AND    b.dat_bis = '9999-12-31'

JOIN    DBP_DATA.art_wg_zu_per_1 d
  ON    b.mandant_id = d.mandant_id 
 AND    b.art_id = d.art_id 
 AND    d.arthiertyp_id = 2 
 AND    d.dat_bis = '9999-12-31'

WHERE   b.mandant_id = 1 
  AND   d.wg_id NOT IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE wg_filter_id = 12)
GROUP BY 1
) 
;


INSERT INTO DBP_ETL.d_fur_woche_sum_1 (wup_id
                           ,art_id
                           ,mandant_id
                           ,kjwo
                           ,menge)
SELECT a.wup_id
      ,a.art_id
      ,a.mandant_id
      ,c.kjwo
      ,SUM(a.menge) menge
FROM DBP_DATA.artbew_1 a

JOIN DBP_ETL.d_fur_exp_1 b
  ON a.art_id = b.art_id

JOIN DBP_DATA.tag_1 c
  ON a.dat = c.dat

WHERE a.mandant_id = 1  
  AND a.dat BETWEEN  (SELECT MIN(wo_dat_von) dat_von FROM dbp_data.woche_1
                      WHERE akt_wo_kalendarisch IN ( -60, -6))                      
                 AND (SELECT MAX(wo_dat_bis) dat_bis FROM dbp_data.woche_1
                      WHERE akt_wo_kalendarisch IN ( -60, -6))
GROUP BY 1,2,3,4
;


INSERT INTO DBP_ETL.d_fur_woche_sum_1 (wup_id
                           ,art_id
                           ,mandant_id
                           ,kjwo
                           ,menge)
SELECT a.wup_id
      ,a.art_id
      ,a.mandant_id
      ,d.kjwo
      ,SUM(a.menge_abschrift * CASE WHEN b.gewart_id = 'KG' THEN 1/1000 ELSE 1 END * (-1)) AS menge
FROM DBP_DATA.marktabschriften_1 a

JOIN DBP_DATA.art_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id

JOIN DBP_ETL.d_fur_exp_1 c
  ON a.art_id = c.art_id

JOIN DBP_DATA.tag_1 d
  ON a.dat = d.dat

WHERE a.mandant_id = 1  
  AND a.abschriftart_id IN (5,7)  
  AND a.dat BETWEEN (SELECT MIN(wo_dat_von) dat_von FROM dbp_data.woche_1
                      WHERE akt_wo_kalendarisch IN ( -60, -6)) 
                 AND (SELECT MAX(wo_dat_bis) dat_bis FROM dbp_data.woche_1
                      WHERE akt_wo_kalendarisch IN ( -60, -6))
GROUP BY 1,2,3,4
;



INSERT INTO DBP_ETL.fur_woche_sum_1 (wup_id
                                    ,art_id
                                    ,mandant_id
                                    ,kjwo
                                    ,menge)
SELECT wup_id
      ,art_id
      ,mandant_id
      ,kjwo
      ,SUM(menge) AS menge
FROM DBP_ETL.d_fur_woche_sum_1
GROUP BY 1,2,3,4
;


CREATE OR REPLACE TABLE DBP_ETL.fur_tag_sum_1
(
      wup_id     INTEGER NOT NULL
     ,art_id     INTEGER NOT NULL
     ,mandant_id BYTEINT NOT NULL
     ,dat        DATE  NOT NULL
     ,menge      DECIMAL (13,6)
)
;


CREATE OR REPLACE  TABLE DBP_ETL.d_fur_tag_sum_1 
(
  wup_id     INTEGER NOT NULL
 ,art_id     INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,dat        DATE NOT NULL
 ,menge      DECIMAL (13,6)
) 
;


/*
#------------------------------------------------------------------------------
# 3) Daten für den gewünschten Zeitraum für die ausgewählte Artikeln summiert in 
#     berichtswesen_sum ablegen. Keine OuG-Artikel_1!!!
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE DBP_ETL.d_fur_exp_1 AS (
SELECT b.art_id
  FROM DBP_DATA.art_1 b
  JOIN DBP_ETL.d_fur_1 c
    ON b.kl_art_id = c.artikelnummer 
   AND b.dat_bis = '9999-12-31'
  JOIN DBP_DATA.art_wg_zu_per_1 d
    ON b.mandant_id = d.mandant_id 
   AND b.art_id = d.art_id 
   AND d.arthiertyp_id = 2 
   AND d.dat_bis = '9999-12-31'
WHERE b.mandant_id = 1 
  AND  d.wg_id NOT IN ( SELECT wg_id 
                        FROM DBP_DATA.wg_filter_zu_1 
                        WHERE wg_filter_id = 12)
GROUP BY 1
) 
;

INSERT INTO DBP_ETL.d_fur_tag_sum_1 (wup_id
                         ,art_id
                         ,mandant_id
                         ,dat
                         ,menge)
SELECT a.wup_id
      ,a.art_id
      ,a.mandant_id
      ,a.dat
      ,SUM(a.menge) AS menge
FROM DBP_DATA.artbew_1 a

JOIN DBP_ETL.d_fur_exp_1 b
  ON a.art_id = b.art_id

WHERE a.mandant_id = 1 AND 
      a.dat BETWEEN (SELECT wo_dat_von  FROM dbp_data.woche_1 WHERE akt_wo_kalendarisch = -5)
            AND  CURRENT_DATE-1 
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.d_fur_tag_sum_1 (wup_id
                         ,art_id
                         ,mandant_id
                         ,dat
                         ,menge)
SELECT a.wup_id
      ,a.art_id
      ,a.mandant_id
      ,a.dat
      ,SUM(a.menge_abschrift * CASE WHEN b.gewart_id = 'KG' THEN 1/1000 ELSE 1 END * (-1)) AS menge
FROM DBP_DATA.marktabschriften_1 a

JOIN DBP_DATA.art_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id

JOIN DBP_ETL.d_fur_exp_1 c
  ON a.art_id = c.art_id

WHERE a.mandant_id = 1 AND 
      a.abschriftart_id IN (5,7) AND 
      a.dat BETWEEN (SELECT wo_dat_von  FROM dbp_data.woche_1 WHERE akt_wo_kalendarisch = -5)
            AND  CURRENT_DATE-1 
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.fur_tag_sum_1 (wup_id
                                  ,art_id
                                  ,mandant_id
                                  ,dat
                                  ,menge)
SELECT wup_id
      ,art_id
      ,mandant_id
      ,dat
      ,SUM(menge) AS menge
FROM DBP_ETL.d_fur_tag_sum_1
GROUP BY 1,2,3,4
;


