CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ADRESSE_ABHOLUNG_2(
	MANDANT_ID,
	BELOS_ADRESSE_ABHOLUNG_ID,
	LAND_ID,
	ADRESS_NAME,
	ADRESS_NAME_ZUSATZ,
	STRASSE,
	BE_ENTLADE_STELLE,
	PLZ,
	ANSPRECHPARTNER,
	ORT
) AS
--2022-05-23, AP0112140, SPEC0155506, dknop, initial
   SELECT

   mandant_id
  ,belos_adresse_id AS belos_adresse_abholung_id
  ,land_id
  ,adress_name
  ,adress_name_zusatz
  ,strasse
  ,be_entlade_stelle
  ,CAST(plz AS VARCHAR(10)) AS plz
  ,ansprechpartner
  ,ort

   FROM dbp_view.v_belos_adresse_2

   WHERE
   
   spedition_fg = 0;