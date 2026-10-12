CREATE OR REPLACE VIEW produktion_fe_mstr_bge_palettierer.v_dim_production_stop_flag (alerts_production_stop_fg,
alerts_production_stop_fg_desc) AS SELECT cast (alerts_production_stop_fg as bool),
 alerts_stop_producion_flag_desc AS alerts_production_stop_fg_desc
FROM (SELECT 0 AS alerts_production_stop_fg,
    'Nein' AS alerts_stop_producion_flag_desc
   UNION ALL
   SELECT 1 AS alerts_production_stop_fg,
    'Ja' AS alerts_stop_producion_flag_desc);