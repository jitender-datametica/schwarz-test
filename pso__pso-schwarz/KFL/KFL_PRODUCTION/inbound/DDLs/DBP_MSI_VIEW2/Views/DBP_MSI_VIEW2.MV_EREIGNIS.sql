CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EREIGNIS (ereignis_id ,ereignistyp_id)
AS
   SELECT ereignis_id, ereignistyp_id from dbp_view.v_ereignis;