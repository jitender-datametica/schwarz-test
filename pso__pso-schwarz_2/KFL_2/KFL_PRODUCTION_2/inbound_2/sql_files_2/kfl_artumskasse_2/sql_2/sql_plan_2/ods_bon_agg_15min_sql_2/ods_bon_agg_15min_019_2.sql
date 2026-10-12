--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_umsatz_2;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE dbp_etl.ods_bon_agg_15min_umsatz_2  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_2
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
)
SELECT
    bon_dat
   ,CASE
      WHEN Extract(HOUR From bon_beginn) = 23 AND
           Extract(HOUR From bon_ende) = 0
      THEN 23
      ELSE Extract(HOUR From bon_ende) END zeit_stunde
   ,CASE WHEN Extract(HOUR From bon_beginn) = 23 AND
              Extract(HOUR From bon_ende) = 0
         THEN 45 
         WHEN (Extract(MINUTE From bon_ende) <15) THEN 0
         WHEN (Extract(MINUTE From bon_ende) <30) THEN 15
         WHEN (Extract(MINUTE From bon_ende) <45) THEN 30
         ELSE 45
    END  zeit_minute
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,Sum(umsatz_brutto) AS ums_brutto
   ,Sum((umsatz_brutto *100) / (100 + mwst) )     AS umsatz_netto
   ,Sum(track_artikel)+Count(DISTINCT CASE WHEN talon IS NOT NULL THEN talon END) anz_artikel
   ,Count( DISTINCT kunde_bon_nr) AS anz_kunden
   ,Sum (0) AS bonanzahl_sug
FROM
(
  SELECT
     k.wup_id
    ,k.bon_dat
    ,k.bon_beginn
    ,k.bon_ende
    ,k.mandant_id
    ,t.kassensystem_name
    ,k.kasse_nr
    ,k.kasse_typ_id
    ,CASE WHEN (k.kunde_fg=1) THEN k.bon_id END kunde_bon_nr
    ,v.kl_art_id
    ,v.wg_id
    ,v.umsatz_brutto
    ,Coalesce (m.mwst,0) mwst
    ,v.einh_id
    ,CASE 
       WHEN v.talon_id <> 0 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.mandant_id > 1
       THEN v.talon_id 
       ELSE NULL 
     END AS talon
    ,CASE
       WHEN v.wg_id = 980 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.umsatz_brutto > 0 AND
            v.mandant_id > 1
       THEN 0
       WHEN v.einh_id = 'PND'
       THEN 0
       WHEN v.talon_id <> 0 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.mandant_id > 1
       THEN 0
       ELSE 1
     END AS track_artikel
       
  FROM dbp_ods.ods_bon_kopf_2 k
  
  LEFT JOIN dbp_ods.ods_bon_transaction_2 t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
  
  INNER JOIN dbp_ods.ods_bon_verkauf_2 v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  
  INNER JOIN dbp_data.mwst_per_2 m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
       (k.bon_id,k.wup_id) NOT IN
  (SELECT bon_id, wup_id
   FROM dbp_ods.ods_bon_storno_2
  )
    AND k.turnover_fg=1
    AND (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT
         mandant_id
        ,wup_id
		,kassensystem_name
        ,kasse_nr
        ,bon_dat
      FROM dbp_etl.bon_agg_kassenberichte_2
     )
  UNION ALL
  
  SELECT
     k.wup_id
    ,k.bon_dat
    ,k.bon_beginn
    ,k.bon_ende
    ,k.mandant_id
    ,t.kassensystem_name
    ,k.kasse_nr
    ,k.kasse_typ_id
    ,CASE WHEN (k.kunde_fg=1) THEN k.bon_id END kunde_bon_nr
    ,v.kl_art_id
    ,v.wg_id
    ,v.umsatz_brutto
    ,Coalesce (m.mwst,0) mwst
    ,v.einh_id
    ,CASE 
       WHEN v.talon_id <> 0 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.mandant_id > 1
       THEN v.talon_id 
       ELSE NULL 
     END AS talon
    ,CASE
       WHEN v.wg_id = 980 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.umsatz_brutto > 0 AND
            v.mandant_id > 1
       THEN 0
       WHEN v.einh_id = 'PND'
       THEN 0
       WHEN v.talon_id <> 0 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.mandant_id > 1
       THEN 0
       ELSE 1
     END AS track_artikel

  FROM dbp_ods.ods_bon_kopf_2 k
  
  LEFT JOIN dbp_ods.ods_bon_transaction_2 t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
  
  INNER JOIN dbp_ods.ods_bon_retoure_2 v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  
  INNER JOIN dbp_data.mwst_per_2 m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
WHERE k.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
      t.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
      v.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
     (k.bon_id,k.bon_dat) NOT IN
  (SELECT bon_id, bon_dat
   FROM dbp_ods.ods_bon_storno_2
  )
    AND k.turnover_fg=1
    AND (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
  (SELECT
      mandant_id
     ,wup_id
     ,kassensystem_name
     ,kasse_nr
     ,bon_dat
   FROM dbp_etl.bon_agg_kassenberichte_2
  )
)t1_2
GROUP BY 1,2,3,4,5,6,7,8
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE dbp_etl.ods_bon_agg_15min_umsatz_2  SET bonanzahl_sug = b.bonanzahl_sug
 
 FROM (

SELECT s.mandant_id
      ,s.wup_id
      ,s.bon_dat
      ,s.zeit_stunde
      ,Max(s.zeit_minute) AS zeit_minute
      ,s.kasse_nr
      ,w.kundenfaktor
      ,s.kasse_typ_id
      ,Sum(CEIL(s.bonanzahl_sug)) AS bonanzahl_sug
FROM (

SELECT 
    k.bon_dat
  ,CASE
     WHEN Extract(HOUR From k.bon_beginn) = 23 AND
          Extract(HOUR From k.bon_ende) = 0
     THEN 23
     ELSE Extract(HOUR From k.bon_beginn) END zeit_stunde
  ,CASE WHEN Extract(HOUR From k.bon_beginn) = 23 AND
             Extract(HOUR From k.bon_ende) = 0
        THEN 45 
        WHEN (Extract(MINUTE From k.bon_ende) <15) THEN 0
        WHEN (Extract(MINUTE From k.bon_ende) <30) THEN 15
        WHEN (Extract(MINUTE From k.bon_ende) <45) THEN 30
        ELSE 45
   END  zeit_minute
  ,k.mandant_id
  ,k.wup_id
  ,k.kasse_nr
  ,k.kasse_typ_id
  ,Count(DISTINCT(k.kasse_nr||k.bon_id)) AS bonanzahl_sug
FROM dbp_ods.ods_bon_kopf_2 k

INNER JOIN dbp_ods.ods_bon_verkauf_2 v
ON k.mandant_id = v.mandant_id
AND k.wup_id = v.wup_id
AND k.bon_id = v.bon_id
AND k.bon_dat = v.bon_dat
 
WHERE k.kunde_fg = 1
  AND v.umsatz_brutto > 0 
  AND k.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1
  AND v.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1
  AND (k.mandant_id,k.bon_dat) IN (SELECT mandant_id,dat FROM dbp_etl.ods_bon_agg_15min_umsatz_2)
  AND (v.mandant_id,v.bon_dat) IN (SELECT mandant_id,dat FROM dbp_etl.ods_bon_agg_15min_umsatz_2)
  AND  (
        (k.mandant_id IN (1,4,6))
     OR (k.mandant_id IN (2,5,7,8) AND k.kassierer_nr NOT BETWEEN 800 AND 900) 
     OR (k.mandant_id = 3 AND (k.kassierer_nr NOT BETWEEN 700 AND 900))
    )
  AND k.kasse_typ_id <> 5
  AND (k.mandant_id,k.bon_id,k.wup_id) NOT IN (SELECT mandant_id,bon_id,wup_id FROM dbp_ods.ods_bon_storno_2)
GROUP BY 1,2,3,4,5,6,7) s
 
LEFT JOIN dbp_data.wup_2 w
 ON w.mandant_id =  s.mandant_id
 AND w.wup_id = s.wup_id
 
GROUP BY 1,2,3,4,6,7,8
) b
 
 WHERE dbp_etl.ods_bon_agg_15min_umsatz.dat = b.bon_dat AND
       dbp_etl.ods_bon_agg_15min_umsatz.mandant_id = b.mandant_id AND
       dbp_etl.ods_bon_agg_15min_umsatz.zeit_stunde = b.zeit_stunde AND
       dbp_etl.ods_bon_agg_15min_umsatz.zeit_15min = b.zeit_minute AND
       dbp_etl.ods_bon_agg_15min_umsatz.wup_id = b.wup_id AND
       dbp_etl.ods_bon_agg_15min_umsatz.kasse_nr = b.kasse_nr AND
       dbp_etl.ods_bon_agg_15min_umsatz.kasse_typ_id = b.kasse_typ_id
;



