create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_GP_1(
	GP_ID,
	MANDANT_ID,
	DAT_VON,
	AGB_ID,
	DAT_BIS,
	ISO_ID,
	EIGENVERPACKUNG_ID,
	EIGENMARKE,
	AUDIT,
	AUDIT_DAT,
	ANLIEFERUNG,
	GP_NAME,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HGP_ID,
	ZEK_ID,
	LIEFERZEIT,
	ZAHLUNGSZIEL_ID,
	AMPEL_FLG,
	EINKAUFSORGANISATION_ID,
	MIN_PAL_FAKTOR_LKW,
	GLN_BBNR,
	GLN_BSNR,
	GLN_BUBKZ
) as
   SELECT
   gp_id, mandant_id, dat_von, agb_id, dat_bis, iso_id, eigenverpackung_id, eigenmarke_id, audit_id, audit_dat, anlieferung_id, gp_name, gp_strasse, gp_plz, gp_ort, land_id, CASE WHEN COALESCE(hgp_id , -1) = -1 THEN gp_id ELSE  hgp_id END AS hgp_id, zek_id, lieferzeit, zahlungsziel_id, 1, einkaufsorganisation_id, min_pal_faktor_lkw, gln_bbnr, gln_bsnr, gln_bubkz

   FROM dbp_view.v_gp_1;