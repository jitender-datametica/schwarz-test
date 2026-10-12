CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ims_projekttyp_spr_zu_en (mandant_id, projekt_typ_id,
projekt_typ_bez) AS SELECT mandant_id,
 ims_projekt_typ_id AS projekt_typ_id,
 ims_projekt_typ_bez AS projekt_typ_bez
FROM kfl_production_dbp_view.v_ims_projekt_typ_spr_zu AS V01
WHERE spr_id = 24;