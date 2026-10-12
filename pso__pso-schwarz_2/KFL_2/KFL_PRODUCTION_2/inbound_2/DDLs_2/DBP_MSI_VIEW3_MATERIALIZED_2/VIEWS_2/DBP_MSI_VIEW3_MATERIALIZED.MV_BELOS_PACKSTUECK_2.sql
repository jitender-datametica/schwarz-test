create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_PACKSTUECK_2(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	PACKSTUECK_GEBINDE_EINH_ID,
	PACKSTUECK_GEBINDEART_ID,
	GEBINDE_ANZ,
	BRUTTOGEW_AVISIERT,
	SENDUNG_FG,
	NETTOGEW_AVISIERT
) as
   SELECT

   mandant_id, belos_vorgang_id, packstueck_gebinde_einh_id, packstueck_gebindeart_id, CASE WHEN sendung_fg = 1 THEN  gebinde_anz   ELSE NULL END AS  gebinde_anz, bruttogew_avisiert, sendung_fg, nettogew_avisiert

   FROM dbp_view.v_belos_packstueck_2
   WHERE

   -- Eingeschränkt auf die Daten der Beschaffungslogistik
   belosart_fg = 0;