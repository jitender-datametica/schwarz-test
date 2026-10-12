CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_EMPFAENGER_BL_2
(
	MANDANT_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	LAND_ID,
	ADRESS_NAME,
	ADRESS_NAME_ZUSATZ,
	STRASSE,
	BE_ENTLADE_STELLE,
	PLZ,
	ANSPRECHPARTNER,
	ORT
) AS
-- 03.02.2016 srom, Umbenennung um Trennung Belos Beschaffungslogistik (BL) und Distributionslogistik (DL) deutlich zu machen

   SELECT
   v01.mandant_id, 
   belos_adresse_id AS belos_adresse_empfaenger_id, 
   v01.land_id, 
   v01.adress_name, 
   v01.adress_name_zusatz, 
   v01.strasse, 
   v01.be_entlade_stelle, 
   v01.plz, 
   v01.ansprechpartner, 
   v01.ort

   FROM dbp_view.v_belos_adresse_2 v01
 
   
   WHERE spedition_fg = 0;