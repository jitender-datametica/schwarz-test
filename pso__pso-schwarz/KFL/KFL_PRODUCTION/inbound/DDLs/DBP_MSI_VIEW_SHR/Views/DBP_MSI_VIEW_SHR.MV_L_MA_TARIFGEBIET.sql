CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MA_TARIFGEBIET
(
mandant_id
,tarifgebiet_id
)
AS
   SELECT
   v01.mandant_id, v01.tarifgebiet_id

   FROM dbp_view.v_l_ma_tarifgebiet v01
;