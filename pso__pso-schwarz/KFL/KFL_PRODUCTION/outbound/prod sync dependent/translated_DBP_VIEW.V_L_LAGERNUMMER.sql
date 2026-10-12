CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagernummer (mandant_id, lagernummer_id, wup_id, nb_id, oug_fg,
dummy_tor_id, scu_id, scu_guid, sort_id, ewm_fg, pers_teilbereich_id) AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 oug_fg,
 dummy_tor_id,
 scu_id,
 scu_guid,
 sort_id,
 ewm_fg,
 pers_teilbereich_id
FROM kfl_production_dbp_data.l_lagernummer;