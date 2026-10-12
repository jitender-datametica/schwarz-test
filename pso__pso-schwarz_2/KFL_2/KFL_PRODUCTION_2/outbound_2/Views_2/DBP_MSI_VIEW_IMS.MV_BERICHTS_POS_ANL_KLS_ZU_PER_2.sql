CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_berichts_pos_anl_kls_zu_per_2 AS SELECT mandant_id,
 anlage_klasse_id,
 dat_von,
 dat_bis,
 ma_ldap,
 berichts_position_invest_id,
 berichts_position_it_id
FROM kfl_production_dbp_msi_v_view.v_berichts_pos_anl_kls_zu_per_2;