CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MANDANT_2
--AP0114176/SPEC0139840 Filter auf spr_id = 22 entfernt / ssch1303 26.01.2022
(
 mandant_id
,mandant_kbez
)
AS 
SELECT 
 v01.mandant_id
,v01.mandant_kbez 
FROM dbp_view.v_mandant_2 v01
JOIN dbp_view.v_land_2 v02
ON CASE WHEN v01.mandant_kbez = 'D' THEN 'DE' ELSE v01.mandant_kbez END = v02.land_id
GROUP BY
 v01.mandant_id
,v01.mandant_kbez
;