CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_BEWART_SPR_ZU
-- 02.10.2013 twie: Erweitert um mandant_id 2
(
spr_id
,bewart_id
,bewart_bez
,mandant_id
)
AS
   SELECT
  v01.spr_id, v01.bewart_id, v01.bewart_bez, v01.mandant_id

   FROM dbp_view.v_bewart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id in (1,2);