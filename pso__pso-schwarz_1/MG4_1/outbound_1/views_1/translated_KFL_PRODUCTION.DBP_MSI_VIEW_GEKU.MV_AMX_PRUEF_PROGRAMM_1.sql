-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20160322 KKaiser, neu für AP0002158 Audimex

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_pruef_programm_1 (pruef_programm_id, amx_system_id,
pruef_programm_bez, zustand_id, kapitel_typ_id, pruef_programm_mutter_id) AS SELECT pruef_programm_id,
 amx_system_id,
 pruef_programm_bez,
 zustand_id,
 kapitel_typ_id,
 pruef_programm_mutter_id
FROM kfl_production_dbp_view.v_amx_pruef_programm_1;