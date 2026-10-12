CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_CORE_ITEM_PROMOTION_1
(
      client_id
    , item_sid
    , promotion_dt
    , promotion_cy_week
    , promotion_busyear
    , promotion_end_dt
    , promotion_end_dt_created_fg
    , promotion_end_dt_truncated_fg
    , promotion_period_orig_days
    , advertising_campaign
    , advertising_theme
    , advertising_group
    , advertising_sub_group
    , turnover_plan_val
    , item_sid_prev_promotion
    , promotion_time_prev_promotion
    , sales_price 
    , sales_price_orig 
    , sales_price_comment 
    , promotion_comment
    , item_list_type
    , promotion_store_placement_int
    , promotion_store_placement_nat
    , promotion_type_int
    , promotion_type_nat
    , deleted_fg
    , excluded_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT      
      Apt.client_id                                                                                             AS client_id
    , ItmMap.rltd_item_sid                                                                                      AS item_sid
    , Apt.promotion_dt                                                                                          AS promotion_dt
    , Apt.promotion_cy_week                                                                                     AS promotion_cy_week
    , Apt.promotion_busyear                                                                                     AS promotion_busyear
    , CASE WHEN Apt.promotion_end_dt IS NULL
               THEN Apt.promotion_dt + pa.apt_time_gap_in_days
           WHEN Apt.promotion_end_dt > Apt.promotion_dt + pa.apt_time_gap_in_days
               THEN Apt.promotion_dt + pa.apt_time_gap_in_days
               ELSE Apt.promotion_end_dt
      END                                                                                                       AS _promotion_end_dt
    , CASE WHEN Apt.promotion_end_dt IS NULL
               THEN 1::SMALLINT
               ELSE 0::SMALLINT
      END                                                                                                       AS promotion_end_dt_created_fg
    , CASE WHEN Apt.promotion_end_dt IS NULL
               THEN 0::SMALLINT
           WHEN Apt.promotion_end_dt > Apt.promotion_dt + pa.apt_time_gap_in_days
               THEN 1::SMALLINT
               ELSE 0::SMALLINT
      END                                                                                                       AS promotion_end_dt_truncated_fg
    , CASE WHEN Apt.promotion_end_dt IS NULL
               THEN 0::INTEGER
               ELSE Cast((Apt.promotion_end_dt - Apt.promotion_dt) AS INTEGER) + 1::INTEGER
      END                                                                                                       AS promotion_period_orig_days
    , Apt.advertising_campaign                                                                                  AS advertising_campaign

	, TO_CHAR ( f_CleanString(COALESCE( Apt.advertising_theme, 'Kein Werbethema definiert' ) ) )				AS _advertising_theme

	, TO_CHAR( f_CleanString(COALESCE( Apt.advertising_group, 'Sonstige' ) ) )									AS advertising_group

    , Apt.advertising_sub_group                                                                                 AS advertising_sub_group
    , Cast(Apt.turnover_plan_val AS NUMBER(38,5))                                                           	AS turnover_plan_val
    , Apt.item_sid_prev_promotion                                                                               AS item_sid_prev_promotion
    , Apt.promotion_time_prev_promotion                                                                         AS promotion_time_prev_promotion
    , Cast(Apt.sales_price AS NUMBER(38,5))                                                                 	AS sales_price
    , Cast(Apt.sales_price_orig AS NUMBER(38,5))                                                            	AS sales_price_orig
    , Apt.sales_price_comment                                                                                   AS sales_price_comment
    , Apt.promotion_comment                                                                                     AS promotion_comment

	, TO_CHAR( f_CleanString(COALESCE( Apt.item_list_type, 'Sonstige' ) ) )										AS item_list_type

    , Apt.promotion_store_placement_int                                                                         AS promotion_store_placement_int
    , Apt.promotion_store_placement_nat                                                                         AS promotion_store_placement_nat
    , Apt.promotion_type_int                                                                                    AS promotion_type_int
    , Apt.promotion_type_nat                                                                                    AS promotion_type_nat
    , Apt.deleted_fg                                                                                            AS deleted_fg
    , 0::INTEGER                                                                                        		AS excluded_fg
    , Apt.dwh_load_id                                                                                           AS dwh_load_id
    , Apt.dwh_created                                                                                           AS dwh_created
    , Apt.dwh_updated                                                                                           AS dwh_updated

FROM 
(
	SELECT * FROM P_LEW_CORE_AC.V_ITEM_PROMOTION_ADP_1 
	WHERE TRUE
		AND DELETED_FG = 0
	) APT


INNER JOIN 
       ( 
        SELECT
              CLIENT_ID     
            , MAX( iff(pa.param_id = 41,CAST(pa.param_value AS INTEGER),NULL) )   					AS ADP_TIME_GAP_IN_DAYS
			, MAX( iff(pa.param_id = 54,CAST(pa.param_value AS INTEGER),NULL) )   					AS APT_TIME_GAP_IN_DAYS
        FROM        
		(
				SELECT * FROM P_LEW_MART_PIT_ONPREM.T_PIT_SCOPE_COUNTRY_PARAM_1 
				WHERE TRUE
					AND CURRENT_DATE() BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
					AND	DELETED_FG 	= 0									
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
		) pa
        GROUP BY 1
        ) pa
        ON Apt.client_id = pa.client_id

INNER JOIN (

                SELECT      MainItm.client_id
                          , MainItm.item_sid
                          , Itm.item_sid         AS rltd_item_sid

                FROM        P_LEW_CORE_AC.V_ITEM_1   AS MainItm
                INNER JOIN  P_LEW_CORE_AC.V_ITEM_1   AS Itm
                        ON  MainItm.client_id = Itm.client_id

                       AND  try_to_number(Coalesce(MainItm.src_orig_item_nr, TRIM(MainItm.config_item_cd), MainItm.src_matnr)) = try_to_number(Coalesce(Itm.src_orig_item_nr, TRIM(Itm.config_item_cd), Itm.src_matnr))
                       AND  (
                                  MainItm.src_dat_valid_from = Itm.src_dat_valid_from
                                 OR
                                  MainItm.src_dat_valid_from IS NULL
                                 OR
                                  Itm.src_dat_valid_from IS NULL
                            )

                GROUP BY  1,2,3
           )                                 AS ItmMap

        ON Apt.client_id = ItmMap.client_id
       AND Apt.item_sid  = ItmMap.item_sid

WHERE TRUE
;