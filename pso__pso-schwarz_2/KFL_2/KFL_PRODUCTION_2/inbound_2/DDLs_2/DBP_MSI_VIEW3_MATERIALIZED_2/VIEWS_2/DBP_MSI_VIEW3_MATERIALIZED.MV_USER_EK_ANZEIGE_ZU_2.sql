create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_USER_EK_ANZEIGE_ZU_2(
	USER_ID,
	EK_ANZEIGE_FG
) as
   SELECT
   user_id, ek_anzeige_fg
   FROM dbp_security.user_ek_anzeige_zu_2;