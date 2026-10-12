CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_wup_art_zu AS SELECT mandant_id,
 aktion_id,
 wup_id,
 nb_id,
 art_id
FROM kfl_production_dbp_data.aktion_art_wup_zu_wme_ame AS WME_AME
WHERE aktion_id IN (SELECT DISTINCT aktion_id
   FROM kfl_production_dbp_data.aktion_werbemengen_einholung
   WHERE dat_bis >= CURRENT_DATE);