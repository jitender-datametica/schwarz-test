CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_FAKTURAART
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
fakturaart_id
, mandant_id
--, system_id
)

AS
   SELECT
   fakturaart_id, mandant_id
   --, system_id

   FROM
   dbp_view.v_flw_l_fakturaart;