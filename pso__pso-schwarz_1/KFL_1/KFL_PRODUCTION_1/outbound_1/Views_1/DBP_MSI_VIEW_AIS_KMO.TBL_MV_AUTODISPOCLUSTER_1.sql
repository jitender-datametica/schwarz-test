CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_autodispocluster_1 AS SELECT V01.mandant_id,
 V01.wg_hierarchie_id AS autodispo_id,
 V02.wg_hierarchie_bez AS autodispo_bez,
 V02.spr_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_id
      = V02.wg_hierarchie_id AND V01.wg_hierarchie_ebene_id = V02.wg_hierarchie_ebene_id AND V01.arthiertyp_id = V02.arthiertyp_id
   
WHERE V01.arthiertyp_id = 9
 AND V01.mandant_id <> 1
 AND V01.wg_hierarchie_ebene_id = 1
 AND V01.dat_bis = DATE '9999-12-31';