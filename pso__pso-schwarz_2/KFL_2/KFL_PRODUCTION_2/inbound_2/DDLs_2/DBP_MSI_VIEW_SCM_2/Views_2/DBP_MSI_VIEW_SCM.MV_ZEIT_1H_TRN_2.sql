CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_1H_TRN_2 as
   -- View fÃ¼r die Transformation fÃ¼r die Kumulierung der Zeitintervalle
   -- Hier fÃ¼r das 1h Zeitinterval

   SELECT
   t1.zeit_stunde               AS zeit_stunde, t2.zeit_stunde               AS zeit_stunde_trn
   FROM dbp_view.v_zeit_2 t1_2, dbp_view.v_zeit_2 t2
   WHERE t1.zeit_stunde >= t2.zeit_stunde
   AND t1.zeit_minute = 0
   AND t2.zeit_minute = 0;