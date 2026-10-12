CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_LAGER_BEWART_SPR_ZU_HIST_1
-- AP0014173, srom0404, neu erstellt
-- kein Historien Flag vorhanden, aber dennoch als eigene View ausgeführt, um es zu trennen
(
lager_bewart_id
, bewart_bez
, mandant_id
, spr_id
, system_id
)
AS
   SELECT
   v01.lager_bewart_id, v01.lager_bewart_bez, v01.mandant_id, v01.spr_id, v01.system_id

   FROM dbp_view.v_lager_bewart_spr_zu_1 v01

   WHERE
   --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
   v01.system_id NOT IN (2,17,28,32,48,53);