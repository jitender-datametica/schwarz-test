CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_aktivitaet_typ_1 AS SELECT mandant_id,
 aktivitaet_typ_id,
 aktivitaet_typ_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_aktivitaet_typ_1
WHERE spr_id = 22;