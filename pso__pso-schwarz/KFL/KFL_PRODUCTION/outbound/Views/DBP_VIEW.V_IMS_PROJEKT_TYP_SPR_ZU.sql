CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_projekt_typ_spr_zu AS SELECT mandant_id,
 ims_projekt_typ_id,
 spr_id,
 ims_projekt_typ_bez
FROM kfl_production_dbp_data.ims_projekt_typ_spr_zu;