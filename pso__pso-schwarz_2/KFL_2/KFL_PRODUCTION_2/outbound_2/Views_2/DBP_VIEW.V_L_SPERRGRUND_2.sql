CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sperrgrund_2 AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 sperrgrund_id
FROM kfl_production_dbp_data.l_sperrgrund_2;