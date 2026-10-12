CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEREICH_ZU_PER
-- AP0021792 WG Refresh arthiertyp_id auf 10 umgestellt / sschuecke 16.04.2018
-- AP0021792 WG Refresh wg_hierarchie_mutter_id wird zu ber_id und wg_hierarchie_ebene_id = 2 / sschuecke 11.11.2018
(ber_id
,mandant_id
,arthiertyp_id
)
AS

   SELECT
   v01.wg_hierarchie_mutter_id AS ber_id,
   v01.mandant_id,
   v01.arthiertyp_id
   FROM dbp_view.v_wg_hierarchie_zu_per v01

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 2
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;