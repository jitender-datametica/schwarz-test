CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ADRESSE_ABHOLUNG_1
(

mandant_id
,belos_adresse_abholung_id
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

   mandant_id, belos_adresse_id AS belos_adresse_abholung_id, land_id, adress_name, adress_name_zusatz, strasse, be_entlade_stelle, CAST(plz AS VARCHAR(10)) AS plz, ansprechpartner, ort

   FROM dbp_view.v_belos_adresse_1

   WHERE
   -- Nur Abholadressen, Speditionsadressen werden aus der View ausgeschlossen.
   spedition_fg = 0;