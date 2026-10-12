CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_wup_status_zu_2 AS SELECT mandant_id,
 nb_id,
 wup_id,
 aktion_id,
 MAX(CASE
   WHEN status_einholung_id = 9
   THEN 1
   ELSE 0
   END) AS aktion_wme_ame_status_fg
FROM kfl_production_dbp_data.aktion_werbemengen_einholung_2 AS EIN_HOL
WHERE dat_bis >= CURRENT_DATE
GROUP BY mandant_id,
 nb_id,
 wup_id,
 aktion_id;