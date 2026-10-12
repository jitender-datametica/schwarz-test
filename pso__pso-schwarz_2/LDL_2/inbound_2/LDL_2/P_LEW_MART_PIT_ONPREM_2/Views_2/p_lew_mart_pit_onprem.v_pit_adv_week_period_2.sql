/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - PITonPrem TD2SF Migration Project Fall 2021
#-------------------------------------------------------------------------------
# Interface : DDL for Create PIT_ONPREM Transformation View V_PIT_ADV_WEEK_PERIOD_2
#-------------------------------------------------------------------------------
# Description: DDL for Create PIT_ONPREM Transformation View V_PIT_ADV_WEEK_PERIOD_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-15 Andreas Kurz     Initial version
#  1.1  2022-05-09 Dirk Hering      Fix for adv week start date, end date
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADV_WEEK_PERIOD_2
AS
SELECT
      adv.client_id                                                         AS client_id
    , adv.adv_week_id                                                       AS adv_week_id
    , CAST( (adv.adv_week_id * 100::INTEGER) + adv.client_id AS INTEGER)    AS adv_week_sid
    , adv.adv_week_id                                                       AS adv_week_rltd_id
    , CAST( (adv.adv_week_id * 100::INTEGER) + adv.client_id AS INTEGER)    AS adv_week_rltd_sid
    , adv.adv_period_id                                                     AS adv_period_id
    , advp.adv_period_descr                                                 AS adv_period_descr
    , TO_CHAR(adv.adv_week_period_start_dt,'DD.MM.YYYY')                    AS adv_week_period_start_dt_descr
    , TO_CHAR(adv.adv_week_period_end_dt,'DD.MM.YYYY')                      AS adv_week_period_end_dt_descr

    --CAST(adv.adv_week_period_start_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'DD.MM.YYYY' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(50)) AS adv_week_period_start_dt_descr,
    --CAST(adv.adv_week_period_end_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'DD.MM.YYYY' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(50)) AS adv_week_period_end_dt_descr,
    , adv.adv_week_period_sort_val                                          AS adv_week_period_sort_val
    , adv.adv_week_period_start_dt                                          AS adv_week_period_start_dt

    --CASE (MOD((adv.adv_week_period_start_dt - DATE '1900-01-01'), 7)) + 1
    , CASE date_part('dayofweekiso', adv.adv_week_period_start_dt::DATE) 
        WHEN 1 THEN 'Montag'
        WHEN 2 THEN 'Dienstag'
        WHEN 3 THEN 'Mittwoch'
        WHEN 4 THEN 'Donnerstag'
        WHEN 5 THEN 'Freitag'
        WHEN 6 THEN 'Samstag'
        WHEN 7 THEN 'Sonntag'
        ELSE 'N/A'
    END                         AS adv_week_period_start_day_desc
    
    --CASE (MOD((adv.adv_week_period_start_dt - DATE '1900-01-01'), 7)) + 1
    , CASE date_part('dayofweekiso', adv.adv_week_period_start_dt::DATE)
        WHEN 1 THEN 'Mo.'
        WHEN 2 THEN 'Di.'
        WHEN 3 THEN 'Mi.'
        WHEN 4 THEN 'Do.'
        WHEN 5 THEN 'Fr.'
        WHEN 6 THEN 'Sa.'
        WHEN 7 THEN 'So.'
        ELSE 'N/A'
    END                         AS adv_week_period_start_day_ab
    
    , adv.adv_week_period_end_dt
    
    --CASE (MOD((adv.adv_week_period_end_dt - DATE '1900-01-01'), 7)) + 1
    , CASE date_part('dayofweekiso', adv.adv_week_period_end_dt::DATE)
        WHEN 1 THEN 'Montag'
        WHEN 2 THEN 'Dienstag'
        WHEN 3 THEN 'Mittwoch'
        WHEN 4 THEN 'Donnerstag'
        WHEN 5 THEN 'Freitag'
        WHEN 6 THEN 'Samstag'
        WHEN 7 THEN 'Sonntag'
        ELSE 'N/A'
    END                         AS adv_week_period_end_day_desc
    
    --CASE (MOD((adv.adv_week_period_end_dt - DATE '1900-01-01'), 7)) + 1
    , CASE date_part('dayofweekiso', adv.adv_week_period_end_dt::DATE)
        WHEN 1 THEN 'Mo.'
        WHEN 2 THEN 'Di.'
        WHEN 3 THEN 'Mi.'
        WHEN 4 THEN 'Do.'
        WHEN 5 THEN 'Fr.'
        WHEN 6 THEN 'Sa.'
        WHEN 7 THEN 'So.'
        ELSE 'N/A'
    END                         AS adv_week_period_end_day_ab
    
    , advw.m_adv_week_start_dt      AS m_adv_week_start_dt
    , advw.m_adv_week_end_dt        AS m_adv_week_end_dt
    , advw.m_adv_week_end_ext_dt    AS m_adv_week_end_ext_dt
    , adv_week_period_start_day_ab || ' ' || adv_week_period_start_dt_descr
        || ' bis '
        || adv_week_period_end_day_ab || ' ' || adv_week_period_end_dt_descr
                                    AS adv_week_period_long_descr
         
    --CASE (MOD((advw.m_adv_week_start_dt - DATE '1900-01-01'), 7)) + 1
    , CASE date_part('dayofweekiso', advw.m_adv_week_start_dt::DATE)
        WHEN 1 THEN 'Mo.'
        WHEN 2 THEN 'Di.'
        WHEN 3 THEN 'Mi.'
        WHEN 4 THEN 'Do.'
        WHEN 5 THEN 'Fr.'
        WHEN 6 THEN 'Sa.'
        WHEN 7 THEN 'So.'
        ELSE 'N/A'
    END
        || ' '
        || 
        --CAST(advw.m_adv_week_start_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'DD.MM.YYYY' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(50))
        TO_CHAR(advw.m_adv_week_start_dt,'DD.MM.YYYY')
        || ' bis '
        || 
        --CASE (MOD((advw.m_adv_week_end_dt - DATE '1900-01-01'), 7)) + 1
        CASE date_part('dayofweekiso', advw.m_adv_week_end_dt::DATE)
            WHEN 1 THEN 'Mo.'
            WHEN 2 THEN 'Di.'
            WHEN 3 THEN 'Mi.'
            WHEN 4 THEN 'Do.'
            WHEN 5 THEN 'Fr.'
            WHEN 6 THEN 'Sa.'
            WHEN 7 THEN 'So.'
            ELSE 'N/A'
        END
        || ' '
        || 
        --CAST(advw.m_adv_week_end_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'DD.MM.YYYY' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(50))
        TO_CHAR(advw.m_adv_week_end_dt,'DD.MM.YYYY')
        || ' (Anmerkung: Maximale Laufzeit bis: '
        --|| CASE (MOD((advw.m_adv_week_end_ext_dt - DATE '1900-01-01'), 7)) + 1
        ||
        CASE date_part('dayofweekiso', advw.m_adv_week_end_ext_dt::DATE)
            WHEN 1 THEN 'Mo.'
            WHEN 2 THEN 'Di.'
            WHEN 3 THEN 'Mi.'
            WHEN 4 THEN 'Do.'
            WHEN 5 THEN 'Fr.'
            WHEN 6 THEN 'Sa.'
            WHEN 7 THEN 'So.'
            ELSE 'N/A'
        END
        || ' '
        || 
        --CAST(advw.m_adv_week_end_ext_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'DD.MM.YYYY' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(50))
        TO_CHAR(advw.m_adv_week_end_ext_dt, 'DD.MM.YYYY')
        || ') '
                                    AS adv_week_range_long_descr

FROM P_LEW_MART_PIT_ONPREM.t_advert_week_period_2 AS adv

INNER JOIN P_LEW_MART_PIT_ONPREM.t_advert_period_2 AS advp
    ON  adv.adv_period_id = advp.adv_period_id
    AND advp.mstr_related_fg = 0

INNER JOIN
(
    SELECT
          p.client_id                           AS client_id
        , p.adv_week_id                         AS adv_week_id
        , a.adv_week_start_dt                   AS m_adv_week_start_dt
        , a.adv_week_end_dt                     AS m_adv_week_end_dt
        , MAX(p.adv_week_period_end_dt)         AS m_adv_week_end_ext_dt
   
    FROM P_LEW_MART_PIT_ONPREM.t_advert_week_period_2 p
   
    INNER JOIN P_LEW_MART_PIT_ONPREM.t_advert_week_2 a
       ON  p.client_id   = a.client_id
       AND p.adv_week_id = a.adv_week_id
    
    GROUP BY
          p.client_id
        , p.adv_week_id
        , m_adv_week_start_dt
        , m_adv_week_end_dt
    
) advw
    ON  adv.client_id   = advw.client_id
    AND adv.adv_week_id = advw.adv_week_id
;