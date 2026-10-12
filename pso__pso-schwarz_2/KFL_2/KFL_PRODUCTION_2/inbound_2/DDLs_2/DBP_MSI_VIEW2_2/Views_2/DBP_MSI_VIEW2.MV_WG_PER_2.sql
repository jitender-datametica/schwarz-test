CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WG_PER_2
(
 wg_id
,arthiertyp_id
,lead_mwst_id
,dat_von
,abt_id
,mandant_id
,dat_bis
,owg_id
,werbeteam_cd

)
AS
SELECT

 wg_id
,arthiertyp_id
,lead_mwst_id
,dat_von
,abt_id
,mandant_id
,dat_bis
,owg_id
,werbeteam_cd

FROM dbp_view.v_wg_per_2
WHERE mandant_id = 1
AND arthiertyp_id = 2
AND dat_bis = '9999-12-31';