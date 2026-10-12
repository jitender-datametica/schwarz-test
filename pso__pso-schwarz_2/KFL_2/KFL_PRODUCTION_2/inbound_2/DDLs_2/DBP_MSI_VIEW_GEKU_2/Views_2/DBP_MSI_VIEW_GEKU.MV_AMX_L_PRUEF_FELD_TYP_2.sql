CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_L_PRUEF_FELD_TYP_2
(
pruef_feld_typ_id
,amx_system_id
,pruef_feld_typ_bez
,pruef_feld_typ_typ_id
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160429 twie: Filter auf Prüfobjekte, Prüfprozesse eigene Lookup
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
pruef_feld_typ_id
,amx_system_id
,pruef_feld_typ_bez
,pruef_feld_typ_typ_id
FROM dbp_view.v_amx_l_pruef_feld_typ_2
WHERE pruef_feld_typ_typ_id = 1;