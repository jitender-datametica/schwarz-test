CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_DIENSTLEISTER_SPR_ZU(
	   DIENSTLEISTER_ID
    ,DIENSTLEISTER_BEZ
    ,DIENSTLEISTER_BEZ_CZ
    ,DIENSTLEISTER_BEZ_PL
    ,DIENSTLEISTER_BEZ_SK
    ,DIENSTLEISTER_BEZ_HR
    ,DIENSTLEISTER_BEZ_RO
    ,DIENSTLEISTER_BEZ_BG
) AS 
/* 
   LOOKUP: Dienstleister
   2023-07-05 muellerpatri : Setup AP0172061 
*/ 
SELECT  
  dl.dienstleister_id
, MAX(CASE WHEN spr_id =  22 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez   --standard=deutsch
, MAX(CASE WHEN spr_id = 124 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_cz
, MAX(CASE WHEN spr_id =  90 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_pl
, MAX(CASE WHEN spr_id = 108 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_sk
, MAX(CASE WHEN spr_id =  65 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_hr
, MAX(CASE WHEN spr_id =  95 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_ro
, MAX(CASE WHEN spr_id =  18 THEN dienstleister_bez ELSE NULL END)  AS dienstleister_bez_bg
FROM dbp_data.dienstleister_spr_zu dl
GROUP BY  dl.dienstleister_id
;