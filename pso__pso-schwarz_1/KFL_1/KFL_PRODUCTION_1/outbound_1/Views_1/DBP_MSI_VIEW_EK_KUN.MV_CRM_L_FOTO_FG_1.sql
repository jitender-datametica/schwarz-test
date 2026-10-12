CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_foto_fg_1 (foto_fg) AS SELECT flag AS foto_fg
FROM kfl_production_dbp_data.flag_spr_zu_1
GROUP BY foto_fg;