CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_MAT_KJWO_UPDATE
(
MANDANT_ID,
KJMO,
KJWO_UPDATE,
KJMO_VJ,
KJWO_UPDATE_VJ,
KJWO_UPDATE_BEZ
)
AS
SELECT 
 v01.mandant_id
,v01.kjmo
,v01.kjwo_update
,v01.kjmo -100 AS kjmo_vj
,v02.kjwo_vj AS kjwo_update_vj
,'MAT ' || TRIM(mo_bez) || ' ' || SUBSTR(CAST(v01.kjmo AS CHAR(6)),1,4) || ' / KL data status ' || TO_CHAR(v02.wo_dat_von - 1,'DD.MM.YYYY') AS kjwo_update_bez 

FROM dbp_data.l_kjmo_sort v01
JOIN dbp_data.woche  v02
ON (v01.kjwo_update = v02.kjwo)
JOIN dbp_data.monat_spr_zu v03
ON (CAST(SUBSTR(CAST(v01.kjmo AS CHAR(6)),5,2) AS BYTEINT) = v03.mo_id AND v03.spr_id = 24)
WHERE akt_wo BETWEEN -158 AND 0;