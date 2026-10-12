CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ART_HERST_ZU_1
(
mandant_id
,art_id
,herst_id
,gp_art_id
,mhd_zeitraum_dz
)
AS
   SELECT
   mandant_id, art_id, herst_id, gp_art_id, mhd_zeitraum_dz

   FROM dbp_view.v_art_gp_zu_per_1

   WHERE mandant_id = 1
   AND dat_bis = '9999-12-31';