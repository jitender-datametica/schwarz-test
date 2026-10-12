INSERT INTO CORE_REL.t_local_product_variant_1
(prod_variant_sid,
int_org_sid,
dwh_valid_from_tmsp,
dwh_valid_to_tmsp,
dwh_valid_fg,
local_prod_variant_nr,
local_prod_variant_name,
prod_sid,
dwh_created_tmsp,
dwh_updated_tmsp,
dwh_load_id,
dwh_node_cd)
SELECT 
prod_variant_sid,
p.party_sid as int_org_sid,
to_timestamp_ltz('1900-01-01 00:00:00') as dwh_valid_from_tmsp,
to_timestamp_ltz('9999-12-31 23:59:59.999999999') dwh_valid_to_tmsp,
true as dwh_valid_fg,
Substring(prod_variant_nat_key_nr, 4) local_prod_variant_nr,
'Unbekannt' local_prod_variant_name,
NULL as prod_sid,
current_timestamp,
current_timestamp,
${LOAD_ID} dwh_load_id,
'MAN' dwh_node_cd
FROM META.t_product_variant_key_1 pv
join meta.t_party_key_1 p
on p.party_key_type_cd='COUNTRY_1'
and p.party_nat_key_nr=substring(pv.prod_variant_nat_key_nr,0,2)
and p.dwh_valid_fg=pv.dwh_valid_fg
WHERE prod_variant_key_type_cd = 'SLS_UNK'
  AND pv.dwh_valid_fg
  AND prod_variant_sid NOT IN (
        SELECT prod_variant_sid
        FROM CORE_REL.t_local_product_variant_1)
  AND prod_variant_sid NOT IN (
        SELECT prod_variant_sid
        FROM META.t_product_variant_key_1
 WHERE prod_variant_key_type_cd <> 'SLS_UNK');
