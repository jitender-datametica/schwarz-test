CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ABSENDER_BL_2
-- 13.05.2013 srom, 589416, belos_adresse_num_id
-- 03.02.2016 srom, Umbenennung um Trennung Belos Beschaffungslogistik (BL) und Distributionslogistik (DL) deutlich zu machen
(
mandant_id
,belos_adresse_absender_id
,belos_adresse_absender_num_id
,land_id
,adress_name
,adress_name_zusatz
,strasse
,be_entlade_stelle
,plz
,ansprechpartner
,ort

)
AS
   SELECT
   mandant_id, belos_adresse_id AS belos_adresse_absender_id, belos_adresse_num_id AS belos_adresse_absender_num_id, land_id, adress_name, adress_name_zusatz, strasse, be_entlade_stelle, plz, ansprechpartner, ort

   FROM dbp_view.v_belos_adresse_2

   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0;