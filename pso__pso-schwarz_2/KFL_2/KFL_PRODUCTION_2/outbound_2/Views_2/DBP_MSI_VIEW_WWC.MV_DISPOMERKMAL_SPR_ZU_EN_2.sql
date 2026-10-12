CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_dispomerkmal_spr_zu_en_2 (mandant_id, dismm, spr_id, dibez) AS
SELECT mandant_id,
 dispomerkmal AS dismm,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dibez
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_2
WHERE spr_id IN (22, 24)
 AND mandant_id <> 1
GROUP BY mandant_id,
 dismm;