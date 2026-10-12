CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zeitfenster_spr_zu AS SELECT mandant_id,
 zeitfenster_id,
 spr_id,
 zeitfenster_bez
FROM kfl_production_dbp_data.zeitfenster_spr_zu;