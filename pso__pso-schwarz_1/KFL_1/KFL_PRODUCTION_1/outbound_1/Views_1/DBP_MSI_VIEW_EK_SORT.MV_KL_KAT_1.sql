CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_kl_kat_1 (mandant_id, kl_kat_id) AS SELECT mandant_id,
 kl_art_kat_id AS kl_kat_id
FROM (SELECT mandant_id,
    wg_hierarchie_id AS kl_art_kat_id
   FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V01
   WHERE mandant_id > 1
    AND CURRENT_DATE BETWEEN dat_von AND dat_bis
    AND arthiertyp_id = 5
    AND wg_hierarchie_ebene_id = 3
   UNION DISTINCT
   SELECT mandant_id,
    kl_art_kat_id
   FROM kfl_production_dbp_view.v_kl_art_kat_nielsen_1 AS V02) AS t1_1;