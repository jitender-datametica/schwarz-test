CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_ts_sortiment_preisklasse_uwg_1 (mandant_id, arthiertyp_id,
kl_owg_id, kl_uwg_id, wrg_id, preislage_1, preislage_2, preislage_3, preislage_4, preislage_5, preislage_6, preislage_7
, preislage_8, preislage_9, preislage_10) AS SELECT mandant_id,
 arthiertyp_id,
 wg_id AS kl_owg_id,
 wug_id AS kl_uwg_id,
 wrg_id,
 preislage_1,
 preislage_2,
 preislage_3,
 preislage_4,
 preislage_5,
 preislage_6,
 preislage_7,
 preislage_8,
 preislage_9,
 preislage_10
FROM kfl_production_dbp_view.v_ts_sortiment_preisklasse_wug_1;