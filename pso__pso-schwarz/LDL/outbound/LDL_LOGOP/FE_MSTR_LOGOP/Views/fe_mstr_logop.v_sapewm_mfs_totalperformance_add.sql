/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_totalperformance_add
Description		|	SAP EWM MFS - view with additional columns 
====================================================================================================
*/

-- WHEN wh_task_type IN (11.2) AND t.CLIENT_ID = 23 THEN 'S' || LPAD(REGEXP_SUBSTR(t.nlpla, '\\d\\d', 8), 2, '0')

CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_totalperformance_add (client_id
OPTIONS(description='Client ID'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task'), wh_task_item
OPTIONS(description='Warehouse Task Item'), wh_task_stat OPTIONS(description='Warehouse Task Status'), wh_proc_type
OPTIONS(description='Warehouse Process Type'), wh_proc_cat OPTIONS(description='Warehouse Process Category'), doc_nr
OPTIONS(description='Document'), doc_cat OPTIONS(description='Document Category for Document-Related Stocks'),
hu_task_type OPTIONS(description='Handling Unit Type'), unit_switch
OPTIONS(description='Switches between Pallets and EPA amounts'), conf_dt OPTIONS(description='Confirmation date'),
conf_tm OPTIONS(description='Confirmation time'), conf_hr OPTIONS(description='Confirmation hour'), queue
OPTIONS(description='Queue'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), bin_grp
OPTIONS(description='Storage bin group'), wh_task_type OPTIONS(description='Warehouse task type'), srm_type
OPTIONS(description='Type of storage and retrieval machine (SRM / Regalbediengeraet)'), min_conf_tm
OPTIONS(description='Earliest confirmation time per hour'), max_conf_tm
OPTIONS(description='Latest confirmation time per hour'), cnt_task_ph
OPTIONS(description='Amount of tasks per hour which is shown once for the first row of the hour'), cnt_task_ph_pre
OPTIONS(description='Amount of tasks per hour from the preceding hour group (0 for the first hour per day because there are no previous tasks)'),
cnt_task_ph_suc
OPTIONS(description='Amount of tasks per hour from the succeding hour group (0 for the last hour per day because there are no following tasks)'),
prod_tm_sec OPTIONS(description='Productive time in seconds calculated based on number of tasks per hour')) AS WITH
 BINGROUP AS (SELECT strg_bin,
   bin_grp
  FROM ldl_logop_data.t_ref_bin_group), MFSTASKS AS (SELECT T.client_id,
   T.lidl_country AS lidl_ctry,
   T.wh_id,
   T.tanum AS wh_task_nr,
   T.tapos AS wh_task_item,
   T.tostat AS wh_task_stat,
   T.procty AS wh_proc_type,
   T.trart AS wh_proc_cat,
   T.docno AS doc_nr,
   CAST(T.itemno AS STRING) AS doc_cat,
   T.letyp AS hu_task_type,
   T.confirmed_date AS conf_dt,
   T.confirmed_time AS conf_tm,
   TIME_TRUNC(T.confirmed_time, HOUR) AS conf_hr,
   T.queue,
   T.vlpla AS src_strg_bin,
   T.vlenr AS src_hu,
   T.vltyp AS src_strg_type,
   T.srsrc AS src_rsrc,
   T.nlpla AS dest_strg_bin,
   T.nlenr AS dest_hu,
   T.nltyp AS dest_strg_type,
   T.drsrc AS dest_rsrc,
   T.dwh_created,
   T.dwh_updated,
   b.bin_grp,
    CASE
    WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
    THEN 7.1
    WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 3
    WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 3.2
    WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 3.3
    WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 3.4
    WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
    THEN 12
    WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND 
      REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
    THEN 12.1
    WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
          'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
    THEN 4.0
    WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
          'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
    THEN 3.1
    WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
    THEN 7.0
    WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
    THEN 7.2
    WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
       = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
    THEN 2
    WHEN T.procty = '8090' AND T.client_id <> 23 AND  REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
         , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
       FROM ldl_logop_data.t_sapewm_warehousetask
       WHERE procty = '8090'
        AND nlpla = 'N1-IP2-1')
    THEN 1.0
    WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
         , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
        FROM ldl_logop_data.t_sapewm_warehousetask
        WHERE procty = '8090'
         AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
    THEN 1.1
    WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
         , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
       FROM ldl_logop_data.t_sapewm_warehousetask
       WHERE procty = '8090'
        AND nlpla = 'N1-IP2-1')
    THEN 1.2
    WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE
             'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
      )
    THEN 5.0
    WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
              'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
         NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE 'HF-PD%'
      
    THEN 51
    WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 52
    WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
    THEN 52.5
    WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 11.0
    WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
    THEN 11.1
    WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
    THEN 11.2
    WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 14.0
    WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
      )
    THEN 14.2
    WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
         'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
        'HF-PD%')
    THEN 8.0
    WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
           'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
      )
    THEN 6.0
    WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
         'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
    THEN 9.0
    WHEN  REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
        <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
    THEN 10
    WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
    THEN 14.5
    WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
    THEN 15.0
    ELSE 99
    END AS wh_task_type,
    CASE
    WHEN CASE
      WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
      THEN 7.1
      WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 3
      WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 3.2
      WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 3.3
      WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 3.4
      WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
      THEN 12
      WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND False <>
        REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
      THEN 12.1
      WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
            'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
      THEN 4.0
      WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
            'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
      THEN 3.1
      WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
      THEN 7.0
      WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
      THEN 7.2
      WHEN T.procty = '8090' AND T.client_id <> 23 AND  REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
         = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
      THEN 2
      WHEN T.procty = '8090' AND T.client_id <> 23 AND  REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
           , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
          
         FROM ldl_logop_data.t_sapewm_warehousetask
         WHERE procty = '8090'
          AND nlpla = 'N1-IP2-1')
      THEN 1.0
      WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
           , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
      THEN 1.1
      WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
           , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
          
         FROM ldl_logop_data.t_sapewm_warehousetask
         WHERE procty = '8090'
          AND nlpla = 'N1-IP2-1')
      THEN 1.2
      WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
               'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
               LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
        )
      THEN 5.0
      WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
           NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
        'HF-PD%'
      THEN 51
      WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 52
      WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
      THEN 52.5
      WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 11.0
      WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
      THEN 11.1
      WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 11.2
      WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 14.0
      WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
        )
      THEN 14.2
      WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
           'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
          'HF-PD%')
      THEN 8.0
      WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
             'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
        )
      THEN 6.0
      WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
           'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
      THEN 9.0
      WHEN  REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND  REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
          <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
      THEN 10
      WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
      THEN 14.5
      WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
      THEN 15.0
      ELSE 99
      END = 99
    THEN ''
    WHEN LEFT(T.queue, 2) = 'SR' AND T.client_id <> 23
    THEN T.queue
    WHEN LEFT(T.queue, 2) = 'S' AND T.client_id = 23
    THEN T.queue
    WHEN CASE
       WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.1
       WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3
       WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.2
       WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.3
       WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.4
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
       THEN 12
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
       THEN 12.1
       WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 4.0
       WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 3.1
       WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.0
       WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 7.2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
          = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.0
       WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 1.1
       WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.2
       WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 5.0
       WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
            NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
         'HF-PD%'
       THEN 51
       WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 52
       WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
       THEN 52.5
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.0
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 11.1
       WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.2
       WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.0
       WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.2
       WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
           'HF-PD%')
       THEN 8.0
       WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
              'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 6.0
       WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
       THEN 9.0
       WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
           <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
       THEN 10
       WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 14.5
       WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 15.0
       ELSE 99
       END = 51 AND T.client_id <> 23
    THEN 'Staging Direct'
    WHEN CASE
       WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.1
       WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3
       WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.2
       WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.3
       WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.4
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
       THEN 12
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
       THEN 12.1
       WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 4.0
       WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 3.1
       WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.0
       WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 7.2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
          = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.0
       WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 1.1
       WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.2
       WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 5.0
       WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
            NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
         'HF-PD%'
       THEN 51
       WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 52
       WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
       THEN 52.5
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.0
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 11.1
       WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.2
       WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.0
       WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.2
       WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
           'HF-PD%')
       THEN 8.0
       WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
              'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 6.0
       WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
       THEN 9.0
       WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
           <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
       THEN 10
       WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 14.5
       WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 15.0
       ELSE 99
       END IN (11.2, 52, 52.5) AND T.client_id = 23
    THEN T.queue
    WHEN CASE
        WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.1
        WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3
        WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.2
        WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.3
        WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.4
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
        THEN 12
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
        THEN 12.1
        WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 4.0
        WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 3.1
        WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.0
        WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 7.2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
           = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.0
        WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
            FROM ldl_logop_data.t_sapewm_warehousetask
            WHERE procty = '8090'
             AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 1.1
        WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.2
        WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla
                 LIKE 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                 LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 5.0
        WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                  'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
             NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
          'HF-PD%'
        THEN 51
        WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 52
        WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
        THEN 52.5
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.0
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 11.1
        WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.2
        WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.0
        WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.2
        WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
            'HF-PD%')
        THEN 8.0
        WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
               'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 6.0
        WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
        THEN 9.0
        WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
            <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
        THEN 10
        WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 14.5
        WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 15.0
        ELSE 99
        END IN (4, 5, 6, 7, 8, 10) AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1%' OR T.vlpla
        LIKE 'P1-PD1%')
    THEN 'SR' || LPAD(REGEXP_EXTRACT(SUBSTR(T.vlpla, 8), '\\d\\d'), 2, '0')
    WHEN CASE
        WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.1
        WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3
        WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.2
        WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.3
        WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.4
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
        THEN 12
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
        THEN 12.1
        WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 4.0
        WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 3.1
        WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.0
        WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 7.2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
           = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.0
        WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
            FROM ldl_logop_data.t_sapewm_warehousetask
            WHERE procty = '8090'
             AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 1.1
        WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.2
        WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla
                 LIKE 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                 LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 5.0
        WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                  'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
             NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
          'HF-PD%'
        THEN 51
        WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 52
        WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
        THEN 52.5
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.0
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 11.1
        WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.2
        WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.0
        WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.2
        WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
            'HF-PD%')
        THEN 8.0
        WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
               'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 6.0
        WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
        THEN 9.0
        WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
            <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
        THEN 10
        WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 14.5
        WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 15.0
        ELSE 99
        END IN (52, 52.5, 15.0, 7.2, 3.4, 3.3, 3.2) AND T.client_id = 23 AND (T.vlpla LIKE 'TO-OF%' OR T.vlpla LIKE
         'F1-PD1%' OR T.vlpla LIKE 'P1-PD1%')
    THEN 'S' || LPAD(REGEXP_EXTRACT(SUBSTR(T.vlpla, 8), '\\d\\d'), 2, '0')
    WHEN CASE
       WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.1
       WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3
       WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.2
       WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.3
       WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.4
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
       THEN 12
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
       THEN 12.1
       WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 4.0
       WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 3.1
       WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.0
       WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 7.2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
          = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.0
       WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 1.1
       WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.2
       WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 5.0
       WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
            NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
         'HF-PD%'
       THEN 51
       WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 52
       WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
       THEN 52.5
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.0
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 11.1
       WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.2
       WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.0
       WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.2
       WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
           'HF-PD%')
       THEN 8.0
       WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
              'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 6.0
       WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
       THEN 9.0
       WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
           <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
       THEN 10
       WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 14.5
       WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 15.0
       ELSE 99
       END IN (4, 5, 6, 7, 8, 10) AND T.client_id <> 23
    THEN COALESCE(T.srsrc, '')
    WHEN CASE
        WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.1
        WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3
        WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.2
        WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.3
        WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 3.4
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
        THEN 12
        WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
        THEN 12.1
        WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 4.0
        WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
              LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
        THEN 3.1
        WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 7.0
        WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 7.2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
           = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 2
        WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.0
        WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
            FROM ldl_logop_data.t_sapewm_warehousetask
            WHERE procty = '8090'
             AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
        THEN 1.1
        WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
             , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
            dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1')
        THEN 1.2
        WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla
                 LIKE 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                 LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 5.0
        WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                  'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
             NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
          'HF-PD%'
        THEN 51
        WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 52
        WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
        THEN 52.5
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.0
        WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
        THEN 11.1
        WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 11.2
        WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.0
        WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
          )
        THEN 14.2
        WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
            'HF-PD%')
        THEN 8.0
        WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
               'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
          )
        THEN 6.0
        WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
             'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
        THEN 9.0
        WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
            <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
        THEN 10
        WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 14.5
        WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
        THEN 15.0
        ELSE 99
        END IN (52, 52.5, 15.0, 7.2, 3.4, 3.3, 3.2) AND T.client_id = 23 AND T.srsrc IS NOT NULL
    THEN COALESCE(T.srsrc, '')
    WHEN T.client_id = 23 AND T.srsrc IS NULL AND (T.queue IS NULL OR T.queue LIKE 'TAB%')
    THEN 'Fördertechnik'
    WHEN T.client_id = 23 AND T.srsrc IS NULL AND T.queue NOT LIKE 'TAB%'
    THEN T.queue
    WHEN CASE
       WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.1
       WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3
       WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.2
       WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.3
       WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 3.4
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
       THEN 12
       WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
       THEN 12.1
       WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 4.0
       WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla
             LIKE 'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
       THEN 3.1
       WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 7.0
       WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 7.2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
          = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 2
       WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.0
       WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
           FROM ldl_logop_data.t_sapewm_warehousetask
           WHERE procty = '8090'
            AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
       THEN 1.1
       WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
            , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS
           dest_hu
          FROM ldl_logop_data.t_sapewm_warehousetask
          WHERE procty = '8090'
           AND nlpla = 'N1-IP2-1')
       THEN 1.2
       WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
                LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 5.0
       WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
                 'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
            NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
         'HF-PD%'
       THEN 51
       WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 52
       WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
       THEN 52.5
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.0
       WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
       THEN 11.1
       WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 11.2
       WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.0
       WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
         )
       THEN 14.2
       WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
           'HF-PD%')
       THEN 8.0
       WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
              'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
         )
       THEN 6.0
       WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
            'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
       THEN 9.0
       WHEN REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
           <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
       THEN 10
       WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 14.5
       WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
       THEN 15.0
       ELSE 99
       END IN (11.1, 12.1) AND T.client_id <> 23
    THEN 'SR' || LPAD(REGEXP_EXTRACT(SUBSTR(T.nlpla, 8), '\\d\\d'), 2, '0')
    ELSE T.srsrc
    END AS srm_type,
   MIN(T.confirmed_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.confirmed_date,
      TIME_TRUNC(T.confirmed_time, HOUR) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min_conf_tm,
   MAX(T.confirmed_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.confirmed_date,
      TIME_TRUNC(T.confirmed_time, HOUR) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_conf_tm,
   IF((MIN(T.confirmed_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.confirmed_date,
         TIME_TRUNC(T.confirmed_time, HOUR) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = T.confirmed_time
     , COUNT(*) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.confirmed_date, TIME_TRUNC(T
        .confirmed_time, HOUR) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS cnt_task_ph
  FROM ldl_logop_data.t_sapewm_warehousetask AS T
   LEFT JOIN BINGROUP AS b ON T.vlpla = b.strg_bin
  WHERE T.tostat = 'C'
   AND CASE
     WHEN T.procty = '6666' AND T.client_id <> 23 AND T.vltyp = '8141'
     THEN 7.1
     WHEN T.procty = '8086' AND T.client_id <> 23 AND T.nltyp = '8142' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 3
     WHEN T.procty = '8287' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 3.2
     WHEN T.procty = '8284' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 3.3
     WHEN T.procty = '8280' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 3.4
     WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'HF-PD%')
     THEN 12
     WHEN T.procty = '8086' AND T.client_id <> 23 AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'HF-PD%') AND 
       REGEXP_CONTAINS(T.nlpla , r'HF-LP0-.*')
     THEN 12.1
     WHEN T.procty = '8087' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
           'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
     THEN 4.0
     WHEN T.procty = '8084' AND T.client_id <> 23 AND (T.nlpla LIKE 'HF-DS%' OR T.nlpla LIKE 'F1-PD1-%' OR T.nlpla LIKE
           'P1-PD1-%' OR T.nlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*')
     THEN 3.1
     WHEN T.procty = '8088' AND T.client_id <> 23 AND T.vltyp = '8141'
     THEN 7.0
     WHEN T.procty = '8288' AND T.client_id = 23 AND T.vltyp = '8241'
     THEN 7.2
     WHEN T.procty = '8090' AND T.client_id <> 23 AND  REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND CAST(T.itemno AS STRING)
        = 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
     THEN 2
     WHEN T.procty = '8090' AND T.client_id <> 23 AND REGEXP_CONTAINS(T.nltyp , r'814[1|2]') AND IFNULL(CAST(T.itemno AS STRING)
          , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
        FROM ldl_logop_data.t_sapewm_warehousetask
        WHERE procty = '8090'
         AND nlpla = 'N1-IP2-1')
     THEN 1.0
     WHEN T.procty = '8090' AND T.client_id <> 23 AND (T.nlpla LIKE '8141%' OR T.nlpla LIKE '8142%') AND IFNULL(CAST(T.itemno AS STRING)
          , '') <> 'PDO' AND T.nlenr IN (SELECT nlenr AS dest_hu
         FROM ldl_logop_data.t_sapewm_warehousetask
         WHERE procty = '8090'
          AND nlpla = 'N1-IP2-1') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*')
     THEN 1.1
     WHEN T.procty = '8290' AND T.client_id = 23 AND (T.nltyp LIKE '8241%' OR T.nltyp LIKE '8280%') AND IFNULL(CAST(T.itemno AS STRING)
          , '') <> 'PDO' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.nlenr NOT IN (SELECT nlenr AS dest_hu
        FROM ldl_logop_data.t_sapewm_warehousetask
        WHERE procty = '8090'
         AND nlpla = 'N1-IP2-1')
     THEN 1.2
     WHEN T.procty = '8092' AND T.client_id <> 23 AND ((T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
              'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla
              LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') OR T.srsrc LIKE 'SR%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
       )
     THEN 5.0
     WHEN T.procty = '8092' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
               'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*') AND T.vlpla
          NOT LIKE 'HF-DS%' AND T.vlpla NOT LIKE 'F1-PD1-%' AND T.vlpla NOT LIKE 'P1-PD1-%' AND T.vlpla NOT LIKE
       'HF-PD%'
     THEN 51
     WHEN T.procty = '8292' AND T.client_id = 23 AND T.nlpla LIKE 'TF-DS%' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 52
     WHEN T.client_id = 23 AND T.procty LIKE '82%' AND T.nlpla LIKE 'TF-DS%' AND T.procty NOT IN ('8292', '8287')
     THEN 52.5
     WHEN T.procty = '8093' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 11.0
     WHEN T.procty = '8093' AND T.client_id <> 23 AND T.vltyp = '8141'
     THEN 11.1
     WHEN T.procty = '8293' AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 11.2
     WHEN T.procty = '8094' AND T.client_id <> 23 AND T.nltyp = '8141' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 14.0
     WHEN T.procty IN ('8294', '8292') AND T.client_id = 23 AND T.nltyp = '8241' AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*'
       )
     THEN 14.2
     WHEN T.procty = '8095' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
          'F1-OF%') AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE 'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE
         'HF-PD%')
     THEN 8.0
     WHEN T.procty = '8097' AND T.client_id <> 23 AND T.nlpla = 'N1-OF1-2' AND (T.vlpla LIKE 'HF-DS%' OR T.vlpla LIKE
            'F1-PD1-%' OR T.vlpla LIKE 'P1-PD1-%' OR T.vlpla LIKE 'HF-PD%') AND NOT REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|5|6].*'
       )
     THEN 6.0
     WHEN T.procty = '8098' AND T.client_id <> 23 AND (T.nlpla LIKE 'OB-OF%' OR T.nlpla LIKE 'OB-PM%' OR T.nlpla LIKE
          'F1-OF%' OR T.nlpla LIKE 'RL-OF1-01')
     THEN 9.0
     WHEN  REGEXP_CONTAINS(T.procty , r'8\d\d\d') AND  REGEXP_CONTAINS(T.vlenr , r'9[2|3|4|6].*') AND T.client_id
         <> 23 AND (T.nlpla LIKE '%SPS%' OR T.nlpla LIKE '%EPS%' OR T.nltyp = '8141')
     THEN 10
     WHEN T.procty = '8266' AND T.client_id = 23 AND T.vltyp = '8241'
     THEN 14.5
     WHEN T.procty = '8299' AND T.client_id = 23 AND T.vltyp = '8241'
     THEN 15.0
     ELSE 99
     END <> 99) (SELECT *
  FROM (SELECT client_id,
      lidl_ctry,
      wh_id,
      wh_task_nr,
      wh_task_item,
      wh_task_stat,
      wh_proc_type,
      wh_proc_cat,
      doc_nr,
      doc_cat,
      hu_task_type,
      1 AS unit_switch,
      conf_dt,
      conf_tm,
      conf_hr,
      queue,
      src_strg_bin,
      src_hu,
      src_strg_type,
      src_rsrc,
      dest_strg_bin,
      dest_hu,
      dest_strg_type,
      dest_rsrc,
      dwh_created,
      dwh_updated,
      bin_grp,
      wh_task_type,
      srm_type,
      min_conf_tm,
      max_conf_tm,
      cnt_task_ph,
      IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
          , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL)
      AS cnt_task_ph_pre,
      IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
          , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL)
      AS cnt_task_ph_suc,
       CASE
       WHEN cnt_task_ph < 5
       THEN NULL
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) + IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) < 5
       THEN TIME_DIFF(max_conf_tm, min_conf_tm, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) < 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) > 5
       THEN TIME_DIFF(TIME_ADD(conf_hr, INTERVAL 3600 SECOND), min_conf_tm, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) > 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) < 5
       THEN TIME_DIFF(max_conf_tm, conf_hr, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) > 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) > 5
       THEN 3600
       ELSE NULL
       END AS prod_tm_sec
     FROM MFSTASKS AS t63
     UNION DISTINCT
     SELECT client_id,
      lidl_ctry,
      wh_id,
      wh_task_nr,
      wh_task_item,
      wh_task_stat,
      wh_proc_type,
      wh_proc_cat,
      doc_nr,
      doc_cat,
      hu_task_type,
      2 AS unit_switch,
      conf_dt,
      conf_tm,
      conf_hr,
      queue,
      src_strg_bin,
      src_hu,
      src_strg_type,
      src_rsrc,
      dest_strg_bin,
      dest_hu,
      dest_strg_type,
      dest_rsrc,
      dwh_created,
      dwh_updated,
      bin_grp,
      wh_task_type,
      srm_type,
      min_conf_tm,
      max_conf_tm,
      cnt_task_ph,
      IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
          , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL)
      AS cnt_task_ph_pre,
      IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
          , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL)
      AS cnt_task_ph_suc,
       CASE
       WHEN cnt_task_ph < 5
       THEN NULL
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) + IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) < 5
       THEN TIME_DIFF(max_conf_tm, min_conf_tm, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) < 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) > 5
       THEN TIME_DIFF(TIME_ADD(conf_hr, INTERVAL 3600 SECOND), min_conf_tm, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) > 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) < 5
       THEN TIME_DIFF(max_conf_tm, conf_hr, SECOND)
       WHEN IF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
             , conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr),
          NULL) > 5 AND IF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph, 1, 0) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), conf_dt ORDER BY conf_hr IS NULL, conf_hr, conf_tm IS NULL, conf_tm, wh_task_nr
             IS NULL, wh_task_nr), NULL) > 5
       THEN 3600
       ELSE NULL
       END AS prod_tm_sec
     FROM MFSTASKS AS t129));