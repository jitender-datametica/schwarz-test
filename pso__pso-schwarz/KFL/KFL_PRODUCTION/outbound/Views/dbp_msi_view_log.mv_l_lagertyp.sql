CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagertyp AS SELECT lagernummer_id,
 lagertyp_id,
 lagertyp_typ_id,
 lagerzone_id,
  CASE
  WHEN lagersortiment_id = '5'
  THEN '1'
  ELSE lagersortiment_id
  END AS lagersortiment_id,
 mandant_id,
 nb_id,
 wup_id,
 griffzone_typ_id
FROM kfl_production_dbp_view.v_l_lagertyp AS V01
WHERE LENGTH(TRIM(lagertyp_id)) = 4
 AND wup_id > 0;