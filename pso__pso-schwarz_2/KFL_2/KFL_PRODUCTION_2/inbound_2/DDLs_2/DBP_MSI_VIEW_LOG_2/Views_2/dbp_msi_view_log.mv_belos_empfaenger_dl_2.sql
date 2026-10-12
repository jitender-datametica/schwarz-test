CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_EMPFAENGER_DL_2(
	MANDANT_ID,
	WUP_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_EMPF_NUM_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	LAND_ID,
	ADRESS_NAME,
	ADRESS_NAME_ZUSATZ,
	STRASSE,
	BE_ENTLADE_STELLE,
	PLZ,
	ANSPRECHPARTNER,
	ORT
) AS
--2023-03-16, dknop, changing to spedition_fg <> 1 instead of spedition_fg = 1


SELECT
 v01.mandant_id
,v01.belos_adresse_num_id AS wup_id
,v01.belos_adresse_id AS belos_adresse_empfaenger_id
,v01.belos_adresse_num_id AS belos_adresse_empf_num_id
,v01.belos_adresse_num_id AS belos_adresse_absender_num_id
,v01.land_id
,v01.adress_name
,v01.adress_name_zusatz
,v01.strasse
,v01.be_entlade_stelle
,v01.plz
,v01.ansprechpartner
,v01.ort

FROM dbp_view.v_belos_adresse_2 v01
   
   WHERE v01.spedition_fg <> 1;