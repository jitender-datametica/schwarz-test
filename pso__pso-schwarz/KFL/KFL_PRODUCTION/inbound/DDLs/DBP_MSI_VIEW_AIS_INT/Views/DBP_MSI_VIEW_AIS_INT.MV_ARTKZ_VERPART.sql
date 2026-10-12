CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_VERPART
(
mandant_id
, verpart_id
, verpart_bez
, verpart_bez_de
, verpart_bez_cz
, verpart_bez_sk
, verpart_bez_hr
, verpart_bez_pl
, verpart_bez_ro
, verpart_bez_bg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, v01.verpart_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.verpart_bez END),'N/A') AS verpart_bez                                                          -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.verpart_bez END),'N/A') AS verpart_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.verpart_bez END), verpart_bez_de) AS verpart_bez_bg  -- BG
   FROM dbp_view.v_artkz_verpart v01
   GROUP BY 1,2;