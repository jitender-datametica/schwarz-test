CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kreistyp_gruppe_spr_zu_1 (mandant_id, kreistyp_gruppe_id,
kreistyp_gruppe_bez) AS SELECT V01.mandant_id,
 V01.kreistyp_gruppe_id,
 V01.kreistyp_gruppe_bez
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2)
UNION ALL
SELECT mandant_id,
 '-1' AS kreistyp_gruppe_id,
 '-' AS kreistyp_gruppe_bez
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id IN (1, 2);