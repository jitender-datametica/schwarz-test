CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_VERSION
(
mandant_id
,gj_plan
,version_id
,datzeit_upload
,dat_planwerte_ist_ab
)
AS
   SELECT
   mandant_id, gj_plan, version_id, datzeit_upload, dat_planwerte_ist_ab
   FROM dbp_view.v_coi_ump_version;