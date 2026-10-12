CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_bereich_spr_zu AS SELECT V01.wg_hierarchie_id AS
 ber_id,
 V02.wg_hierarchie_bez AS ber_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V02.spr_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_ebene_id
      = V02.wg_hierarchie_ebene_id AND V01.wg_hierarchie_id = V02.wg_hierarchie_id AND V01.arthiertyp_id = V02.arthiertyp_id
   
WHERE V01.mandant_id > 1
 AND V01.arthiertyp_id = 10
 AND V01.wg_hierarchie_ebene_id = 1
 AND CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis;