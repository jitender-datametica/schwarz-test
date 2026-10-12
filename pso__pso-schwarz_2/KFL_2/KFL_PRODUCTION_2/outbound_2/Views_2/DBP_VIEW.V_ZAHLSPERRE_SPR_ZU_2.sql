CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zahlsperre_spr_zu_2 AS SELECT system_id,
 mandant_id,
 zahlsperre_id,
 spr_id,
 zahlsperre_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.zahlsperre_spr_zu_2;