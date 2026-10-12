/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.v_itm_item_list_type_hist_2
#----------------------------------------------------------------------------
# History:
#  1.0  19.06.2021    Bachmann, Torsten        Transfer to LEAD, new logic for listing-related Attributes, rename to _list_type_hist, PatchNo: 2915, REP3-8659
#  1.1  24.08.2021    Bachmann, Torsten        Migrated to Snowflake
#  1.2  16.02.2022    Bachmann, Torsten        Logic adjusted because of INC3507733, SPEC0116558, ADO User Story 261320
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITM_ITEM_LIST_TYPE_HIST_2 COMMENT = 'History of buying_list_type_id, brand_type_id and listing_type_id per item_2'
(
  client_id                    COMMENT 'Landeskennzeichen'
, item_id                      COMMENT 'Artikelnummer'
, dat_rec_start                COMMENT 'Gültigkeitsdatum von'
, dat_rec_end                  COMMENT 'Gültigkeitsdatum bis'
, brand_name                   COMMENT 'The name of the brand.'
, buying_list_type_id          COMMENT 'Einkauf Listungstyp'
, buying_list_type_desc        COMMENT 'Bezeichnung der Art_2 des Artikels ( Saison, ... )'
, listing_type_id              COMMENT 'the type of listing article'
, brand_type_id                COMMENT 'the type of brand_2 of an article'
, buying_list_type_group_id    COMMENT 'Gruppe_2 der Art_2 des Artikels ( Saison, ... )'
, listing_type_group_id        COMMENT 'Guppe Einlistungstype Id'
, brand_type_group_id          COMMENT 'Guppen Markenart ID'
, src                          COMMENT 'Where does the row come from: WAWI, ELW=eLWIS, pre/post_elwis=from WAWI before/after switching to/from eLWIS'
)
AS

/*
#DescStart#
#LastChangedBy: tbachmann
#LastChange: 2022-02-16
#SubjectAreas#: Artikelstamm
#DescEnd#
*/

SELECT
  imaster.client_id
, imaster.item_id                                                                         AS item_id
, CASE WHEN itm.client_id IS NULL THEN DATE '1900-01-01' ELSE itm.dat_rec_start END       AS dat_rec_start
, CASE WHEN itm.client_id IS NULL
       THEN DATE '9999-12-31'
       ELSE LEAD (itm.dat_rec_start -1, 1, DATE '9999-12-31') OVER (PARTITION BY imaster.client_id, imaster.item_id
                                                                    ORDER BY itm.dat_rec_start)
  END                                                                                     AS dat_rec_end
, COALESCE(itm.brand_name, '--')                                                          AS brand_name
, COALESCE(itm.buying_list_type_id, -1)                                                   AS buying_list_type_id
, COALESCE(reflist.buying_list_type_desc, itm.buying_list_type_desc, 'Dummy_2-Artikelart')  AS buying_list_type_desc
, COALESCE(reflist.listing_type_id, -1)                                                   AS listing_type_id
, COALESCE(reflist.brand_type_id, -1)                                                     AS brand_type_id
, COALESCE(reflist.buying_list_type_group_id, -1)                                         AS buying_list_type_group_id
, COALESCE(reflist.listing_type_group_id, -1)                                             AS listing_type_group_id
, COALESCE(reflist.brand_type_group_id, -1)                                               AS brand_type_group_id
, itm.src
FROM P_LEW_MART_LEAD.v_itm_item_2 imaster
   LEFT OUTER JOIN
(
  SELECT
    client_id
  , item_sid
  , dat_rec_start
  , dat_rec_end
  , brand_name
  , buying_list_type_id
  , buying_list_type_desc
  , CAST ('WAWI' AS VARCHAR(10)) AS src
  FROM
  (
    SELECT /* NORMALIZE */
      client_id
    , item_sid
    , brand_name
    , buying_list_type_id
    , buying_list_type_desc
    , MIN(start_date)   AS dat_rec_start
    , MAX(end_date)     AS dat_rec_end
    FROM
    (
      SELECT
        client_id
      , item_sid
      , brand_name
      , buying_list_type_id
      , buying_list_type_desc
      , start_date
      , CASE WHEN end_date = DATE '9999-12-31'
             THEN end_date
             ELSE end_date -1
        END                         AS end_date
      , flag
      , SUM(flag) OVER (PARTITION BY client_id, item_sid, brand_name, buying_list_type_id ORDER BY start_date ROWS UNBOUNDED PRECEDING) AS groupid
      FROM
      (
        SELECT
          client_id
        , item_sid
        , brand_name
        , buying_list_type_id
        , dat_rec_start                 AS start_date
        , MAX(dat_rec_end)              AS end_date
        , (CASE WHEN start_date <= LAG(end_date) OVER (PARTITION BY client_id, item_sid, brand_name, buying_list_type_id ORDER BY start_date, end_date) THEN 0 ELSE 1 END) AS flag
        , MAX(buying_list_type_desc)    AS buying_list_type_desc
        FROM
        (
          SELECT
            wii1.client_id
          , wii1.item_sid
          , wii1.dat_rec_start
          , LEAD(wii1.dat_rec_start, 1, CASE WHEN wii1.dat_rec_end = DATE '9999-12-31' THEN wii1.dat_rec_end ELSE wii1.dat_rec_end +1 END) OVER (PARTITION BY wii1.client_id, wii1.item_sid ORDER BY wii1.dat_rec_start)  AS dat_rec_end
          , wii1.brand_name
          , wii1.buying_list_type_id
          , descr.buying_list_type_desc
          FROM P_LEW_CORE_AC.v_wawi_itm_item_2 wii1
            INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
              ON wii1.client_id = mig.client_id
            LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2 AS descr
              ON COALESCE (wii1.buying_list_type_id, -1) = descr.buying_list_type_id
             AND wii1.client_id                          = descr.language_id
          WHERE mig.migration_dat_valid_from = '9999-12-31'
        ) AS W11
        GROUP BY
          client_id
        , item_sid
        , brand_name
        , buying_list_type_id
        , start_date
      ) AS W111
      GROUP BY
        client_id
      , item_sid
      , brand_name
      , buying_list_type_id
      , buying_list_type_desc
      , start_date
      , end_date
      , flag
    ) AS wawi
    GROUP BY
      client_id
    , item_sid
    , brand_name
    , buying_list_type_id
    , buying_list_type_desc
    , groupid
  ) pure_wawi

    UNION ALL
    /* pre-elwis: Data from WAWI before country_2 switched to elwis */
  SELECT
    wii3.client_id
  , wii3.item_sid
  , wii3.dat_rec_start
  , LEAD(wii3.dat_rec_start -1, 1, CASE WHEN wii3.dat_rec_end > mig.migration_dat_valid_from THEN mig.migration_dat_valid_from ELSE wii3.dat_rec_end END) OVER (PARTITION BY wii3.client_id, wii3.item_sid ORDER BY wii3.dat_rec_start)
  , wii3.brand_name
  , wii3.buying_list_type_id
  , wii3.buying_list_type_desc
  , CAST ('pre_elwis' AS VARCHAR(10)) AS src
  FROM P_LEW_CORE_AC.v_wawi_itm_item_2 wii3
    INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
     ON wii3.client_id     = mig.client_id
    AND wii3.dat_rec_start < mig.migration_dat_valid_from
  WHERE mig.migration_dat_valid_from <> '9999-12-31'

    UNION ALL
    /* post-elwis: Data from WAWI after country_2 rolled back from elwis */
  SELECT
    wii3.client_id
  , wii3.item_sid
  , GREATEST(mig.migration_dat_valid_to+1,wii3.dat_rec_start)                                                                       AS dat_rec_start
  , LEAD(wii3.dat_rec_start -1, 1, wii3.dat_rec_end) OVER (PARTITION BY wii3.client_id, wii3.item_sid ORDER BY wii3.dat_rec_start)  AS dat_rec_end
  , wii3.brand_name
  , wii3.buying_list_type_id
  , wii3.buying_list_type_desc
  , CAST ('post_elwis' AS VARCHAR(10))                                                                                              AS src
  FROM P_LEW_CORE_AC.v_wawi_itm_item_2 wii3
    INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
     ON wii3.client_id   = mig.client_id
    AND wii3.dat_rec_end > mig.migration_dat_valid_to
  WHERE mig.migration_dat_valid_from <> '9999-12-31'

    UNION ALL
  SELECT
    dmy.client_id
  , dmy.item_sid
  , dmy.dat_rec_start
  , dmy.dat_rec_end
  , CAST('--' AS VARCHAR(2))    AS brand_name
  , -1                          AS buying_list_type_id
  , 'Dummy_2-Artikelart'          AS buying_list_type_desc
  , CAST ('WAWI' AS VARCHAR(4)) AS src
  FROM
  (
       /* Vorgaenger */
    SELECT
      client_id
    , item_sid
    , DATE '1900-01-01'       AS dat_rec_start
    , MIN(dat_rec_start) -1   AS dat_rec_end
    FROM P_LEW_CORE_AC.v_wawi_itm_item_2
    GROUP BY
      client_id
    , item_sid
    HAVING MIN(dat_rec_start) > DATE '1900-01-01'
      UNION ALL
      /* Nachfolger */
    SELECT
      client_id
    , item_sid
    , MAX(dat_rec_end) +1    AS dat_rec_start
    , DATE '9999-12-31'      AS dat_rec_end
    FROM P_LEW_CORE_AC.v_wawi_itm_item_2
    GROUP BY
      client_id
    , item_sid
    HAVING MAX(dat_rec_end) < DATE '9999-12-31'
  ) dmy
     /* only WAWI countries */
   INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
    ON dmy.client_id = mig.client_id
  WHERE dmy.dat_rec_start NOT BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
    AND CURRENT_DATE      NOT BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to

     /* eLwis countries */
    UNION ALL
  SELECT
    elw.client_id
  , elw.item_sid
  , GREATEST (elw.dat_rec_start, mig.migration_dat_valid_from)   AS dat_rec_start
  , elw.dat_rec_end
  , elw.brand_name
  , elw.buying_list_type_id
  , elw.buying_list_type_desc
  , CAST ('ELW' AS VARCHAR(4)) AS src
  FROM
  (
    SELECT
      client_id
    , item_sid
    , dat_rec_start
    , LEAD (dat_rec_start -1, 1, DATE '9999-12-31') OVER (PARTITION BY client_id, item_sid ORDER BY dat_rec_start) AS dat_rec_end
    , CASE
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) = 'A'   THEN  8 /* Aktionsartikel EM              */
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) = 'A'   THEN  7 /* Aktionsartikel M               */
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) = 'S'   THEN  2 /* Normalsortiment EM             */
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) = 'S'   THEN  1 /* Normalsortiment M              */
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) IS NULL THEN -2 /* EM ohne Listungsart            */
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) IS NULL THEN -3 /* M ohne Listungsart             */
           WHEN MAX(brand_type_mark) IS NULL AND MAX(list_type) = 'A'   THEN -4 /* Aktionsartikel ohne Markenart  */
           WHEN MAX(brand_type_mark) IS NULL AND MAX(list_type) = 'S'   THEN -5 /* Normalsortiment ohne Markenart */
           ELSE                                                              -1 /* Dummy_2-Artikelart               */
      END                          AS buying_list_type_id
    , CASE
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) = 'A'   THEN 'Aktionsartikel EM'
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) = 'A'   THEN 'Aktionsartikel M'
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) = 'S'   THEN 'Normalsortiment EM'
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) = 'S'   THEN 'Normalsortiment M'
           WHEN MAX(brand_type_mark) = 'EM'  AND MAX(list_type) IS NULL THEN 'EM ohne Listungsart'
           WHEN MAX(brand_type_mark) = 'M'   AND MAX(list_type) IS NULL THEN 'M ohne Listungsart'
           WHEN MAX(brand_type_mark) IS NULL AND MAX(list_type) = 'A'   THEN 'Aktionsartikel ohne Markenart'
           WHEN MAX(brand_type_mark) IS NULL AND MAX(list_type) = 'S'   THEN 'Normalsortiment ohne Markenart'
           ELSE                                                              'Dummy_2-Artikelart'
      END                          AS buying_list_type_desc
    , MAX(brand_descr)             AS brand_name
    FROM
    (
      SELECT
        COALESCE (ibr.client_id, ilt.client_id) AS client_id
      , COALESCE (ibr.item_sid, ilt.item_sid)   AS item_sid
      , GREATEST (COALESCE (ibr.dat_rec_start, ilt.dat_rec_start), COALESCE(ilt.dat_rec_start, ibr.dat_rec_start)) AS dat_rec_start
      , ibr.brand_type_mark
      , ilt.list_type
      , ibr.brand_descr
      FROM
      (
        SELECT /* NORMALIZE */
          client_id
        , item_sid
        , brand_type_mark
        , brand_descr
        , MIN(start_date)   AS dat_rec_start
        , MAX(end_date)     AS dat_rec_end
        FROM
        (
          SELECT
            client_id
          , item_sid
          , brand_type_mark
          , brand_descr
          , start_date
          , end_date
          , flag
          , SUM(flag) OVER (PARTITION BY client_id, item_sid, brand_type_mark, brand_descr ORDER BY start_date ROWS UNBOUNDED PRECEDING) AS groupid
          FROM
          (
            SELECT
              client_id
            , item_sid
            , brand_type_mark
            , brand_descr
            , dwh_valid_from          AS start_date
            , MAX(dwh_valid_to)       AS end_date
            , (CASE WHEN start_date <= LAG(end_date) OVER (PARTITION BY client_id, item_sid, brand_type_mark, brand_descr ORDER BY start_date, end_date) THEN 0 ELSE 1 END) AS flag
            FROM
            (
              SELECT
                client_id
              , item_sid
              , brand_type_mark
              , brand_descr
              , dwh_valid_from
              , LEAD (dwh_valid_from, 1, DATE '9999-12-31') OVER (PARTITION BY client_id, item_sid ORDER BY dwh_valid_from) AS dwh_valid_to
              FROM
              (
                SELECT
                  a.client_id
                , a.item_sid
                , a.brand_type_mark  AS brand_type_mark
                , a.dwh_valid_from
                , d.brand_descr
                , COUNT(*)           AS conti
                , MAX(a.dwh_updated) AS last_upd
                FROM P_LEW_CORE_AC.v_item_location_brand_hist_2 AS a
                  INNER JOIN P_LEW_CORE_AC.v_location_2 AS b
                    ON b.loc_sid            = a.loc_sid
                   AND b.wh_store_mark      = 'A'
                   AND b.global_loc_type_cd = '0'
                  INNER JOIN P_LEW_CORE_AC.v_location_hist_2 AS c
                    ON c.loc_sid=b.loc_sid
                   /* removed in version 1.2 */
                   /*AND c.demand_plan_active_fg = 1*/
                   AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
                   AND c.deleted_fg = 0
                  LEFT OUTER JOIN P_LEW_CORE_AC.v_client_2 AS cli
                    ON cli.client_id = a.client_id
                  LEFT OUTER JOIN P_LEW_CORE_AC.v_country_2 AS ctry
                    ON cli.country_sid = ctry.country_sid
                  LEFT OUTER JOIN P_LEW_CORE_AC.v_brand_descr_2 AS d
                    ON d.client_id = a.client_id
                   AND d.brand_sid = a.brand_sid
                   AND d.lang_sid  = ctry.lang_sid
                GROUP BY
                   a.client_id
                  ,a.item_sid
                  ,a.brand_type_mark
                  ,a.dwh_valid_from
                  ,d.brand_descr
                QUALIFY ROW_NUMBER() OVER (PARTITION BY a.client_id, a.item_sid, a.dwh_valid_from ORDER BY last_upd DESC, conti DESC, a.brand_type_mark NULLS LAST, d.brand_descr NULLS LAST) = 1
              ) AS X1
            ) AS X11
            GROUP BY
              client_id
            , item_sid
            , brand_type_mark
            , brand_descr
            , start_date
          ) AS X111
          GROUP BY
            client_id
          , item_sid
          , brand_type_mark
          , brand_descr
          , start_date
          , end_date
          , flag
        ) AS X1111
        GROUP BY
          client_id
        , item_sid
        , brand_type_mark
        , brand_descr
        , groupid
      ) ibr
         FULL OUTER JOIN
      (
        SELECT /* NORMALIZE */
          client_id
        , item_sid
        , list_type
        , MIN(start_date)   AS dat_rec_start
        , MAX(end_date)     AS dat_rec_end
        FROM
        (
          SELECT
            client_id
          , item_sid
          , list_type
          , start_date
          , end_date
          , flag
          , SUM(flag) OVER (PARTITION BY client_id, item_sid, list_type ORDER BY start_date ROWS UNBOUNDED PRECEDING) AS groupid
          FROM
          (
            SELECT
              client_id
            , item_sid
            , list_type
            , dwh_valid_from          AS start_date
            , MAX(dwh_valid_to)       AS end_date
            , (CASE WHEN start_date <= LAG(end_date) OVER (PARTITION BY client_id, item_sid, list_type ORDER BY start_date, end_date) THEN 0 ELSE 1 END) AS flag
            FROM
            (
              SELECT
                client_id
              , item_sid
              , list_type
              , dwh_valid_from
              , LEAD (dwh_valid_from, 1, DATE '9999-12-31') OVER (PARTITION BY client_id, item_sid ORDER BY dwh_valid_from) AS dwh_valid_to
              FROM
              (
                SELECT
                  a.client_id
                , a.item_sid
                , COALESCE(a.list_type_mark,'-') AS list_type
                , a.dwh_valid_from
                , COUNT(*)                       AS conti
                , MAX(a.dwh_updated)             AS last_upd
                FROM P_LEW_CORE_AC.v_item_listing_type_hist_2 AS a
                  INNER JOIN P_LEW_CORE_AC.v_location_2 AS b
                   ON b.loc_sid            = a.loc_sid
                  AND b.wh_store_mark      = 'A'
                  AND b.global_loc_type_cd = '0'
                  INNER JOIN P_LEW_CORE_AC.v_location_hist_2 AS c
                   ON c.loc_sid=b.loc_sid
                   /* removed in version 1.2 */
                  /*AND c.demand_plan_active_fg = 1*/
                  AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
                  AND c.deleted_fg = 0
                GROUP BY
                  a.client_id
                , a.item_sid
                , a.list_type_mark
                , a.dwh_valid_from
                QUALIFY ROW_NUMBER() OVER (PARTITION BY a.client_id, a.item_sid, a.dwh_valid_from ORDER BY last_upd DESC, conti DESC, a.list_type_mark NULLS LAST) = 1
              ) AS Y1
            ) AS Y11
            GROUP BY
              client_id
            , item_sid
            , list_type
            , start_date
          ) AS Y111
          GROUP BY
            client_id
          , item_sid
          , list_type
          , start_date
          , end_date
          , flag
        ) AS Y1111
        GROUP BY
          client_id
        , item_sid
        , list_type
        , groupid
      ) ilt
        ON ibr.client_id = ilt.client_Id
       AND ibr.item_sid  = ilt.item_sid
       /* On Teradata we used OVERLAPS: AND ibr.brand_type_validity OVERLAPS ilt.list_type_validity */
       AND (  
               (ibr.dat_rec_start > ilt.dat_rec_start AND NOT (ibr.dat_rec_start >= ilt.dat_rec_end AND ibr.dat_rec_end >= ilt.dat_rec_end))
            OR (ilt.dat_rec_start > ibr.dat_rec_start AND NOT (ilt.dat_rec_start >= ibr.dat_rec_end AND ilt.dat_rec_end >= ibr.dat_rec_end))
            OR (ibr.dat_rec_start = ilt.dat_rec_start AND     (ibr.dat_rec_end    = ilt.dat_rec_end OR  ibr.dat_rec_end <> ilt.dat_rec_end))
           )
    ) tmp
    GROUP BY
      client_id
    , item_sid
    , dat_rec_start

  ) elw
   INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
    ON elw.client_id = mig.client_id
   AND (   /* similar logic AS OVERLAPS */
            (elw.dat_rec_start > mig.migration_dat_valid_from AND NOT (elw.dat_rec_start >= mig.migration_dat_valid_to AND elw.dat_rec_end >= mig.migration_dat_valid_to))
         OR (mig.migration_dat_valid_from > elw.dat_rec_start AND NOT (mig.migration_dat_valid_from >= elw.dat_rec_end AND mig.migration_dat_valid_to >= elw.dat_rec_end))
         OR (elw.dat_rec_start = mig.migration_dat_valid_from AND     (elw.dat_rec_end    = mig.migration_dat_valid_to OR  elw.dat_rec_end <> mig.migration_dat_valid_to))
       )

) AS itm
   ON imaster.client_id = itm.client_id
  AND imaster.item_id   = itm.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2 AS reflist
  ON COALESCE(itm.buying_list_type_id, -1) = reflist.buying_list_type_id
 AND itm.client_id                         = reflist.language_id
;
