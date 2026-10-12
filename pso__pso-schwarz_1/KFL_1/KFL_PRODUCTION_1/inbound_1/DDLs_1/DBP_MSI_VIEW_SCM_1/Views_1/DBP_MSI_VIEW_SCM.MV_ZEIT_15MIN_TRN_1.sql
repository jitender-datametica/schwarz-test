CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_15MIN_TRN_1 as
   -- View fÃ¼r die Transformation fÃ¼r die Kumulierung der Zeitintervalle
   -- Hier fÃ¼r das 15Min Zeitinterval

   SELECT
   t1.zeit_stunde               AS zeit_stunde, t1.zeit_minute               AS zeit_15min, t2.zeit_stunde               AS zeit_stunde_trn, t2.zeit_minute               AS zeit_15min_trn
   FROM dbp_view.v_zeit_1 t1_1, dbp_view.v_zeit_1 t2
   WHERE (t1.zeit_stunde > t2.zeit_stunde
   OR
   (t1.zeit_stunde = t2.zeit_stunde AND t1.zeit_minute >= t2.zeit_minute)
   );