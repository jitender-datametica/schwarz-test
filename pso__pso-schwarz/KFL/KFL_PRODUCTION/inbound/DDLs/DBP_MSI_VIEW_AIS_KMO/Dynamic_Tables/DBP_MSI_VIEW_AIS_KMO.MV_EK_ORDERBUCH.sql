CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_EK_ORDERBUCH
(
  art_id
, mandant_id
, wup_id
, nb_id
, gp_id
, orderbuch_gueltig
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   -- gültige Orderbucheinträge

   SELECT DISTINCT
   v01.art_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.gp_id,
   CAST ('gültiger Orderbucheintrag' AS VARCHAR(100)) AS orderbuch_gueltig
  FROM dbp_view.v_ek_orderbuch v01
   WHERE v01.mandant_id <>1
   AND (v01.gesperrt_fg = 0 AND CURRENT_DATE-1 BETWEEN v01.dat_von AND v01.dat_bis)

   UNION ALL

   -- ungültige Orderbucheinträge

   SELECT DISTINCT
   v02.art_id,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v02.gp_id,
   CAST ('ungültiger Orderbucheintrag' AS VARCHAR(100)) AS orderbuch_gueltig
   FROM dbp_view.v_ek_orderbuch v02
   WHERE v02.mandant_id <>1
   AND (art_id, mandant_id, wup_id, nb_id, gp_id) NOT IN
   (SELECT DISTINCT
   art_id,
   mandant_id,
   wup_id,
   nb_id,
   gp_id
  FROM dbp_view.v_ek_orderbuch
  WHERE mandant_id <>1
  AND (gesperrt_fg = 0 AND CURRENT_DATE-1 BETWEEN dat_von AND dat_bis)
  );