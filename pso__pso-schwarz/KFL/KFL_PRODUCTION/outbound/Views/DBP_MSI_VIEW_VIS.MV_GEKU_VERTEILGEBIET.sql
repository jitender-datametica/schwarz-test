CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_verteilgebiet (verteilgebiet_uid, verteilgebiet_bez,
nils_verteilgebiet_id, mandant_id) AS SELECT verteilgebiet_uid,
 verteilgebiet_bez,
 nils_verteilgebiet_id,
 mandant_id
FROM kfl_production_dbp_view.v_geku_verteilgebiet AS V01
WHERE STRPOS(verteilgebiet_bez, 'TIP') <> 0;