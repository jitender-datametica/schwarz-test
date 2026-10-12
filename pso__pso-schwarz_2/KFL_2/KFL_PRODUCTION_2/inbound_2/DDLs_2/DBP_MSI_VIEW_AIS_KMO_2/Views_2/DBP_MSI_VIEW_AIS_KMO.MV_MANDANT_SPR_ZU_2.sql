CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MANDANT_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
--Aufnahme Feld kbez, um Vervielfachung zu beheben / ssch1303 01.03.2022
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
,MAX (land_id) AS mandant_kbez 
,COALESCE(MAX(CASE WHEN v02.mandant_id = 1 THEN v02.land_bez END), 'N/A') AS mandant_bez
,COALESCE(MAX(CASE WHEN v02.mandant_id = 1 THEN v02.land_bez END), 'N/A') AS mandant_bez_de
,COALESCE(MAX(CASE WHEN v02.mandant_id = 2 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_cz
,COALESCE(MAX(CASE WHEN v02.mandant_id = 5 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_sk
,COALESCE(MAX(CASE WHEN v02.mandant_id = 6 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_hr
,COALESCE(MAX(CASE WHEN v02.mandant_id = 3 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_pl
,COALESCE(MAX(CASE WHEN v02.mandant_id = 7 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_ro
,COALESCE(MAX(CASE WHEN v02.mandant_id = 8 THEN v02.land_bez END), mandant_bez_de) AS mandant_bez_bg

FROM dbp_data.mandant_2 v01

JOIN dbp_data.land_2 v02
ON CASE WHEN v01.mandant_kbez = 'D' THEN 'DE' ELSE v01.mandant_kbez END = v02.land_id

WHERE v01.mandant_id <> 1

GROUP BY 
v01.MANDANT_ID;