CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_teku_checkliste_1 AS SELECT teku_checkliste_id,
 mandant_id,
 frische_fg,
 teku_checkliste_bez
FROM kfl_production_dbp_data.l_teku_checkliste_1;