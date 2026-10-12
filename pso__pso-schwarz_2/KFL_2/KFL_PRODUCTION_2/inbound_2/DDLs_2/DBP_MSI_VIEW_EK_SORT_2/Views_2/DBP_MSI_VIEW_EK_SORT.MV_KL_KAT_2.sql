CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_KL_KAT_2
(
mandant_id
, kl_kat_id
)
AS
   SELECT
   mandant_id, kl_art_kat_id

   FROM

   (
   SELECT v01.mandant_id, v01.wg_hierarchie_id AS kl_art_kat_id
   FROM dbp_view.v_wg_hierarchie_zu_per_2 v01
   WHERE v01.mandant_id > 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
   AND v01.arthiertyp_id = 5
   AND v01.wg_hierarchie_ebene_id = 3

   UNION

   SELECT v02.mandant_id, v02.kl_art_kat_id
   FROM dbp_view.v_kl_art_kat_nielsen_2 v02
   ) t1_2;