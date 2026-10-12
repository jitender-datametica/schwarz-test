CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ADRESSE
-- 13.05.2013 srom, 589416, belos_adresse_num_id
(
mandant_id
,belos_adresse_id
,belos_adresse_num_id
,land_id
,adress_name
,adress_name_zusatz
,strasse
,be_entlade_stelle
,plz
,ansprechpartner
,ort
,spedition_fg
,belos_standort_typ_id
)
AS
   SELECT
   v1.mandant_id, v1.belos_adresse_id, v1.belos_adresse_num_id, v1.land_id, v1.adress_name, v1.adress_name_zusatz, v1.strasse, v1.be_entlade_stelle, v1.plz, v1.ansprechpartner, v1.ort, v1.spedition_fg, v1.belos_standort_typ_id
   FROM dbp_view.v_belos_adresse v1
;