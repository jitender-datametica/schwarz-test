CREATE OR REPLACE VIEW kfl_production_dbp_view.v_produktgruppe_spr_zu AS SELECT mandant_id,
 produktgruppe_id,
 spr_id,
 produktgruppe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.produktgruppe_spr_zu;