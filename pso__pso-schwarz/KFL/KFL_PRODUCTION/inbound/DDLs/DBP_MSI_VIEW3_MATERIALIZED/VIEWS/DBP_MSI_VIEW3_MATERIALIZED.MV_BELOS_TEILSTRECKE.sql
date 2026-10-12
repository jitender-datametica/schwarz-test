create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_TEILSTRECKE(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	BELOS_LEISTUNGSART_ID,
	BELOS_ADRESSE_ABSENDER_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	SENDUNG_FG,
	BELOS_LADUNG_ID,
	TEILSTRECKE_ID,
	ANZ_STELLPLATZ,
	STELLPLATZ_MENGE_EINH_ID
) as

   SELECT

   mandant_id, belos_vorgang_id, teilstrecke_nr          AS belos_leistungsart_id, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id, teilstrecke_id, anz_stellplatz, stellplatz_menge_einh_id

   FROM dbp_view.v_belos_teilstrecke

   
   WHERE sendung_fg = 1

   AND
   
   belosart_fg = 0;