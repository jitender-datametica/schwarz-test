CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_SM_VW_ZU_1
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
(
art_id
,vw_id
,sm_id
,mandant_id
)
AS
   SELECT
   v01.art_id, v01.vw_id, v01.sm_id, v01.mandant_id
   FROM dbp_view.v_art_sm_vw_zu_per_1 v01
   WHERE
   v01.dat_bis = '9999-12-31'
   -- AND v01.mandant_id <> 1
   AND v01.vw_id = 10;