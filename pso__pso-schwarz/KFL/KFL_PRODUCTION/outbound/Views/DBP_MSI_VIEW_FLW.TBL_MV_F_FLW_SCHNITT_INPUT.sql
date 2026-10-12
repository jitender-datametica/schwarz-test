CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_schnitt_input (mandant_id, schnitt_id,
sek_schl_typ_id, sek_schl_id, in_art_id, werk_id, dat_von, dat_bis, default_wrg, wrg_id_v01, material_einzel_kosten) AS
SELECT V01.mandant_id,
 V01.schnitt_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 V01.dat_von,
 V01.dat_bis,
 V100.default_wrg,
 V01.wrg_id AS wrg_id_v01,
 V01.material_einzel_kosten
FROM kfl_production_dbp_view.v_flw_schnitt_input AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.sek_schl_typ_id IN ('M', 'P');