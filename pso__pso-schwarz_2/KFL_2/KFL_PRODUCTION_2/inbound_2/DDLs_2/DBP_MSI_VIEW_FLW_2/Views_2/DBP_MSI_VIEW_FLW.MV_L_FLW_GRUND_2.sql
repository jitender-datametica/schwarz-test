CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_GRUND_2
-- 29.05.2019, pjan1603, SPEC0045510: new lookup table created for "Grund (PDAO)" attribute
-- 10.07.2019, pjan1603, SPEC0045510: view renamed

(
mandant_id
,flw_bew_grund_id
)
AS
   SELECT

   v01.mandant_id, v01.flw_bew_grund_id

   FROM dbp_view.v_flw_l_bew_grund_2 v01

   --nur Lagerbew.art_2 531, dies ist in der spr_zu hinterlegt
   WHERE EXISTS (
   SELECT 1
   FROM dbp_view.v_flw_bew_grund_spr_zu_2 v02
   WHERE
   v02.lager_bewart_id IN ('531')
   AND v01.mandant_id = v02.mandant_id
   AND v01.flw_bew_grund_id = v02.flw_bew_grund_id
   );