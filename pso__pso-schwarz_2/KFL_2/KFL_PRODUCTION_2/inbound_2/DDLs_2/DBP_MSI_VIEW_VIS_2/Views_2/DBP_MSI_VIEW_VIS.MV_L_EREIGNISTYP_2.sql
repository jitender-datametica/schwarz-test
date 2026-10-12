CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_EREIGNISTYP_2
(
mandant_id
,ereignistyp_id
)
AS
   SELECT
   v01.mandant_id, v02.ereignistyp_id
   FROM dbp_view.v_mandant_2 v01
   CROSS JOIN dbp_view.v_ereignistyp_2 v02

   UNION

   SELECT
   mandant_id, -1
   FROM dbp_view.v_mandant_2;