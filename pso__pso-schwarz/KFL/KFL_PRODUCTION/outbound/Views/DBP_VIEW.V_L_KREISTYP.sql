CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kreistyp AS SELECT mandant_id,
 kreistyp_id,
 vz_prio_id
FROM kfl_production_dbp_data.l_kreistyp;