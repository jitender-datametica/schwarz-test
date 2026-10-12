CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_absagegrund_spr_zu (mandant_id, absagegrund_id,
absagegrund_bez) AS SELECT V01.mandant_id,
 V01.absagegrund_id,
 V01.absagegrund_bez
FROM kfl_production_dbp_view.v_flw_absagegrund_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
UNION DISTINCT
SELECT mandant_id,
 '-1' AS absagegrund_id,
 '' AS absagegrund_bez
FROM kfl_production_dbp_view.v_mandant AS V02
WHERE mandant_id IN (1, 2);