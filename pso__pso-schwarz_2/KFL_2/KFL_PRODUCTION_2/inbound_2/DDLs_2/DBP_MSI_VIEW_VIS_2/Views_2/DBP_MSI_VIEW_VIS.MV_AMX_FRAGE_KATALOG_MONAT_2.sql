CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FRAGE_KATALOG_MONAT_2
-- 23.03.2017 twie alle Kombinationen Fragekatalog - Monat_2 für 360 Grad Bericht
-- 20180625 ttod SPEC0038139 Schlüssel für Fragekatalog um kmr_quelle_id ergänzg für Zusammenführung Hierarchie
-- 20200416 lsvi SPEC0073867 OneAudimex filter amx_system_id=1
(
amx_frage_katalog_id
,kmr_quelle_id
,kjmo
,wert
)
AS 
SELECT 
v01.amx_frage_katalog_id
,1 AS kmr_quelle_id
,v02.kjmo
,1 AS wert
FROM dbp_view.v_amx_frage_katalog_2 v01
CROSS JOIN dbp_view.v_monat_2 v02
WHERE v02.akt_gj BETWEEN -1 AND 0
AND v01.amx_system_id=1;