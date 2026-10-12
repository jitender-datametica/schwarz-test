CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_VW
(
vw_id,
vw_bez,
vk_id,
mandant_id,
vwvt_bez,
sap_vw_id,
KL_ID
)
AS
   SELECT
  vw_id,
   TRIM(vw_bez),
   vk_id,
   mandant_id,
   TRIM(vwvt_bez),
   sap_vw_id,
   1
   FROM dbp_view.v_l_vw
   WHERE mandant_id=1
   AND vwart_id=1
   AND vw_id IN (1,2,3,6);