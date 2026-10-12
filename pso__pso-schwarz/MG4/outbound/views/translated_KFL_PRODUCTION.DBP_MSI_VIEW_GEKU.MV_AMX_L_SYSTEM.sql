-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id, dies ist die Lookup

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_amx_l_system (amx_system_id, amx_system_bez) AS SELECT amx_system_id,
 amx_system_bez
FROM kfl_production_dbp_view.v_amx_l_system;