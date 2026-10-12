CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktion_thema_spr_zu_2 (aktion_thema_id, mandant_id, spr_id,
aktion_thema_bez, sap_aktion_thema_bez, aktion_thema_gruppe_id) AS SELECT V01.aktion_thema_id,
 V01.mandant_id,
 V02.spr_id,
 V02.aktion_thema_bez,
   V01.aktion_thema_id || '   ' || V02.aktion_thema_bez AS sap_aktion_thema_bez,
 V01.aktion_thema_gruppe_id
FROM kfl_production_dbp_view.v_l_aktion_thema_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_aktion_thema_spr_zu_2 AS V02 ON V01.aktion_thema_id = V02.aktion_thema_id AND V01.mandant_id
    = V02.mandant_id
WHERE V01.mandant_id = 1
 AND V02.spr_id = 22
 AND V01.aktion_thema_id <> 'XYZA';