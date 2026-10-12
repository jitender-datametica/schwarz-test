CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_wbs_artikel_vz_share_1 AS SELECT mandant_id,
 art_id,
 aktion_id,
 angebot_id,
 kjwo,
 ausliefergruppe_id,
 gp_id,
 wup_id_vz,
 nb_id_vz,
 mandant_id_vz,
 rank_share,
 share_wert
FROM kfl_production_dbp_data.ts_wbs_artikel_vz_share_1;