CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_zeit_2 AS SELECT dat,
 wup_id,
 mandant_id,
 nb_id,
 umsatz_brutto,
 bonanzahl,
 zeit_stunde,
 zeit_minute
FROM kfl_production_dbp_data.wup_zeit_2;