/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.v_itm_item_list_type_hist_1
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_item_list_type_hist_1 (client_id OPTIONS(description='Landeskennzeichen'),
item_id OPTIONS(description='Artikelnummer'), dat_rec_start OPTIONS(description='Gültigkeitsdatum von'), dat_rec_end
OPTIONS(description='Gültigkeitsdatum bis'), brand_name OPTIONS(description='The name of the brand.'),
buying_list_type_id OPTIONS(description='Einkauf Listungstyp'), buying_list_type_desc
OPTIONS(description='Bezeichnung der Art_1 des Artikels ( Saison, ... )'), listing_type_id
OPTIONS(description='the type of listing article'), brand_type_id OPTIONS(description='the type of brand_1 of an article'),
buying_list_type_group_id OPTIONS(description='Gruppe_1 der Art_1 des Artikels ( Saison, ... )'), listing_type_group_id
OPTIONS(description='Guppe Einlistungstype Id'), brand_type_group_id OPTIONS(description='Guppen Markenart ID'), src
OPTIONS(description='Where does the row come from: WAWI, ELW=eLWIS, pre/post_elwis=from WAWI before/after switching to/from eLWIS'))
OPTIONS(DESCRIPTION = `HISTORY OF BUYING_LIST_TYPE_ID, BRAND_TYPE_ID AND LISTING_TYPE_ID PER ITEM_1`) AS SELECT IMASTER.client_id
 ,
 IMASTER.item_id,
  CASE
  WHEN itm.client_id IS NULL
  THEN DATE '1900-01-01'
  ELSE itm.dat_rec_start
  END AS dat_rec_start,
  CASE
  WHEN itm.client_id IS NULL
  THEN DATE '9999-12-31'
  ELSE LEAD(DATE_SUB(itm.dat_rec_start, INTERVAL 1 DAY), 1, DATE '9999-12-31') OVER (PARTITION BY CAST(IMASTER.client_id AS STRING)
     , IMASTER.item_id ORDER BY itm.dat_rec_start IS NULL, itm.dat_rec_start)
  END AS dat_rec_end,
 COALESCE(itm.brand_name, '--') AS brand_name,
 COALESCE(itm.buying_list_type_id, - 1) AS buying_list_type_id,
 COALESCE(REFLIST.buying_list_type_desc, itm.buying_list_type_desc, 'Dummy_1-Artikelart') AS buying_list_type_desc,
 COALESCE(REFLIST.listing_type_id, - 1) AS listing_type_id,
 COALESCE(REFLIST.brand_type_id, - 1) AS brand_type_id,
 COALESCE(REFLIST.buying_list_type_group_id, - 1) AS buying_list_type_group_id,
 COALESCE(REFLIST.listing_type_group_id, - 1) AS listing_type_group_id,
 COALESCE(REFLIST.brand_type_group_id, - 1) AS brand_type_group_id,
 itm.src
FROM ldl_p_lew_mart_lead.v_itm_item_1 AS IMASTER
 LEFT JOIN (SELECT client_id,
    item_sid,
    MIN(start_date) AS dat_rec_start,
    MAX(end_date) AS dat_rec_end,
    brand_name,
    buying_list_type_id,
    buying_list_type_desc,
    'WAWI' AS src
   FROM (SELECT client_id,
      item_sid,
      brand_name,
      buying_list_type_id,
      buying_list_type_desc,
      SUM(flag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), brand_name, CAST(buying_list_type_id AS STRING)
         ORDER BY start_date IS NULL, start_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
      start_date,
       CASE
       WHEN end_date = DATE '9999-12-31'
       THEN end_date
       ELSE DATE_SUB(end_date, INTERVAL 1 DAY)
       END AS end_date
     FROM (SELECT client_id,
        item_sid,
        brand_name,
        buying_list_type_id,
        MAX(buying_list_type_desc) AS buying_list_type_desc,
        start_date,
        MAX(dat_rec_end) AS end_date,
         CASE
         WHEN start_date <= (LAG(MAX(dat_rec_end)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
              , brand_name, CAST(buying_list_type_id AS STRING) ORDER BY start_date IS NULL, start_date, MAX(dat_rec_end
               ) IS NULL, MAX(dat_rec_end)))
         THEN 0
         ELSE 1
         END AS flag
       FROM (SELECT WII1.client_id,
          WII1.item_sid,
          WII1.brand_name,
          WII1.buying_list_type_id,
          WII1.dat_rec_start AS start_date,
          LEAD(WII1.dat_rec_start, 1, CASE
            WHEN WII1.dat_rec_end = DATE '9999-12-31'
            THEN WII1.dat_rec_end
            ELSE DATE_ADD(WII1.dat_rec_end, INTERVAL 1 DAY)
            END) OVER (PARTITION BY CAST(WII1.client_id AS STRING), CAST(WII1.item_sid AS STRING) ORDER BY WII1.dat_rec_start
             IS NULL, WII1.dat_rec_start) AS dat_rec_end,
          DESCR.buying_list_type_desc
         FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS WII1
          INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON WII1.client_id = MIG.client_id
          LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS DESCR ON COALESCE(WII1.buying_list_type_id, - 1) =
            DESCR.buying_list_type_id AND WII1.client_id = DESCR.language_id
         WHERE MIG.migration_dat_valid_from = DATE '9999-12-31') AS W11
       GROUP BY client_id,
        item_sid,
        brand_name,
        buying_list_type_id,
        start_date) AS t3) AS wawi
   GROUP BY client_id,
    item_sid,
    brand_name,
    buying_list_type_id,
    buying_list_type_desc,
    groupid
   UNION ALL
   SELECT WII3.client_id,
    WII3.item_sid,
    WII3.dat_rec_start,
    LEAD(DATE_SUB(WII3.dat_rec_start, INTERVAL 1 DAY), 1, CASE
      WHEN WII3.dat_rec_end > MIG.migration_dat_valid_from
      THEN MIG.migration_dat_valid_from
      ELSE WII3.dat_rec_end
      END) OVER (PARTITION BY CAST(WII3.client_id AS STRING), CAST(WII3.item_sid AS STRING) ORDER BY WII3.dat_rec_start
       IS NULL, WII3.dat_rec_start) AS
    wii3_dat_rec_start_wii3_dat_rec_end_mig_migration_dat_valid_from_mig_migration_dat_valid_from_wii3_dat_rec_end_wii3_client_id_wii3_item_sid_wii3_dat_rec_start
    ,
    WII3.brand_name,
    WII3.buying_list_type_id,
    WII3.buying_list_type_desc,
    'pre_elwis' AS src
   FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS WII3
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON WII3.client_id = MIG.client_id AND WII3.dat_rec_start
      < MIG.migration_dat_valid_from
   WHERE MIG.migration_dat_valid_from <> DATE '9999-12-31'
   UNION ALL
   SELECT WII3.client_id,
    WII3.item_sid,
    GREATEST(DATE_ADD(MIG.migration_dat_valid_to, INTERVAL 1 DAY), WII3.dat_rec_start) AS dat_rec_start,
    LEAD(DATE_SUB(WII3.dat_rec_start, INTERVAL 1 DAY), 1, WII3.dat_rec_end) OVER (PARTITION BY CAST(WII3.client_id AS STRING)
       , CAST(WII3.item_sid AS STRING) ORDER BY WII3.dat_rec_start IS NULL, WII3.dat_rec_start) AS dat_rec_end,
    WII3.brand_name,
    WII3.buying_list_type_id,
    WII3.buying_list_type_desc,
    'post_elwis' AS src
   FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS WII3
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON WII3.client_id = MIG.client_id AND WII3.dat_rec_end >
      MIG.migration_dat_valid_to
   WHERE MIG.migration_dat_valid_from <> DATE '9999-12-31'
   UNION ALL
   SELECT dmy.client_id,
    dmy.item_sid,
    dmy.dat_rec_start,
    dmy.dat_rec_end,
    '--' AS brand_name,
    - 1 AS buying_list_type_id,
    'Dummy_1-Artikelart' AS buying_list_type_desc,
    'WAWI' AS src
   FROM (SELECT client_id,
       item_sid,
       DATE '1900-01-01' AS dat_rec_start,
       DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY) AS dat_rec_end
      FROM ldl_p_lew_core_ac.v_wawi_itm_item_1
      GROUP BY client_id,
       item_sid
      HAVING MIN(dat_rec_start) > DATE '1900-01-01'
      UNION ALL
      SELECT client_id,
       item_sid,
       DATE_ADD(MAX(dat_rec_end), INTERVAL 1 DAY) AS dat_rec_start,
       DATE '9999-12-31' AS dat_rec_end
      FROM ldl_p_lew_core_ac.v_wawi_itm_item_1
      GROUP BY client_id,
       item_sid
      HAVING MAX(dat_rec_end) < DATE '9999-12-31') AS dmy
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON dmy.client_id = MIG.client_id
   WHERE dmy.dat_rec_start NOT BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
    AND CURRENT_DATE NOT BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
   UNION ALL
   SELECT elw.client_id,
    elw.item_sid,
    GREATEST(elw.dat_rec_start, MIG.migration_dat_valid_from) AS dat_rec_start,
    elw.dat_rec_end,
    elw.brand_name,
    elw.buying_list_type_id,
    elw.buying_list_type_desc,
    'ELW' AS src
   FROM (SELECT client_id,
      item_sid,
      dat_rec_start,
      LEAD(DATE_SUB(dat_rec_start, INTERVAL 1 DAY), 1, DATE '9999-12-31') OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
         ORDER BY dat_rec_start IS NULL, dat_rec_start) AS dat_rec_end,
       CASE
       WHEN a0 = 'EM' AND a0_0 = 'A'
       THEN 8
       WHEN a0 = 'M' AND a0_0 = 'A'
       THEN 7
       WHEN a0 = 'EM' AND a0_0 = 'S'
       THEN 2
       WHEN a0 = 'M' AND a0_0 = 'S'
       THEN 1
       WHEN a0 = 'EM' AND a0_0 IS NULL
       THEN - 2
       WHEN a0 = 'M' AND a0_0 IS NULL
       THEN - 3
       WHEN a0 IS NULL AND a0_0 = 'A'
       THEN - 4
       WHEN a0 IS NULL AND a0_0 = 'S'
       THEN - 5
       ELSE - 1
       END AS buying_list_type_id,
       CASE
       WHEN a0 = 'EM' AND a0_0 = 'A'
       THEN 'Aktionsartikel EM'
       WHEN a0 = 'M' AND a0_0 = 'A'
       THEN 'Aktionsartikel M'
       WHEN a0 = 'EM' AND a0_0 = 'S'
       THEN 'Normalsortiment EM'
       WHEN a0 = 'M' AND a0_0 = 'S'
       THEN 'Normalsortiment M'
       WHEN a0 = 'EM' AND a0_0 IS NULL
       THEN 'EM ohne Listungsart'
       WHEN a0 = 'M' AND a0_0 IS NULL
       THEN 'M ohne Listungsart'
       WHEN a0 IS NULL AND a0_0 = 'A'
       THEN 'Aktionsartikel ohne Markenart'
       WHEN a0 IS NULL AND a0_0 = 'S'
       THEN 'Normalsortiment ohne Markenart'
       ELSE 'Dummy_1-Artikelart'
       END AS buying_list_type_desc,
      brand_name
     FROM (SELECT COALESCE(ibr.client_id, ilt.client_id) AS client_id,
        COALESCE(ibr.item_sid, ilt.item_sid) AS item_sid,
        GREATEST(COALESCE(ibr.dat_rec_start, ilt.dat_rec_start), COALESCE(ilt.dat_rec_start, ibr.dat_rec_start)) AS
        dat_rec_start,
        MAX(ibr.brand_type_mark) AS a0,
        MAX(ilt.list_type) AS a0_0,
        MAX(ibr.brand_descr) AS brand_name
       FROM (SELECT client_id,
          item_sid,
          brand_type_mark,
          brand_descr,
          MIN(start_date) AS dat_rec_start,
          MAX(end_date) AS dat_rec_end
         FROM (SELECT client_id,
            item_sid,
            brand_type_mark,
            brand_descr,
            SUM(flag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), brand_type_mark,
               brand_descr ORDER BY start_date IS NULL, start_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
            groupid,
            start_date,
            end_date
           FROM (SELECT client_id,
              item_sid,
              brand_type_mark,
              brand_descr,
              start_date,
              MAX(dwh_valid_to) AS end_date,
               CASE
               WHEN start_date <= (LAG(MAX(dwh_valid_to)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
                    , brand_type_mark, brand_descr ORDER BY start_date IS NULL, start_date, MAX(dwh_valid_to) IS NULL,
                    MAX(dwh_valid_to)))
               THEN 0
               ELSE 1
               END AS flag
             FROM (SELECT t22.client_id,
                t22.item_sid,
                t22.brand_type_mark0 AS brand_type_mark,
                t22.brand_descr,
                t22.dwh_valid_from AS start_date,
                LEAD(t22.dwh_valid_from, 1, DATE '9999-12-31') OVER (PARTITION BY CAST(t22.client_id AS STRING), CAST(t22.item_sid AS STRING)
                   ORDER BY t22.dwh_valid_from IS NULL, t22.dwh_valid_from) AS dwh_valid_to
               FROM (SELECT A.client_id,
                  A.item_sid,
                  A.brand_type_mark AS brand_type_mark0,
                  A.dwh_valid_from,
                  D.brand_descr,
                  COUNT(*) AS conti,
                  MAX(A.dwh_updated) AS last_upd,
                  A.brand_type_mark
                 FROM ldl_p_lew_core_ac.v_item_location_brand_hist_1 AS A
                  INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B ON A.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B
                    .global_loc_type_cd = '0'
                  INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C ON B.loc_sid = C.loc_sid AND CURRENT_DATE BETWEEN C
                     .dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
                  LEFT JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON A.client_id = CLI.client_id
                  LEFT JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON CLI.country_sid = CTRY.country_sid
                  LEFT JOIN ldl_p_lew_core_ac.v_brand_descr_1 AS D ON A.client_id = D.client_id AND A.brand_sid = D.brand_sid
                      AND CTRY.lang_sid = D.lang_sid
                 GROUP BY A.client_id,
                  A.item_sid,
                  A.brand_type_mark,
                  A.dwh_valid_from,
                  D.brand_descr
                 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.item_sid AS STRING), A.dwh_valid_from
                       ORDER BY last_upd IS NULL DESC, last_upd DESC, conti IS NULL DESC, conti DESC, A.brand_type_mark
                       IS NULL, A.brand_type_mark, D.brand_descr IS NULL, D.brand_descr)) = 1) AS t22) AS X11
             GROUP BY client_id,
              item_sid,
              brand_type_mark,
              brand_descr,
              start_date) AS t26) AS X1111
         GROUP BY client_id,
          item_sid,
          brand_type_mark,
          brand_descr,
          groupid) AS ibr
        FULL JOIN (SELECT client_id,
          item_sid,
          list_type,
          MIN(start_date) AS dat_rec_start,
          MAX(end_date) AS dat_rec_end
         FROM (SELECT client_id,
            item_sid,
            list_type,
            SUM(flag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), list_type ORDER BY
               start_date IS NULL, start_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
            start_date,
            end_date
           FROM (SELECT client_id,
              item_sid,
              list_type,
              start_date,
              MAX(dwh_valid_to) AS end_date,
               CASE
               WHEN start_date <= (LAG(MAX(dwh_valid_to)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
                    , list_type ORDER BY start_date IS NULL, start_date, MAX(dwh_valid_to) IS NULL, MAX(dwh_valid_to)))
               THEN 0
               ELSE 1
               END AS flag
             FROM (SELECT t32.client_id,
                t32.item_sid,
                t32.list_type,
                t32.dwh_valid_from AS start_date,
                LEAD(t32.dwh_valid_from, 1, DATE '9999-12-31') OVER (PARTITION BY CAST(t32.client_id AS STRING), CAST(t32.item_sid AS STRING)
                   ORDER BY t32.dwh_valid_from IS NULL, t32.dwh_valid_from) AS dwh_valid_to
               FROM (SELECT A0.client_id,
                  A0.item_sid,
                  COALESCE(A0.list_type_mark, '-') AS list_type,
                  A0.dwh_valid_from,
                  COUNT(*) AS conti,
                  MAX(A0.dwh_updated) AS last_upd,
                  A0.list_type_mark
                 FROM ldl_p_lew_core_ac.v_item_listing_type_hist_1 AS A0
                  INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B0 ON A0.loc_sid = B0.loc_sid AND B0.wh_store_mark = 'A'
                   AND B0.global_loc_type_cd = '0'
                  INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C0 ON B0.loc_sid = C0.loc_sid AND CURRENT_DATE BETWEEN
                     C0.dwh_valid_from AND C0.dwh_valid_to AND C0.deleted_fg = 0
                 GROUP BY A0.client_id,
                  A0.item_sid,
                  A0.list_type_mark,
                  A0.dwh_valid_from
                 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A0.client_id AS STRING), CAST(A0.item_sid AS STRING), A0
                       .dwh_valid_from ORDER BY last_upd IS NULL DESC, last_upd DESC, conti IS NULL DESC, conti DESC, A0
                       .list_type_mark IS NULL, A0.list_type_mark)) = 1) AS t32) AS Y11
             GROUP BY client_id,
              item_sid,
              list_type,
              start_date) AS t36) AS Y1111
         GROUP BY client_id,
          item_sid,
          list_type,
          groupid) AS ilt ON ibr.client_id = ilt.client_id AND ibr.item_sid = ilt.item_sid AND (ibr.dat_rec_start > ilt
              .dat_rec_start AND (ibr.dat_rec_start < ilt.dat_rec_end OR ibr.dat_rec_end < ilt.dat_rec_end) OR ibr.dat_rec_start
               < ilt.dat_rec_start AND (ibr.dat_rec_end > ilt.dat_rec_start OR ibr.dat_rec_end > ilt.dat_rec_end) OR ibr
             .dat_rec_start = ilt.dat_rec_start AND (ibr.dat_rec_end = ilt.dat_rec_end OR ibr.dat_rec_end <> ilt.dat_rec_end
               ))
       GROUP BY client_id,
        item_sid,
        dat_rec_start) AS t41) AS elw
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON elw.client_id = MIG.client_id AND (elw.dat_rec_start >
          MIG.migration_dat_valid_from AND (elw.dat_rec_start < MIG.migration_dat_valid_to OR elw.dat_rec_end < MIG.migration_dat_valid_to
            ) OR elw.dat_rec_start < MIG.migration_dat_valid_from AND (elw.dat_rec_end > MIG.migration_dat_valid_from OR
            elw.dat_rec_end > MIG.migration_dat_valid_to) OR elw.dat_rec_start = MIG.migration_dat_valid_from AND (elw.dat_rec_end
            = MIG.migration_dat_valid_to OR elw.dat_rec_end <> MIG.migration_dat_valid_to))) AS itm ON IMASTER.client_id
    = itm.client_id AND IMASTER.item_id = itm.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS REFLIST ON COALESCE(itm.buying_list_type_id, - 1) = REFLIST.buying_list_type_id
    AND itm.client_id = REFLIST.language_id;