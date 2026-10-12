CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_EREIGNIS
(
ereignis_id
,ereignistyp_id
,mandant_id
)
AS
   SELECT
   v01.ereignis_id, v01.ereignistyp_id, v01.mandant_id
   FROM dbp_view.v_ereignis v01

   UNION

   SELECT
   -1, 100, mandant_id
   FROM dbp_view.v_mandant

   UNION

   SELECT
   -1, 101, mandant_id
   FROM dbp_view.v_mandant;