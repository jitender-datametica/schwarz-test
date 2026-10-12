create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_GP(
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
	REGION_ID,
	SAP_REGION_ID,
	HGP_ID,
	ZEK_ID,
	LIEFERZEIT,
	ZAHLUNGSZIEL,
	AMPEL_FLG,
	GLN_BBNR,
	GLN_BSNR,
	GLN_BUBKZ,
	ILN_ID
) as
   SELECT
   v01.gp_id, v01.mandant_id, v01.dat_von, v01.agb_id, v01.dat_bis, v01.iso_id, v01.eigenverpackung_id, v01.eigenmarke_id, v01.audit_id, v01.audit_dat, v01.anlieferung_id, v01.gp_name, v01.gp_strasse, v01.gp_plz, v01.gp_ort, v01.land_id, v01.region_id, v02.sap_region_id, v01.hgp_id, v01.zek_id, v01.lieferzeit, v01.zahlungsziel_id, 1, v01.gln_bbnr, v01.gln_bsnr, v01.gln_bubkz, NULL AS iln_id

   FROM dbp_view.v_gp v01, dbp_view.v_region v02

   WHERE v01.mandant_id = 1
   AND v01.mandant_id = v02.mandant_id
   AND v01.land_id = v02.land_id
   AND v01.region_id = v02.region_id
   AND v01.gp_id NOT BETWEEN 10000 AND 999999
;