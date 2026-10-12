CREATE OR REPLACE VIEW dbp_view.v_art_nielsen_mapping_uwg_zu_1
AS
SELECT
 mandant_id
 ,art_nielsen_tag
 ,gtin_id
 ,art_nielsen_bez
 ,kl_art_kat_id
 ,kl_wg_id
 ,kl_owg_id
 ,kl_uwg_id
FROM dbp_etl_process.art_nielsen_mapping_uwg_zu_1;