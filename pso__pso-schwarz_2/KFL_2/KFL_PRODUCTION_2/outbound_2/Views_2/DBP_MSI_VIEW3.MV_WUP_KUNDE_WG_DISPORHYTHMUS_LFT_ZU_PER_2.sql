CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_kunde_wg_disporhythmus_lft_zu_per_2 (mandant_id, wup_id, nb_id
, mandant_id_kunde, kunde_id, wg_id, arthiertyp_id, sortimentslistenart_id, terminierungsgruppe_1_id,
terminierungsgruppe_2_id, terminierungsgruppe_3_id, dat_von, dat_bis, auslieferungsgruppe_id,
disposition_rhythmus_ltf_id) AS SELECT mandant_id,
 wup_id,
 nb_id,
 mandant_id AS mandant_id_kunde,
 kunde_id,
 wg_id,
 arthiertyp_id,
 sortimentslistenart_id,
 terminierungsgruppe_1_id,
 terminierungsgruppe_2_id,
 terminierungsgruppe_3_id,
 dat_von,
 dat_bis,
 auslieferungsgruppe_id,
 disposition_rhythmus_ltf_id
FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 AS V01
WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis;