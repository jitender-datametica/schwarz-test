CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagertyp_spr_zu_2 AS SELECT lagernummer_id,
 wup_id,
 nb_id,
 mandant_id,
 lagertyp_id,
 spr_id,
 lagersortiment_id,
 lagertyp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagertyp_spr_zu_2;