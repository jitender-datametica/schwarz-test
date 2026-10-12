CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_leist_empfaenger_ldap_zu_1 (mandant_id, wup_id, nb_id, ma_ldap,
gp_id, leist_auswerteberechtigt_fg) AS SELECT mandant_id,
 wup_id,
 nb_id,
 ma_ldap,
 gp_id,
 leist_auswerteberechtigt_fg
FROM kfl_production_dbp_security.leist_empfaenger_ldap_zu_1
GROUP BY mandant_id,
 wup_id,
 nb_id,
 ma_ldap,
 gp_id,
 leist_auswerteberechtigt_fg;