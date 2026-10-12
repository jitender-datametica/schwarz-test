CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_schnitt_spr_zu_2 (mandant_id, schnitt_id,
spr_id, sek_schl_typ_id, sek_schl_id, schnitt_bez) AS SELECT V01.mandant_id,
 V01.schnitt_id,
 V01.spr_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.schnitt_bez
FROM kfl_production_dbp_view.v_flw_schnitt_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.sek_schl_typ_id IN ('M', 'P');