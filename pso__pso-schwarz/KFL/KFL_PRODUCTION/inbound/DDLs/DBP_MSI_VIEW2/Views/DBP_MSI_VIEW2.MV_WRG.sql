CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WRG ( wrg_id ,wrg_bez)
AS
   SELECT wrg_id, wrg_bez from dbp_view.v_wrg;