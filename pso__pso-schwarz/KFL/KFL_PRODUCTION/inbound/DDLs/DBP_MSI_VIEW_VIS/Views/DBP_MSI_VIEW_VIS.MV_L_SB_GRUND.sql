CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_GRUND
(
sb_grund_id
,mandant_id
)
AS
   SELECT
   sb_grund_id, mandant_id
   FROM dbp_view.v_l_sb_grund  v01;