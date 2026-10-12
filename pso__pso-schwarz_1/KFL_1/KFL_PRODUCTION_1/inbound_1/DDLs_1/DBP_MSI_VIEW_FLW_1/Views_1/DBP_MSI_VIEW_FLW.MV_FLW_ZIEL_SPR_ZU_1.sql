CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_ZIEL_SPR_ZU_1
-- 29.05.2019, pjan1603, SPEC0045510: new table created for "Ziel (PDAO)" attribute description form
-- 08.07.2019, pjan1603, SPEC0045510: view renamed

(
mandant_id
,flw_ziel_id
,flw_ziel_bez
)
AS
   SELECT

   v01.mandant_id, v01.flw_ziel_id, v01.flw_ziel_bez

   FROM dbp_view.v_flw_bew_ziel_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON  v01.spr_id = v02.spr_id

   WHERE v01.domaene_bez IN ('ZFWZIEL');