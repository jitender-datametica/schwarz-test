CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_tiergattung_spr_zu AS SELECT V01.mandant_id,
 V01.tiergattung_id,
 V01.tiergattung_bez
FROM kfl_production_dbp_view.v_flw_tiergattung_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;