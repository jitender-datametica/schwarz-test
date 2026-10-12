CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_GRUND_SPR_ZU_2
-- 29.05.2019, pjan1603, SPEC0045510: new table created for "Grund (PDAO)" attribute description form
-- 10.07.2019, pjan1603, SPEC0045510: view renamed

(
mandant_id
,flw_bew_grund_id
,flw_bew_grund_bez
)
AS
   SELECT

   v01.mandant_id, v01.flw_bew_grund_id, v01.flw_bew_grund_bez

   FROM dbp_view.v_flw_bew_grund_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON  v01.spr_id = v02.spr_id

   WHERE v01.lager_bewart_id IN ('531');