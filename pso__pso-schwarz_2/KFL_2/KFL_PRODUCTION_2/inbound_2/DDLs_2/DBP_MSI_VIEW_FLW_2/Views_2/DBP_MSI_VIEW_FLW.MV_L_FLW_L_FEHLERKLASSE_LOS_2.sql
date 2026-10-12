CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_FEHLERKLASSE_LOS_2
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, fehlerklasse_id
, fehlerklasse_kennzahl
, fehlerklasse_kennzahl_ber
, fehlerklasse
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id,
   v01.fehlerklasse_id, 
   v01.fehlerklasse_kennzahl, 
  
   CASE WHEN fehlerklasse_kennzahl = 1 THEN 0 ELSE fehlerklasse_kennzahl END AS fehlerklasse_kennzahl_ber,
   
   100 - fehlerklasse_kennzahl_ber AS fehlerklasse
  

   FROM dbp_view.v_flw_l_fehlerklasse_2 v01;