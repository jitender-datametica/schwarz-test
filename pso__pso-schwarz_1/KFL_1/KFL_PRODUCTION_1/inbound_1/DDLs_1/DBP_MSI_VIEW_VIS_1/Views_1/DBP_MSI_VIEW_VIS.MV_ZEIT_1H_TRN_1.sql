CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEIT_1H_TRN_1 as
   -- View für die Transformation für die Kumulierung der Zeitintervalle
   -- Hier für das 1h Zeitinterval

   SELECT
   t1.zeit_stunde               AS zeit_stunde, t2.zeit_stunde               AS zeit_stunde_trn
   FROM dbp_view.v_zeit_1 t1_1, dbp_view.v_zeit_1 t2
   WHERE t1.zeit_stunde >= t2.zeit_stunde
   AND t1.zeit_minute = 0
   AND t2.zeit_minute = 0;