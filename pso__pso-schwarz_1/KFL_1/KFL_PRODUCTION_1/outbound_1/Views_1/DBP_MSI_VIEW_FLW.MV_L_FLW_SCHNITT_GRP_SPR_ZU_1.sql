CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_schnitt_grp_spr_zu_1 (mandant_id, schnitt_id, spr_id,
sek_schl_typ_id, schnitt_bez) AS SELECT V01.mandant_id,
 V01.schnitt_id,
 V01.spr_id,
 V01.sek_schl_typ_id,
 MAX(V01.schnitt_bez) AS schnitt_bez
FROM kfl_production_dbp_view.v_flw_schnitt_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.sek_schl_typ_id IN ('M', 'P')
GROUP BY V01.mandant_id,
 V01.schnitt_id,
 V01.spr_id,
 V01.sek_schl_typ_id;