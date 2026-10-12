CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MONAT_VORMONAT_TRN_1
(
kjmo,
gjmo,
gjmo_vmo,
gjmo_vvmo,
gjmo_vvvmo,
gjmo_vvvvmo,
kjmo_vmo,
kjmo_vvmo,
kjmo_vvvmo,
kjmo_vvvvmo
)
AS
   SELECT
   kjmo
   , gjmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 1 PRECEDING) AS gjmo_vmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 2 PRECEDING) AS gjmo_vvmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 3 PRECEDING) AS gjmo_vvvmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 4 PRECEDING) AS gjmo_vvvvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 1 PRECEDING) AS kjmo_vmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 2 PRECEDING) AS kjmo_vvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 3 PRECEDING) AS kjmo_vvvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 4 PRECEDING) AS kjmo_vvvvmo
   FROM dbp_view.v_monat_1
   WHERE kjmo>=200201;