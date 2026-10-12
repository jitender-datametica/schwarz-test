CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_lager_bewgrund_spr_zu_2 (mandant_id, grund_id, spr_id, grund_bez
, system_id) AS SELECT mandant_id,
 grund_id,
 spr_id,
 MAX(grund_bez) AS grund_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1
GROUP BY mandant_id,
 grund_id,
 spr_id,
 system_id;