CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEIT_15MIN_2 as
   -- LOOKUP: Zeit_2 15Min
   -- Lookup-View fÃ¼r viertel-stÃ¼ndliches Intervall

   SELECT
   zeit_stunde, zeit_minute zeit_15min, zeit_von || '-' || zeit_bis_15min   AS zeit_15min_bez, ((zeit_minute / 30)::BYTEINT) *30  AS zeit_30min
   FROM dbp_view.v_zeit_2;