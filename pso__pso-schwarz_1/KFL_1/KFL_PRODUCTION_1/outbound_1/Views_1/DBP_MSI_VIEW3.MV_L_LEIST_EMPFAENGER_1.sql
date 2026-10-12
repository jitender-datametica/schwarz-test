CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_leist_empfaenger_1 (mandant_id, leist_empfaenger_sap_id,
leist_empfaenger_gruppe_id, wup_id, nb_id, ext_ma_fg) AS SELECT mandant_id,
 leist_empfaenger_sap_id,
 leist_empfaenger_gruppe_id,
 wup_id,
 nb_id,
 ext_ma_fg
FROM kfl_production_dbp_view.v_l_leist_empfaenger_1
UNION DISTINCT
SELECT mandant_id,
 'Eigen' AS leist_empfaenger_sap_id,
 leist_empfaenger_gruppe_id,
 wup_id,
 nb_id,
 MAX(0) AS ext_ma_fg
FROM kfl_production_dbp_view.v_l_leist_empfaenger_1
GROUP BY mandant_id,
 wup_id,
 nb_id,
 leist_empfaenger_gruppe_id;