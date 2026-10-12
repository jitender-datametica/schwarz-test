create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LEIST_EMPFAENGER_LDAP_ZU_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	MA_LDAP,
	GP_ID,
	LEIST_AUSWERTEBERECHTIGT_FG
) as
   SELECT
   mandant_id, wup_id, nb_id, ma_ldap, gp_id, leist_auswerteberechtigt_fg
   FROM dbp_security.leist_empfaenger_ldap_zu_2
   GROUP BY mandant_id
   ,wup_id
   ,nb_id
   ,ma_ldap
   ,gp_id
   ,leist_auswerteberechtigt_fg;