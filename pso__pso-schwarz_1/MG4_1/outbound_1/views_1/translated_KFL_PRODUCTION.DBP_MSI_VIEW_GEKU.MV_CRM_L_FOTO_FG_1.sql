-- 22.07.2019 twie: SPEC0059158 Lookup CRM Foto Flag

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_foto_fg_1 (foto_fg) AS -- keine Lookup vorhanden
 SELECT
 flag AS foto_fg
FROM kfl_production_dbp_view.v_flag_spr_zu_1
GROUP BY foto_fg;