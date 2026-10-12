-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_frage_kat_pruef_progr_zu (frage_kat_pruef_progr_zu_id,
amx_system_id, pruef_programm_id, amx_frage_katalog_id) AS SELECT frage_kat_pruef_progr_zu_id,
 amx_system_id,
 pruef_programm_id,
 amx_frage_katalog_id
FROM kfl_production_dbp_view.v_amx_frage_kat_pruef_progr_zu;