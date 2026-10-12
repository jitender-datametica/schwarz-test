CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_LIFT_TREND_COMPARISON_1(
      CLIENT_ID
    , RTL_ID
    , RTL_LVL
    , PER_ID
    , PROM_ID
    , MEAS_ID
    , LIFT_CAT_ID
    , CURRENCY_ISO_CD
    , RTL_TP_ID
    , DSC_NR
    , REVENUECHANGE
    , REVENUECHANGE_TO_EJR
    , TREND_RATIO
    , COVER
    , COVER_LJP
    , COVER_DELTA
) AS
    WITH REPORT_LAYER AS (
      WITH EXTERNAL_DATA AS (
          SELECT
                v_lil_period.per_id                                                                                   AS per_id
              , EXTDAT.client_id                                                                                      AS client_id
              , v_lil_lift_cat.lift_cat_id                                                                            AS lift_cat_id

              ,  EXTDAT.rtl_lvl                                                                                       AS rtl_lvl
              ,  EXTDAT.rtl_id                                                                                        AS rtl_id
              ,  EXTDAT.prom_id                                                                                       AS prom_id
              ,  EXTDAT.meas_id                                                                                       AS meas_id
              ,  EXTDAT.currency_iso_cd                                                                               AS currency_iso_cd
              ,  v_lil_rtl_lvl_tp.rtl_tp_id                                                                           AS rtl_tp_id
              ,  v_lil_data_delivery_classification.dsc_nr                                                            AS dsc_nr

              , (DECODE(EXTDAT.meas_id, 27, COALESCE(EXTDAT.val,0)    * 100, COALESCE(EXTDAT.val,0))    / 1000.0    ) AS val__divk
              , (DECODE(EXTDAT.meas_id, 27, EXTDAT.py_val * 100, EXTDAT.py_val) / 1000.0    )                         AS py_val__divk
              ,  DECODE(EXTDAT.meas_id, 27, COALESCE(EXTDAT.val,0)    * 100, COALESCE(EXTDAT.val,0)                 ) AS val
              ,  DECODE(EXTDAT.meas_id, 27, EXTDAT.py_val * 100, EXTDAT.py_val              )                         AS py_val

          FROM    P_LEW_MART_CM_AC.v_lil_lift_data_act_1    EXTDAT

    INNER JOIN    P_LEW_MART_CM_AC.v_lil_rtl_lvl_tp_1    v_lil_rtl_lvl_tp_1
            ON     (EXTDAT.rtl_lvl = v_lil_rtl_lvl_tp.rtl_lvl)
    INNER JOIN    P_LEW_MART_CM_AC.v_lil_lift_cat_1    v_lil_lift_cat_1
            ON     (EXTDAT.lift_cat_id = v_lil_lift_cat.lift_cat_id)
    INNER JOIN    P_LEW_MART_CM_AC.v_lil_period_1    v_lil_period_1
            ON     (EXTDAT.per_id = v_lil_period.per_id)
    INNER JOIN    P_LEW_MART_CM_AC.v_lil_data_delivery_classification_1 
            ON     EXTDAT.client_id   = v_lil_data_delivery_classification.client_id
           AND     EXTDAT.per_id      = v_lil_data_delivery_classification.period_id

          WHERE    EXTDAT.rtl_id = 1000

        ), INTERNAL_DATA AS (
          SELECT
                v_lil_period.per_id                                                         AS per_id
              , INTDAT.client_id                                                            AS client_id
              , v_lil_lift_cat.lift_cat_id                                                  AS lift_cat_id

              , INTDAT.rtl_id                                                               AS rtl_id
              , INTDAT.rtl_lvl                                                              AS rtl_lvl
              , INTDAT.prom_id                                                              AS prom_id
              , INTDAT.meas_id                                                              AS meas_id
              , INTDAT.currency_iso_cd                                                      AS currency_iso_cd
              , v_lil_rtl_lvl_tp.rtl_tp_id                                                  AS rtl_tp_id
              , v_lil_data_delivery_classification.dsc_nr                                   AS dsc_nr

              , COALESCE(INTDAT.val,0) / 1000.0                                             AS val__divk
              , INTDAT.py_val / 1000.0                                                      AS py_val__divk
              , COALESCE(INTDAT.val,0)                                                      AS val
              , INTDAT.py_val                                                               AS py_val

          FROM    P_LEW_MART_CM_AC.v_lil_ejr_lift_data_act_1    INTDAT
          
              JOIN    P_LEW_MART_CM_AC.v_lil_rtl_lvl_tp_1    v_lil_rtl_lvl_tp_1
                ON     (INTDAT.rtl_lvl = v_lil_rtl_lvl_tp.rtl_lvl)
              JOIN    P_LEW_MART_CM_AC.v_lil_lift_cat_1    v_lil_lift_cat_1
                ON     (INTDAT.lift_cat_id = v_lil_lift_cat.lift_cat_id)
              JOIN    P_LEW_MART_CM_AC.v_lil_period_1    v_lil_period_1
                ON     (INTDAT.per_id = v_lil_period.per_id)
        INNER JOIN    P_LEW_MART_CM_AC.v_lil_data_delivery_classification_1 
                ON     INTDAT.client_id   = v_lil_data_delivery_classification.client_id
               AND     INTDAT.per_id      = v_lil_data_delivery_classification.period_id      
               
          WHERE    INTDAT.rtl_id = 1000
      )

       SELECT
              INT_EXT.client_id                                                                             AS CLIENT_ID
            , INT_EXT.rtl_id                                                                                AS RTL_ID
            , INT_EXT.rtl_lvl                                                                               AS RTL_LVL
            , v_lil_period.per_id                                                                           AS PER_ID
            , INT_EXT.prom_id                                                                               AS PROM_ID
            , INT_EXT.meas_id                                                                               AS MEAS_ID
            , INT_EXT.currency_iso_cd                                                                       AS CURRENCY_ISO_CD
            , INT_EXT.rtl_tp_id                                                                             AS RTL_TP_ID
            , v_lil_lift_cat.lift_cat_id                                                                    AS LIFT_CAT_ID
            , INT_EXT.EXTERNAL_DATA__dsc_nr                                                                 AS DSC_NR
            
            , INTERNAL_DATA__val__divk                                                                      AS INTERNAL_DATA__val__divk
            , INTERNAL_DATA__val                                                                            AS INTERNAL_DATA__val
            , INTERNAL_DATA__py_val__divk                                                                   AS INTERNAL_DATA__py_val__divk
            , INTERNAL_DATA__py_val                                                                         AS INTERNAL_DATA__py_val

            , EXTERNAL_DATA__val__divk                                                                      AS EXTERNAL_DATA__val__divk
            , EXTERNAL_DATA__val                                                                            AS EXTERNAL_DATA__val
            , EXTERNAL_DATA__py_val__divk                                                                   AS EXTERNAL_DATA__py_val__divk
            , EXTERNAL_DATA__py_val                                                                         AS EXTERNAL_DATA__py_val

            , CASE WHEN ext_calc_fg = 1 THEN EXTERNAL_DATA_revenuechange__perc
              ELSE NULL END                                                                                 AS REVENUECHANGE_EXTERNAL_PERCENTAGE
            , CASE WHEN int_calc_fg = 1 THEN INTERNAL_DATA_revenuechange__perc
              ELSE NULL END                                                                                 AS REVENUECHANGE_INTERNAL_PERCENTAGE

            , COALESCE(INTERNAL_DATA_revenuechange__perc,0) - COALESCE(EXTERNAL_DATA_revenuechange__perc,0) AS REVENUECHANGE_TO_EJR

            , CASE WHEN calc_fg = 1
              THEN ((EXTERNAL_DATA_revenuechange__perc
                   - INTERNAL_DATA_revenuechange__perc)
                    /NULLIFZERO(
                    INTERNAL_DATA_revenuechange__perc))*100
              ELSE NULL END                                                                                 AS TREND_RATIO
            , CASE WHEN calc_fg = 1
              THEN 100 * (EXTERNAL_DATA__val__divk
                    /NULLIFZERO(INTERNAL_DATA__val__divk))
              ELSE NULL END                                                                                 AS COVER
            , CASE WHEN calc_fg = 1
              THEN 100 * ((EXTERNAL_DATA__py_val__divk)
                    /NULLIFZERO(INTERNAL_DATA__py_val__divk))
              ELSE NULL END                                                                                 AS COVER_LJP

            , COALESCE(cover,0) - COALESCE(cover_ljp,0)                                                     AS COVER_DELTA

        FROM    (
        SELECT
              COALESCE(EXTERNAL_DATA.per_id,      INTERNAL_DATA.per_id     )                                AS PER_ID
            , COALESCE(EXTERNAL_DATA.client_id,   INTERNAL_DATA.client_id  )                                AS CLIENT_ID
            , COALESCE(EXTERNAL_DATA.lift_cat_id, INTERNAL_DATA.lift_cat_id)                                AS LIFT_CAT_ID

            , COALESCE(EXTERNAL_DATA.rtl_id , INTERNAL_DATA.rtl_id )                                        AS RTL_ID
            , COALESCE(EXTERNAL_DATA.rtl_lvl, INTERNAL_DATA.rtl_lvl)                                        AS RTL_LVL
            , COALESCE(EXTERNAL_DATA.prom_id, INTERNAL_DATA.prom_id)                                        AS PROM_ID
            , COALESCE(EXTERNAL_DATA.meas_id, INTERNAL_DATA.meas_id)                                        AS MEAS_ID
            , COALESCE(EXTERNAL_DATA.currency_iso_cd, INTERNAL_DATA.currency_iso_cd)                        AS CURRENCY_ISO_CD
            , COALESCE(EXTERNAL_DATA.rtl_tp_id, INTERNAL_DATA.rtl_tp_id)                                    AS RTL_TP_ID
            , EXTERNAL_DATA.dsc_nr                                                                          AS EXTERNAL_DATA__dsc_nr
            , INTERNAL_DATA.dsc_nr                                                                          AS INTERNAL_DATA__dsc_nr

            , INTERNAL_DATA.val__divk                                                                       AS INTERNAL_DATA__val__divk
            , INTERNAL_DATA.val                                                                             AS INTERNAL_DATA__val
            , INTERNAL_DATA.py_val__divk                                                                    AS INTERNAL_DATA__py_val__divk
            , INTERNAL_DATA.py_val                                                                          AS INTERNAL_DATA__py_val

            , EXTERNAL_DATA.val__divk                                                                       AS EXTERNAL_DATA__val__divk
            , EXTERNAL_DATA.val                                                                             AS EXTERNAL_DATA__val
            , EXTERNAL_DATA.py_val__divk                                                                    AS EXTERNAL_DATA__py_val__divk
            , EXTERNAL_DATA.py_val                                                                          AS EXTERNAL_DATA__py_val

            , (   CASE
                WHEN COALESCE((
                           (
                            (COALESCE(INTERNAL_DATA.val, 0) - COALESCE(INTERNAL_DATA.py_val, 0))
                            / ( CASE WHEN INTERNAL_DATA.py_val=0 THEN NULL
                                ELSE INTERNAL_DATA.py_val
                                END)
                           ) * 100), 0)=0 THEN NULL
                ELSE COALESCE((
                            (
                                (COALESCE(INTERNAL_DATA.val, 0) - COALESCE(INTERNAL_DATA.py_val, 0))
                                / ( CASE WHEN INTERNAL_DATA.py_val=0 THEN NULL
                                    ELSE INTERNAL_DATA.py_val
                                    END)) * 100)
                                    , 0)END)                                                                AS INTERNAL_DATA_revenuechange__perc

            , (   CASE
                WHEN COALESCE((
                        (
                            (COALESCE(EXTERNAL_DATA.val, 0) - COALESCE(EXTERNAL_DATA.py_val, 0))
                            / ( CASE WHEN EXTERNAL_DATA.py_val=0 THEN NULL
                            ELSE EXTERNAL_DATA.py_val END)) * 100), 0)=0
                THEN NULL
                ELSE COALESCE(((
                        (COALESCE(EXTERNAL_DATA.val, 0) - COALESCE(EXTERNAL_DATA.py_val, 0))
                                    /
                        (CASE WHEN EXTERNAL_DATA.py_val=0 THEN NULL
                         ELSE EXTERNAL_DATA.py_val END)) * 100)
                         , 0) END)                                                                          AS EXTERNAL_DATA_revenuechange__perc
            , CASE WHEN
                 INTERNAL_DATA__val__divk    IS NULL
              OR INTERNAL_DATA__val          IS NULL
              OR INTERNAL_DATA__py_val__divk IS NULL
              OR INTERNAL_DATA__py_val       IS NULL
              OR EXTERNAL_DATA__val__divk    IS NULL
              OR EXTERNAL_DATA__val          IS NULL
              OR EXTERNAL_DATA__py_val__divk IS NULL
              OR EXTERNAL_DATA__py_val       IS NULL
              THEN 0 ELSE 1 END                                                                             AS calc_fg      -- no nulls
            , CASE WHEN
                 INTERNAL_DATA__val__divk    IS NULL
              OR INTERNAL_DATA__val          IS NULL
              OR INTERNAL_DATA__py_val__divk IS NULL
              OR INTERNAL_DATA__py_val       IS NULL
              THEN 0 ELSE 1 END                                                                             AS int_calc_fg  -- no nulls for internal data (ejr)
            , CASE WHEN
                 EXTERNAL_DATA__val__divk    IS NULL
              OR EXTERNAL_DATA__val          IS NULL
              OR EXTERNAL_DATA__py_val__divk IS NULL
              OR EXTERNAL_DATA__py_val       IS NULL
              THEN 0 ELSE 1 END                                                                             AS ext_calc_fg  -- no nulls for external data (lift)

        FROM             INTERNAL_DATA
        FULL OUTER JOIN  EXTERNAL_DATA

        ON     (
                    EXTERNAL_DATA.client_id              = INTERNAL_DATA.client_id
                AND EXTERNAL_DATA.lift_cat_id            = INTERNAL_DATA.lift_cat_id
                AND EXTERNAL_DATA.per_id                 = INTERNAL_DATA.per_id

                AND EXTERNAL_DATA.rtl_id                 = INTERNAL_DATA.rtl_id
                AND EXTERNAL_DATA.rtl_lvl                = INTERNAL_DATA.rtl_lvl
                AND EXTERNAL_DATA.prom_id                = INTERNAL_DATA.prom_id
                AND EXTERNAL_DATA.meas_id                = INTERNAL_DATA.meas_id
                AND EXTERNAL_DATA.currency_iso_cd        = INTERNAL_DATA.currency_iso_cd
                AND EXTERNAL_DATA.rtl_tp_id              = INTERNAL_DATA.rtl_tp_id
            )

        )    INT_EXT

        INNER JOIN    P_LEW_MART_CM_AC.v_lil_lift_cat_1                     ON     INT_EXT.lift_cat_id = v_lil_lift_cat.lift_cat_id
        INNER JOIN    P_LEW_MART_CM_AC.v_lil_period_1                       ON     INT_EXT.per_id      = v_lil_period.per_id
 
  )

SELECT
      CLIENT_ID                                   AS CLIENT_ID
    , RTL_ID                                      AS RTL_ID
    , RTL_LVL                                     AS RTL_LVL
    , PER_ID                                      AS PER_ID
    , PROM_ID                                     AS PROM_ID
    , MEAS_ID                                     AS MEAS_ID
    , LIFT_CAT_ID                                 AS LIFT_CAT_ID
    , CURRENCY_ISO_CD                             AS CURRENCY_ISO_CD
    , RTL_TP_ID                                   AS RTL_TP_ID
    , 0                                           AS DSC_NR
    , ROUND(REVENUECHANGE_INTERNAL_PERCENTAGE, 2) AS REVENUECHANGE_PERCENTAGE    
    , ROUND(REVENUECHANGE_TO_EJR             , 2) AS REVENUECHANGE_TO_EJR
    , ROUND(TREND_RATIO                      , 2) AS TREND_RATIO
    , ROUND(COVER                            , 2) AS COVER
    , ROUND(COVER_LJP                        , 2) AS COVER_LJP
    , ROUND(COVER_DELTA                      , 2) AS COVER_DELTA
FROM    REPORT_LAYER
UNION 
SELECT
      CLIENT_ID                                   AS CLIENT_ID
    , RTL_ID                                      AS RTL_ID
    , RTL_LVL                                     AS RTL_LVL
    , PER_ID                                      AS PER_ID
    , PROM_ID                                     AS PROM_ID
    , MEAS_ID                                     AS MEAS_ID
    , LIFT_CAT_ID                                 AS LIFT_CAT_ID
    , CURRENCY_ISO_CD                             AS CURRENCY_ISO_CD
    , RTL_TP_ID                                   AS RTL_TP_ID
    , DSC_NR                                      AS DSC_NR
    , ROUND(REVENUECHANGE_EXTERNAL_PERCENTAGE, 2) AS REVENUECHANGE
    , ROUND(REVENUECHANGE_TO_EJR             , 2) AS REVENUECHANGE_TO_EJR
    , ROUND(TREND_RATIO                      , 2) AS TREND_RATIO
    , ROUND(COVER                            , 2) AS COVER
    , ROUND(COVER_LJP                        , 2) AS COVER_LJP
    , ROUND(COVER_DELTA                      , 2) AS COVER_DELTA

FROM    REPORT_LAYER     
;