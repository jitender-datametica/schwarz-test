CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_auftrag_artikelart_zu_1 (mandant_id, auftrag_id, in_art_id,
artikelart_id) AS SELECT V01.mandant_id,
 V01.auftrag_id,
 V01.flw_art_id AS in_art_id,
 V02.artikelart_id
FROM kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
   
WHERE V02.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND V01.mandant_id IN (1, 2);