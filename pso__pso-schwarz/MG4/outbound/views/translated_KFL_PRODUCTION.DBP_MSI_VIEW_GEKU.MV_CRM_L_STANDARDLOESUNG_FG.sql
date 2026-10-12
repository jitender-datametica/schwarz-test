-- 02.04.2020 lsvi: SPEC0064978 Lookup CRM Standardloesung Flag

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_standardloesung_fg (standardloesung_fg) AS
-- keine Lookup vorhanden
 SELECT flag AS standardloesung_fg
FROM kfl_production_dbp_view.v_flag_spr_zu
GROUP BY standardloesung_fg;