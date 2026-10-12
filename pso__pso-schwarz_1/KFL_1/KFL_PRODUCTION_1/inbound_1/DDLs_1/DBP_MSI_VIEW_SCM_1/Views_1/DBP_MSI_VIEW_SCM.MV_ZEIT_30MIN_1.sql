CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_30MIN_1 as
   -- LOOKUP: Zeit_1 30Min
   -- Lookup-View fÃ¼r halb-stÃ¼ndliches Intervall

   SELECT
   zeit_stunde, zeit_minute zeit_30min, zeit_von || '-' || zeit_bis_30min   AS zeit_30min_bez
   FROM dbp_view.v_zeit_1
   WHERE zeit_minute IN (0,30);