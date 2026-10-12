
CREATE OR REPLACE TABLE DBP_ETL.bon_agg_kassenberichte_tmp  (
      bon_id VARCHAR(25) COLLATE 'en-cs' NOT NULL,
      bon_dat DATE NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      xml_name VARCHAR(255)
);

INSERT INTO DBP_ETL.bon_agg_kassenberichte_tmp
(
    bon_id
   ,mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
   ,xml_name
)
SELECT
    t2.bon_id
   ,t2.mandant_id
   ,t2.wup_id
   ,COALESCE(k.wrg_id,mwzp.wrg_id)
   ,t2.kassensystem_name
   ,t2.kasse_nr
   ,t2.bon_dat
   ,t2.datei_name AS xml_name
FROM DBP_ODS.ods_bon_transaction t2

INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
ON t2.mandant_id = mwzp.mandant_id
AND t2.bon_dat between mwzp.dat_von and mwzp.dat_bis
AND t2.training_fg != 1
LEFT JOIN DBP_ODS.ods_bon_kopf k
ON k.bon_id = t2.bon_id
AND k.wup_id = t2.wup_id
AND k.mandant_id = t2.mandant_id
WHERE t2.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1
;

CREATE OR REPLACE TABLE DBP_ETL.bon_agg_kassenberichte  (
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      bon_dat DATE NOT NULL
     )
;

INSERT INTO DBP_ETL.bon_agg_kassenberichte
(
    mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
)
SELECT
    mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
FROM DBP_ETL.bon_agg_kassenberichte_tmp t1
GROUP BY 1,2,3,4,5,6
;

CREATE OR REPLACE TABLE DBP_ETL.ods_bon_sign_on_off  (
      bon_dat DATE NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT,
      kasse_typ_id BYTEINT,
      transaction_name VARCHAR(30) COLLATE 'en-ci' ,
      bon_ende TIMESTAMP(0) NOT NULL,
      bon_nr INTEGER NOT NULL
);

INSERT INTO DBP_ETL.ods_bon_sign_on_off
(
    bon_dat
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT
    t.bon_dat
   ,t.wup_id
   ,COALESCE(k.wrg_id,mwzp.wrg_id)
   ,t.mandant_id
   ,t.kassensystem_name
   ,t.kasse_nr
   ,t.kasse_typ_id
   ,CASE WHEN t.transaction_name = 'OperatorLock' THEN 'SignOffTransaction'
         WHEN t.transaction_name = 'OperatorUnlock' THEN 'SignOnTransaction'
         WHEN t.transaction_name = 'PosLockTransaction' THEN 'SignOffTransaction'
         WHEN t.transaction_name = 'PosUnlockTransaction' THEN 'SignOnTransaction'
		 ELSE t.transaction_name 
    END transaction_name
   ,t.bon_ende
   ,t.bon_nr
FROM DBP_ODS.ods_bon_transaction t

INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
ON t.mandant_id = mwzp.mandant_id
AND t.bon_dat between mwzp.dat_von and mwzp.dat_bis
AND t.training_fg <> 1
LEFT JOIN DBP_ODS.ods_bon_kopf k
ON k.bon_id = t.bon_id
AND k.wup_id = t.wup_id
AND k.mandant_id = t.mandant_id

WHERE t.transaction_name IN ('SignOffTransaction','SignOnTransaction','OperatorLock','OperatorUnlock','PosUnlockTransaction','PosLockTransaction')
  AND (t.mandant_id,t.wup_id,t.kassensystem_name,t.kasse_nr,t.bon_dat) IN
  (SELECT
       mandant_id
      ,wup_id
      ,kassensystem_name
      ,kasse_nr
      ,bon_dat
   FROM DBP_ETL.bon_agg_kassenberichte
  )
AND t.kassensystem_name NOT IN ('KPOS')
;

INSERT INTO DBP_ETL.ods_bon_sign_on_off
(
    bon_dat
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT
    t.bon_dat
   ,t.wup_id
   ,COALESCE(k.wrg_id,mwzp.wrg_id)
   ,t.mandant_id
   ,t.kassensystem_name
   ,t.kasse_nr
   ,t.kasse_typ_id
   ,CASE WHEN t.transaction_name = 'OperatorLock' THEN 'SignOffTransaction'
         WHEN t.transaction_name = 'OperatorUnlock' THEN 'SignOnTransaction'
         WHEN t.transaction_name = 'PosLockTransaction' THEN 'SignOffTransaction'
         WHEN t.transaction_name = 'PosUnlockTransaction' THEN 'SignOnTransaction'
	 ELSE t.transaction_name 
    END transaction_name_
   ,t.bon_ende
   ,row_number() over (partition by t.wup_id,t.kasse_nr,t.bon_dat order by t.wup_id,t.kasse_nr,t.bon_ende,transaction_name_ DESC) bon_nr
FROM DBP_ODS.ods_bon_transaction t

INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
ON t.mandant_id = mwzp.mandant_id
AND t.bon_dat between mwzp.dat_von and mwzp.dat_bis
AND t.training_fg <> 1
LEFT JOIN DBP_ODS.ods_bon_kopf k
ON k.bon_id = t.bon_id
AND k.wup_id = t.wup_id
AND k.mandant_id = t.mandant_id

WHERE t.transaction_name IN ('SignOffTransaction','SignOnTransaction','OperatorLock','OperatorUnlock','PosUnlockTransaction','PosLockTransaction')
  AND (t.mandant_id,t.wup_id,t.kassensystem_name,t.kasse_nr,t.bon_dat) IN
  (SELECT
       mandant_id
      ,wup_id
      ,kassensystem_name
      ,kasse_nr
      ,bon_dat
   FROM DBP_ETL.bon_agg_kassenberichte
  )
AND t.kassensystem_name IN ('KPOS')
;

CREATE OR REPLACE TRANSIENT TABLE _fake_entries_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT
    bon_dat
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,'SignOnTransaction' transaction_name
--   ,to_timestamp((to_date(bon_ende, 'yyyy-mm-dd') || ' 00:00:00')) AS bon_ende
   ,to_timestamp(to_date(bon_ende)) AS bon_ende
   ,bon_nr-1 AS bon_nr
FROM DBP_ETL.ods_bon_sign_on_off
WHERE (mandant_id,wup_id,wrg_id,kassensystem_name,kasse_nr,bon_dat,bon_nr) IN (SELECT mandant_id,
                                                                               wup_id,
                                                                               wrg_id,
                                                                               kassensystem_name,
                                                                               kasse_nr,
                                                                               bon_dat,
                                                                               Min(bon_nr) min_bon_nr
                                                                        FROM DBP_ETL.ods_bon_sign_on_off
                                                                        GROUP BY 1,2,3,4,5,6)
  AND transaction_name IN ('SignOffTransaction','OperatorLock','PosLockTransaction')
);

CREATE OR REPLACE TRANSIENT TABLE _not_applicable_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.bon_dat+1 AS bon_dat,
       a.wup_id,
       a.wrg_id,
       a.mandant_id,
       a.kassensystem_name,
       a.kasse_nr,
       a.kasse_typ_id,
       a.transaction_name,
       a.bon_ende,
       a.bon_nr
FROM DBP_ETL.ods_bon_sign_on_off a
JOIN (SELECT mandant_id,
             wup_id,
             wrg_id,
             kassensystem_name,
             kasse_nr,
             bon_dat,
             Max(bon_nr) min_bon_nr
      FROM DBP_ETL.ods_bon_sign_on_off
      GROUP BY 1,2,3,4,5,6) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.wrg_id = b.wrg_id AND
     a.kassensystem_name = b.kassensystem_name AND
     a.kasse_nr = b.kasse_nr AND
     a.bon_dat = b.bon_dat AND
     a.bon_nr = b.min_bon_nr
WHERE a.transaction_name = 'SignOffTransaction'
);

DELETE FROM _fake_entries_${TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,wrg_id,kassensystem_name,kasse_nr,bon_dat) IN (SELECT mandant_id,wup_id,wrg_id,kassensystem_name,kasse_nr,bon_dat FROM _not_applicable_${TRANSIENT_TABLE_SUFFIX})
;

INSERT INTO DBP_ETL.ods_bon_sign_on_off
(
    bon_dat
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT bon_dat
      ,wup_id
      ,wrg_id
      ,mandant_id
      ,kassensystem_name
      ,kasse_nr
      ,kasse_typ_id
      ,transaction_name
      ,bon_ende
      ,bon_nr
FROM _fake_entries_${TRANSIENT_TABLE_SUFFIX}
;

DROP TABLE IF EXISTS _fake_entries_${TRANSIENT_TABLE_SUFFIX};
DROP TABLE IF EXISTS _not_applicable_${TRANSIENT_TABLE_SUFFIX};

CREATE OR REPLACE TABLE DBP_ETL.ods_bon_sign_on_off_time  (
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT,
      kasse_typ_id BYTEINT,
      start_time TIMESTAMP(0) NOT NULL,
      end_time TIMESTAMP(0) NOT NULL
);

INSERT INTO DBP_ETL.ods_bon_sign_on_off_time
(
    mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,start_time
   ,end_time
)
SELECT
    t1.mandant_id
   ,t1.wup_id
   ,t1.wrg_id
   ,t1.kassensystem_name
   ,t1.kasse_nr
   ,t1.kasse_typ_id
   ,t1.bon_ende AS start_time
   ,Max(Coalesce(t2.bon_ende,t3.bon_ende,to_timestamp(to_date(t1.bon_ende) || ' 23:59:59') )) AS end_time
FROM 
(
 SELECT
     wup_id
    ,wrg_id
    ,bon_dat
    ,mandant_id
    ,kassensystem_name
    ,kasse_nr
    ,kasse_typ_id
    ,bon_ende
    ,bon_nr
    --,MSum(bon_nr,2,bon_nr DESC)-bon_nr  folgeBon
    ,lag(bon_nr) over (partition by wup_id,mandant_id,kasse_nr,bon_dat order by bon_nr DESC) as folgeBon
    ,CASE WHEN folgeBon is null THEN 99999999 ELSE folgeBon END folge_bon_nr
 FROM DBP_ETL.ods_bon_sign_on_off
 WHERE transaction_name IN ('SignOnTransaction')
-- GROUP BY wup_id,mandant_id,kasse_nr,bon_dat
) t1
   LEFT OUTER JOIN 
(SELECT *
 FROM DBP_ETL.ods_bon_sign_on_off
 WHERE transaction_name IN ('SignOffTransaction')
) t2
 ON  t1.wup_id=t2.wup_id
 AND t1.wrg_id = t2.wrg_id
 AND t1.mandant_id=t2.mandant_id 
 AND t1.kassensystem_name=t2.kassensystem_name 
 AND t1.kasse_nr=t2.kasse_nr
 AND t2.bon_nr BETWEEN t1.bon_nr AND  t1.folge_bon_nr
 AND t2.bon_dat =t1.bon_dat
   LEFT OUTER JOIN 
(SELECT *
 FROM DBP_ETL.ods_bon_sign_on_off
 WHERE transaction_name IN ('SignOnTransaction')
) t3
 ON  t1.wup_id=t3.wup_id
 AND t1.wrg_id = t3.wrg_id
 AND t1.mandant_id=t3.mandant_id 
 AND t1.kassensystem_name = t3.kassensystem_name
 AND t1.kasse_nr=t3.kasse_nr
 AND t3.bon_nr= t1.folge_bon_nr
 AND t3.bon_dat =t1.bon_dat
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE TRANSIENT TABLE _kill_zombies_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT wup_id,
       mandant_id,
       kasse_nr,
       Cast(start_time AS DATE) AS dat
FROM DBP_ETL.ods_bon_sign_on_off_time
WHERE LPad(Cast(HOUR ( start_time)   AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( start_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( start_time) AS VARCHAR(2)),2,'0') = '00:00:00' AND
      LPad(Cast(HOUR ( end_time)     AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( end_time)   AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( end_time) AS VARCHAR(2)),2,'0') = '23:59:59'
);

CREATE OR REPLACE TABLE DBP_ETL.ods_bon_agg_15min_kassierzeit  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      kassierzeit INTEGER NOT NULL)
;

CREATE OR REPLACE TRANSIENT TABLE _track_it_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT
     mandant_id
    ,kassensystem_name
    ,wup_id
    ,wrg_id
    ,kasse_nr
    ,kasse_typ_id
    ,zeit_stunde
    ,zeit_minute
    ,Cast(t1.start_time AS DATE) bon_dat
    ,to_timestamp(to_date(t1.start_time) || ' ' || t2.start_time) zeit_scheibe_start
    ,to_timestamp(to_date(t1.start_time) || ' ' || t2.end_time) + INTERVAL '1 SECOND'   zeit_scheibe_ende
    ,t1.start_time
    ,t1.end_time
 FROM DBP_ETL.ods_bon_sign_on_off_time t1
    INNER JOIN
 (
  SELECT 
      zeit_stunde
     ,zeit_minute
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute<10
           THEN '0' || Trim(zeit_minute)
           ELSE Trim(zeit_minute)
      END || ':00' start_time
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute = 0 THEN '14:59'
           WHEN zeit_minute = 15 THEN '29:59'
           WHEN zeit_minute = 30 THEN '44:59'
           WHEN zeit_minute = 45 THEN '59:59'
      END AS end_time
  FROM DBP_DATA.zeit
 ) t2
  ON  to_timestamp(to_date(t1.start_time) || ' ' || t2.end_time) + INTERVAL '1 SECOND'  >= t1.start_time 
  AND to_timestamp(to_date(t1.start_time) || ' ' || t2.start_time) <= t1.end_time
);

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL
);

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
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
   ,wrg_id
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
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
            v.umsatz_brutto > 0 /*AND
            v.mandant_id > 1  am 07.04.2027 spec0305460 selim kjamili*/
       THEN 0
       WHEN v.einh_id = 'PND'
       THEN 0
       WHEN v.talon_id <> 0 AND
            t.kassensystem_name IN ( 'KPOS' , 'POSITION') AND
            v.mandant_id > 1
       THEN 0
       ELSE 1
     END AS track_artikel
       
  FROM dbp_ods.ods_bon_kopf k

  INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  LEFT JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
  
  INNER JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  
  INNER JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
       (k.bon_id,k.wup_id) NOT IN (SELECT bon_id, wup_id FROM dbp_ods.ods_bon_storno) AND 
        k.turnover_fg=1 AND 
       (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT mandant_id ,wup_id	,kassensystem_name ,kasse_nr ,bon_dat FROM dbp_etl.bon_agg_kassenberichte )

  UNION ALL
  
  SELECT
     k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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

  FROM dbp_ods.ods_bon_kopf k

  INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  LEFT JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
  
  INNER JOIN dbp_ods.ods_bon_retoure v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  
  INNER JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
WHERE k.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
      t.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
      v.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
     (k.bon_id,k.bon_dat) NOT IN
  (SELECT bon_id, bon_dat   FROM dbp_ods.ods_bon_storno  )
    AND k.turnover_fg=1
    AND (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
  (SELECT
      mandant_id
     ,wup_id
     ,kassensystem_name
     ,kasse_nr
     ,bon_dat
   FROM dbp_etl.bon_agg_kassenberichte
  )
)t1
GROUP BY 1,2,3,4,5,6,7,8,9
;

UPDATE dbp_etl.ods_bon_agg_15min_umsatz  SET bonanzahl_sug = b.bonanzahl_sug
 
 FROM (

SELECT s.mandant_id
      ,s.wup_id
      ,s.wrg_id
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
  ,k.wrg_id
  ,k.kasse_nr
  ,k.kasse_typ_id
  ,Count(DISTINCT(k.kasse_nr||k.bon_id)) AS bonanzahl_sug
FROM dbp_ods.ods_bon_kopf k

INNER JOIN dbp_ods.ods_bon_verkauf v
ON k.mandant_id = v.mandant_id
AND k.wup_id = v.wup_id
AND k.bon_id = v.bon_id
AND k.bon_dat = v.bon_dat
 
WHERE k.kunde_fg = 1
  AND v.umsatz_brutto > 0 
  AND k.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1
  AND v.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1
  AND (k.mandant_id,k.bon_dat) IN (SELECT mandant_id,dat FROM dbp_etl.ods_bon_agg_15min_umsatz)
  AND (v.mandant_id,v.bon_dat) IN (SELECT mandant_id,dat FROM dbp_etl.ods_bon_agg_15min_umsatz)
  AND  (
        (k.mandant_id IN (1,4,6))
     OR (k.mandant_id IN (2,5,7,8) AND k.kassierer_nr NOT BETWEEN 800 AND 900) 
     OR (k.mandant_id = 3 AND (k.kassierer_nr NOT BETWEEN 700 AND 900))
    )
  AND k.kasse_typ_id <> 5
  AND (k.mandant_id,k.bon_id,k.wup_id) NOT IN (SELECT mandant_id,bon_id,wup_id FROM dbp_ods.ods_bon_storno)
GROUP BY 1,2,3,4,5,6,7,8) s
 
LEFT JOIN dbp_data.wup w
 ON w.mandant_id =  s.mandant_id
 AND w.wup_id = s.wup_id
 
GROUP BY 1,2,3,4,5,7,8,9
) b
 
 WHERE dbp_etl.ods_bon_agg_15min_umsatz.dat = b.bon_dat AND
       dbp_etl.ods_bon_agg_15min_umsatz.mandant_id = b.mandant_id AND
       dbp_etl.ods_bon_agg_15min_umsatz.zeit_stunde = b.zeit_stunde AND
       dbp_etl.ods_bon_agg_15min_umsatz.zeit_15min = b.zeit_minute AND
       dbp_etl.ods_bon_agg_15min_umsatz.wup_id = b.wup_id AND
       dbp_etl.ods_bon_agg_15min_umsatz.kasse_nr = b.kasse_nr AND
       dbp_etl.ods_bon_agg_15min_umsatz.kasse_typ_id = b.kasse_typ_id
;

DELETE FROM _track_it_${TRANSIENT_TABLE_SUFFIX}
WHERE LPad(Cast(HOUR   ( end_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( end_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( end_time) AS VARCHAR(2)),2,'0') = '23:59:59' and
     (mandant_id,wup_id,kasse_nr,kasse_typ_id,zeit_stunde,zeit_minute) not in (select mandant_id,wup_id,kasse_nr,kasse_typ_id,zeit_stunde,zeit_15min from dbp_etl.ods_bon_agg_15min_umsatz where umsatz_brutto <> 0)
;

/*SPEC0196833**************/

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_zeilenstorno INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 

)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
   ,anz_zeilenstorno
   ,umsatz_brutto_zeilenstorno 
   ,umsatz_netto_zeilenstorno
    /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
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
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,sum(0) as  umsatz_brutto
   ,sum(0) AS umsatz_netto
   ,Sum(0) anz_artikel
   ,sum(0) AS anz_kunden
   ,sum(0) AS bonanzahl_sug
   /*SPEC0262312*/
   --,count( case when zeilenstorno_fg = 1 then zeilenstorno_fg end) as anz_zeilenstorno
   --,count( case when zeilenstorno_fg = 1 AND wg_id <> 980 AND umsatz_brutto < 0 then zeilenstorno_fg end) as anz_zeilenstorno
   ,sum(zeilenstorno_fg) anz_zeilenstorno
   ,sum(umsatz_brutto) as umsatz_brutto_zeilenstorno
   ,sum((umsatz_brutto * 100) / (100 + mwst)) as umsatz_netto_zeilenstorno
    /*SPEC0277885*/
   ,sum(0) as anz_bonabbruch_suspended 			
   ,coalesce(case when anz_zeilenstorno > 0 then count(distinct(bon_id)) end,0) anz_bon_zeilenstorno				
   ,sum(0) as anz_bon_kscan 						
   ,sum(0) as anz_zeilen_kscan 					
   ,sum(0) as umsatz_netto_bonabbruch_suspended 	
   ,sum(0) as umsatz_netto_kscan 
FROM
(
  SELECT
     k.bon_id
    ,k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
     ,v.zeilenstorno_fg       
  FROM dbp_ods.ods_bon_kopf k

  INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  LEFT JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
 
  INNER JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  INNER JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
       (k.bon_id,k.wup_id, k.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_ods.ods_bon_storno) AND 
        k.turnover_fg = 1 AND 
       (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT mandant_id ,wup_id	,kassensystem_name ,kasse_nr ,bon_dat FROM dbp_etl.bon_agg_kassenberichte )
  and v.zeilenstorno_fg = 1
------SPEC0310372------------ SK--13052025---
--  and v.wg_id <> 980 AND v.umsatz_brutto < 0
  )t1
GROUP BY all
;

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonstorno  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_bonstorno INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 

)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonstorno
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
   ,anz_bonstorno
   ,umsatz_brutto_bonstorno 
   ,umsatz_netto_bonstorno
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
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
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,sum(0) as  umsatz_brutto
   ,sum(0) AS umsatz_netto
   ,Sum(0) anz_artikel
   ,sum(0) AS anz_kunden
   ,sum(0) AS bonanzahl_sug
   ,count(distinct bon_id) as anz_bonstorno
   ,sum(umsatz_brutto) as umsatz_brutto_bonstorno
   ,sum((umsatz_brutto * 100) / (100 + mwst)) as umsatz_netto_bonstorno
   /*SPEC0277885*/
   ,sum(0) as anz_bonabbruch_suspended 			
   ,sum(0) as anz_bon_zeilenstorno 				
   ,sum(0) as anz_bon_kscan 						
   ,sum(0) as anz_zeilen_kscan 					
   ,sum(0) as umsatz_netto_bonabbruch_suspended 	
   ,sum(0) as umsatz_netto_kscan 
FROM
(
  SELECT
     k.bon_id
    ,k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
  FROM dbp_ods.ods_bon_kopf k

  INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  LEFT JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
 
  INNER JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  INNER JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
  inner join dbp_ods.ods_bon_storno s
   ON  k.mandant_id = s.mandant_id
  AND k.wup_id = s.wup_id
  AND k.bon_id = s.bon_id
  AND k.bon_dat = s.bon_dat    
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
       (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT mandant_id ,wup_id	,kassensystem_name ,kasse_nr ,bon_dat FROM dbp_etl.bon_agg_kassenberichte )
  )t1
GROUP BY 1,2,3,4,5,6,7,8,9
;


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_bonabbruch INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
   ,anz_bonabbruch 
   ,umsatz_brutto_bonabbruch
   ,umsatz_netto_bonabbruch  
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
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
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,Sum(0) AS ums_brutto
   ,Sum(0)     AS umsatz_netto
   ,Sum(0) anz_artikel
   ,sum(0) AS anz_kunden
   ,Sum (0) AS bonanzahl_sug
   ,count(distinct case
          when 
            ((kpos_transaction_name = 'SALE' 
              and bon_status_cd = 'CANCELED' 
              and upper(bon_abbruch_grund_txt) <> 'SCO_TILL_SWITCH')
              or
            (kpos_transaction_name = 'EXPENSE_INCOME'
             and bon_status_cd = 'CANCELED')
             or
            (kpos_transaction_name = 'EXPENSE_INCOME'
             and bon_status_cd = 'CLOSED')
            ) 
          then  bon_id 
         end ) as anz_bonabbruch
   ,sum(umsatz_brutto)*-1 as umsatz_brutto_bonabbruch
   ,sum((umsatz_brutto * 100) / (100 + mwst))*-1 as umsatz_netto_bonabbruch
    /*SPEC0277885*/
   ,sum(0) as anz_bonabbruch_suspended 			
   ,sum(0) as anz_bon_zeilenstorno 				
   ,sum(0) as anz_bon_kscan 						
   ,sum(0) as anz_zeilen_kscan 					
   ,sum(0) as umsatz_netto_bonabbruch_suspended 	
   ,sum(0) as umsatz_netto_kscan 
FROM 
( 
 SELECT
      t.bon_abbruch_grund_txt
     ,t.kpos_transaction_name
     ,t.bon_status_cd
     ,k.bon_id
    ,k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
      ,k.umsatz_mwst 
      ,k.turnover_fg
  FROM dbp_ods.ods_bon_kopf k

   JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat

  JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat

  JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        k.turnover_fg = 0 AND 
       (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT mandant_id ,wup_id	,kassensystem_name ,kasse_nr ,bon_dat FROM dbp_etl.bon_agg_kassenberichte )
     and ((
        t.kpos_transaction_name = 'SALE' 
          and t.bon_status_cd = 'CANCELED' 
          and upper(t.bon_abbruch_grund_txt) <> 'SCO_TILL_SWITCH')
          or
         (kpos_transaction_name = 'EXPENSE_INCOME'
                   and t.bon_status_cd = 'CANCELED')
          or
         (kpos_transaction_name = 'EXPENSE_INCOME'
                   and t.bon_status_cd = 'CLOSED')
        )
)t1
GROUP BY 1,2,3,4,5,6,7,8,9
;



CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch_suspended  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_bonabbruch INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch_suspended
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
   ,anz_bonabbruch 
   ,umsatz_brutto_bonabbruch
   ,umsatz_netto_bonabbruch  
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
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
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,sum(0) as ums_brutto
   ,sum(0) as umsatz_netto
   ,sum(0) as anz_artikel
   ,sum(0) as anz_kunden
   ,sum(0) as bonanzahl_sug
   ,sum(0) as anz_bonabbruch
   ,sum(0) as umsatz_brutto_bonabbruch
   ,sum(0) as umsatz_netto_bonabbruch
    /*SPEC0277885*/
   ,count(distinct(bon_id)) as anz_bonabbruch_suspended 			
   ,sum(0) as anz_bon_zeilenstorno 				
   ,sum(0) as anz_bon_kscan 						
   ,sum(0) as anz_zeilen_kscan 					
   ,sum((umsatz_brutto * 100) / (100 + mwst))*-1 as umsatz_netto_bonabbruch_suspended 	
   ,sum(0) as umsatz_netto_kscan 
FROM 
( 
 SELECT
     k.bon_id
    ,k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
      ,k.umsatz_mwst 
      ,k.turnover_fg
  FROM dbp_ods.ods_bon_kopf k

   JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat

  JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat

  JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND   
        (k.bon_id,k.wup_id, k.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_ods.ods_bon_storno) AND 
         k.turnover_fg = 0 and 
         t.suspended_fg <> 0
)t1
group by all
;

/*SPEC0277885*/
CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_kscan  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_zeilenstorno INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_kscan
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,bonanzahl_sug
   ,anz_zeilenstorno
   ,umsatz_brutto_zeilenstorno 
   ,umsatz_netto_zeilenstorno
    /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
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
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,sum(0) as  umsatz_brutto
   ,sum(0) AS umsatz_netto
   ,Sum(0) anz_artikel
   ,sum(0) AS anz_kunden
   ,sum(0) AS bonanzahl_sug 
   ,sum(0) as anz_zeilenstorno
   ,sum(0) as umsatz_brutto_zeilenstorno
   ,sum(0) as umsatz_netto_zeilenstorno
    /*SPEC0277885*/
   ,sum(0) as anz_bonabbruch_suspended 			
   ,sum(0) anz_bon_zeilenstorno				
   ,count(distinct(bon_id)) as anz_bon_kscan						
   ,count(bon_zeile) anz_zeilen_kscan  					
   ,sum(0) as umsatz_netto_bonabbruch_suspended 	
   ,sum((umsatz_brutto * 100) / (100 + mwst)) as umsatz_netto_kscan
FROM
(
  SELECT
     k.bon_id
    ,k.wup_id
    ,COALESCE(k.wrg_id,mwzp.wrg_id) wrg_id
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
    ,v.bon_zeile
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
     ,v.zeilenstorno_fg       
  FROM dbp_ods.ods_bon_kopf k

  INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
     ON k.mandant_id = mwzp.mandant_id
    AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis
  
  LEFT JOIN dbp_ods.ods_bon_transaction t
  ON t.bon_id = k.bon_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = k.mandant_id
  AND t.bon_dat = k.bon_dat
 
  INNER JOIN dbp_ods.ods_bon_verkauf v
  ON  k.mandant_id = v.mandant_id
  AND k.wup_id = v.wup_id
  AND k.bon_id = v.bon_id
  AND k.bon_dat = v.bon_dat
  INNER JOIN dbp_data.mwst_per m
  ON v.mandant_id = m.mandant_id
  AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
  AND v.mwst_id = m.mwst_id
      
  WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        t.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
        v.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1 AND
       (k.bon_id,k.wup_id) NOT IN (SELECT bon_id, wup_id FROM dbp_ods.ods_bon_storno) AND 
        k.turnover_fg = 1 AND 
       (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
     (SELECT mandant_id ,wup_id	,kassensystem_name ,kasse_nr ,bon_dat FROM dbp_etl.bon_agg_kassenberichte )
  and v.kpos_erfassung_id = 'MOBILE_S_SCANN'
  )t1
GROUP BY all
;




INSERT INTO DBP_ETL.ods_bon_agg_15min_kassierzeit
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,kassensystem_name
   ,wup_id
   ,wrg_id
   ,kasse_nr
   ,kasse_typ_id
   ,kassierzeit
 )

SELECT
    bon_dat
   ,zeit_stunde
   ,zeit_minute
   ,mandant_id
   ,kassensystem_name
   ,wup_id
   ,wrg_id
   ,kasse_nr
   ,kasse_typ_id
   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END, 
                      CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END
                     )
   )
   AS kassierzeit
FROM _track_it_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6,7,8,9
;

CREATE OR REPLACE TABLE DBP_ETL.bon_agg_kassierzeiten  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL,
      kasse_typ_id BYTEINT ,
      bon_dat DATE NOT NULL,
      bon_beginn TIMESTAMP(6),
      bon_ende TIMESTAMP(6),
      scan_ende TIMESTAMP(6)
);

INSERT INTO DBP_ETL.bon_agg_kassierzeiten
(
mandant_id 
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr 
,kasse_typ_id
,bon_dat 
,bon_beginn 
,bon_ende
,scan_ende 
)

SELECT 
 k.mandant_id
,k.wup_id
,COALESCE(k.wrg_id,mwzp.wrg_id)
,t.kassensystem_name
,k.kasse_nr
,k.kasse_typ_id
,k.bon_dat
,Cast(k.bon_beginn AS TIMESTAMP(6)) AS bon_beginn
,Cast(k.bon_ende AS TIMESTAMP(6)) AS bon_ende
,Max(Coalesce(Coalesce(Coalesce(v.start_bon_zeile,r.start_bon_zeile),f.start_bon_zeile),k.bon_beginn)) AS scan_ende
FROM DBP_ODS.ods_bon_kopf k

INNER JOIN DBP_DATA.mandant_wrg_zu_per mwzp
ON k.mandant_id = mwzp.mandant_id
AND k.bon_dat between mwzp.dat_von and mwzp.dat_bis

LEFT JOIN DBP_ODS.ods_bon_transaction t
ON t.bon_id = k.bon_id
AND t.wup_id = k.wup_id
AND t.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_verkauf v
ON v.bon_id = k.bon_id
AND v.wup_id = k.wup_id
AND v.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_retoure r
ON r.bon_id = k.bon_id
AND r.wup_id = k.wup_id
AND r.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_financial f
ON f.bon_id = k.bon_id
AND f.wup_id = k.wup_id 
AND f.mandant_id = k.mandant_id

WHERE k.reactivated_fg = 0 AND 
      k.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
      v.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
      t.bon_dat BETWEEN CURRENT_DATE-${days}-1 AND CURRENT_DATE-1 AND
     (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
(SELECT
    mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
FROM DBP_ETL.bon_agg_kassenberichte)

GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO  DBP_ETL.bon_agg_kassierzeiten
(
mandant_id 
,wup_id
,wrg_id
,kassensystem_name 
,kasse_nr 
,kasse_typ_id
,bon_dat
,bon_beginn 
,scan_ende
,bon_ende 
)
SELECT mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,to_timestamp(to_char(bon_beginn, 'YYYY-MM-DD') || ' 23:59:59' ) AS scan_ende
,bon_ende
FROM 
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende 
FROM  DBP_ETL.bon_agg_kassierzeiten
WHERE Cast(scan_ende AS DATE) > Cast(bon_beginn AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,to_timestamp(to_char(scan_ende , 'YYYY-MM-DD') || ' 00:00:00' ) AS bon_beginn
,scan_ende
,bon_ende
FROM
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende 
FROM DBP_ETL.bon_agg_kassierzeiten
WHERE Cast(scan_ende AS DATE) > Cast(bon_beginn AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,to_timestamp(to_char(scan_ende, 'YYYY-MM-DD') || ' 23:59:59') AS bon_ende
FROM
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende 
FROM DBP_ETL.bon_agg_kassierzeiten
WHERE Cast(scan_ende AS DATE) < Cast(bon_ende AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,to_timestamp(to_char(bon_ende , 'YYYY-MM-DD') || ' 00:00:00' ) AS scan_ende
,bon_ende
FROM
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende 
FROM DBP_ETL.bon_agg_kassierzeiten
WHERE Cast(scan_ende AS DATE) < Cast(bon_ende AS DATE)
) s1;

CREATE OR REPLACE TRANSIENT TABLE _zeit_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT 
      zeit_stunde
     ,zeit_minute
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute<10
           THEN '0' || Trim(zeit_minute)
           ELSE Trim(zeit_minute)
      END || ':00' start_time
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute = 0 THEN '14:59'
           WHEN zeit_minute = 15 THEN '29:59'
           WHEN zeit_minute = 30 THEN '44:59'
           WHEN zeit_minute = 45 THEN '59:59'
      END AS end_time
  FROM DBP_DATA.zeit
);

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_scanzeit  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      scanzeit INTEGER NOT NULL)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_scanzeit
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,scanzeit
 )
SELECT
    bon_dat
   ,zeit_stunde
   ,zeit_minute
   ,mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END, 
                      CASE WHEN zeit_scheibe_ende <=end_time   THEN zeit_scheibe_ende  ELSE end_time   END
                     )
   ) AS  scanzeit 

FROM
(
SELECT 
 t1.mandant_id
,t1.wup_id
,t1.wrg_id
,t1.kassensystem_name
,t1.kasse_nr
,t1.kasse_typ_id
,t2.zeit_stunde
,t2.zeit_minute
,Cast(t1.bon_beginn AS DATE) AS bon_dat
,to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM-DD') || ' ' || t2.start_time) ) AS zeit_scheibe_start
,to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND' AS zeit_scheibe_ende
,Cast(Substring(Cast(t1.bon_beginn AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS start_time
,Cast(Substring(Cast(t1.scan_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS end_time
FROM
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE Cast(bon_beginn AS DATE) = Cast(scan_ende AS DATE)
AND bon_beginn < scan_ende
)t1
    INNER JOIN _zeit_${TRANSIENT_TABLE_SUFFIX} t2
 ON  ((to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND') >= t1.scan_ende
 AND to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM-DD') || ' ' || t2.start_time) ) <= t1.scan_ende)
 OR ((to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND') >= t1.bon_beginn
 AND to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM-DD') || ' ' || t2.start_time) ) <= t1.bon_beginn)
 WHERE start_time < end_time
 ) dt1
GROUP BY 1,2,3,4,5,6,7,8,9
;

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_zahlzeit  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      zahlzeit INTEGER NOT NULL)
;

INSERT INTO dbp_etl.ods_bon_agg_15min_zahlzeit
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,zahlzeit
 )
SELECT
    bon_dat
   ,zeit_stunde
   ,zeit_minute
   ,mandant_id
   ,wup_id
   ,wrg_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start_ >= start_time_ THEN zeit_scheibe_start_ ELSE start_time_ END, 
                      CASE WHEN zeit_scheibe_ende_  <= end_time_   THEN zeit_scheibe_ende_  ELSE end_time_   END
                     )
   ) AS  scanzeit 


FROM
(
SELECT 
 t1.mandant_id
,t1.wup_id
,t1.wrg_id
,t1.kassensystem_name
,t1.kasse_nr
,t1.kasse_typ_id
,t2.zeit_stunde
,t2.zeit_minute
,Cast(t1.bon_ende AS DATE) AS bon_dat
,to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.start_time)) zeit_scheibe_start_
,to_timestamp((to_char(t1.bon_ende , 'YYYY-MM-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND'   zeit_scheibe_ende_
,Cast(Substring(Cast(t1.scan_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS start_time_
,Cast(Substring(Cast(t1.bon_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS end_time_
FROM
(
SELECT 
mandant_id
,wup_id
,wrg_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE Cast(bon_ende AS DATE) = Cast(scan_ende AS DATE)
)t1
    INNER JOIN _zeit_${TRANSIENT_TABLE_SUFFIX} t2
 ON  ((to_timestamp((to_char(t1.bon_ende , 'YYYY-MM-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND') >= t1.bon_ende
 AND to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.start_time)) <= t1.bon_ende)
 OR ((to_timestamp((to_char(t1.bon_ende , 'YYYY-MM-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND') >= t1.scan_ende
 AND to_timestamp((to_char(t1.scan_ende , 'YYYY-MM-DD') || ' ' || t2.start_time)) <= t1.scan_ende)
 WHERE start_time_ < end_time_
 ) dt1
GROUP BY 1,2,3,4,5,6,7,8,9
;

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      kassierzeit INTEGER NOT NULL,
      registrierzeit INTEGER NOT NULL,
      zahlzeit INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      umsatz_brutto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_zeilenstorno INTEGER NOT NULL DEFAULT 0,
      anz_bonstorno INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000, 
      anz_bonabbruch INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000  ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
)
;

INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 
   ,anz_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,t1.umsatz_brutto AS umsatz_brutto
   ,t1.umsatz_netto  AS umsatz_netto
   ,t1.anz_artikel   AS anz_artikel
   ,t1.anz_kunden    AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,t1.bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 
   ,0 as anz_zeilenstorno 			
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_umsatz t1;

INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 			
   ,anz_zeilenstorno 
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,t1.umsatz_brutto_zeilenstorno as umsatz_brutto_zeilenstorno   
   ,t1.umsatz_netto_zeilenstorno as umsatz_netto_zeilenstorno 			
   ,t1.anz_zeilenstorno as anz_zeilenstorno 
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,t1.anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno t1
;


INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno
   ,anz_zeilenstorno  			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno
   ,0 as anz_zeilenstorno  			
   ,t1.anz_bonstorno as anz_bonstorno 			
   ,t1.umsatz_brutto_bonstorno as umsatz_brutto_bonstorno 	  
   ,t1.umsatz_netto_bonstorno as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_umsatz_bonstorno t1;


INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug	
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 		
   ,anz_zeilenstorno 
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
   
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 			
   ,0 as anz_zeilenstorno 
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,t1.anz_bonabbruch as anz_bonabbruch 			
   ,t1.umsatz_brutto_bonabbruch as umsatz_brutto_bonabbruch 	
   ,t1.umsatz_netto_bonabbruch as umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch t1;


INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug	
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 		
   ,anz_zeilenstorno 
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
   
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 			
   ,0 as anz_zeilenstorno 
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,t1.anz_bonabbruch_suspended as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,t1.umsatz_netto_bonabbruch_suspended as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM ods_bon_agg_15min_umsatz_bonabbruch_suspended t1;


INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug	
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 		
   ,anz_zeilenstorno 
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
   
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 			
   ,0 as anz_zeilenstorno 
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,t1.anz_bon_kscan as  anz_bon_kscan 						
   ,t1.anz_zeilen_kscan as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,t1.umsatz_netto_kscan as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_umsatz_kscan t1;  


INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 
   ,anz_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.wrg_id        AS wrg_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,t1.kassierzeit AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 
   ,0 as anz_zeilenstorno 			
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_kassierzeit t1
;

INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 
   ,anz_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat
   ,t1.zeit_stunde
   ,t1.zeit_15min 
   ,t1.wup_id
   ,t1.wrg_id
   ,t1.mandant_id
   ,t1.kassensystem_name
   ,t1.kasse_nr 
   ,t1.kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,scanzeit AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 
   ,0 as anz_zeilenstorno 			
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch 
    /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_scanzeit t1
;

INSERT INTO dbp_etl.ods_bon_agg_15min
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 
   ,anz_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT
    t1.dat
   ,t1.zeit_stunde
   ,t1.zeit_15min 
   ,t1.wup_id
   ,t1.wrg_id
   ,t1.mandant_id
   ,t1.kassensystem_name
   ,t1.kasse_nr 
   ,t1.kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,zahlzeit AS zahlzeit
   ,0 AS bonanzahl_sug
   ,0 as umsatz_brutto_zeilenstorno   
   ,0 as umsatz_netto_zeilenstorno 
   ,0 as anz_zeilenstorno 			
   ,0 as anz_bonstorno 			
   ,0 as umsatz_brutto_bonstorno 	  
   ,0 as umsatz_netto_bonstorno 	 
   ,0 as anz_bonabbruch 			
   ,0 as umsatz_brutto_bonabbruch 	
   ,0 as umsatz_netto_bonabbruch 
   /*SPEC0277885*/
   ,0 as anz_bonabbruch_suspended 			
   ,0 as anz_bon_zeilenstorno 				
   ,0 as anz_bon_kscan 						
   ,0 as anz_zeilen_kscan 					
   ,0 as umsatz_netto_bonabbruch_suspended 	
   ,0 as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min_zahlzeit t1
;

CREATE OR REPLACE TRANSIENT TABLE _kasse_track_1_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.kasse_nr,
       a.kasse_typ_id,
       COALESCE(b.durchfalllogik_id,99) AS dfl,
       COUNT(a.kasse_typ_id) OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr) AS anz_kt,
       SUM(a.bonanzahl_sug) AS anz_bons,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY anz_bons DESC) AS rang_anz_bons,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY dfl ASC) AS rang_anz_dfl
FROM dbp_etl.ods_bon_agg_15min a
LEFT JOIN dbp_ods.l_kasse_typ b
  ON a.kasse_typ_id = b.kasse_typ_id
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step1_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_${TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt = 1 OR
     (anz_kt > 1 AND
      kasse_typ_id = 2)
);

DELETE FROM _kasse_track_1_${TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step1_${TRANSIENT_TABLE_SUFFIX})
;

CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step2_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_${TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt > 1 AND
      rang_anz_bons = 1
GROUP BY 1,2,3,4,5
);

DELETE FROM _kasse_track_1_${TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step2_${TRANSIENT_TABLE_SUFFIX} GROUP BY 1,2,3,4 HAVING COUNT(*) = 1)
;

CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step3_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_${TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt > 1 AND
      rang_anz_bons = 1 AND
      rang_anz_dfl = 1
GROUP BY 1,2,3,4,5
);

DELETE FROM _kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step3_${TRANSIENT_TABLE_SUFFIX})
;

CREATE OR REPLACE TRANSIENT TABLE _kasse_track_final_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT *
FROM _kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}
UNION
SELECT *
FROM _kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}
UNION
SELECT *
FROM _kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}
);

/*
UPDATE dbp_etl.ods_bon_agg_15min 
SET kasse_typ_id = kasse_typ_id_

FROM (SELECT r.mandant_id AS mandant_id_,
             r.wup_id AS wup_id_,
             r.dat AS dat_,
             r.kasse_nr AS kasse_nr_,
             r.kasse_typ_id AS kasse_typ_id_
      FROM _kasse_track_final_${TRANSIENT_TABLE_SUFFIX} r) x 
WHERE mandant_id = mandant_id_ AND
      wup_id = wup_id_ AND
      dat = dat_ AND
      kasse_nr = kasse_nr_
;
*/

UPDATE  dbp_etl.ods_bon_agg_15min o SET o.wrg_id = m.wrg_id,
                                        o.umsatz_brutto = o.umsatz_brutto / m.umrechnungskurs,
                                        o.umsatz_netto  = o.umsatz_netto  / m.umrechnungskurs
FROM  dbp_data.mandant_wrg_zu_per m
WHERE m.mandant_id=o.mandant_id 
  AND CURRENT_DATE between m.dat_von and m.dat_bis
  AND o.wrg_id <> m.wrg_id
  AND m.umrechnungskurs is not null
;

DROP TABLE IF EXISTS dbp_etl.ods_bon_15min_agg;
CREATE OR REPLACE TABLE dbp_etl.ods_bon_15min_agg  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      kassierzeit INTEGER NOT NULL,
      registrierzeit INTEGER NOT NULL,
      zahlzeit INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL,
      anz_zeilenstorno   INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_zeilenstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_zeilenstorno  DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_bonstorno INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonstorno DECIMAL(18,4) NOT NULL DEFAULT 0.0000, 
      anz_bonabbruch INTEGER NOT NULL DEFAULT 0,
      umsatz_brutto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto_bonabbruch DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
)
;

INSERT INTO dbp_etl.ods_bon_15min_agg
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,anz_zeilenstorno
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
)
SELECT 
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,Sum(umsatz_brutto  ) AS umsatz_brutto
   ,Sum(umsatz_netto   ) AS umsatz_netto
   ,Sum(anz_artikel    ) AS anz_artikel 
   ,Sum(anz_kunden     ) AS anz_kunden 
   ,Sum(kassierzeit    ) AS kassierzeit
   ,Sum(registrierzeit ) AS registrierzeit
   ,Sum(zahlzeit       ) AS zahlzeit
   ,Sum(bonanzahl_sug  ) AS bonanzahl_sug
   ,sum(anz_zeilenstorno) as anz_zeilenstorno 
   ,sum(umsatz_brutto_zeilenstorno) as umsatz_brutto_zeilenstorno
   ,sum(umsatz_netto_zeilenstorno) as umsatz_netto_zeilenstorno			
   ,sum(anz_bonstorno) as anz_bonstorno	 		
   ,sum(umsatz_brutto_bonstorno) as umsatz_brutto_bonstorno 	  
   ,sum(umsatz_netto_bonstorno) as umsatz_netto_bonstorno
   ,sum(anz_bonabbruch) as anz_bonabbruch 			
   ,sum(umsatz_brutto_bonabbruch) as umsatz_brutto_bonabbruch
   ,sum(umsatz_netto_bonabbruch) as umsatz_netto_bonabbruch
    /*SPEC0277885*/
   ,sum(anz_bonabbruch_suspended) as anz_bonabbruch_suspended 			
   ,sum(anz_bon_zeilenstorno) as anz_bon_zeilenstorno 				
   ,sum(anz_bon_kscan) as anz_bon_kscan 						
   ,sum(anz_zeilen_kscan) as anz_zeilen_kscan 					
   ,sum(umsatz_netto_bonabbruch_suspended) as umsatz_netto_bonabbruch_suspended 	
   ,sum(umsatz_netto_kscan) as umsatz_netto_kscan 
FROM dbp_etl.ods_bon_agg_15min
WHERE kassensystem_name IN ('','KPOS','LUCAS','POSITION')
GROUP BY 1,2,3,4,5,6,7,8;

DELETE FROM dbp_etl.ods_bon_15min_agg
WHERE umsatz_brutto = 0 AND
      anz_artikel = 0 AND
      kassierzeit = 900 AND
     (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kill_zombies_${TRANSIENT_TABLE_SUFFIX})
;

UPDATE dbp_etl.ods_bon_15min_agg SET kassierzeit = 900
WHERE kassierzeit > 900
;

UPDATE dbp_etl.ods_bon_15min_agg SET registrierzeit = 0,
                                     zahlzeit = 0
WHERE umsatz_brutto = 0
;

DELETE FROM dbp_etl.ods_bon_15min_agg
WHERE zeit_stunde <= 1
AND anz_kunden = 0
;

DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE
(
   dat
  ,wup_id
  ,wrg_id
  ,mandant_id
  ,zeit_stunde
  ,zeit_15min
  ,kasse_nr
)
IN (
SELECT DISTINCT
    dat
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,zeit_stunde
   ,zeit_15min
   ,kasse_nr
FROM dbp_etl.ods_bon_agg_15min
WHERE zeit_stunde <= 1
)
;

DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1
;


INSERT INTO dbp_ods.ods_bon_agg_15min
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug_okf
   ,anz_zeilenstorno 
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
   ,td_insert
   ,td_update
)
SELECT
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,wrg_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,anz_zeilenstorno 
   ,umsatz_brutto_zeilenstorno   
   ,umsatz_netto_zeilenstorno 			
   ,anz_bonstorno 			
   ,umsatz_brutto_bonstorno 	  
   ,umsatz_netto_bonstorno 	 
   ,anz_bonabbruch 			
   ,umsatz_brutto_bonabbruch 	
   ,umsatz_netto_bonabbruch
   /*SPEC0277885*/
   ,anz_bonabbruch_suspended 			
   ,anz_bon_zeilenstorno 				
   ,anz_bon_kscan 						
   ,anz_zeilen_kscan 					
   ,umsatz_netto_bonabbruch_suspended 	
   ,umsatz_netto_kscan 
   ,CURRENT_TIMESTAMP
   ,CURRENT_TIMESTAMP
FROM dbp_etl.ods_bon_15min_agg
WHERE dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1
;

CREATE OR REPLACE TRANSIENT TABLE _obsolet_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT *
FROM dbp_ods.ods_bon_transaction
WHERE transaction_name IN ('SignOffTransaction','SignOnTransaction','OperatorLock','OperatorUnlock','PosUnlockTransaction','PosLockTransaction') AND
      bon_dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp)
);

DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE (wup_id,mandant_id,kasse_nr,dat) NOT IN (SELECT wup_id,mandant_id,kasse_nr,bon_dat FROM _obsolet_${TRANSIENT_TABLE_SUFFIX}) AND
       dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp) AND
       umsatz_brutto = 0 AND
       anz_artikel = 0 AND
       kassierzeit <> 0 AND
       kassierzeit <> 900
;

DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE (wup_id,wrg_id,mandant_id,kasse_nr,dat) IN (
SELECT wup_id,
       wrg_id,
       mandant_id,
       kasse_nr,
       dat
FROM dbp_ods.ods_bon_agg_15min
WHERE (wup_id,mandant_id,kasse_nr,dat) NOT IN (SELECT wup_id,mandant_id,kasse_nr,bon_dat FROM _obsolet_${TRANSIENT_TABLE_SUFFIX}) AND
       dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp) AND
       umsatz_brutto = 0 AND
       anz_artikel = 0 AND
       kassierzeit <> 0
GROUP BY 1,2,3,4,5
HAVING Min(zeit_stunde) NOT IN (0,1))
;

CREATE OR REPLACE TABLE dbp_etl.vis_tag_kasse  (
      wup_id INTEGER NOT NULL,
      wrg_id VARCHAR(3) NOT NULL,
      nb_id SMALLINT NOT NULL ,
      mandant_id BYTEINT NOT NULL,
      dat DATE NOT NULL,
      kasse_nr SMALLINT NOT NULL,
      kasse_typ_id BYTEINT NOT NULL DEFAULT -1  ,
      kassierzeit DECIMAL(9,2) NOT NULL DEFAULT 0.00 ,
      anz_artikel INTEGER NOT NULL DEFAULT 0 ,
      registrierzeit DECIMAL(9,2),
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000  ,
      anz_kunden INTEGER NOT NULL DEFAULT 0  ,
      kassiervorgangszeit INTEGER NOT NULL DEFAULT 0,
      umsatz_netto_bonabbruch NUMBER(38,4) NOT NULL DEFAULT 0,
      umsatz_netto_bonstorno NUMBER(38,4) NOT NULL DEFAULT 0,
      umsatz_netto_zeilenstorno NUMBER(38,4) NOT NULL DEFAULT 0,
      anz_zeilenstorno NUMBER(38,0) NOT NULL DEFAULT 0,
      anz_bonstorno NUMBER(38,0) NOT NULL DEFAULT 0,
      anz_bonabbruch NUMBER(38,0) NOT NULL DEFAULT 0,
     /*SPEC0277885*/
      anz_bonabbruch_suspended number(38,0) not null default 0 ,
      anz_bon_zeilenstorno number(38,0) not null default 0 ,
      anz_bon_kscan number(38,0) not null default 0 ,
      anz_zeilen_kscan number(38,0) not null default 0 ,
      umsatz_netto_bonabbruch_suspended number(38,4) not null default 0.0000 , 
      umsatz_netto_kscan number(38,4) not null default 0.0000 
 )
;

INSERT INTO dbp_etl.vis_tag_kasse
(
wup_id,
wrg_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr, 
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit,
umsatz_netto_bonabbruch,
umsatz_netto_bonstorno,
umsatz_netto_zeilenstorno,
anz_zeilenstorno,
anz_bonstorno,
anz_bonabbruch,
/*SPEC0277885*/
anz_bonabbruch_suspended, 			
anz_bon_zeilenstorno, 				
anz_bon_kscan, 						
anz_zeilen_kscan, 					
umsatz_netto_bonabbruch_suspended, 	
umsatz_netto_kscan 
)
SELECT 
   agg.wup_id,
   agg.wrg_id,
   0 as nb_id,
   agg.mandant_id,
   agg.dat,
   agg.kasse_nr,
   agg.kasse_typ_id,
   SUM(kassierzeit    ) AS kassierzeit,
   SUM(anz_artikel    ) AS anz_artikel,
   SUM(registrierzeit ) AS registrierzeit,
   SUM(umsatz_netto   ) AS umsatz_netto,
   SUM(anz_kunden     ) AS anz_kunden,
   SUM(registrierzeit + zahlzeit) AS kassiervorgangszeit,
   SUM(umsatz_netto_bonabbruch),   
   SUM(umsatz_netto_bonstorno),
   SUM(umsatz_netto_zeilenstorno),
   SUM(anz_zeilenstorno),
   SUM(anz_bonstorno),
   SUM(anz_bonabbruch),
       /*SPEC0277885*/
   SUM(anz_bonabbruch_suspended), 			
   SUM(anz_bon_zeilenstorno), 				
   SUM(anz_bon_kscan), 						
   SUM(anz_zeilen_kscan), 					
   SUM(umsatz_netto_bonabbruch_suspended), 	
   SUM(umsatz_netto_kscan)
FROM dbp_ods.ods_bon_agg_15min agg
INNER JOIN dbp_etl.bon_agg_kassenberichte k

ON k.mandant_id = agg.mandant_id
AND k.wup_id = agg.wup_id
and k.bon_dat = agg.dat
and k.kasse_nr = agg.kasse_nr

WHERE k.bon_dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1

GROUP BY 1,2,3,4,5,6,7;

DELETE FROM dbp_data.vis_tag_kasse
WHERE dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1
;

INSERT INTO dbp_data.vis_tag_kasse
(
wup_id,
wrg_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr,
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit,
umsatz_netto_bonabbruch,
umsatz_netto_bonstorno,
umsatz_netto_zeilenstorno,
anz_zeilenstorno,
anz_bonstorno,
anz_bonabbruch, 
/*SPEC0277885*/
anz_bonabbruch_suspended, 			
anz_bon_zeilenstorno, 				
anz_bon_kscan, 						
anz_zeilen_kscan, 					
umsatz_netto_bonabbruch_suspended, 	
umsatz_netto_kscan,
td_insert,
td_update
)
SELECT
wup_id,
wrg_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr, 
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit,
umsatz_netto_bonabbruch,
umsatz_netto_bonstorno,
umsatz_netto_zeilenstorno,
anz_zeilenstorno,
anz_bonstorno,
anz_bonabbruch, 
/*SPEC0277885*/
anz_bonabbruch_suspended, 			
anz_bon_zeilenstorno, 				
anz_bon_kscan, 						
anz_zeilen_kscan, 					
umsatz_netto_bonabbruch_suspended, 	
umsatz_netto_kscan, 
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP
   
FROM dbp_etl.vis_tag_kasse
WHERE dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE-1
;

UPDATE dbp_data.wupcal w
   SET w.wrg_id = m.wrg_id
  FROM dbp_data.mandant_wrg_zu_per m
 WHERE w.mandant_id = m.mandant_id
   AND w.dat between m.dat_von and m.dat_bis
   AND w.wrg_id is null
;

UPDATE  dbp_ods.bon_load_status
   SET  ods_bon_agg_fg=1, 
        td_update = CURRENT_TIMESTAMP
 WHERE (xml_name) IN (SELECT xml_name FROM dbp_etl.bon_agg_kassenberichte_tmp)
;
