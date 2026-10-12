CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wbs_aktion_absatz_bereinigt AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 aktion_id,
 bewart_id,
 menge_bereinigt
FROM kfl_production_dbp_view.v_wbs_aktion_absatz_bereinigt
WHERE mandant_id <> 1;