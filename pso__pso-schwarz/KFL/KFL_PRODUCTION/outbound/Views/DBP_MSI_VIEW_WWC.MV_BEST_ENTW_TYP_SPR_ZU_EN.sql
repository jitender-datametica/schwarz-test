CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_best_entw_typ_spr_zu_en (mandant_id, bewtp, spr_id, bewtp_kbez
, bewtp_bez) AS SELECT mandant_id,
 best_entw_typ_id AS bewtp,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN best_entw_typ_kbez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN best_entw_typ_kbez
    ELSE NULL
    END)) AS bewtp_kbez,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN best_entw_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN best_entw_typ_bez
    ELSE NULL
    END)) AS bewtp_bez
FROM kfl_production_dbp_view.v_best_entw_typ_spr_zu AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 bewtp;