CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_aktion_absatz_bereinigt_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 aktion_id,
 bewart_id,
 menge_bereinigt,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wbs_aktion_absatz_bereinigt_1;