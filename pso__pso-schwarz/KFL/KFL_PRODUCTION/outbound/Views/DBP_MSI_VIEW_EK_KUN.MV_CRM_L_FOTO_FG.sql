CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_foto_fg (foto_fg) AS SELECT flag AS foto_fg
FROM kfl_production_dbp_data.flag_spr_zu
GROUP BY foto_fg;