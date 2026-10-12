CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_sqlvariable (user_id, wrg_typ_id) AS SELECT
 user_id,
 wrg_typ_id
FROM kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu AS V02
WHERE user_id = $userid
GROUP BY user_id,
 wrg_typ_id;