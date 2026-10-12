CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_posten_en (mandant_id, posten_id, posten_bez, posten_kz
, spr_id) AS SELECT mandant_id,
 posten_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN posten_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN posten_bez
    ELSE NULL
    END)) AS posten_bez,
 MAX(CASE
   WHEN mandant_id = 1 AND posten_id IN ('PN', 'PF') OR mandant_id <> 1 AND posten_id = '1'
   THEN 'X'
   ELSE ''
   END) AS posten_kz,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_artkz_posten AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 posten_id;