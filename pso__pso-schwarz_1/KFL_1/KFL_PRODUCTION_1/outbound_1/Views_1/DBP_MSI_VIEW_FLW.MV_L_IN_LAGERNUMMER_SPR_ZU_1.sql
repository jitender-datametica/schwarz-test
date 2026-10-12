CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lagernummer_spr_zu_1 (mandant_id, lagernummer_id,
lagernummer_bez, spr_id) AS SELECT V01.mandant_id,
 V01.lagernummer_id,
 V01.lagernummer_bez,
 V01.spr_id
FROM kfl_production_dbp_view.v_flw_lagernummer_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;