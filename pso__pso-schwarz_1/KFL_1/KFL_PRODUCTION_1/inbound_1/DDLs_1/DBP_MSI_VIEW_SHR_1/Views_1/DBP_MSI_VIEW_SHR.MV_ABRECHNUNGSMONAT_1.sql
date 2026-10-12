CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ABRECHNUNGSMONAT_1
(
mandant_id
, kjmo_abr
)
AS
   SELECT

   v01.mandant_id, MAX(v01.kjmo) AS kjmo_abr

   FROM dbp_view.v_shr_kennzahlen_1 v01
   WHERE v01.shr_freigabe_fg = 1
   GROUP BY 1;