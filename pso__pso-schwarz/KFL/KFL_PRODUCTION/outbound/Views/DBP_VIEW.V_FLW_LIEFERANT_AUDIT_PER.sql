CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lieferant_audit_per AS SELECT dat_von,
 flw_lief_id,
 mandant_id,
 dat_bis,
 audit_qzahl,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_lieferant_audit_per;