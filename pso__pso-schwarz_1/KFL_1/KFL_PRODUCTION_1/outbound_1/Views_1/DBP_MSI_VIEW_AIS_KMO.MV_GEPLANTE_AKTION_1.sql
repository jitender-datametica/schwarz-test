CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_geplante_aktion_1 (geplante_aktion_id,
geplante_sap_aktion_id, mandant_id) AS SELECT plan_aktion_id AS geplante_aktion_id,
 aktion_id AS geplante_sap_aktion_id,
 mandant_id
FROM kfl_production_dbp_view.v_aktion_art_aktion_zu_1
WHERE mandant_id <> 1
GROUP BY plan_aktion_id,
 aktion_id,
 mandant_id;