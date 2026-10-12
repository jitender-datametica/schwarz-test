CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAGER_BEWART_SPR_ZU_2
(
lager_bewart_id
, bewart_bez
, mandant_id
, spr_id
)
AS
   SELECT
   v01.lager_bewart_id, v01.lager_bewart_bez, v01.mandant_id, v01.spr_id

   FROM dbp_view.v_lager_bewart_spr_zu_2 v01

   WHERE v01.mandant_id = 1
   AND v01.spr_id = 22
   --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
   AND v01.system_id NOT IN (2,17,28,32,48,53);