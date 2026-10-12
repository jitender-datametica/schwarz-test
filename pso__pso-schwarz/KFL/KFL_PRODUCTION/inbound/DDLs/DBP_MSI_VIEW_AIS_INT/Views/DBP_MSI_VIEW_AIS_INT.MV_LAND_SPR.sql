CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_LAND_SPR
AS   
SELECT
v1.land_id
,v2.mandant_id
,v1."1" AS land_bez
,COALESCE(v1."1", land_bez) AS land_bez_de
,COALESCE(v1."2", land_bez) AS land_bez_cz
,COALESCE(v1."3", land_bez) AS land_bez_pl
,COALESCE(v1."4", land_bez) AS land_bez_md
,COALESCE(v1."5", land_bez) AS land_bez_sk
,COALESCE(v1."6", land_bez) AS land_bez_hr
,COALESCE(v1."7", land_bez) AS land_bez_ro
,COALESCE(v1."8", land_bez) AS land_bez_bg
FROM (
SELECT  *
FROM dbp_view.v_land
PIVOT (MAX(land_bez) FOR mandant_id IN (1,2,3,4,5,6,7,8))) v1
CROSS JOIN dbp_view.v_mandant v2;