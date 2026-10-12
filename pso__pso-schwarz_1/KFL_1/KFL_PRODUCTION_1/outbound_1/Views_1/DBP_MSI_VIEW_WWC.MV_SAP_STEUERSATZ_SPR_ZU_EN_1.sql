CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_sap_steuersatz_spr_zu_en_1 AS SELECT steuer_typ_id,
 sap_steuer_id,
 mandant_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN sap_steuer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sap_steuer_bez
    ELSE NULL
    END)) AS sap_steuer_bez
FROM kfl_production_dbp_view.v_sap_steuersatz_spr_zu_1
WHERE spr_id IN (22, 24)
GROUP BY steuer_typ_id,
 sap_steuer_id,
 mandant_id;