CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_FRAGE_KATALOG_TYP_ZU_1
(
amx_frage_katalog_id
,amx_system_id
,kmr_quelle_id
,frage_typ_id
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20180607 twie: SPEC0038139 Schlüssel für Fragekatalog um kmr_quelle_id ergänzg für Zusammenführung Hierarchie
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
amx_frage_katalog_id
,amx_system_id
,1 AS kmr_quelle_id
,frage_typ_id
FROM dbp_view.v_amx_frage_katalog_typ_zu_1;