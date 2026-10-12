CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_ts_sortiment_preisklasse_wug_1 AS SELECT V01.mandant_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.wug_id,
 V01.wrg_id,
 V01.preislage_1,
 V01.preislage_2,
 V01.preislage_3,
 V01.preislage_4,
 V01.preislage_5,
 V01.preislage_6,
 V01.preislage_7,
 V01.preislage_8,
 V01.preislage_9,
 V01.preislage_10
FROM kfl_production_dbp_view.v_ts_sortiment_preisklasse_wug_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wrg_id = V02.default_wrg;