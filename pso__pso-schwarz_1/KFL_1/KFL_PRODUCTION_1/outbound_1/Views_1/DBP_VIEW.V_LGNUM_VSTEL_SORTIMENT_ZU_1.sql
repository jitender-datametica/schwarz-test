CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lgnum_vstel_sortiment_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 versandstelle_id,
 lagersortiment_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lgnum_vstel_sortiment_zu_1;