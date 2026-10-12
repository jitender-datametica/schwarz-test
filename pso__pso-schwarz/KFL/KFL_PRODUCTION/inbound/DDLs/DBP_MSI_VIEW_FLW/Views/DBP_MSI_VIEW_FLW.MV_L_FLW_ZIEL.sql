CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_ZIEL
-- 29.05.2019, pjan1603, SPEC0045510: new lookup table created for "Ziel (PDAO)" attributes
-- 08.07.2019, pjan1603, SPEC0045510: view renamed

(
mandant_id
,flw_ziel_id
)
AS
   SELECT

   v01.mandant_id, v01.flw_ziel_id

   FROM dbp_view.v_flw_l_bew_ziel v01

   --nur Domaene ZFWZIEL, dies ist in der spr_zu hinterlegt
   WHERE EXISTS (
   SELECT 1
   FROM dbp_view.v_flw_bew_ziel_spr_zu v02
   WHERE
   v02.domaene_bez IN ('ZFWZIEL')
   AND v01.mandant_id = v02.mandant_id
   AND v01.flw_ziel_id = v02.flw_ziel_id
   );