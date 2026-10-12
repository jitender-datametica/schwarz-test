CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_art_nielsen_wug_zu_pflege_vv_1 (mandant_id, art_nielsen_id,
art_nielsen_bez, nielsen_abteilung_bez, nielsen_wg_bez, nielsen_uwg1_bez, nielsen_uwg2_bez, gtin_id) AS SELECT V01.mandant_id
 ,
 V01.art_nielsen_id,
 V01.art_nielsen_bez,
 V01.nielsen_abteilung_bez,
 V01.nielsen_wg_bez,
 V01.nielsen_uwg1_bez,
 V01.nielsen_uwg2_bez,
 V02.gtin_id
FROM kfl_production_dbp_view.v_art_nielsen_wug_zu_pflege_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_nielsen_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_nielsen_id = V02
   .art_nielsen_id;