CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_ruecklastschrift_1 AS SELECT debitor_id,
 mandant_id,
 kjmo,
 dat_beleg,
 beleg_betrag,
 wrg_id
FROM kfl_production_dbp_data.ivs_ruecklastschrift_1;