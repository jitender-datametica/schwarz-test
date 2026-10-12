CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ADRESSE_ABHOLUNG_PLZ
(
land_id
,ort
,plz
)
AS
   SELECT land_id, ort, CAST(plz AS VARCHAR(10)) AS plz
   FROM dbp_view.v_belos_adresse
   -- Nur Abholadressen, Speditionsadressen werden aus der View ausgeschlossen.
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort
   ,plz;