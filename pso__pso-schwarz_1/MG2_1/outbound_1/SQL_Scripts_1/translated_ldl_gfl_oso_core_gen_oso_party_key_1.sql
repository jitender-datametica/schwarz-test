/*
Same key can come in different spelling from different sources
	we want to be able to link all different versions of the same key to same SID
	So, we will create "duplicate records" where the NK is translated, or cleaned from numbers
	and these duplicates will be linked to the same SID
	
Example:
	Original: 
		008JAN HOLÍK (008DOMINIK KOTALA (CZ8))
	Duplicates:
		JAN HOLÍK (DOMINIK KOTALA (CZ8))
		008JAN HOLIK (008DOMINIK KOTALA (CZ8))
		JAN HOLIK (DOMINIK KOTALA (CZ8))
		
How symbols are replaced is described in ETL_PROCESS.T_COUNTRY_SPECIAL_CHAR_1
The contend of this tables is supposed to be used with Snowflake function TRANSLATE
*/





INSERT INTO ldl_data_production_meta.t_party_key_1 (party_sid, party_key_type_cd, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, party_nat_key_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
WITH party_subset AS (SELECT party_sid,
    party_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    party_nat_key_nr
   FROM ldl_data_production_meta.t_party_key_1
   WHERE dwh_valid_fg
    AND party_key_type_cd IN ('SALES_MANAGER', 'ACCOUNT_MANAGER', 'PERSON')), re_party AS (SELECT pk.party_sid,
     pk.party_key_type_cd,
     pk.dwh_valid_from_tmsp,
     pk.dwh_valid_to_tmsp,
     pk.dwh_valid_fg,
     pk.party_nat_key_nr,
     REGEXP_REPLACE(TRANSLATE(pk.party_nat_key_nr, t_country_special_char.country_from_special_char_list,
       t_country_special_char.country_to_special_char_list), r'(\ [0-9]+\ )', ' ') AS re_party_nat_key_nr
    FROM party_subset AS pk
    /*
		Expected to produce the following duplicate: 	"JAN HOLIK (DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))"
	*/
     INNER JOIN ldl_data_production_etl_process.t_country_special_char_1 ON TRUE
    WHERE pk.party_nat_key_nr <> REGEXP_REPLACE(TRANSLATE(pk.party_nat_key_nr, t_country_special_char.country_from_special_char_list
        , t_country_special_char.country_to_special_char_list), r'(\ [0-9]+\ )', ' ')
    UNION ALL

    /*
		Expected to produce the following duplicate: 	"JAN HOLIK (DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))"
		
		similar to first union. Difference is that this matches more patterns, 
			but we apply it only to keys that do not start with #
	*/
    SELECT pk.party_sid,
     pk.party_key_type_cd,
     pk.dwh_valid_from_tmsp,
     pk.dwh_valid_to_tmsp,
     pk.dwh_valid_fg,
     pk.party_nat_key_nr,
     REGEXP_REPLACE(TRANSLATE(pk.party_nat_key_nr, t_country_special_char0.country_from_special_char_list,
       t_country_special_char0.country_to_special_char_list), r'(\ [0-9]+|^[0-9]{3}|\\b[0-9]{3})', '') AS
     re_party_nat_key_nr
    FROM (SELECT *
      FROM party_subset
      WHERE party_nat_key_nr NOT LIKE '#%') AS pk
     INNER JOIN ldl_data_production_etl_process.t_country_special_char_1 AS t_country_special_char0 ON TRUE
    WHERE REGEXP_REPLACE(TRANSLATE(pk.party_nat_key_nr, t_country_special_char0.country_from_special_char_list,
        t_country_special_char0.country_to_special_char_list), r'(\ [0-9]+|^[0-9]{3}|\\b[0-9]{3})', '') <> pk.party_nat_key_nr
      
     AND REGEXP_REPLACE(TRANSLATE(pk.party_nat_key_nr, t_country_special_char0.country_from_special_char_list,
        t_country_special_char0.country_to_special_char_list), r'(\ [0-9]+|^[0-9]{3}|\\b[0-9]{3})', '') <> REGEXP_REPLACE(pk
       .party_nat_key_nr, r'(\ [0-9]+\ )', ' ')
    UNION ALL

    /*
		Expected to produce the following duplicate: 	"008JAN HOLIK (008DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))" -> translated but numbers are kept
	*/
   
    SELECT pk.party_sid,
     pk.party_key_type_cd,
     pk.dwh_valid_from_tmsp,
     pk.dwh_valid_to_tmsp,
     pk.dwh_valid_fg,
     pk.party_nat_key_nr,
     TRANSLATE(pk.party_nat_key_nr, t_country_special_char1.country_from_special_char_list, t_country_special_char1.country_to_special_char_list
      ) AS re_party_nat_key_nr
    FROM party_subset AS pk
     INNER JOIN ldl_data_production_etl_process.t_country_special_char_1 AS t_country_special_char1 ON TRUE
    WHERE pk.party_nat_key_nr <> TRANSLATE(pk.party_nat_key_nr, t_country_special_char1.country_from_special_char_list,
       t_country_special_char1.country_to_special_char_list)) (SELECT a.party_sid,
    a.party_key_type_cd,
    a.dwh_valid_from_tmsp,
    a.dwh_valid_to_tmsp,
    a.dwh_valid_fg,
    a.re_party_nat_key_nr AS party_nat_key_nr,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    CAST('${LOAD_ID}' AS BIGNUMERIC) AS dwh_load_id,
    'OSO' AS dwh_node_cd
   FROM (SELECT party_sid,
      party_key_type_cd,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      re_party_nat_key_nr,
      ROW_NUMBER() OVER (PARTITION BY party_key_type_cd, re_party_nat_key_nr ORDER BY party_sid IS NULL, party_sid) AS
      rn
     FROM re_party) AS a
    LEFT JOIN ldl_data_production_meta.t_party_key_1 AS b ON a.party_key_type_cd = b.party_key_type_cd AND a.re_party_nat_key_nr
       = b.party_nat_key_nr
   WHERE b.party_nat_key_nr IS NULL
    AND a.rn = 1);
