CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_audit_2 AS SELECT hyg_audit_id,
 audit_instance_id,
 mandant_id,
 wup_id,
 dat_start,
 dat_ende,
 audit_instance_bez,
 status_string,
 notes,
 gj,
 dat_real
FROM kfl_production_dbp_data.hyg_audit_2;