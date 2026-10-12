CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_autodispocluster_2 AS SELECT V01.mandant_id,
 V01.wg_hierarchie_id AS autodispo_id,
 V02.wg_hierarchie_bez AS autodispo_bez
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_id
      = V02.wg_hierarchie_id AND V01.wg_hierarchie_ebene_id = V02.wg_hierarchie_ebene_id AND V01.arthiertyp_id = V02.arthiertyp_id
   
WHERE V01.arthiertyp_id = 9
 AND V01.mandant_id = 1
 AND V01.wg_hierarchie_ebene_id = 1
 AND V02.spr_id = 22
 AND V01.dat_bis = DATE '9999-12-31';