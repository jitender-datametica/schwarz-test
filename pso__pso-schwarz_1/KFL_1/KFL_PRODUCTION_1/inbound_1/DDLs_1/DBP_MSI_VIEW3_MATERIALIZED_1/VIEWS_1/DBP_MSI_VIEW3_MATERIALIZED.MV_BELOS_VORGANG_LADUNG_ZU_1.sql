create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_VORGANG_LADUNG_ZU_1(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	TEILSTRECKE_NR,
	BELOS_ADRESSE_ABSENDER_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	SENDUNG_FG,
	BELOS_LADUNG_ID,
	TEILSTRECKE_ID
) as
   SELECT

   mandant_id, belos_vorgang_id, teilstrecke_nr, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id, teilstrecke_id
   FROM dbp_view.v_belos_teilstrecke_1

   
   WHERE sendung_fg=0;