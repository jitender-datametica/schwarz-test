CREATE OR REPLACE VIEW kfl_production_dbp_view.v_versandstelle_spr_zu_2 AS SELECT mandant_id,
 versandstelle_id,
 spr_id,
 versandstelle_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.versandstelle_spr_zu_2;