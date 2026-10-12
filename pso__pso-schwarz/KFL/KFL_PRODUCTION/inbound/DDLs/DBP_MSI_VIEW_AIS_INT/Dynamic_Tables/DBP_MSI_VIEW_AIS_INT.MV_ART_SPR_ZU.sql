CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_SPR_ZU
(
mandant_id
, art_id
, kl_art_id
, art_bez
, art_bez_de
, art_bez_cz
, art_bez_sk
, art_bez_hr
, art_bez_pl
, art_bez_ro
, art_bez_bg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, v01.art_id, v02.kl_art_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.art_bez END), art_bez_de) AS art_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.art_bez END), art_bez_de) AS art_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.art_bez END), art_bez_de) AS art_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.art_bez END), art_bez_de) AS art_bez_bg  -- BG


   FROM dbp_view.v_art_spr_zu v01

   JOIN dbp_view.v_art v02
   ON (v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id)
   GROUP BY 1,2,3;