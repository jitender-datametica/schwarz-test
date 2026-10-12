CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_objekt_debitor_zu_1 AS SELECT DP.mandant_id,
 DP.debitor_id,
 COALESCE(sub01.immo_objekt_id, 'IW----------0') AS immo_objekt_id
FROM kfl_production_dbp_view.v_ivs_debitor_per_1 AS DP
 LEFT JOIN (SELECT DISTINCT mandant_id,
    debitor_id,
    immo_objekt_id
   FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_1 AS MED
   WHERE mandant_id <> 1
   UNION ALL
   SELECT DISTINCT mandant_id,
    debitor_id,
    immo_objekt_id
   FROM kfl_production_dbp_view.v_ivs_debitor_immo_objekt_zu_1 AS DIOZ
   WHERE mandant_id = 1) AS sub01 ON DP.mandant_id = sub01.mandant_id AND DP.debitor_id = sub01.debitor_id
WHERE DP.ivs_fg = 1;