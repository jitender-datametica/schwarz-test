CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_letzter_abverkauf_2 (kl_art_id, mandant_id, wup_id, datzeit
, dat) AS SELECT LAV.kl_art_id,
 LAV.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 LAV.datzeit,
 LAV.dat
FROM kfl_production_dbp_v_ods.v_ods_letzter_abverkauf_2 AS LAV
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON LAV.mandant_id = WUP.mandant_id AND LAV.wup_id = WUP.wup_id
 INNER JOIN kfl_production_dbp_view.v_art_2 AS ART_2 ON LAV.mandant_id = ART.mandant_id AND LAV.kl_art_id = ART.kl_art_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS ARTWG ON ART.mandant_id = ARTWG.mandant_id AND ART.art_id = ARTWG
   .art_id
WHERE ARTWG.wg_id <> 961
 AND ARTWG.arthiertyp_id = 2
 AND ARTWG.dat_bis = DATE '9999-12-31';