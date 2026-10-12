-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_business_process_2 (business_process_id, amx_system_id,
business_process_bez, pruef_feld_typ_id, in_matrix_pruefgebiete_fg, aktiv_fg) AS SELECT business_process_id,
 amx_system_id,
 business_process_bez,
 pruef_feld_typ_id,
 in_matrix_pruefgebiete_fg,
 aktiv_fg
FROM kfl_production_dbp_view.v_amx_l_business_process_2;