CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_PRUEF_FELD_TYP_2
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160429 twie: Filter auf Prüfobjekte, Prüfprozesse eigene Lookup
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
pruef_feld_typ_id
,pruef_feld_typ_bez
,pruef_feld_typ_typ_id
)
AS 
SELECT 
pruef_feld_typ_id
,pruef_feld_typ_bez
,pruef_feld_typ_typ_id
FROM dbp_view.v_amx_l_pruef_feld_typ_2
WHERE pruef_feld_typ_typ_id = 1
AND amx_system_id=1;