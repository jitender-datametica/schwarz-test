CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_VW_RETAIL
-- 02.10.2013 twie: Erweitert um mandant_id 2
--11.06.2014 twie: vw_id 10 fuer CZ ergaenzt
--28.09.2016 twie: SPEC0015193 Vertriebswegsumstellung DE von 1,2,3 auf 6
(
vw_id, -- vw_id <> in_vw_id. Die Vertriebswege aus Retail haben keinen Zusammenhang zu denen aus Industrie
vw_ret_bez, -- 'ret' eingefuegt fuer Retail, da im  Industrie-Umfeld es schon eine vw_bez gibt.
vk_id,
mandant_id,
vwvt_bez
)
AS
   SELECT
  vw_id,
   vw_bez AS vw_ret_bez,
   vk_id,
   mandant_id,
   vwvt_bez
   FROM dbp_view.v_l_vw
   WHERE mandant_id IN (1,2)
   AND vwart_id=1
   AND vw_id IN (6,10);