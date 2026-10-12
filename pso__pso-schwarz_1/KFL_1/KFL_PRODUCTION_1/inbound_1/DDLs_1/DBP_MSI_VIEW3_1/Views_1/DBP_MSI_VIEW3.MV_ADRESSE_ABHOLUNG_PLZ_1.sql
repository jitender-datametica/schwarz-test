CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ADRESSE_ABHOLUNG_PLZ_1
(
land_id
,ort
,plz
)
AS
   SELECT land_id, ort, CAST(plz AS VARCHAR(10)) AS plz
   FROM dbp_view.v_belos_adresse_1
   -- Nur Abholadressen, Speditionsadressen werden aus der View ausgeschlossen.
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort
   ,plz;