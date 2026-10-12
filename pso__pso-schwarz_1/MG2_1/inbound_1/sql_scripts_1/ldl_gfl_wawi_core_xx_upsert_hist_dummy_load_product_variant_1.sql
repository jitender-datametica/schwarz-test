INSERT INTO CORE_REL.t_product_variant_1
(prod_variant_sid,
gtin,
dwh_valid_from_tmsp,
dwh_valid_to_tmsp,
dwh_valid_fg,
prod_variant_nr,
prod_variant_name,
prod_sid,
weight_based_fg,
logistic_variant_type_cd,
case_size_cnt,
prod_variant_type_cd,
sales_variant_type_cd,
sales_variant_content_meas,
unit_cnt,
unit_content_meas,
content_uom_cd,
non_food_variant_type_cd,
size_name,
style_name,
kind_name,
fruits_and_vegetables_class_cd,
min_caliber_meas,
max_caliber_meas,
caliber_uom_cd,
country_of_origin_sid,
dwh_created_tmsp,
dwh_updated_tmsp,
dwh_load_id,
dwh_node_cd)
SELECT 
prod_variant_sid,
NULL as gtin,
to_timestamp_ltz('1900-01-01 00:00:00') as dwh_valid_from_tmsp,
to_timestamp_ltz('9999-12-31 23:59:59.999999999') dwh_valid_to_tmsp,
true as dwh_valid_fg,
Substring(prod_variant_nat_key_nr, 4) prod_variant_nr,
'Unbekannt' prod_variant_name,
NULL as prod_sid,
NULL weight_based_fg,
NULL logistic_variant_type_cd,
NULL case_size_cnt,
'SALES_1' prod_variant_type_cd, 
'OTHER' sales_variant_type_cd,
NULL sales_variant_content_meas,
NULL unit_cnt,
NULL unit_content_meas,
NULL content_uom_cd,
NULL non_food_variant_type_cd,
NULL size_name,
NULL style_name,
NULL kind_name,
NULL fruits_and_vegetables_class_cd,
NULL min_caliber_meas,
NULL max_caliber_meas,
NULL caliber_uom_cd,
NULL country_of_origin_sid,
current_timestamp,
current_timestamp,
${LOAD_ID} dwh_load_id,
'MAN' dwh_node_cd
FROM META.t_product_variant_key_1 pv
WHERE prod_variant_key_type_cd = 'SLS_UNK'
  AND pv.dwh_valid_fg
  AND prod_variant_sid NOT IN (
        SELECT prod_variant_sid
        FROM CORE_REL.t_product_variant_1)
  AND prod_variant_sid NOT IN (
        SELECT prod_variant_sid
        FROM META.t_product_variant_key_1
 WHERE prod_variant_key_type_cd <> 'SLS_UNK');

