CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_1H_1 as
   -- LOOKUP: Zeit_1 1h
   -- Lookup-View fÃ¼r stÃ¼ndliches Intervall

   SELECT
   zeit_stunde, zeit_von || '-' || zeit_bis_1_h   AS zeit_1_h_bez
   FROM dbp_view.v_zeit_1
   WHERE zeit_minute = 0;