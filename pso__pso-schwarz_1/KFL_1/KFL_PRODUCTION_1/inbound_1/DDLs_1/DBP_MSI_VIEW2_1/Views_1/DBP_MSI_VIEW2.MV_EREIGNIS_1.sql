CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EREIGNIS_1 (ereignis_id ,ereignistyp_id)
AS
   SELECT ereignis_id, ereignistyp_id from dbp_view.v_ereignis_1;