CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_in_auftrag (mandant_id, auftrag_id,
auftragsart_id, auftrag_bez, dat_start) AS SELECT V01.mandant_id,
 V01.auftrag_id,
 V01.auftragsart_id,
 V03.art_bez AS auftrag_bez,
 V02.dat_start
FROM kfl_production_dbp_view.v_flw_auftrag AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_auftrag_pps AS V02 ON V01.mandant_id = V02.mandant_id AND V01.auftrag_id = V02
   .auftrag_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_spr_zu AS V03 ON V01.mandant_id = V03.mandant_id AND V02.flw_art_id = V03.flw_art_id
   
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V04 ON V03.spr_id = V04.spr_id
WHERE V01.auftragsart_id IN ('FL02', 'FL04')
 AND V01.mandant_id IN (1, 2)
UNION ALL
SELECT V01.mandant_id,
 V01.auftrag_id,
 V02.auftragsart_id,
 V03.auftrag_bez,
 V01.dat_start
FROM kfl_production_dbp_view.v_flw_auftrag_pps AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_auftrag AS V02 ON V01.mandant_id = V02.mandant_id AND V01.auftrag_id = V02.auftrag_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_trenn_auftrag AS V03 ON V01.mandant_id = V03.mandant_id AND V01.auftrag_id =
   V03.auftrag_id
WHERE V02.auftragsart_id IN ('ZPP1', '-1')
 AND V01.mandant_id IN (1, 2);