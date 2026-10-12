CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ims_projekttyp_1 (mandant_id, projekt_typ_id) AS SELECT
 mandant_id,
 ims_projekt_typ_id AS projekt_typ_id
FROM kfl_production_dbp_view.v_l_ims_projekt_typ_1 AS V01;