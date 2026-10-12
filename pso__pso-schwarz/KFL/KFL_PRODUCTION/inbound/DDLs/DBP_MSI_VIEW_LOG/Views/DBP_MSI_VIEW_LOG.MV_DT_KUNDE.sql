CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_LOG.MV_DT_KUNDE(
	KUNDE_ID,
	AKTUELL_WUP_ID,
	IS_AKT_WUP_ID_FG,
	MANDANT_ID_KUNDE,
	NB_ID,
	KUNDE_BEZ,
	DAT_VON,
	DAT_BIS,
	WUP_TYP_ID
) 
TARGET_LAG = '30 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG 
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG 
AS
--2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id, is_akt_wup_id_fg
--2025-04-01, nwag, adding B2B + move to DT
SELECT	
wup_id AS kunde_id,	
aktuell_wup_id,
CASE WHEN aktuell_wup_id = v01.wup_id THEN 1 ELSE 0 END AS is_akt_wup_id_fg,
v01.mandant_id AS mandant_id_kunde,	
v01.nb_id AS nb_id,	
CASE	
WHEN v01.nb_id = -1 THEN '---'	
ELSE v01.wup_standort END AS kunde_bez,	
v01.dat_von AS dat_von,	
v01.dat_bis AS dat_bis,	
v01.wup_typ_id AS wup_typ_id	
FROM dbp_view.v_wup v01	
WHERE ((v01.nb_id IN (2, 0, -111) AND v01.wup_id > 0)	
   OR (v01.nb_id = -1 AND v01.wup_id = 0) )

UNION

SELECT  kunde_id, 
kunde_id AS aktuell_wup_id,
1 AS IS_AKT_WUP_ID_FG,
MANDANT_ID_KUNDE,
NB_ID,
'B2B' AS KUNDE_BEZ,
MIN(DAT_LIEF_SOLL) AS DAT_VON,
DATE'9999-12-31' AS DAT_BIS,
2 AS WUP_TYP_ID
FROM dbp_Data.besch_lief_wa_hu_sum 
WHERE kunde_id > 10000 AND mandant_id=8
GROUP BY 1,2,3,4,5,6,9
;