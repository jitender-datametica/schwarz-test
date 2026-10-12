CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_VKL
(
vkl_id
,gf_id
,vkl_name
,mandant_id
)
AS
   SELECT
  v01.vkl_id,
   v01.gf_id,
   TRIM(v02.ma_anrede || ' ' || v02.ma_vorname || ' ' || v02.ma_name) AS vkl_name,
   v01.mandant_id

  FROM dbp_view.v_vkl v01

   JOIN dbp_view.v_ma_spr_zu v02
   ON v01.vkl_id = v02.ma_id
   AND v01.mandant_id = v02.mandant_id
   AND v02.spr_id = 22

   WHERE v01.mandant_id<>1;