CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_berichts_pos_kostart_zu_per_1 AS SELECT mandant_id,
 kostenart_id,
 krk_id,
 dat_von,
 dat_bis,
 ma_ldap,
 berichts_position_invest_id,
 berichts_position_it_id
FROM kfl_production_dbp_msi_data.berichts_pos_kostart_zu_per_1;