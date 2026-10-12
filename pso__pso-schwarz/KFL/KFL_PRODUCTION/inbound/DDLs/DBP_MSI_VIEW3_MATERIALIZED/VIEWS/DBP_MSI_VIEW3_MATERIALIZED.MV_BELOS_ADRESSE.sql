create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_ADRESSE(
	MANDANT_ID,
	BELOS_ADRESSE_ID,
	BELOS_ADRESSE_NUM_ID,
	LAND_ID,
	ADRESS_NAME,
	ADRESS_NAME_ZUSATZ,
	STRASSE,
	BE_ENTLADE_STELLE,
	PLZ,
	ANSPRECHPARTNER,
	ORT,
	SPEDITION_FG,
	BELOS_STANDORT_TYP_ID
) as
   SELECT
   v1.mandant_id, v1.belos_adresse_id, v1.belos_adresse_num_id, v1.land_id, v1.adress_name, v1.adress_name_zusatz, v1.strasse, v1.be_entlade_stelle, v1.plz, v1.ansprechpartner, v1.ort, v1.spedition_fg, v1.belos_standort_typ_id
   FROM dbp_view.v_belos_adresse v1;