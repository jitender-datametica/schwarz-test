CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_FEHLARTIKEL_KZ_2 as
   SELECT
   CASE WHEN dat = current_date          THEN  0
   WHEN dat = current_date - 1     THEN 1
   WHEN dat = current_date - 2     THEN 2
   END AS fehlartikel_kz,

   CASE WHEN dat = current_date          THEN  'nicht relevant'
   WHEN dat = current_date - 1     THEN 'relevant und kein Fehlartikel'
   WHEN dat = current_date - 2     THEN 'relevant und Fehlartikel'
   END AS fehlartikel_bez
   FROM dbp_view.v_tag_2
   WHERE dat BETWEEN current_date-2 AND current_date;