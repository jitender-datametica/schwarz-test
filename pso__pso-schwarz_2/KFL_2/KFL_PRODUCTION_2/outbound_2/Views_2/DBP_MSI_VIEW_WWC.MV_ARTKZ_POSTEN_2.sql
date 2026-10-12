CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_posten_2 (mandant_id, posten_id, spr_id, posten_bez,
posten_kz, posten_bez_agg) AS SELECT mandant_id,
 posten_id,
 spr_id,
 posten_bez,
  CASE
  WHEN mandant_id = 1 AND posten_id IN ('PN', 'PF')
  THEN 'X'
  ELSE ''
  END AS posten_kz,
  CASE
  WHEN posten_bez = 'Postenartikel/Werbung - Non Food'
  THEN 'Postenartikel'
  ELSE posten_bez
  END AS posten_bez_agg
FROM kfl_production_dbp_view.v_artkz_posten_2 AS V01
WHERE mandant_id = 1
 AND spr_id = 22
UNION DISTINCT
SELECT mandant_id,
 posten_kz_sap AS posten_id,
 spr_id,
 posten_bez_sap AS posten_bez,
  CASE
  WHEN mandant_id <> 1 AND posten_kz_sap IN ('PN', 'SP')
  THEN 'X'
  ELSE ''
  END AS posten_kz,
  CASE
  WHEN CASE
    WHEN mandant_id <> 1 AND posten_kz_sap IN ('PN', 'SP')
    THEN 'X'
    ELSE ''
    END = 'X'
  THEN 'Posten'
  ELSE 'Sortimentsartikel'
  END AS posten_bez_agg
FROM kfl_production_dbp_view.v_posten_kz_sap_spr_zu_2 AS V02
WHERE mandant_id <> 1
 AND spr_id = 22;