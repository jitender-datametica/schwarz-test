--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.wsoh
(
     MANDT
     ,SART
     ,SKOPF
     ,VTEXT
     ,DATAB
     ,DATUB
     ,LVORM
)
SELECT
     MANDT
     ,SART
     ,SKOPF
     ,VTEXT
     ,DATAB
     ,DATUB
     ,LVORM
FROM DBP_ETL.wsox
WHERE SART = 'H'
GROUP BY 1,2,3,4,5,6,7
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.wsof
(
     MANDT
     ,SART
     ,SKOPF
     ,FILIALE
     ,DATUV
     ,DATUB
     ,LVORM
)
SELECT
     MANDT
     ,SART
     ,SKOPF
     ,FILIALE
     ,DATUV
     ,DATUB
     ,LVORM
FROM DBP_ETL.wsox
WHERE SART = 'F'
GROUP BY 1,2,3,4,5,6,7
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.wsop
(
     MANDT
     ,SART
     ,SKOPF
     ,SPOSI
     ,DATUV
     ,DATUB
     ,LVORM
     ,AKZ
     ,STCKLST
)
SELECT
     MANDT
     ,SART
     ,SKOPF
     ,SPOSI
     ,DATUV
     ,DATUB
     ,LVORM
     ,AKZ
     ,STCKLST
FROM DBP_ETL.wsox
WHERE SART = 'P'
GROUP BY 1,2,3,4,5,6,7,8,9
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.baustein_per
WHERE
(mandant_id
,baustein_id
) IN 
(       SELECT
        man.mandant_id
        ,skopf
        FROM DBP_ETL.wsoh

        INNER JOIN DBP_DATA.mandant AS man
        ON man.mandant_sap_id = wsoh.mandt
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.baustein_wup_zu_per
WHERE
(mandant_id
,baustein_id
) IN 
(
SELECT  man.mandant_id
        ,skopf
FROM DBP_ETL.wsoh

INNER JOIN DBP_DATA.mandant AS man
ON man.mandant_sap_id = wsoh.mandt
WHERE lvorm = 'X'
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.baustein_art_zu_per
WHERE
(mandant_id
,baustein_id
) IN 
(
        SELECT
        man.mandant_id
        ,skopf
        FROM DBP_ETL.wsoh

        INNER JOIN DBP_DATA.mandant AS man
        ON man.mandant_sap_id = wsoh.mandt
        WHERE lvorm = 'X'
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.baustein_per
(
         mandant_id
        ,baustein_id
        ,spr_id
        ,baustein_bez
        ,dat_von
        ,dat_bis
)
SELECT
         man.mandant_id
        ,wsoh.skopf
        ,22
        ,wsoh.vtext
        ,wsoh.datab
        ,wsoh.datub
FROM DBP_ETL.wsoh

INNER JOIN DBP_DATA.mandant AS man
ON man.mandant_sap_id = wsoh.mandt
WHERE lvorm <> 'X'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.wsof
WHERE filiale IN (3142,4112,4132,4182,4202,4252,4372,5400,6420,6912,6914,9002)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_data.baustein_wup_zu_per
WHERE
(  mandant_id
  ,baustein_id
  ,wup_id
  ,nb_id
  ,dat_bis
) IN 
(
SELECT  man.mandant_id
        ,skopf
        ,filiale
        ,wup.nb_id
        ,datub
FROM dbp_load.wsof

INNER JOIN dbp_data.mandant AS man
ON man.mandant_sap_id = wsof.mandt
INNER JOIN dbp_data.wup AS wup
ON wup.mandant_id = man.mandant_id
AND wup.wup_id = wsof.filiale
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_data.baustein_wup_zu_per
(
        mandant_id
        ,baustein_id
        ,wup_id
        ,nb_id
        ,dat_von
        ,dat_bis
)
SELECT
        man.mandant_id
        ,skopf
        ,filiale
        ,wup.nb_id
        ,datuv
        ,datub
FROM dbp_load.wsof

INNER JOIN dbp_data.mandant AS man
ON man.mandant_sap_id = wsof.mandt

INNER JOIN dbp_data.wup AS wup
ON wup.mandant_id = man.mandant_id
AND wup.wup_id = wsof.filiale
WHERE lvorm <>'X'
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_data.baustein_art_zu_per
WHERE
(       mandant_id
        ,baustein_id
        ,art_id
        ,dat_bis
        ,stueckliste_id
) IN 
(SELECT man.mandant_id
        ,skopf
        ,art.art_id
        ,datub
        ,stcklst
 FROM dbp_load.wsop

 INNER JOIN dbp_data.mandant AS man
 ON man.mandant_sap_id = wsop.mandt

 INNER JOIN
 (SELECT kl_art_id, mandant_id, MAX (art_id) art_id
  FROM dbp_data.art
  GROUP BY kl_art_id, mandant_id
 ) AS art
ON art.kl_art_id = wsop.sposi AND
art.mandant_id = man.mandant_id
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_data.baustein_art_zu_per
(        mandant_id
        ,baustein_id
        ,art_id
        ,dat_von
        ,dat_bis
        ,stueckliste_id
        ,akz_id
)
SELECT
        man.mandant_id
        ,skopf
        ,art.art_id
        ,datuv
        ,datub
        ,stcklst
        ,akz
FROM dbp_load.wsop

INNER JOIN dbp_data.mandant AS man
ON man.mandant_sap_id = wsop.mandt

INNER JOIN
        (SELECT kl_art_id, mandant_id, MAX (art_id) art_id
         FROM dbp_data.art
         GROUP BY kl_art_id, mandant_id
        ) AS art
ON art.kl_art_id = wsop.sposi AND
art.mandant_id = man.mandant_id
WHERE lvorm <>'X'
;

