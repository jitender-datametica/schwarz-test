-- 22.07.2019 twie: SPEC0059158 Lookup CRM Fremdkoerper Flag

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_fremdkoerper_fg (fremdkoerper_fg) AS SELECT flag AS
 fremdkoerper_fg
FROM kfl_production_dbp_view.v_flag_spr_zu
GROUP BY fremdkoerper_fg;