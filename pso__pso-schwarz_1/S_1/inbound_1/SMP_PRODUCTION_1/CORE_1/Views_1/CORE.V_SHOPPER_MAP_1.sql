create or replace view SMP_PRODUCTION.CORE.V_SHOPPER_MAP_1(
	DIVISION_ID,
	COUNTRY_ID,
	SHOPPER_ID,
	SHOPPER_ID_REF
) as 
SELECT 
   division_id
  ,country_id
  ,shopper_id
  ,REPLACE(f.VALUE, '"', '') AS shopper_id_ref
FROM core_rel.t_shopper_1 s
  ,LATERAL FLATTEN (INPUT=>s.shopper_id_ref) f
;
