CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FRAGE_KATALOG_TYP_ZU
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20180625 ttod: SPEC0038139 Schlüssel für Fragekatalog um kmr_quelle_id ergänzg für Zusammenführung Hierarchie
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
amx_frage_katalog_id
,kmr_quelle_id
,frage_typ_id
)
AS 
SELECT 
amx_frage_katalog_id
,1 AS kmr_quelle_id
,frage_typ_id
FROM dbp_view.v_amx_frage_katalog_typ_zu
WHERE amx_system_id=1;