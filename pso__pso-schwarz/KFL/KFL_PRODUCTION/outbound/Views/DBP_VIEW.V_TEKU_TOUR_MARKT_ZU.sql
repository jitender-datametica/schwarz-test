CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_tour_markt_zu AS SELECT teku_tour_wup_zu_id,
 teku_tour_pos_id,
 teku_tour_id,
 mandant_id,
 wup_id,
 teku_checkliste_id,
 aktiv_fg
FROM kfl_production_dbp_data.teku_tour_markt_zu;