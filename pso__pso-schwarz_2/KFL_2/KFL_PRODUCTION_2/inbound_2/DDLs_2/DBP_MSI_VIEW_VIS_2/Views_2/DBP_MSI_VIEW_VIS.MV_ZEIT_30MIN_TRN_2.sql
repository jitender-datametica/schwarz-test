CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEIT_30MIN_TRN_2 as
   -- View für die Transformation für die Kumulierung der Zeitintervalle
   -- Hier für das 30Min Zeitinterval

   SELECT
   t1.zeit_stunde               AS zeit_stunde, t1.zeit_minute               AS zeit_30min, t2.zeit_stunde               AS zeit_stunde_trn, t2.zeit_minute               AS zeit_30min_trn
   FROM dbp_view.v_zeit_2 t1_2, dbp_view.v_zeit_2 t2
   WHERE (t1.zeit_minute IN (0, 30) AND t2.zeit_minute IN (0,30))
   AND (t1.zeit_stunde > t2.zeit_stunde
   OR
   (t1.zeit_stunde = t2.zeit_stunde AND t1.zeit_minute >= t2.zeit_minute)
   );