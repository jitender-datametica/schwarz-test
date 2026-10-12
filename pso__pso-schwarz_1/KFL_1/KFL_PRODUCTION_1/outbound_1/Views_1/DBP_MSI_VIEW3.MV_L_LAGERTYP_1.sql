CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lagertyp_1 (lagernummer_id, lagertyp_id, lagertyp_typ_id,
lagerzone_id, mandant_id, nb_id, wup_id, griffzone_typ_id) AS SELECT lagernummer_id,
 lagertyp_id,
 lagertyp_typ_id,
 lagerzone_id,
 mandant_id,
 nb_id,
 wup_id,
 griffzone_typ_id
FROM kfl_production_dbp_view.v_l_lagertyp_1;