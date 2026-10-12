CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_els_leergut_position_2 AS SELECT barcode_leergut,
 mandant_id,
 bon_zeile,
 mwst_id,
 wrg_id,
 kl_art_id,
 menge,
 bon_zeilen_wert,
 plu_gruppe
FROM kfl_production_dbp_ods.els_leergut_position_2;