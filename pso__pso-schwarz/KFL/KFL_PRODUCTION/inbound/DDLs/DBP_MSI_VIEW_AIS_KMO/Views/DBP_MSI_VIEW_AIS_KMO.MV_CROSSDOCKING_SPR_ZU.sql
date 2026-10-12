CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_CROSSDOCKING_SPR_ZU
(
 mandant_id
,crossdocking_id
,crossdocking_bez
,crossdocking_bez_de
,crossdocking_bez_cz
,crossdocking_bez_sk
,crossdocking_bez_hr
,crossdocking_bez_pl
,crossdocking_bez_ro
,crossdocking_bez_bg
)
AS

SELECT
 v01.Mandant_ID
,v01.crossdocking_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.crossdocking_bez END), 'N/A') AS crossdocking_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.crossdocking_bez END), 'N/A') AS crossdocking_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.crossdocking_bez END), crossdocking_bez_de) AS crossdocking_bez_bg
FROM dbp_data.crossdocking_spr_zu v01

GROUP BY mandant_id,crossdocking_id;