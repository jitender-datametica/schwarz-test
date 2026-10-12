CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_CORE_ITEM_PROMOTION_MEDIUM_1

(
      client_id
    , item_sid
    , promotion_dt
    , advertising_medium_cd
    , advertising_medium_pos
    , deleted_fg
    , dwh_load_id
    , dwh_created
    , dwh_upDATEd
)
AS
SELECT DISTINCT 
      Apt.client_id                                                                                     AS client_id
    , ItmMap.rltd_item_sid                                                                              AS item_sid
    , Apt.promotion_dt                                                                                  AS promotion_dt

    , TO_CHAR( f_CleanString(COALESCE( Apt.advertising_medium_cd, 'Sonstige' ) ) )                         AS advertising_medium_cd

    , Apt.advertising_medium_pos                                                                        AS advertising_medium_pos
    , Apt.deleted_fg                                                                                    AS deleted_fg

    , Apt.dwh_load_id                                                                                   AS dwh_load_id
    , Apt.dwh_created                                                                                   AS dwh_created
    , Apt.dwh_upDATEd                                                                                   AS dwh_upDATEd

FROM P_LEW_CORE_AC.V_ITEM_PROMOTION_MEDIUM_ADP_1 Apt

INNER JOIN (
            
                SELECT      MainItm.client_id
                          , MainItm.item_sid
                          , Itm.item_sid         AS rltd_item_sid

                FROM        P_LEW_CORE_AC.V_ITEM_1    MainItm
                INNER JOIN  P_LEW_CORE_AC.V_ITEM_1     Itm
                        ON  MainItm.client_id = Itm.client_id
                       
                       AND  try_TO_NUMBER(Coalesce(MainItm.src_orig_item_nr, TRIM(MainItm.config_item_cd), MainItm.src_matnr)) = try_TO_NUMBER(Coalesce(Itm.src_orig_item_nr, TRIM(Itm.config_item_cd), Itm.src_matnr))
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

WHERE Apt.deleted_fg = 0;