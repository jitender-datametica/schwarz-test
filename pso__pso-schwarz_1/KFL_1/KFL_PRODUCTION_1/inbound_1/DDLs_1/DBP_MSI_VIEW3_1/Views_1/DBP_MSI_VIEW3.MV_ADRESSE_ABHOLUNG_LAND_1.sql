CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ADRESSE_ABHOLUNG_LAND_1
(
land_id
)
AS
   SELECT land_id
   FROM dbp_view.v_belos_adresse_1
   -- Nur Abholadressen, Speditionsadressen werden aus der View ausgeschlossen.
   WHERE spedition_fg = 0
   GROUP BY land_id;