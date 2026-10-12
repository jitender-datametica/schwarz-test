-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20160429 twie: Filter auf Prüfobjekte, Prüfprozesse eigene Lookup

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_pruef_feld_typ_2 (pruef_feld_typ_id, amx_system_id,
pruef_feld_typ_bez, pruef_feld_typ_typ_id) AS SELECT pruef_feld_typ_id,
 amx_system_id,
 pruef_feld_typ_bez,
 pruef_feld_typ_typ_id
FROM kfl_production_dbp_view.v_amx_l_pruef_feld_typ_2
WHERE pruef_feld_typ_typ_id = 1;