CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sperrgrund_spr_zu AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 spr_id,
 sperrgrund_id,
 sperrgrund_bez
FROM kfl_production_dbp_data.sperrgrund_spr_zu;