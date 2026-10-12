CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geschaeftsvorfall_spr_zu_1 AS SELECT mandant_id,
 geschaeftsvorfall_id,
 spr_id,
 geschaeftsvorfall_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geschaeftsvorfall_spr_zu_1;