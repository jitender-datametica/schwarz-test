CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_30MIN_TRN as
   -- View fÃ¼r die Transformation fÃ¼r die Kumulierung der Zeitintervalle
   -- Hier fÃ¼r das 30Min Zeitinterval

   SELECT
   t1.zeit_stunde               AS zeit_stunde, t1.zeit_minute               AS zeit_30min, t2.zeit_stunde               AS zeit_stunde_trn, t2.zeit_minute               AS zeit_30min_trn
   FROM dbp_view.v_zeit t1, dbp_view.v_zeit t2
   WHERE (t1.zeit_minute IN (0, 30) AND t2.zeit_minute IN (0,30))
   AND (t1.zeit_stunde > t2.zeit_stunde
   OR
   (t1.zeit_stunde = t2.zeit_stunde AND t1.zeit_minute >= t2.zeit_minute)
   );