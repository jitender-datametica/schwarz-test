CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ts_scm_tor_gruppe_map (mandant_id, lagernummer_id, wup_id, nb_id
, tor_id_zugeordnet, tor_gruppe, hallenseite_id, hallenseite_bez) AS SELECT v1.mandant_id,
 v1.lagernummer_id,
 v1.wup_id,
 v1.nb_id,
 v1.tor_id_zugeordnet,
 COALESCE(V2.tor_gruppe, '-1') AS tor_gruppe,
 COALESCE(NULLIF(V2.hallenseite_bez, ''), '-1') AS hallenseite_id,
 COALESCE(V2.hallenseite_bez, '-1') AS hallenseite_bez
FROM (SELECT DISTINCT lagernummer_id,
   mandant_id,
   wup_id,
   nb_id,
   tor_id_zugeordnet
  FROM kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_per AS T01
  WHERE EXISTS (SELECT 1
    FROM kfl_production_dbp_data.l_vz_sap_system_zu AS SVZ
     INNER JOIN kfl_production_dbp_data.l_system AS S ON SVZ.mandant_id = S.mandant_id AND SVZ.system_id = S.system_id
    WHERE S.system_gruppe = 'SAP LVS'
     AND SVZ.mandant_id = T01.mandant_id
     AND SVZ.wup_id = T01.wup_id
     AND SVZ.system_id = T01.system_id)) AS v1
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_tor_gruppe_map AS V2 ON v1.lagernummer_id = V2.lagernummer_id AND v1.mandant_id
       = V2.mandant_id AND v1.wup_id = V2.wup_id AND v1.nb_id = V2.nb_id AND v1.tor_id_zugeordnet = V2.tor_id_zugeordnet;