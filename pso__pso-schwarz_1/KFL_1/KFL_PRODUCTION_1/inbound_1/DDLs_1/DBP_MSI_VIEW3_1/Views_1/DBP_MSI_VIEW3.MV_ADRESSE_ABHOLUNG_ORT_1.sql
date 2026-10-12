CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ADRESSE_ABHOLUNG_ORT_1

(
land_id
,ort
)
AS
   SELECT land_id, ort
   FROM dbp_view.v_belos_adresse_1
   -- Nur Abholadressen, Speditionsadressen werden aus der View ausgeschlossen.
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort;