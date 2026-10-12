CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_besch_faktura_1 (faktura_beleg_id, mandant_id, in_vw_id,
dat_faktura, dat_erstellung, fakturaart_id, in_kunde_id, faktura_status_kz) AS SELECT faktura_beleg_id,
 mandant_id,
 flw_vw_id AS in_vw_id,
 dat_faktura,
 dat_erstellung,
 fakturaart_id,
 flw_kunde_id AS in_kunde_id,
 faktura_status_kz
FROM kfl_production_dbp_view.v_flw_besch_faktura_1;