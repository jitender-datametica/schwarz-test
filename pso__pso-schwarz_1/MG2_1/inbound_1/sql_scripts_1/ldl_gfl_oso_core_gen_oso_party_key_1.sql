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

insert into meta.t_party_key_1 
(
	PARTY_SID,
	PARTY_KEY_TYPE_CD,
	DWH_VALID_FROM_TMSP,
	DWH_VALID_TO_TMSP,
	DWH_VALID_FG,
	PARTY_NAT_KEY_NR,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD
) 
with party_subset as 
( 
	select 
		PARTY_SID,
		PARTY_KEY_TYPE_CD,
		DWH_VALID_FROM_TMSP,
		DWH_VALID_TO_TMSP,
		DWH_VALID_FG,
		PARTY_NAT_KEY_NR, 
	from meta.t_party_key_1
	where DWH_VALID_FG
		and PARTY_KEY_TYPE_CD in ( 'SALES_MANAGER','ACCOUNT_MANAGER','PERSON')
),
re_party as 
(
	/*
		Expected to produce the following duplicate: 	"JAN HOLIK (DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))"
	*/
	select 
		pk.PARTY_SID,
		pk.PARTY_KEY_TYPE_CD,
		pk.DWH_VALID_FROM_TMSP,
		pk.DWH_VALID_TO_TMSP,
		pk.DWH_VALID_FG,
		pk.PARTY_NAT_KEY_NR,

		REGEXP_REPLACE(
			TRANSLATE( pk.party_nat_key_nr, COUNTRY_FROM_SPECIAL_CHAR_LIST, COUNTRY_TO_SPECIAL_CHAR_LIST)
			, '(\ [0-9]+\ )'
			, ' ') as re_party_nat_key_nr
	from party_subset as pk 
		CROSS JOIN ETL_PROCESS.T_COUNTRY_SPECIAL_CHAR_1
	where PARTY_NAT_KEY_NR <> re_party_nat_key_nr
 
	union all
	
	/*
		Expected to produce the following duplicate: 	"JAN HOLIK (DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))"
		
		similar to first union. Difference is that this matches more patterns, 
			but we apply it only to keys that do not start with #
	*/
	select 
		pk.PARTY_SID,
		pk.PARTY_KEY_TYPE_CD,
		pk.DWH_VALID_FROM_TMSP,
		pk.DWH_VALID_TO_TMSP,
		pk.DWH_VALID_FG,
		pk.PARTY_NAT_KEY_NR,

		REGEXP_REPLACE(
				TRANSLATE( pk.party_nat_key_nr, COUNTRY_FROM_SPECIAL_CHAR_LIST, COUNTRY_TO_SPECIAL_CHAR_LIST)
				, '(\ [0-9]+|^[0-9]{3}|\\b[0-9]{3})'
				, ''
			) AS RE_PARTY_NAT_KEY_NR
	from 
		(
			select * 
			from party_subset
		   where party_nat_key_nr NOT LIKE '#%'
		) as pk
		CROSS JOIN ETL_PROCESS.T_COUNTRY_SPECIAL_CHAR_1
	where RE_PARTY_NAT_KEY_NR <> PARTY_NAT_KEY_NR
		and RE_PARTY_NAT_KEY_NR <> REGEXP_REPLACE(party_nat_key_nr, '(\ [0-9]+\ )', ' ')
 
	union all  
	
	/*
		Expected to produce the following duplicate: 	"008JAN HOLIK (008DOMINIK KOTALA (CZ8))"
		from original record that looks like: 			"008JAN HOLÍK (008DOMINIK KOTALA (CZ8))" -> translated but numbers are kept
	*/
	select 
		pk.PARTY_SID,
		pk.PARTY_KEY_TYPE_CD,
		pk.DWH_VALID_FROM_TMSP,
		pk.DWH_VALID_TO_TMSP,
		pk.DWH_VALID_FG,
		pk.PARTY_NAT_KEY_NR,

		TRANSLATE( pk.party_nat_key_nr, COUNTRY_FROM_SPECIAL_CHAR_LIST, COUNTRY_TO_SPECIAL_CHAR_LIST) as re_party_nat_key_nr
	from party_subset as pk 
		CROSS JOIN ETL_PROCESS.T_COUNTRY_SPECIAL_CHAR_1
	where PARTY_NAT_KEY_NR <> re_party_nat_key_nr
)
SELECT 
	a.PARTY_SID,
	a.PARTY_KEY_TYPE_CD,
	a.DWH_VALID_FROM_TMSP,
	a.DWH_VALID_TO_TMSP,
	a.DWH_VALID_FG,
	a.RE_PARTY_NAT_KEY_NR as PARTY_NAT_KEY_NR,
	current_timestamp as DWH_CREATED_TMSP,
	current_timestamp as DWH_UPDATED_TMSP,
	'${LOAD_ID}' as DWH_LOAD_ID,
	'OSO' as DWH_NODE_CD
FROM 
	( 
		SELECT 
			PARTY_SID,
			PARTY_KEY_TYPE_CD,
			DWH_VALID_FROM_TMSP,
			DWH_VALID_TO_TMSP,
			DWH_VALID_FG,
			RE_PARTY_NAT_KEY_NR,

			row_number() over ( partition by PARTY_KEY_TYPE_CD, re_party_nat_key_nr order by PARTY_SID) as RN
		FROM re_party
	) as a
LEFT JOIN META.T_PARTY_KEY_1 AS B
  ON A.PARTY_KEY_TYPE_CD = B.PARTY_KEY_TYPE_CD
 AND A.RE_PARTY_NAT_KEY_NR = B.PARTY_NAT_KEY_NR
WHERE B.PARTY_NAT_KEY_NR IS NULL
 AND A.RN =1
;
