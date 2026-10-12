CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ofentyp_spr_zu_2 AS SELECT mandant_id,
 ofen_typ_id,
 ofen_typ_bez,
 spr_id
FROM kfl_production_dbp_view.v_ofentyp_spr_zu_2;