CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_KONZERN_1
--07.12.2012 SHoger Initial


( mandant_id
,konzern_id
,konzern_name



)
AS
   SELECT
   mandant_id,
   konzern_id,
   konzern_name



   FROM dbp_view.v_in_l_konzern_1  ;