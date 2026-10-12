CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEREICH_SPR_ZU_1
-- AP0021792 WG Refresh arthiertyp_id auf 10 umgestellt / sschuecke 16.04.2018
(ber_id
,ber_bez
,mandant_id
,arthiertyp_id
,spr_id
)
AS

   SELECT
   v01.wg_hierarchie_id AS ber_id,
   v02.wg_hierarchie_bez AS ber_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v02.spr_id
   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
   INNER JOIN dbp_view.v_wg_hierarchie_spr_zu_1 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
   AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
   AND v02.arthiertyp_id = v01.arthiertyp_id
   AND v02.spr_id = 22

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;