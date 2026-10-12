DROP TABLE IF EXISTS DBP_ETL.kmo_marm_anr;
CREATE TABLE DBP_ETL.kmo_marm_anr  (
  matnr                  INTEGER NOT NULL
, mandant_id             INTEGER NOT NULL
, altnv_menge_einh_id    VARCHAR (3)   COLLATE 'de-ci' NOT NULL                   
, bruttogew              DECIMAL(18,3) NOT NULL 
, gew_einh_id            VARCHAR (3)   COLLATE 'de-ci' NOT NULL                  
, umrech_faktor          FLOAT NOT NULL 
, dat_von                DATE NOT NULL
, dat_bis                DATE NOT NULL
, laenge                 DECIMAL(18,3)  NOT NULL  
, breite                 DECIMAL(18,3)  NOT NULL  
, hoehe                  DECIMAL(18,3)  NOT NULL  
, umren                  INTEGER
, umrez                  INTEGER  
, td_insert              TIMESTAMP_LTZ(9)
)
;

CREATE VOLATILE TABLE _dup_check AS (
SELECT a.*
FROM DBP_ETL.kmo_marm a
JOIN (SELECT mandant_id,
             matnr_char,
             meinh
      FROM DBP_ETL.kmo_marm
      GROUP BY 1,2,3
      HAVING COUNT(*) > 1) b
  ON a.mandant_id = b.mandant_id AND
     a.matnr_char = b.matnr_char AND
     a.meinh = b.meinh
QUALIFY ROW_NUMBER () OVER (PARTITION BY a.mandant_id,a.matnr_char,a.meinh
                            ORDER BY a.mandant_id,a.matnr_char,a.meinh,a.bezugsdatum DESC) = 1
);

DELETE FROM DBP_ETL.kmo_marm
WHERE (mandant_id,matnr_char,meinh) IN (SELECT mandant_id,matnr_char,meinh FROM _dup_check)
;

INSERT INTO DBP_ETL.kmo_marm
SELECT *
FROM _dup_check
;

INSERT INTO DBP_ETL.kmo_marm_anr
(
 
  matnr        
, mandant_id   
, altnv_menge_einh_id        
, bruttogew        
, gew_einh_id        
, umrech_faktor 
, dat_von  
, dat_bis
, laenge
, breite
, hoehe 
, umren
, umrez

)
SELECT
  m.matnr AS matnr
, m.mandant_id   
, COALESCE(SUBSTRING(m.MEINH, 1, 3),'-1')    AS altnv_menge_einh_id
, COALESCE(m.BRGEW,0)                               AS bruttogew
, COALESCE(SUBSTRING(m.GEWEI, 1, 3),'-1')    AS gew_einh_id
, COALESCE(CAST((CAST(m.UMREN AS FLOAT ) / m.UMREZ ) AS FLOAT) ,1)  AS  umrech_faktor     
, m.bezugsdatum -1 
, date('99991231','yyyymmdd') as dat_bis 
, COALESCE(laenge,0)  AS laenge
, COALESCE(breite,0)  AS breite
, COALESCE(hoehe,0)   AS hoehe 
, UMREN               AS umrech_nenner
, UMREZ               AS umrech_zaehler

FROM DBP_ETL.kmo_marm m 
;

DROP TABLE IF EXISTS DBP_ETL.art_umrechnung_faktor_per_tmp;
CREATE TABLE DBP_ETL.art_umrechnung_faktor_per_tmp  (
  art_id                 INTEGER NOT NULL 
, mandant_id             INTEGER NOT NULL
, altnv_menge_einh_id    VARCHAR (3)   COLLATE 'de-ci' NOT NULL                   
, bruttogew              DECIMAL(18,3) NOT NULL 
, gew_einh_id            VARCHAR (3)   COLLATE 'de-ci' NOT NULL         
, umrech_faktor          FLOAT NOT NULL 
, dat_von                DATE NOT NULL
, dat_bis                DATE NOT NULL
, laenge                 DECIMAL(18,3)  NOT NULL  
, breite                 DECIMAL(18,3)  NOT NULL  
, hoehe                  DECIMAL(18,3)  NOT NULL  
, umrech_nenner          INTEGER  
, umrech_zaehler         INTEGER 
)
;

INSERT INTO DBP_ETL.art_umrechnung_faktor_per_tmp
(
  mandant_id
, art_id
, altnv_menge_einh_id
, bruttogew
, umrech_faktor
, gew_einh_id
, dat_von
, dat_bis
, laenge
, breite
, hoehe 
, umrech_nenner
, umrech_zaehler

)
SELECT
  nw.mandant_id
, nw.art_id
, nw.altnv_menge_einh_id
, nw.bruttogew
, nw.umrech_faktor
, nw.gew_einh_id
, nw.dat_von
, nw.dat_bis
, nw.laenge
, nw.breite
, nw.hoehe 
, nw.umren
, nw.umrez

FROM 
(
SELECT 
  dt1.mandant_id            
, dt2.art_id                
, dt1.altnv_menge_einh_id   
, dt1.bruttogew             
, dt1.umrech_faktor         
, dt1.gew_einh_id           
, dt1.dat_von               
, dt1.dat_bis               
, laenge
, breite
, hoehe 
, umren
, umrez
FROM DBP_ETL.kmo_marm_anr dt1
INNER JOIN
  (
  SELECT
    kl_art_id
  , art_id
  , mandant_id
  FROM DBP_DATA.art 
  QUALIFY ROW_NUMBER() OVER (PARTITION BY kl_art_id,mandant_id ORDER BY art_id DESC) = 1
  ) dt2
  ON dt1.matnr = dt2.kl_art_id
  AND dt1.mandant_id = dt2.mandant_id 
) nw 
;

DELETE FROM DBP_DATA.art_umrechnung_faktor_per
WHERE
(mandant_id, art_id, altnv_menge_einh_id, dat_von)

IN
(
SELECT
  mandant_id
, art_id
, altnv_menge_einh_id
, dat_von

FROM DBP_ETL.art_umrechnung_faktor_per_tmp
)
;

INSERT INTO DBP_DATA.art_umrechnung_faktor_per
(
  mandant_id
, art_id
, altnv_menge_einh_id
, bruttogew
, umrech_faktor
, gew_einh_id
, dat_von
, dat_bis
, laenge
, breite
, hoehe 
, umrech_nenner
, umrech_zaehler
)
SELECT
  dt1.mandant_id           
, dt1.art_id               
, dt1.altnv_menge_einh_id  
, dt1.bruttogew            
, dt1.umrech_faktor        
, dt1.gew_einh_id          
, dt1.dat_von              
, dt1.dat_bis              
, dt1.laenge               
, dt1.breite               
, dt1.hoehe    
, dt1.umrech_nenner
, dt1.umrech_zaehler            

FROM DBP_ETL.art_umrechnung_faktor_per_tmp dt1

                LEFT OUTER JOIN
     (SELECT * 
      FROM DBP_DATA.art_umrechnung_faktor_per dt3
      WHERE  dt3.dat_bis   = to_date('9999-12-31','YYYY-MM-DD')
     )  dt2
ON
(
     dt1.mandant_id           = dt2.mandant_id 
 AND dt1.art_id               = dt2.art_id 
 AND dt1.altnv_menge_einh_id  = dt2.altnv_menge_einh_id 
 AND dt1.bruttogew            = dt2.bruttogew
 --AND CAST(dt1.umrech_faktor AS DECIMAL(18,4)) = CAST(dt2.umrech_faktor AS DECIMAL(18,4))
 AND dt1.gew_einh_id          = dt2.gew_einh_id
 AND dt1.laenge               = dt2.laenge
 AND dt1.breite               = dt2.breite
 AND dt1.hoehe                = dt2.hoehe
 AND dt1.umrech_nenner        = dt2.umrech_nenner
 AND dt1.umrech_zaehler       = dt2.umrech_zaehler
 )
WHERE dt2.art_id IS NULL
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
;

UPDATE DBP_DATA.art_umrechnung_faktor_per
SET   dat_bis = dt1.dat_bis
FROM
(
SELECT
 mandant_id
, art_id
, altnv_menge_einh_id
, dat_von
, CASE 
     WHEN SUM(to_number(to_char(dat_von,'YYYYMMDD'),'99999999')) over (partition by mandant_id,art_id,altnv_menge_einh_id order by dat_von desc rows between 1 preceding AND current row) - to_number(to_char(dat_von,'YYYYMMDD'),'99999999') = 0
      THEN to_date('9999-12-31','YYYY-MM-DD')
      ELSE to_date(to_char(SUM(to_number(to_char(dat_von,'YYYYMMDD'),'99999999')) over (partition by mandant_id,art_id,altnv_menge_einh_id order by dat_von desc rows between 1 preceding AND current row) - to_number(to_char(dat_von,'YYYYMMDD'),'99999999')),'YYYYMMDD')-1
  END AS dat_bis
FROM DBP_DATA.art_umrechnung_faktor_per
) dt1 WHERE DBP_DATA.art_umrechnung_faktor_per.mandant_id = dt1.mandant_id
AND   DBP_DATA.art_umrechnung_faktor_per.art_id           = dt1.art_id
AND   DBP_DATA.art_umrechnung_faktor_per.altnv_menge_einh_id     = dt1.altnv_menge_einh_id
AND   DBP_DATA.art_umrechnung_faktor_per.dat_bis               <> dt1.dat_bis
AND   DBP_DATA.art_umrechnung_faktor_per.dat_von               = dt1.dat_von
AND   DBP_DATA.art_umrechnung_faktor_per.mandant_id IN 
      (SELECT 
        mandant_id
       FROM DBP_ETL.art_umrechnung_faktor_per_tmp
       GROUP BY 1
       )
;

DROP TABLE IF EXISTS DBP_ETL.art_umrechnung_faktor_per_tmp;

