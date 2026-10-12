CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_cost_center_fiscal_year_ah_2
(
	ctrl_area_cd
	, cost_center_nr
	, cost_center_name_en
	, cost_center_name_de
	, fiscal_year
	, cc_group_lvl1_nr
	, cc_group_lvl1_name_en
	, cc_group_lvl1_name_de
	, cc_group_lvl2_nr
	, cc_group_lvl2_name_en
	, cc_group_lvl2_name_de
	, cc_group_lvl3_nr
	, cc_group_lvl3_name_en
	, cc_group_lvl3_name_de
	, cc_group_lvl4_nr
	, cc_group_lvl4_name_en
	, cc_group_lvl4_name_de
	, cc_group_lvl5_nr
	, cc_group_lvl5_name_en
	, cc_group_lvl5_name_de
	, cc_group_lvl6_nr
	, cc_group_lvl6_name_en
	, cc_group_lvl6_name_de
	, dwh_created_tmsp
	, dwh_updated_tmsp
	, dwh_src_file_name
	, src_file_tmsp
)
AS
WITH
    cc_dim AS (
        SELECT
            ctrl_area_cd
            , cost_center_nr
            , IFF( CURRENT_DATE() BETWEEN cc_valid_from_dt AND cc_valid_to_dt, 1, 0 ) :: BOOLEAN 	AS active_fg
            , long_name_en
            , long_name_de
        FROM 
            lec_share.v_dim_cost_center_2
		WHERE
			active_fg = 1
    )

-- Select everything from T_DIM_COST_CENTER_FISCAL_YEAR_AH_2

SELECT
    IFNULL( NULLIF( ah.ctrl_area_cd, '' ), '-1' ) 			AS ctrl_area_cd
    , IFNULL( NULLIF( ah.cost_center_nr, '' ), '-1' ) 		AS cost_center_nr
    , IFNULL( cc_dim.long_name_en, '' ) 					AS cost_center_name_en
    , IFNULL( cc_dim.long_name_de, '' ) 					AS cost_center_name_de
    , IFNULL( ah.fiscal_year, '1900' ) 						AS fiscal_year
    , IFNULL( NULLIF( ah.cc_group_lvl1_nr, '' ), '-1' ) 	AS cc_group_lvl1_nr
    , ah.cc_group_lvl1_name_en 								AS cc_group_lvl1_name_en
    , ah.cc_group_lvl1_name_de 								AS cc_group_lvl1_name_de
    , IFNULL( NULLIF( ah.cc_group_lvl2_nr, '' ), '-1' ) 	AS cc_group_lvl2_nr
    , ah.cc_group_lvl2_name_en 								AS cc_group_lvl2_name_en
    , ah.cc_group_lvl2_name_de 								AS cc_group_lvl2_name_de
    , IFNULL( NULLIF( ah.cc_group_lvl3_nr, '' ), '-1' ) 	AS cc_group_lvl3_nr
    , ah.cc_group_lvl3_name_en 								AS cc_group_lvl3_name_en
    , ah.cc_group_lvl3_name_de 								AS cc_group_lvl3_name_de
    , IFNULL( NULLIF( ah.cc_group_lvl4_nr, '' ), '-1' ) 	AS cc_group_lvl4_nr
    , ah.cc_group_lvl4_name_en 								AS cc_group_lvl4_name_en
    , ah.cc_group_lvl4_name_de 								AS cc_group_lvl4_name_de
    , IFNULL( NULLIF( ah.cc_group_lvl5_nr, '' ), '-1' ) 	AS cc_group_lvl5_nr
    , ah.cc_group_lvl5_name_en 								AS cc_group_lvl5_name_en
    , ah.cc_group_lvl5_name_de 								AS cc_group_lvl5_name_de
    , IFNULL( NULLIF( ah.cc_group_lvl6_nr, '' ), '-1' ) 	AS cc_group_lvl6_nr
    , ah.cc_group_lvl6_name_en 								AS cc_group_lvl6_name_en
    , ah.cc_group_lvl6_name_de 								AS cc_group_lvl6_name_de
    , ah.dwh_created_tmsp 									AS dwh_created_tmsp
    , ah.dwh_updated_tmsp 									AS dwh_updated_tmsp
    , ah.dwh_src_file_name 									AS dwh_src_file_name
    , ah.src_file_tmsp 										AS src_file_tmsp
FROM
    lec_share.v_dim_cost_center_fiscal_year_ah_2  AS ah
LEFT JOIN
    cc_dim     ON ah.ctrl_area_cd = cc_dim.ctrl_area_cd
               AND ah.cost_center_nr = cc_dim.cost_center_nr

UNION
    SELECT
        '-1' 		-- ctrl_area_cd
        , '-1' 		-- cost_center_nr
        , '' 		-- cost_center_name_en
        , '' 		-- cost_center_name_de
        , '1900' 	-- fiscal_year
        , '-1' 		-- cc_group_lvl1_nr
        , '' 		-- cc_group_lvl1_name_en
        , '' 		-- cc_group_lvl1_name_de
        , '-1' 		-- cc_group_lvl2_nr
        , '' 		-- cc_group_lvl2_name_en
        , '' 		-- cc_group_lvl2_name_de
        , '-1' 		-- cc_group_lvl3_nr
        , '' 		-- cc_group_lvl3_name_en
        , '' 		-- cc_group_lvl3_name_de
        , '-1' 		-- cc_group_lvl4_nr
        , '' 		-- cc_group_lvl4_name_en
        , '' 		-- cc_group_lvl4_name_de
        , '-1' 		-- cc_group_lvl5_nr
        , '' 		-- cc_group_lvl5_name_en
        , '' 		-- cc_group_lvl5_name_de
        , '-1' 		-- cc_group_lvl6_nr
        , '' 		-- cc_group_lvl6_name_en
        , '' 		-- cc_group_lvl6_name_de
        , CAST('1900-01-01' AS timestamp_ltz) 	-- dwh_created_tmsp
        , CAST('1900-01-01' AS timestamp_ltz) 	-- dwh_updated_tmsp
        , '' 									-- dwh_src_file_name
        , CAST('1900-01-01' AS timestamp_ltz) 	-- src_file_tmsp
;