CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_OUG_ID_SPR_ZU(
	OUG_ID,
	OUG_ID_BEZ,
	OUG_ID_BEZ_DE,
	OUG_ID_BEZ_CZ,
	OUG_ID_BEZ_SK,
	OUG_ID_BEZ_HR,
	OUG_ID_BEZ_PL,
	OUG_ID_BEZ_RO,
	OUG_ID_BEZ_BG
) AS

/* SPRACHEN : Kennzeichen Obst und Gemuese Artikel
   2022-07-26 ssch0611 : added entry 0 (nicht gepflegt) via union
*/

SELECT 
  $1 AS oug_id
, $2 AS oug_id_bez
, $3 AS oug_id_bez_de
, $4 AS oug_id_bez_cz
, $5 AS oug_id_bez_sk
, $6 AS oug_id_bez_hr
, $7 AS oug_id_bez_pl
, $8 AS oug_id_bez_ro
, $9 AS oug_id_bez_bg
FROM (
  SELECT 
    oug_id
  , MAX(CASE WHEN spr_id =  22 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id =  22 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id = 124 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id = 108 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id =  65 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id =  90 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id =  95 THEN oug_id_bez ELSE NULL END)
  , MAX(CASE WHEN spr_id =  18 THEN oug_id_bez ELSE NULL END)
  FROM dbp_view.v_oug_id_spr_zu
  WHERE oug_id > 0
  GROUP BY oug_id
  
  UNION ALL
  SELECT 
    0
  ,'nicht gepflegt'
  ,'nicht gepflegt'
  ,'žádné specifikace'
  ,'žiadne špecifikácie'
  ,'nema specifikacija'
  ,'bez specyfikacji'
  ,'fara precizare'
  ,'без спецификация'
  FROM TABLE(GENERATOR(ROWCOUNT => 1))
) sub00;