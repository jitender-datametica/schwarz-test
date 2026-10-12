CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EREIGNIS
(
ereignis_id,
ereignistyp_id,
default_offen
)
AS
   SELECT
   ereignis_id,
   ereignistyp_id,
   default_offen
   from dbp_view.v_ereignis;