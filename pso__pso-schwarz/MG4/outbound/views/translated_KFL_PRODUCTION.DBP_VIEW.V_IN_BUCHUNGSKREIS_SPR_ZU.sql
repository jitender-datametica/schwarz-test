CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_buchungskreis_spr_zu (buchungskreis_id, mandant_id, spr_id,
buchungskreis_bez, td_update, td_insert) AS SELECT buchungskreis_id,
 mandant_id,
 spr_id,
 buchungskreis_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_buchungskreis_spr_zu;