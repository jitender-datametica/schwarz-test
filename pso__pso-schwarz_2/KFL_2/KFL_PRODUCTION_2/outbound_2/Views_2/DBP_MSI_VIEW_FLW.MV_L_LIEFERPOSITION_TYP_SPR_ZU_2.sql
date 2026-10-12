CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_lieferposition_typ_spr_zu_2 (lief_pos_typ_id, mandant_id,
spr_id, lief_pos_typ_bez) AS SELECT V01.lief_pos_typ_id,
 V01.mandant_id,
 V01.spr_id,
 V01.lief_pos_typ_bez
FROM kfl_production_dbp_view.v_flw_lieferpos_typ_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;