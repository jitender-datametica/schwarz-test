CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_fremdkoerper_fg_2 (fremdkoerper_fg) AS SELECT flag AS
 fremdkoerper_fg
FROM kfl_production_dbp_data.flag_spr_zu_2
GROUP BY fremdkoerper_fg;