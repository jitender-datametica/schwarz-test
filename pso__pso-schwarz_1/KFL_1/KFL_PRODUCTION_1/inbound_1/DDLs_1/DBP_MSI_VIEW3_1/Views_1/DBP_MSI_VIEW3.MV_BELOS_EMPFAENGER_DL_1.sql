CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_EMPFAENGER_DL_1(
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
	ORT,
	NB_ID
) AS
-- 08.09.2011 Alex Lipkin neu erstellt
-- 30.07.2014 srom, belos_adresse_empfaenger_id auch als belos_adresse_empf_num_id bereitstellen
-- 03.02.2016 srom, Umbenennung um Trennung Belos Beschaffungslogistik (BL) und Distributionslogistik (DL) deutlich zu machen
   SELECT
   a.mandant_id, a.belos_adresse_num_id AS wup_id, a.belos_adresse_id AS belos_adresse_empfaenger_id, 
   a.belos_adresse_num_id AS belos_adresse_empf_num_id, a.belos_adresse_num_id AS belos_adresse_absender_num_id, a.land_id, a.adress_name, 
   a.adress_name_zusatz, a.strasse, a.be_entlade_stelle, a.plz, a.ansprechpartner, a.ort, COALESCE(b.nb_id,-1) AS nb_id

   FROM dbp_view.v_belos_adresse_1 a
   LEFT JOIN dbp_view.v_wup_1 b
   ON a.mandant_id = b.mandant_id
   AND a.belos_adresse_id = CAST(wup_id AS VARCHAR(10))


   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0;