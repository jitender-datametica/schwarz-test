CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ABSENDER_DL
-- 08.09.2011 Alex Lipkin neu erstellt
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
,nb_id

)
AS
   SELECT
   a.mandant_id, a.belos_adresse_id AS belos_adresse_absender_id, a.belos_adresse_num_id AS belos_adresse_absender_num_id, a.land_id, a.adress_name, a.adress_name_zusatz, a.strasse, a.be_entlade_stelle, a.plz, a.ansprechpartner, a.ort, COALESCE(b.nb_id,-1) AS nb_id

   FROM dbp_view.v_belos_adresse a
   LEFT JOIN dbp_view.v_wup b
   ON a.mandant_id = b.mandant_id
   AND a.belos_adresse_id = CAST(wup_id AS VARCHAR(10))

   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0;