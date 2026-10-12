/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  19.09.2022    Bachmann, Torsten       Initial Version: Historization of Dispo Data (t_replenish_order_wh_record_pos) on daily basis.
#  1.1  26.09.2022    Bachmann, Torsten       CURSOR part simplified
#  1.2  28.09.2022    Bachmann, Torsten       Adjusted logic for init values
#  1.3  19.10.2022    Bachmann, Torsten       sup_sid added to _act table, several adjustments to the logic
#  1.4  17.11.2022    Bachmann, Torsten       Logic to get initial order_qty changed
#  1.5  18.01.2023    Bachmann, Torsten       Historisation of init row (order_pos_version_nr = 0) corrected, different other corrections, dwh_cal_dt added
#  1.6  13.02.2023    Bachmann, Torsten       Fix calculation of cnt_days_delayed
#  1.7  01.03.2023    Bachmann, Torsten       added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG
#  1.8  04.03.2026    Bachmann, Torsten       Adjust logic which rows needs to be logically deleted (deleted_fg=1)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_LOAD_DISPO_POS_HIST(start_dt DATE)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS CALLER  /* because we want TO CHANGE SESSION parameters */
AS
'
DECLARE
  tt_tmsp TIMESTAMP_LTZ;
  dwh_valid_from DATE;
  cur_tmsp TIMESTAMP_LTZ;
  run_id INTEGER DEFAULT 0;
  step_id INTEGER DEFAULT 0;
  alter_stmt VARCHAR(2000);
  hist_dt DATE;
  /* Get information for which dates we have to run historization */
  /* Idea is that we use timetravel to get the status of replenish_order_wh_record_pos table as of 7 o`clock for each day in the past (last ELT job runs at 6:30) */
  /* Furthermore we consider that dwh_valid_from is then the day before */
  /* e.g. on 13.09.22 at 7:00 the table should contain data which was loaded during the night, which means it contains data as of 12.09.22 (=dwh_valid_from) */
  cursor1 CURSOR FOR SELECT dateadd(HOUR, 7, c.cal_dt+1) AS timetravel_tmsp, c.cal_dt AS dwh_valid_from, c.cy_day_seq
                     FROM p_lew_core.t_cal_calendarday c
                     WHERE c.cal_dt <= current_date
                       AND c.cy_day_seq < 1
                       AND c.cal_dt > COALESCE ((SELECT max(dwh_valid_from) max_dwh_valid_from
                                                 FROM P_LEW_MART_LEAD.t_dispo_pos_act), ''2020-03-01'' )
                          /* Timetravel Timestamp can only be max retention_time in the past or 21 days in the past (we start with 21 days), depending what is closer to today */
                          /* If start_dt was provided (e.g. for init), we will use that date as long as it is not past retention_time */
                       AND dateadd(HOUR, 7, c.cal_dt+1) >= (SELECT GREATEST (t.created, DATEADD (DAY, -LEAST(t.retention_time, COALESCE (current_date - tmp.start_dt, 21)), current_timestamp))
                                                            FROM information_schema.TABLES t,
                                                                 p_lew_tmp.tmp_dispo_proc tmp
                                                            WHERE t.table_name = ''T_REPLENISH_ORDER_WH_RECORD_POS''
                                                              AND t.table_schema = ''P_LEW_CORE''
                                                           )
                     ORDER BY 1
                     ;
   // get the current Query_TAG and add more information for each step later on
  param_key VARCHAR(2000);
  current_qt VARCHAR(2000);
  static_qt VARIANT;
  new_qt VARIANT;
  qt_res resultset DEFAULT (SHOW PARAMETERS LIKE ''query_tag'');
  qt_cur CURSOR FOR qt_res;
  cur_wh VARCHAR(200);
  new_wh VARCHAR(200);
  sql_stmt VARCHAR(2000);
BEGIN
  OPEN qt_cur;
  FETCH qt_cur INTO param_key, current_qt;
  CLOSE qt_cur;
  static_qt := ''CurQT='' || current_qt || '';Job=Prep_Lieftreu_Dashboard;JobDesc=Prepare Dispo Data for Liefertreue Dashboard;'';
  IF (TRY_PARSE_JSON(:current_qt) IS NULL ) THEN
    static_qt := TO_OBJECT(PARSE_JSON(''{
   "Current_QueryTag" : "'' || :current_qt || ''",
   "Job" : "Prep_Lieftreu_Dashboard",
   "JobDesc" : "Prepare Dispo Data for Liefertreue Dashboard"
}''));
  ELSE
    static_qt := OBJECT_INSERT (OBJECT_INSERT (to_object (parse_json(:current_qt)), ''Job'', ''Prep_Lieftreu_Dashboard'', TRUE), ''JobDesc'' ,''Prepare Dispo Data for Liefertreue Dashboard'', TRUE);
  END IF;
  /* Store start_dt */
  CREATE OR REPLACE TEMPORARY TABLE p_lew_tmp.tmp_dispo_proc AS SELECT :start_dt AS start_dt;

  FOR tt IN cursor1 DO
    tt_tmsp := tt.timetravel_tmsp;
    dwh_valid_from := tt.dwh_valid_from;
    cur_tmsp := current_timestamp();
    run_id := COALESCE(:run_id,0) +1;
    /* Test */
    /*tt_tmsp := ''2022-09-15 08:00:00'';
    dwh_valid_from := ''2022-09-14''::date;*/

    new_qt := OBJECT_INSERT (:static_qt, ''run_id'', :run_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''timetravel_val'', :tt_tmsp::varchar, TRUE);
    step_id := 1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Load data from CORE into _l01 table'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                      
    EXECUTE IMMEDIATE alter_stmt;
    IF (tt.cy_day_seq < 0) THEN
      /* if we missed some historic data, we use timetravel to get this data */
      CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l01
      AS
      SELECT
        CLIENT_ID
      , LOC_SID
      , ORDER_RECORD_ID
      , ITEM_SID
      , ORDER_POS_VERSION_NR
      , CAST(:tt_tmsp AS DATE) -1 AS DWH_VALID_FROM
      , ORDER_POS_CREATED_TMSP
      , ORDER_POS_UPDATED_TMSP
      , DELIVERY_DT
      , DELIVERY_TMSP
      , ORDER_STATUS_CD
      , PART_FG
      , ORDER_QTY_TYPE_CD
      , ORDER_QTY
      , ORDER_REMAIN_QTY AS ORDER_DELIVERED_CASE_QTY
      , CASE_FACTOR
      , REAL_CASE_SIZE
      , DWH_CAL_DT
      , DWH_LOAD_ID
      , DWH_CREATED
      , DWH_UPDATED
      , CASE WHEN dwh_created = MIN(dwh_created) OVER (PARTITION BY client_id, loc_sid) /* consider init data as not deleted */
             THEN 0
             WHEN CAST(dwh_updated AS date) - CAST (dwh_created AS date) >= 180   /* data which has been update 180 days after creation is probably also not deleted */
             THEN 0
             WHEN CAST(dwh_updated AS date) - CAST (dwh_created AS date) < 180    /* data which has been recently/today updatedis ofc actual */
              AND CAST (dwh_updated AS date) = MAX(CAST (dwh_updated AS date)) OVER (PARTITION BY client_id, loc_sid)
             THEN 0
             WHEN CAST(:dwh_valid_from AS DATE) - dwh_cal_dt >= 183               /* data which is out of export scope (183 days) cannot be checked and should be considered as not deleted */
             THEN -1
             ELSE 1                                                               /* data which has not been updated for 180 days is probably not actual any more */
        END AS deleted_fg
      FROM P_LEW_CORE.T_REPLENISH_ORDER_WH_RECORD_POS AT (timestamp=>:tt_tmsp::timestamp)
      ;
    ELSE
      /* The usual way is to just get the current status/data of the table */
      CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l01
      AS
      SELECT
        CLIENT_ID
      , LOC_SID
      , ORDER_RECORD_ID
      , ITEM_SID
      , ORDER_POS_VERSION_NR
      , CAST(:dwh_valid_from AS DATE) AS  DWH_VALID_FROM
      , ORDER_POS_CREATED_TMSP
      , ORDER_POS_UPDATED_TMSP
      , DELIVERY_DT
      , DELIVERY_TMSP
      , ORDER_STATUS_CD
      , PART_FG
      , ORDER_QTY_TYPE_CD
      , ORDER_QTY
      , ORDER_REMAIN_QTY AS ORDER_DELIVERED_CASE_QTY
      , CASE_FACTOR
      , REAL_CASE_SIZE
      , DWH_CAL_DT
      , DWH_LOAD_ID
      , DWH_CREATED
      , DWH_UPDATED
      , CASE WHEN dwh_created = MIN(dwh_created) OVER (PARTITION BY client_id, loc_sid) /* consider init data as not deleted */
             THEN 0
             WHEN CAST(dwh_updated AS date) - CAST (dwh_created AS date) >= 180   /* data which has been update 180 days after creation is probably also not deleted */
             THEN 0
             WHEN CAST(dwh_updated AS date) - CAST (dwh_created AS date) < 180    /* data which has been recently/today updatedis ofc actual */
              AND CAST (dwh_updated AS date) = MAX(CAST (dwh_updated AS date)) OVER (PARTITION BY client_id, loc_sid)
             THEN 0
             WHEN CAST(:dwh_valid_from AS DATE) - dwh_cal_dt >= 183               /* data which is out of export scope (183 days) cannot be checked and should be considered as not deleted */
             THEN -1
             ELSE 1                                                               /* data which has not been updated for 180 days is probably not actual any more */
        END AS deleted_fg
      FROM P_LEW_CORE.T_REPLENISH_ORDER_WH_RECORD_POS
      ;
    END IF;

    /*
     * Steps for Historization
     * A) Deleted rows:
     *    1. Terminate current rows, which are not delivered anymore with dwh_valid_to = cal_dt-1 (cy_day_seq=-1)
     *    2. Insert same row with dwh_valid_from = cal_dt (cy_day_seq=0), but with deleted_fg = 1
     * B) Changed data
     *    1. Terminate current rows dwh_valid_to = cal_dt-1 (cy_day_seq=-1)
     *    2. Insert new row with dwh_valid_from = cal_dt (cy_day_seq=0) and dwh_valid_to = 9999-12-30
     * C) New data
     *    1. Insert new row with dwh_valid_from = cal_dt (cy_day_seq=0) and dwh_valid_to = 9999-12-30
     * Keep in mind: We are using time travel to get status of dispo table at 7 o''clock each day. This means that (in general) actual cal_dt is the day before
     * e.g. get dispo data for 4.9.22 means that cal_dt is 3.9.22 (=dwh_valid_from) 
    */
    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Create some intermediate/TEMPORARY tables'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                           
    EXECUTE IMMEDIATE alter_stmt;

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l10 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;
    ALTER TABLE P_LEW_TMP.t_dispo_pos_hist_l10
    ADD COLUMN reuse_for_deleted_row_fg Number (1,0);

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l15 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l20 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l25 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l30 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;

    CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_hist_l99 LIKE P_LEW_MART_LEAD.t_dispo_pos_hist;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Insert current row for changed or deleted data into t_dispo_pos_hist_l10'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                                                          
    EXECUTE IMMEDIATE alter_stmt;
    /* Insert current row for changed or deleted data into t_dispo_pos_hist_l10 */
    INSERT INTO P_LEW_TMP.t_dispo_pos_hist_l10
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    , reuse_for_deleted_row_fg
    )
    SELECT
      tgt.client_id
    , tgt.loc_sid
    , tgt.order_record_id
    , tgt.item_sid
    , tgt.order_pos_version_nr
    , tgt.dwh_valid_from
    , CAST(:dwh_valid_from AS DATE) -1  AS dwh_valid_to
    , tgt.deleted_fg
    , tgt.delivery_dt
    , tgt.order_status_cd
    , tgt.part_fg
    , tgt.order_qty_type_cd
    , tgt.order_qty
    , tgt.order_delivered_case_qty
    , tgt.case_factor
    , tgt.real_case_size
    , tgt.delta_order_case_qty
    , tgt.order_pos_created_tmsp
    , tgt.order_pos_updated_tmsp
    , tgt.delivery_tmsp
    , tgt.dwh_cal_dt
    , tgt.dwh_load_id
    , tgt.dwh_created
    , tgt.dwh_updated
    , CASE WHEN l01.client_id IS NULL
           THEN 1
           ELSE 0
      END                     AS reuse_for_deleted_row_fg  /* IF ROW was deleted/not delivered, we just duplicate the existing ROW. The existing ROW will be terminated AND the duplicated ROW will have validitiy FOR future but WITH deleted_fg = 1 */
    FROM P_LEW_MART_LEAD.t_dispo_pos_hist tgt
      LEFT OUTER JOIN P_LEW_TMP.t_dispo_pos_hist_l01 l01
        ON tgt.client_id            = l01.client_id
       AND tgt.loc_sid              = l01.loc_sid
       AND tgt.order_record_id      = l01.order_record_id 
       AND tgt.item_sid             = l01.item_sid
       AND tgt.order_pos_version_nr = l01.order_pos_version_nr
       AND l01.dwh_valid_from BETWEEN tgt.dwh_valid_from AND tgt.dwh_valid_to
    WHERE CAST(:dwh_valid_from AS DATE) BETWEEN tgt.dwh_valid_from AND tgt.dwh_valid_to
      AND tgt.order_pos_version_nr <> 0                           /* ignore order_pos_version_nr = 0, because this is a row which we created for inital values */
      AND (   (l01.client_id IS NULL AND tgt.deleted_fg <> 1)     /* ROW NOT delivered anymore --> terminate existing ROW */
           OR (l01.client_id IS NOT NULL
               AND (   (tgt.deleted_fg <> l01.deleted_fg AND l01.deleted_fg <> -1)                /* ROW was deleted in the past, but now we got it again in vice versa. Ingnore rows which were out of export timeframe (183 days) */
                    OR  tgt.order_pos_created_tmsp <> l01.order_pos_created_tmsp
                    OR (tgt.order_pos_created_tmsp IS     NULL AND l01.order_pos_created_tmsp IS NOT NULL)
                    OR (tgt.order_pos_created_tmsp IS NOT NULL AND l01.order_pos_created_tmsp IS     NULL)
                    OR  tgt.order_pos_updated_tmsp <> l01.order_pos_updated_tmsp
                    OR (tgt.order_pos_updated_tmsp IS     NULL AND l01.order_pos_updated_tmsp IS NOT NULL)
                    OR (tgt.order_pos_updated_tmsp IS NOT NULL AND l01.order_pos_updated_tmsp IS     NULL)
                    OR  tgt.delivery_dt <> l01.delivery_dt
                    OR (tgt.delivery_dt IS     NULL AND l01.delivery_dt IS NOT NULL)
                    OR (tgt.delivery_dt IS NOT NULL AND l01.delivery_dt IS     NULL)
                    OR  tgt.delivery_tmsp <> l01.delivery_tmsp
                    OR (tgt.delivery_tmsp IS     NULL AND l01.delivery_tmsp IS NOT NULL)
                    OR (tgt.delivery_tmsp IS NOT NULL AND l01.delivery_tmsp IS     NULL)
                    OR  tgt.order_status_cd <> l01.order_status_cd
                    OR (tgt.order_status_cd IS     NULL AND l01.order_status_cd IS NOT NULL)
                    OR (tgt.order_status_cd IS NOT NULL AND l01.order_status_cd IS     NULL)
                    OR  tgt.part_fg <> l01.part_fg
                    OR (tgt.part_fg IS     NULL AND l01.part_fg IS NOT NULL)
                    OR (tgt.part_fg IS NOT NULL AND l01.part_fg IS     NULL)
                    OR  tgt.order_qty_type_cd <> l01.order_qty_type_cd
                    OR (tgt.order_qty_type_cd IS     NULL AND l01.order_qty_type_cd IS NOT NULL)
                    OR (tgt.order_qty_type_cd IS NOT NULL AND l01.order_qty_type_cd IS     NULL)
                    OR  tgt.order_qty <> l01.order_qty
                    OR (tgt.order_qty IS     NULL AND l01.order_qty IS NOT NULL)
                    OR (tgt.order_qty IS NOT NULL AND l01.order_qty IS     NULL)
                    OR  tgt.order_delivered_case_qty <> l01.order_delivered_case_qty
                    OR (tgt.order_delivered_case_qty IS     NULL AND l01.order_delivered_case_qty IS NOT NULL)
                    OR (tgt.order_delivered_case_qty IS NOT NULL AND l01.order_delivered_case_qty IS     NULL)
                    OR  tgt.case_factor <> l01.case_factor
                    OR (tgt.case_factor IS     NULL AND l01.case_factor IS NOT NULL)
                    OR (tgt.case_factor IS NOT NULL AND l01.case_factor IS     NULL)
                    OR  tgt.real_case_size <> l01.real_case_size
                    OR (tgt.real_case_size IS     NULL AND l01.real_case_size IS NOT NULL)
                    OR (tgt.real_case_size IS NOT NULL AND l01.real_case_size IS     NULL)
                   )
              )
          )
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Insert new data (never received before) into t_dispo_pos_hist_l15'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                                                   
    EXECUTE IMMEDIATE alter_stmt;
    /* Insert new data (never received before) into t_dispo_pos_hist_l15 */
    INSERT INTO P_LEW_TMP.t_dispo_pos_hist_l15
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
    SELECT
      l01.client_id
    , l01.loc_sid
    , l01.order_record_id
    , l01.item_sid
    , l01.order_pos_version_nr
    , l01.dwh_valid_from
    , CAST (''9999-12-30'' AS DATE) AS dwh_valid_to
    , CASE WHEN l01.deleted_fg = -1               /* out of export scope data (183 days) should be considered as not deleted */
           THEN 0
           ELSE l01.deleted_fg
      END                           AS deleted_fg
    , l01.delivery_dt
    , l01.order_status_cd
    , l01.part_fg
    , l01.order_qty_type_cd
    , l01.order_qty
    , l01.order_delivered_case_qty
    , l01.case_factor
    , l01.real_case_size
    , 0                           AS delta_order_case_qty
    , l01.order_pos_created_tmsp
    , l01.order_pos_updated_tmsp
    , l01.delivery_tmsp
    , l01.dwh_cal_dt
    , l01.dwh_load_id
    , l01.dwh_created
    , l01.dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l01 l01
      LEFT OUTER JOIN P_LEW_MART_LEAD.t_dispo_pos_hist tgt
        ON l01.client_id            = tgt.client_id
       AND l01.loc_sid              = tgt.loc_sid
       AND l01.order_record_id      = tgt.order_record_id 
       AND l01.item_sid             = tgt.item_sid
       AND l01.order_pos_version_nr = tgt.order_pos_version_nr
       AND l01.dwh_valid_from BETWEEN tgt.dwh_valid_from AND tgt.dwh_valid_to
       AND tgt.dwh_valid_to         = CAST (''9999-12-30'' AS DATE)
    WHERE tgt.client_id IS NULL
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Preparation for calculation of init values'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                            
    EXECUTE IMMEDIATE alter_stmt;

    INSERT into p_lew_tmp.t_dispo_pos_hist_l20
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
    /* changed/updated data for already existing data */
    SELECT
      l01.client_id
    , l01.loc_sid
    , l01.order_record_id
    , l01.item_sid
    , l01.order_pos_version_nr
    , l01.dwh_valid_from
    , CAST (''9999-12-30'' AS DATE) AS dwh_valid_to
    , l01.deleted_fg
    , l01.delivery_dt
    , l01.order_status_cd
    , l01.part_fg
    , l01.order_qty_type_cd
    , l01.order_qty
    , l01.order_delivered_case_qty
    , l01.case_factor
    , l01.real_case_size
    /* This COLUMN stores the delta BETWEEN previous AND CURRENT order_qty ON CASE LEVEL AND can be used TO calculate corrected order_qty based ON init_order_qty */
    , CASE WHEN l01.order_status_cd IN (0,1)                                                   /* we only accept modifications of order_qty if status is 0 or 1 */
           THEN (l01.case_factor * l01.order_qty) - (l10.case_factor * l10.order_qty) + l10.delta_order_case_qty
           ELSE l10.delta_order_case_qty
      END                         AS delta_order_case_qty
    , l01.order_pos_created_tmsp
    , l01.order_pos_updated_tmsp
    , l01.delivery_tmsp
    , l01.dwh_cal_dt
    , l01.dwh_load_id
    , l01.dwh_created
    , l01.dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l01 l01
      INNER JOIN P_LEW_TMP.t_dispo_pos_hist_l10 l10
        ON l01.client_id            = l10.client_id
       AND l01.loc_sid              = l10.loc_sid
       AND l01.order_record_id      = l10.order_record_id 
       AND l01.item_sid             = l10.item_sid
       AND l01.order_pos_version_nr = l10.order_pos_version_nr
       AND l01.dwh_valid_from       = l10.dwh_valid_to +1
      UNION ALL
      /* new data */
    SELECT
      l15.client_id
    , l15.loc_sid
    , l15.order_record_id
    , l15.item_sid
    , l15.order_pos_version_nr
    , l15.dwh_valid_from
    , l15.dwh_valid_to
    , l15.deleted_fg
    , l15.delivery_dt
    , l15.order_status_cd
    , l15.part_fg
    , l15.order_qty_type_cd
    , l15.order_qty
    , l15.order_delivered_case_qty
    , l15.case_factor
    , l15.real_case_size
    , l15.delta_order_case_qty
    , l15.order_pos_created_tmsp
    , l15.order_pos_updated_tmsp
    , l15.delivery_tmsp
    , l15.dwh_cal_dt
    , l15.dwh_load_id
    , l15.dwh_created
    , l15.dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l15 l15
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Combine newly delivered rows with unchanged hist rows for the corresponding order'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                                                                   
    EXECUTE IMMEDIATE alter_stmt;
    INSERT INTO p_lew_tmp.t_dispo_pos_hist_l25
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
    WITH l20a AS
    (SELECT
       client_id
     , loc_sid
     , order_record_id
     , item_sid
     , SUM(CASE WHEN order_status_cd IN (1,2) THEN 1 ELSE 0 END) cnt
     FROM p_lew_tmp.t_dispo_pos_hist_l20
     GROUP BY
       client_id
     , loc_sid
     , order_record_id
     , item_sid
     HAVING cnt = 0  /* only those orders without status 1 or 2 */
         OR COUNT(*) = MAX(order_pos_version_nr) /* or all lines (version_nr) for the same position are new */
    )
    SELECT
      l20.client_id
    , l20.loc_sid
    , l20.order_record_id
    , l20.item_sid
    , l20.order_pos_version_nr
    , l20.dwh_valid_from
    , l20.dwh_valid_to
    , l20.deleted_fg
    , l20.delivery_dt
    , l20.order_status_cd
    , l20.part_fg
    , l20.order_qty_type_cd
    , l20.order_qty
    , l20.order_delivered_case_qty
    , l20.case_factor
    , l20.real_case_size
    , l20.delta_order_case_qty
    , l20.order_pos_created_tmsp
    , l20.order_pos_updated_tmsp
    , l20.delivery_tmsp
    , l20.dwh_cal_dt
    , l20.dwh_load_id
    , l20.dwh_created
    , l20.dwh_updated
    FROM p_lew_tmp.t_dispo_pos_hist_l20 l20
      INNER JOIN l20a
        ON l20.client_id       = l20a.client_id
       AND l20.loc_sid         = l20a.loc_sid
       AND l20.item_sid        = l20a.item_sid
       AND l20.order_record_id = l20a.order_record_id
      UNION ALL
    SELECT
      tgt.client_id
    , tgt.loc_sid
    , tgt.order_record_id
    , tgt.item_sid
    , tgt.order_pos_version_nr
    , tgt.dwh_valid_from
    , tgt.dwh_valid_to
    , tgt.deleted_fg
    , tgt.delivery_dt
    , tgt.order_status_cd
    , tgt.part_fg
    , tgt.order_qty_type_cd
    , tgt.order_qty
    , tgt.order_delivered_case_qty
    , tgt.case_factor
    , tgt.real_case_size
    , tgt.delta_order_case_qty
    , tgt.order_pos_created_tmsp
    , tgt.order_pos_updated_tmsp
    , tgt.delivery_tmsp
    , tgt.dwh_cal_dt
    , tgt.dwh_load_id
    , tgt.dwh_created
    , tgt.dwh_updated
    FROM P_LEW_MART_LEAD.t_dispo_pos_hist tgt
      INNER JOIN l20a
        ON tgt.client_id       = l20a.client_id
       AND tgt.loc_sid         = l20a.loc_sid
       AND tgt.item_sid        = l20a.item_sid
       AND tgt.order_record_id = l20a.order_record_id
       AND CAST(:dwh_valid_from AS DATE) BETWEEN tgt.dwh_valid_from AND tgt.dwh_valid_to
      LEFT OUTER JOIN p_lew_tmp.t_dispo_pos_hist_l20 l20b
        ON tgt.client_id       = l20b.client_id
       AND tgt.loc_sid         = l20b.loc_sid
       AND tgt.item_sid        = l20b.item_sid
       AND tgt.order_record_id = l20b.order_record_id
       AND tgt.order_pos_version_nr = l20b.order_pos_version_nr
       AND CAST(:dwh_valid_from AS DATE) BETWEEN tgt.dwh_valid_from AND tgt.dwh_valid_to
    WHERE l20b.client_id IS NULL
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Generate order_pos_version_nr 0 for initial values'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                                    
    EXECUTE IMMEDIATE alter_stmt;
    INSERT INTO p_lew_tmp.t_dispo_pos_hist_l30
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
    WITH new_init AS
    (
      SELECT
        l25a.client_id
      , l25a.loc_sid
      , l25a.order_record_id
      , l25a.item_sid
      , l25a.order_pos_version_nr
      , l25b.dwh_valid_from             AS prev_dwh_valid_from
      , CAST(:dwh_valid_from AS DATE)   AS dwh_valid_from
      , l25a.dwh_valid_to
      , l25a.deleted_fg
      , l25a.delivery_dt
      , l25a.order_status_cd
      , l25a.part_fg
      , l25a.order_qty_type_cd
      , l25a.order_qty
      , l25a.order_delivered_case_qty
      , l25a.case_factor
      , l25a.real_case_size
      , l25a.delta_order_case_qty
      , l25a.order_pos_created_tmsp
      , l25a.order_pos_updated_tmsp
      , l25a.delivery_tmsp
      , l25a.dwh_cal_dt
      , l25a.dwh_load_id
      , l25a.dwh_created
      , l25a.dwh_updated
      FROM
      (
        SELECT
          CASE WHEN SUM(CASE WHEN l25.order_status_cd IN (2) THEN 1 ELSE 0 END) OVER (PARTITION BY l25.client_id, l25.loc_sid, l25.order_record_id, l25.item_sid) > 0 /* we have at least one WE */
               THEN FIRST_VALUE(l25.order_pos_version_nr) OVER (PARTITION BY l25.client_id, l25.loc_sid, l25.order_record_id, l25.item_sid ORDER BY l25.order_pos_version_nr)  /* use first order_pos_version_nr, either 0 (if we already have an init row) or 1 which is the first one we received */
               WHEN SUM(CASE WHEN l25.order_status_cd IN (1) THEN 1 ELSE 0 END) OVER (PARTITION BY l25.client_id, l25.loc_sid, l25.order_record_id, l25.item_sid) = 0 /* we only have status 0 and 9 */
               THEN FIRST_VALUE(l25.order_pos_version_nr) OVER (PARTITION BY l25.client_id, l25.loc_sid, l25.order_record_id, l25.item_sid
                                                                ORDER BY l25.order_status_cd
                                                                       , CASE WHEN l25.order_pos_version_nr = 0 THEN 9999 ELSE l25.order_pos_version_nr END) /* use first order_pos_version_nr >0 with status 0 */
               /* In case we have status 0,1,9, use row with lowest status and lowest order_pos_version_nr. In case we already have an init row, we would use that row */
               ELSE FIRST_VALUE(l25.order_pos_version_nr) OVER (PARTITION BY l25.client_id, l25.loc_sid, l25.order_record_id, l25.item_sid
                                                                ORDER BY l25.order_status_cd, l25.order_pos_version_nr)
          END   AS init_order_pos_version_nr
        , l25.client_id
        , l25.loc_sid
        , l25.order_record_id
        , l25.item_sid
        , l25.order_pos_version_nr
        , l25.dwh_valid_from
        , l25.dwh_valid_to
        , l25.deleted_fg
        , l25.delivery_dt
        , l25.order_status_cd
        , l25.part_fg
        , l25.order_qty_type_cd
        , l25.order_qty
        , l25.order_delivered_case_qty
        , l25.case_factor
        , l25.real_case_size
        , l25.delta_order_case_qty
        , l25.order_pos_created_tmsp
        , l25.order_pos_updated_tmsp
        , l25.delivery_tmsp
        , l25.dwh_cal_dt
        , l25.dwh_load_id
        , l25.dwh_created
        , l25.dwh_updated
        FROM p_lew_tmp.t_dispo_pos_hist_l25 l25
        QUALIFY init_order_pos_version_nr = l25.order_pos_version_nr
      ) l25a
        LEFT OUTER JOIN p_lew_tmp.t_dispo_pos_hist_l25 l25b
          ON l25a.client_id            = l25b.client_id
         AND l25a.loc_sid              = l25b.loc_sid
         AND l25a.order_record_id      = l25b.order_record_id 
         AND l25a.item_sid             = l25b.item_sid
         AND l25b.order_pos_version_nr = 0
      WHERE 1=1
        AND (    l25a.order_pos_created_tmsp <> l25b.order_pos_created_tmsp
             OR (l25a.order_pos_created_tmsp IS     NULL AND l25b.order_pos_created_tmsp IS NOT NULL)
             OR (l25a.order_pos_created_tmsp IS NOT NULL AND l25b.order_pos_created_tmsp IS     NULL)
             OR  l25a.order_pos_updated_tmsp <> l25b.order_pos_updated_tmsp
             OR (l25a.order_pos_updated_tmsp IS     NULL AND l25b.order_pos_updated_tmsp IS NOT NULL)
             OR (l25a.order_pos_updated_tmsp IS NOT NULL AND l25b.order_pos_updated_tmsp IS     NULL)
             OR  l25a.delivery_dt <> l25b.delivery_dt
             OR (l25a.delivery_dt IS     NULL AND l25b.delivery_dt IS NOT NULL)
             OR (l25a.delivery_dt IS NOT NULL AND l25b.delivery_dt IS     NULL)
             OR  l25a.delivery_tmsp <> l25b.delivery_tmsp
             OR (l25a.delivery_tmsp IS     NULL AND l25b.delivery_tmsp IS NOT NULL)
             OR (l25a.delivery_tmsp IS NOT NULL AND l25b.delivery_tmsp IS     NULL)
             OR  l25a.order_status_cd <> l25b.order_status_cd
             OR (l25a.order_status_cd IS     NULL AND l25b.order_status_cd IS NOT NULL)
             OR (l25a.order_status_cd IS NOT NULL AND l25b.order_status_cd IS     NULL)
             OR  l25a.part_fg <> l25b.part_fg
             OR (l25a.part_fg IS     NULL AND l25b.part_fg IS NOT NULL)
             OR (l25a.part_fg IS NOT NULL AND l25b.part_fg IS     NULL)
             OR  l25a.order_qty_type_cd <> l25b.order_qty_type_cd
             OR (l25a.order_qty_type_cd IS     NULL AND l25b.order_qty_type_cd IS NOT NULL)
             OR (l25a.order_qty_type_cd IS NOT NULL AND l25b.order_qty_type_cd IS     NULL)
             OR  l25a.order_qty <> l25b.order_qty
             OR (l25a.order_qty IS     NULL AND l25b.order_qty IS NOT NULL)
             OR (l25a.order_qty IS NOT NULL AND l25b.order_qty IS     NULL)
             OR  l25a.order_delivered_case_qty <> l25b.order_delivered_case_qty
             OR (l25a.order_delivered_case_qty IS     NULL AND l25b.order_delivered_case_qty IS NOT NULL)
             OR (l25a.order_delivered_case_qty IS NOT NULL AND l25b.order_delivered_case_qty IS     NULL)
             OR  l25a.case_factor <> l25b.case_factor
             OR (l25a.case_factor IS     NULL AND l25b.case_factor IS NOT NULL)
             OR (l25a.case_factor IS NOT NULL AND l25b.case_factor IS     NULL)
             OR  l25a.real_case_size <> l25b.real_case_size
             OR (l25a.real_case_size IS     NULL AND l25b.real_case_size IS NOT NULL)
             OR (l25a.real_case_size IS NOT NULL AND l25b.real_case_size IS     NULL)
            )
    )
    SELECT
      cur.client_id
    , cur.loc_sid
    , cur.order_record_id
    , cur.item_sid
    , 0                    AS order_pos_version_nr
    , cur.dwh_valid_from 
    , cur.dwh_valid_to
    , cur.deleted_fg
    , cur.delivery_dt
    , cur.order_status_cd
    , cur.part_fg
    , cur.order_qty_type_cd
    , cur.order_qty
    , cur.order_delivered_case_qty
    , cur.case_factor
    , cur.real_case_size
    , 0                    AS delta_order_case_qty   /* There are no correction on init values. If init value has been modified, we assume the new value as init value w/o tracking the delta */
    , cur.order_pos_created_tmsp
    , cur.order_pos_updated_tmsp
    , cur.delivery_tmsp
    , cur.dwh_cal_dt
    , cur.dwh_load_id
    , cur.dwh_created
    , cur.dwh_updated
    FROM new_init cur
      UNION ALL
        SELECT
      l25b.client_id
    , l25b.loc_sid
    , l25b.order_record_id
    , l25b.item_sid
    , l25b.order_pos_version_nr
    , l25b.dwh_valid_from 
    , cur.dwh_valid_from -1     AS dwh_valid_to
    , l25b.deleted_fg
    , l25b.delivery_dt
    , l25b.order_status_cd
    , l25b.part_fg
    , l25b.order_qty_type_cd
    , l25b.order_qty
    , l25b.order_delivered_case_qty
    , l25b.case_factor
    , l25b.real_case_size
    , 0                    AS delta_order_case_qty   /* There are no correction on init values. If init value has been modified, we assume the new value as init value w/o tracking the delta */
    , l25b.order_pos_created_tmsp
    , l25b.order_pos_updated_tmsp
    , l25b.delivery_tmsp
    , l25b.dwh_cal_dt
    , l25b.dwh_load_id
    , l25b.dwh_created
    , l25b.dwh_updated
    FROM p_lew_tmp.t_dispo_pos_hist_l25 l25b
      INNER JOIN new_init cur
        ON l25b.client_id            = cur.client_id
       AND l25b.loc_sid              = cur.loc_sid
       AND l25b.order_record_id      = cur.order_record_id 
       AND l25b.item_sid             = cur.item_sid
       AND l25b.dwh_valid_from       = cur.prev_dwh_valid_from
       AND l25b.order_pos_version_nr = 0
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Combine/Collect all data into t_dispo_pos_hist_l99'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                                                    
    EXECUTE IMMEDIATE alter_stmt;
    INSERT INTO P_LEW_TMP.t_dispo_pos_hist_l99
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
      /* historic rows for changed or deleted data (used for updating dwh_valid_to) */
    SELECT
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l10
      UNION ALL
      /* actual row for deleted row (not delivered anymore) */
    SELECT
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , CAST (:dwh_valid_from AS DATE) AS dwh_valid_from
    , CAST (''9999-12-30'' AS DATE)  AS dwh_valid_to
    , 1                              AS deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l10
    WHERE reuse_for_deleted_row_fg = 1
      UNION ALL
      /* actual version for changed data rows */
    SELECT
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l20
      UNION ALL
      /* Row for init values (order_pos_version_nr = 0)*/
    SELECT
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , delivery_dt
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , delta_order_case_qty
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_tmsp
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    FROM p_lew_tmp.t_dispo_pos_hist_l30
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Delete data from target'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                         
    EXECUTE IMMEDIATE alter_stmt;
    DELETE FROM P_LEW_MART_LEAD.t_dispo_pos_hist tgt
    USING P_LEW_TMP.t_dispo_pos_hist_l99 l99
    WHERE  l99.client_id            = tgt.client_id
       AND l99.loc_sid              = tgt.loc_sid
       AND l99.order_record_id      = tgt.order_record_id 
       AND l99.item_sid             = tgt.item_sid
       AND l99.order_pos_version_nr = tgt.order_pos_version_nr
       AND l99.dwh_valid_from       = tgt.dwh_valid_from
    ;

    step_id := :step_id +1;
    new_qt := OBJECT_INSERT (:new_qt, ''StepID'', :step_id::varchar, TRUE);
    new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Load data into target'', TRUE);
    alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
                                                                                                                                                                                                                                                       
    EXECUTE IMMEDIATE alter_stmt;
    INSERT INTO P_LEW_MART_LEAD.t_dispo_pos_hist
    (
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_dt
    , delivery_tmsp
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , init_order_qty_type_cd
    , init_order_qty
    , init_case_factor
    , delta_order_case_qty
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    )
    SELECT
      client_id
    , loc_sid
    , order_record_id
    , item_sid
    , order_pos_version_nr
    , dwh_valid_from
    , dwh_valid_to
    , deleted_fg
    , order_pos_created_tmsp
    , order_pos_updated_tmsp
    , delivery_dt
    , delivery_tmsp
    , order_status_cd
    , part_fg
    , order_qty_type_cd
    , order_qty
    , order_delivered_case_qty
    , case_factor
    , real_case_size
    , init_order_qty_type_cd
    , init_order_qty
    , init_case_factor
    , delta_order_case_qty
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
    FROM P_LEW_TMP.t_dispo_pos_hist_l99
    ;

  END FOR;

  step_id := :step_id +1;
  new_qt := OBJECT_INSERT (:static_qt, ''StepID'', :step_id::varchar, TRUE);
  new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Aggregate Order_change_log'', TRUE);
  alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
  EXECUTE IMMEDIATE alter_stmt;
  
  CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.order_change_log
  AS
  SELECT
    client_id
  , loc_sid
  , order_record_id
  , item_sid
  , LISTAGG(ORDER_CHANGE_TYPE_ID *10 + ORDER_CHANGE_SRC_ID, '','') WITHIN GROUP (ORDER BY CHANGE_SEQ) all_reason_cd
  , TO_NUMBER (SPLIT_PART(all_reason_cd, '','', 1)) first_reason_cd
  , TO_NUMBER (SPLIT_PART(all_reason_cd, '','', -1)) last_reason_cd
  , CASE WHEN LENGTH (all_reason_cd) > 300
         THEN SUBSTR (all_reason_cd, 1, 297) || ''...''
         ELSE all_reason_cd
    END                                             AS all_reason_cd_cut
  FROM P_LEW_CORE.T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG
  GROUP BY client_id, loc_sid, order_record_id, item_sid
  ;

  step_id := :step_id +1;
  new_qt := OBJECT_INSERT (:static_qt, ''StepID'', :step_id::varchar, TRUE);
  new_qt := OBJECT_INSERT (:new_qt, ''StepDesc'', ''Prepare act table'', TRUE);
  alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| PARSE_JSON(:new_qt) || '''''''';
  EXECUTE IMMEDIATE alter_stmt;
  SELECT MIN(cal_dt) INTO :hist_dt
  FROM p_lew_core_ac.v_cal_calendarday
  WHERE cy_day_seq < 0
    AND busyear_seq > -4
  ;

  CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.t_dispo_pos_act_l99 LIKE P_LEW_MART_LEAD.t_dispo_pos_act;
/* optional change WH size as needed
  SELECT current_warehouse() INTO :cur_wh;
  SELECT REGEXP_REPLACE( current_warehouse(), ''(.*)_(.*)$'' , ''\\\\1'', 1, 1, ''i'' ) || ''_L'' INTO :new_wh;
  
  sql_stmt := ''USE WAREHOUSE ''|| :new_wh || '''';
  EXECUTE IMMEDIATE sql_stmt;
*/
  INSERT INTO P_LEW_TMP.t_dispo_pos_act_l99
  (
    client_id
  , loc_sid
  , sup_sid
  , order_record_id
  , item_sid
  , order_pos_version_nr
  , dwh_valid_from
  , deleted_fg
  , delivery_dt
  , order_status_cd
  , part_fg
  , order_qty_type_cd
  , order_qty
  , order_delivered_case_qty
  , case_factor
  , real_case_size
  , delta_order_case_qty
  , order_status_cd_override
  , init_delivery_dt
  , min_rcv_dt
  , max_rcv_dt
  , qty_case_rcv_ontime
  , qty_case_rcv_ahead_schedule
  , qty_case_rcv_delay_1_day
  , qty_case_rcv_delay_2_days
  , qty_case_rcv_delay_3_days
  , qty_case_rcv_delay_ge_4_days
  , cnt_days_delayed
  , cnt_rcv
  , orig_receipt_id_rcv
  , mapping_pos_nr
  , order_pos_created_tmsp
  , order_pos_updated_tmsp
  , delivery_tmsp
  , all_reason_cd
  , first_reason_cd
  , last_reason_cd
  , dwh_load_id
  , dwh_created
  , dwh_updated
  )
  SELECT
    dispo.client_id
  , dispo.loc_sid
  , dispoh.sup_sid
  , dispo.order_record_id
  , dispo.item_sid
  , dispo.order_pos_version_nr
  , MAX(dispo.dwh_valid_from)
  , MAX(dispo.deleted_fg)
  , MAX(dispo.delivery_dt)
  , MAX(dispo.order_status_cd)
  , MAX(dispo.part_fg)
  , MAX(dispo.order_qty_type_cd)
  , MAX(dispo.order_qty)
  , MAX(dispo.order_delivered_case_qty)
  , MAX(dispo.case_factor)
  , MAX(dispo.real_case_size)
  , MAX(dispo.delta_order_case_qty)
  , CASE WHEN MAX(dispo.order_status_cd) = 9
          AND MAX(we.cnt_rcv) >= 1 
         THEN 92   /* if line is cancelled, but there are receivings booked on it, mark it with status = 92 = cancelled, but with receivings */
         WHEN MAX(dispo.order_status_cd) = 9
          AND dispo.order_pos_version_nr <> LAST_VALUE(dispo.order_pos_version_nr) OVER (PARTITION BY dispo.client_id, dispo.loc_sid, dispo.order_record_id, dispo.item_sid ORDER BY dispo.order_pos_version_nr)
         THEN 99  /* if version_nr is cancelled, but it is not the last row/version_nr for this order position, set status = 99, so that only "real" cancelled lines can be identified */
         ELSE MAX(dispo.order_status_cd)
    END                                           AS order_status_cd_override
  , MAX(dispoh.delivery_dt)
  , MIN(we.rcv_dt)                                AS min_rcv_dt
  , MAX(we.rcv_dt)                                AS max_rcv_dt
  , SUM(CASE WHEN we.rcv_dt = dispoh.delivery_dt
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_ontime
  , SUM(CASE WHEN we.rcv_dt < dispoh.delivery_dt
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_ahead_schedule
  , SUM(CASE WHEN we.rcv_dt - dispoh.delivery_dt = 1
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_delay_1_day
  , SUM(CASE WHEN we.rcv_dt - dispoh.delivery_dt = 2
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_delay_2_days
  , SUM(CASE WHEN we.rcv_dt - dispoh.delivery_dt = 3
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_delay_3_days
  , SUM(CASE WHEN we.rcv_dt - dispoh.delivery_dt >= 4
             THEN we.sum_qty_case_rcv
             ELSE 0
        END)                                      AS qty_case_rcv_delay_ge_4_days
  , CASE WHEN MAX(we.rcv_dt) - MAX(dispoh.delivery_dt) < 0
         THEN 0
         ELSE MAX(we.rcv_dt) - MAX(dispoh.delivery_dt)
    END                                           AS cnt_days_delayed
  , MAX(we.cnt_rcv)                               AS cnt_rcv
  , MAX(we.orig_receipt_id_rcv)                   AS orig_receipt_id_rcv
  , MAX(we.mapping_pos_nr)                        AS mapping_pos_nr
  , MAX(dispo.order_pos_created_tmsp)
  , MAX(dispo.order_pos_updated_tmsp)
  , MAX(dispo.delivery_tmsp)
  , MAX(ocl.all_reason_cd_cut)                    AS all_reason_cd
  , MAX(ocl.first_reason_cd)
  , MAX(ocl.last_reason_cd)
  , MAX(dispo.dwh_load_id)
  , MAX(dispo.dwh_created)
  , MAX(dispo.dwh_updated)
  FROM p_lew_mart_lead.t_dispo_pos_hist dispo
    INNER JOIN p_lew_core_ac.v_replenish_order_wh_record dispoh
      ON dispo.client_id       = dispoh.client_id
     AND dispo.loc_sid         = dispoh.loc_sid
     AND dispo.order_record_id = dispoh.order_record_id
     AND dispoh.delivery_dt   >= :hist_dt::date
    LEFT OUTER JOIN
    (SELECT
       client_id
     , wh_loc_sid
     , dat_formdate       AS rcv_dt
     , item_sid
     , position_nr_rcv
     , dispo_link_pos_nr
     , SUM (qty_case_rcv + COALESCE(qty_piece_rcv/NULLIFZERO(case_size_dec), 0)) AS sum_qty_case_rcv
     , COUNT(*)           AS cnt_rcv
     , MIN(orig_receipt_id_rcv)                                                  AS orig_receipt_id_rcv
     , MIN(mapping_pos_nr)                                                       AS mapping_pos_nr
     FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving
     WHERE receipttype_id in (1,2,3)
       AND dat_formdate >= :hist_dt::date
     GROUP BY
       client_id
     , wh_loc_sid
     , dat_formdate
     , item_sid
     , position_nr_rcv
     , dispo_link_pos_nr
    ) we
      ON dispo.client_id            = we.client_id
     AND dispo.loc_sid              = we.wh_loc_sid
     AND dispo.item_sid             = we.item_sid
     AND dispo.order_record_id      = we.position_nr_rcv
     AND dispo.order_pos_version_nr = we.dispo_link_pos_nr
    LEFT OUTER JOIN P_LEW_TMP.order_change_log ocl
      ON dispo.client_id       = ocl.client_id
     AND dispo.loc_sid         = ocl.loc_sid
     AND dispo.order_record_id = ocl.order_record_id
     AND dispo.item_sid        = ocl.item_sid
  WHERE dispo.dwh_valid_to = ''9999-12-30''
    AND dispo.delivery_dt >= :hist_dt::date
  GROUP BY
    dispo.client_id
  , dispo.loc_sid
  , dispoh.sup_sid
  , dispo.order_record_id
  , dispo.item_sid
  , dispo.order_pos_version_nr
  ;
/* optional change back WH size
  sql_stmt := ''USE WAREHOUSE ''|| :cur_wh || '''';
  EXECUTE IMMEDIATE sql_stmt;
*/
  BEGIN TRANSACTION;
  DELETE FROM P_LEW_MART_LEAD.t_dispo_pos_act;

  INSERT INTO P_LEW_MART_LEAD.t_dispo_pos_act
  (
    client_id
  , loc_sid
  , sup_sid
  , order_record_id
  , item_sid
  , order_pos_version_nr
  , dwh_valid_from
  , deleted_fg
  , delivery_dt
  , order_status_cd
  , part_fg
  , order_qty_type_cd
  , order_qty
  , order_delivered_case_qty
  , case_factor
  , real_case_size
  , delta_order_case_qty
  , order_status_cd_override
  , init_delivery_dt
  , min_rcv_dt
  , max_rcv_dt
  , qty_case_rcv_ontime
  , qty_case_rcv_ahead_schedule
  , qty_case_rcv_delay_1_day
  , qty_case_rcv_delay_2_days
  , qty_case_rcv_delay_3_days
  , qty_case_rcv_delay_ge_4_days
  , cnt_days_delayed
  , cnt_rcv
  , orig_receipt_id_rcv
  , mapping_pos_nr
  , order_pos_created_tmsp
  , order_pos_updated_tmsp
  , delivery_tmsp
  , all_reason_cd
  , first_reason_cd
  , last_reason_cd
  , dwh_load_id
  , dwh_created
  , dwh_updated
  )
  SELECT
    client_id
  , loc_sid
  , sup_sid
  , order_record_id
  , item_sid
  , order_pos_version_nr
  , dwh_valid_from
  , deleted_fg
  , delivery_dt
  , order_status_cd
  , part_fg
  , order_qty_type_cd
  , order_qty
  , order_delivered_case_qty
  , case_factor
  , real_case_size
  , delta_order_case_qty
  , order_status_cd_override
  , init_delivery_dt
  , min_rcv_dt
  , max_rcv_dt
  , qty_case_rcv_ontime
  , qty_case_rcv_ahead_schedule
  , qty_case_rcv_delay_1_day
  , qty_case_rcv_delay_2_days
  , qty_case_rcv_delay_3_days
  , qty_case_rcv_delay_ge_4_days
  , cnt_days_delayed
  , cnt_rcv
  , orig_receipt_id_rcv
  , mapping_pos_nr
  , order_pos_created_tmsp
  , order_pos_updated_tmsp
  , delivery_tmsp
  , all_reason_cd
  , first_reason_cd
  , last_reason_cd
  , dwh_load_id
  , dwh_created
  , dwh_updated
  FROM P_LEW_TMP.t_dispo_pos_act_l99
  ;
  COMMIT;
  alter_stmt := ''ALTER SESSION SET query_tag = ''''''|| :current_qt || '''''''';
  EXECUTE IMMEDIATE alter_stmt;
  RETURN ''Dispo Data loaded'';
END;
'
;
