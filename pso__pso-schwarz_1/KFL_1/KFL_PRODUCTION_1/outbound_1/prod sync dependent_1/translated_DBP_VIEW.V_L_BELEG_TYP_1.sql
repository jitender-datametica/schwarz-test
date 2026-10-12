CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_beleg_typ_1 (system_id, mandant_id, beleg_typ_id) AS SELECT system_id,
 mandant_id,
 beleg_typ_id
FROM kfl_production_dbp_data.l_beleg_typ_1;