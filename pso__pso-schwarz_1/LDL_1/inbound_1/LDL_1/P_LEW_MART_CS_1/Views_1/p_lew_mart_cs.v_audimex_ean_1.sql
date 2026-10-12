CREATE OR REPLACE VIEW P_LEW_MART_CS.v_audimex_ean_1
(
  client_id
  ,country_iso_cd
  ,orig_item_nr
  ,case_size
  ,ean_code
  ,cs_updated
  ,cs_created
  ,cs_load_id 
)
AS
SELECT
    ean.client_id           AS client_id
    ,ean.country_iso_cd     AS country_iso_cd
    ,ean.orig_item_nr        AS orig_item_nr
    ,ean.case_size          AS case_size  
    ,ean.ean_code           AS ean_code
    ,ean.cs_updated         AS cs_updated
    ,ean.cs_created         AS cs_created
    ,ean.cs_load_id         AS cs_load_id
  FROM P_LEW_MART_CS.t_audimex_ean_1 AS ean_1;