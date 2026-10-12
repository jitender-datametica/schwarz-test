CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_ABSENDER_DL
--14.12.2021, AP0073899, SPEC0091861, dknop, initial
--2023-03-16, dknop, changing to spedition_fg <> 1 instead of spedition_fg = 1
AS
   SELECT
 v01.mandant_id
,v01.belos_adresse_id AS belos_adresse_absender_id
,v01.belos_adresse_num_id AS belos_adresse_absender_num_id
,v01.land_id
,v01.adress_name
,v01.adress_name_zusatz
,v01.strasse
,v01.be_entlade_stelle
,v01.plz
,v01.ansprechpartner
,v01.ort
 FROM dbp_view.v_belos_adresse v01 
    WHERE v01.spedition_fg <> 1;