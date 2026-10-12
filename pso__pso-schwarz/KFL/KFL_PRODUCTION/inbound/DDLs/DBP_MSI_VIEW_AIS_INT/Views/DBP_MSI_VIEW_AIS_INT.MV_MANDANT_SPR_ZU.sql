CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MANDANT_SPR_ZU
(
 mandant_id
,mandant_kbez
,mandant_bez
,mandant_bez_de
,mandant_bez_cz
,mandant_bez_sk
,mandant_bez_hr
,mandant_bez_pl
,mandant_bez_ro
,mandant_bez_bg
)
AS
SELECT 
v01.mandant_id
,Max(land_id) AS mandant_kbez
,COALESCE(MAX(CASE WHEN v02.mandant_id = 1 THEN v02.land_bez END), 'N/A') AS mandant_bez
,COALESCE(MAX(CASE WHEN v02.mandant_id = 1 THEN v02.land_bez END), 'N/A') AS mandant_bez_de
,COALESCE(MAX(CASE WHEN v02.mandant_id = 2 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_cz
,COALESCE(MAX(CASE WHEN v02.mandant_id = 5 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_sk
,COALESCE(MAX(CASE WHEN v02.mandant_id = 6 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_hr
,COALESCE(MAX(CASE WHEN v02.mandant_id = 3 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_pl
,COALESCE(MAX(CASE WHEN v02.mandant_id = 7 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_ro
,COALESCE(MAX(CASE WHEN v02.mandant_id = 8 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_bg
FROM dbp_data.mandant v01
JOIN dbp_data.land v02
ON CASE WHEN v01.mandant_kbez = 'D' THEN 'DE' ELSE v01.mandant_kbez END = v02.land_id
GROUP BY 
v01.MANDANT_ID;