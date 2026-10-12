CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagertyp_2 AS SELECT lagernummer_id,
 wup_id,
 nb_id,
 mandant_id,
 lagertyp_id,
 lagerzone_id,
 lagertyp_typ_id,
 griffzone_typ_id,
 lagersortiment_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagertyp_2;