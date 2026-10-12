CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_nio_add_2 (client_id OPTIONS(description='Client ID'),
lidl_ctry OPTIONS(description='Country_2 code'), wh_id OPTIONS(description='Warehouse ID'), wh_task_nr
OPTIONS(description='Warehouse Task'), wh_task_item OPTIONS(description='Warehouse Task Item_2'), wh_task_stat
OPTIONS(description='Warehouse Task Status_2'), wh_proc_type OPTIONS(description='Warehouse Process Type'), wh_proc_cat
OPTIONS(description='Warehouse Process Category'), doc_nr OPTIONS(description='Document'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks'), conf_dt OPTIONS(description='Confirmation date'),
conf_tm OPTIONS(description='Confirmation time'), queue OPTIONS(description='Queue'), exc_cd
OPTIONS(description='Exception Code'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit_2'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit_2'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), hu_ident
OPTIONS(description='NIO History Handling Unit_2 Identification'), log_seq OPTIONS(description='NIO History Log Sequence'),
crtd_on_dt OPTIONS(description='NIO History Created on'), com_point
OPTIONS(description='NIO History Communication_2 Point for Conveyor Technique'), hu_stat_short
OPTIONS(description='NIO History Individual status_2 of an object in short form'), err_cd
OPTIONS(description='NIO History error code used to identify pallets with relevant errors'), first_log_seq
OPTIONS(description='Indicator to identify the first record of Nio History per task group'), hu_checked
OPTIONS(description='Pallet provided to conveyor'), hu_passed OPTIONS(description='Pallet successfully checked'),
nio_count OPTIONS(description='Pallet with encountered error'), nio_sonstige
OPTIONS(description='Pallet manually moved to NIO Station'), send_out
OPTIONS(description='Pallet moved to clearing station'), nio_send_out
OPTIONS(description='TAB Only: Pallet moved to clearing station'), conveyor_id
OPTIONS(description='ID for the FE lookup of conveyor and area (LU view v_lu_mfs_conveyor_2)')) AS WITH NIO AS (SELECT
   client_id,
   lidl_country AS lidl_ctry,
   wh_id,
   tanum AS wh_task_nr,
   tapos AS wh_task_item,
   tostat AS wh_task_stat,
   procty AS wh_proc_type,
   trart AS wh_proc_cat,
   docno AS doc_nr,
   itemno AS doc_cat,
   confirmed_date AS conf_dt,
   confirmed_time AS conf_tm,
   queue,
   exccode AS exc_cd,
   vlpla AS src_strg_bin,
   vlenr AS src_hu,
   vltyp AS src_strg_type,
   srsrc AS src_rsrc,
   nlpla AS dest_strg_bin,
   nlenr AS dest_hu,
   nltyp AS dest_strg_type,
   drsrc AS dest_rsrc,
   dwh_created,
   dwh_updated,
    CASE
    WHEN client_id = 1 AND wh_id = 9
    THEN CASE
     WHEN STARTS_WITH(vlpla, 'IB-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(vlpla, 'IB-IP2')
           AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01%') OR STARTS_WITH(nlpla, 'IB-IP2') AND
           IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(nlpla, 'IB-NO1') AND (procty <> '8091' OR STARTS_WITH(vlpla,
             'HF')) AND procty NOT IN ('8099', '9999') OR STARTS_WITH(nlpla, 'IB-NO1') AND procty = '8091' AND NOT
         STARTS_WITH(vlpla, 'IB-SCN-01') AND NOT STARTS_WITH(vlpla, 'HF') OR vlpla LIKE 'IB-%' AND nlpla = 'IB-OF1-01'
     THEN 1
     WHEN STARTS_WITH(vlpla, 'DI-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(vlpla, 'DI-IP2')
           AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01%') OR STARTS_WITH(nlpla, 'DI-IP2') AND
           IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(nlpla, 'DI-NO1') AND (procty <> '8091' OR STARTS_WITH(vlpla,
             'HF')) AND procty NOT IN ('8099', '9999') OR STARTS_WITH(nlpla, 'DI-NO1') AND procty = '8091' AND NOT
        STARTS_WITH(vlpla, 'HF') OR vlpla LIKE 'DI-%' AND nlpla = 'RL-OF1-01'
     THEN 2
     WHEN STARTS_WITH(vlpla, 'P2-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(vlpla, 'P2-IP2')
           AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01%') OR STARTS_WITH(vlpla, 'P2-IP1') AND
            (nlpla LIKE 'P2-IP2%' OR nlpla LIKE 'P2-NO1%') AND (NOT STARTS_WITH(nlenr, '3') OR IFNULL(exccode, '') <>
             'MLOC') OR STARTS_WITH(nlpla, 'P2-IP1') OR STARTS_WITH(nlpla, 'P2-NO1') AND procty NOT IN ('8091', '8099',
          '9999') OR STARTS_WITH(nlpla, 'P2-NO1') AND procty = '8091' AND NOT STARTS_WITH(vlpla, 'HF')
     THEN 4
     WHEN STARTS_WITH(vlpla, 'F1-IP2') AND STARTS_WITH(nlpla, 'F1-PD1') OR STARTS_WITH(vlpla, 'B1-IP2') AND STARTS_WITH(nlpla
             , 'B1-PD1') OR (STARTS_WITH(vlpla, 'F1-IP1') AND STARTS_WITH(nlpla, 'F1-IP2') OR STARTS_WITH(vlpla,
                 'F1-IP1') AND STARTS_WITH(nlpla, 'F1-NO1') OR STARTS_WITH(vlpla, 'B1-IP1') AND STARTS_WITH(nlpla,
                'B1-IP2') OR STARTS_WITH(vlpla, 'B1-IP1') AND STARTS_WITH(nlpla, 'B1-NO1')) AND (NOT STARTS_WITH(nlenr,
              '3') OR IFNULL(exccode, '') <> 'MLOC') OR nlpla LIKE 'B1-IP1%' OR nlpla LIKE 'F1-IP1%' OR procty = '8090'
        AND (nlpla LIKE 'F1-NO1%' OR nlpla LIKE 'B1-NO1%') OR (nlpla LIKE 'F1-NO1%' OR nlpla LIKE 'B1-NO1%') AND procty
        = '8091'
     THEN 5
     WHEN STARTS_WITH(vlpla, 'B2-IP2') AND STARTS_WITH(nlpla, 'B2-PD1') OR STARTS_WITH(vlpla, 'B2-IP1') AND (nlpla LIKE
              'B2-IP2%' OR nlpla LIKE 'B2-NO1%') AND (NOT STARTS_WITH(nlenr, '3') OR IFNULL(exccode, '') <> 'MLOC') OR
        STARTS_WITH(nlpla, 'B2-IP1') OR STARTS_WITH(nlpla, 'B2-NO1') AND procty = '8090' OR STARTS_WITH(nlpla, 'B2-NO1'
        ) AND procty = '8091'
     THEN 6
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3|4].*')
     THEN 9
     ELSE 99
     END
    WHEN client_id = 8 AND wh_id = 6
    THEN CASE
     WHEN STARTS_WITH(vlpla, 'IB-IP2-01') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(vlpla,
           'IB-IP2') AND STARTS_WITH(nlpla, 'HF') OR (nlpla LIKE 'IB-IP2%' OR nlpla LIKE 'DI-IPN_2%') AND IFNULL(exccode,
           '') <> 'MLOC' OR STARTS_WITH(nlpla, 'DI-NO1') AND (procty <> '8090' OR vlpla NOT LIKE 'DI-IPN_2%' AND vlpla
              NOT LIKE 'DI-IPT%') AND (procty <> '8091' OR STARTS_WITH(vlpla, 'HF')) AND procty NOT IN ('8099', '9999')
      OR vlpla LIKE 'IB-%' AND nlpla = 'DI-OF1-01'
     THEN 1
     WHEN (vlpla LIKE 'DI-IP2%' OR vlpla LIKE 'DI-IPN_2-01%' OR vlpla LIKE 'DI-IPT-01%') AND procty = '8090' AND
          STARTS_WITH(nlpla, 'HF') OR (vlpla LIKE 'DI-IP2%' OR vlpla LIKE 'DI-IPN_2%') AND STARTS_WITH(nlpla, 'HF') OR (nlpla
            LIKE 'DI-IP2%' OR nlpla LIKE 'DI-IPT%') AND IFNULL(exccode, '') <> 'MLOC' OR vltyp = '8180' AND (STARTS_WITH(nlpla
               , 'DI-NO1') AND procty = '8091' AND NOT STARTS_WITH(vlpla, 'HF') OR STARTS_WITH(nlpla, 'DI-OF1') AND
               procty = '8091' AND NOT STARTS_WITH(vlpla, 'HF') OR STARTS_WITH(nlpla, 'DI-NO1') AND procty = '8090' AND
            STARTS_WITH(vlpla, 'DI-IPN_2') OR STARTS_WITH(nlpla, 'DI-NO1') AND procty = '8090' AND STARTS_WITH(vlpla,
            'DI-IPT')) OR vlpla LIKE 'DI-%' AND nlpla = 'DI-OF1-1'
     THEN 2
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3].*')
     THEN 9
     ELSE 99
     END
    WHEN client_id = 10 AND wh_id = 7
    THEN CASE
     WHEN STARTS_WITH(vlpla, 'IB-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'IB-IP2%' OR nlpla
             LIKE 'OB-IP2-%' OR nlpla LIKE 'IB-NO1%' OR nlpla LIKE 'OB-NO1-%' OR nlpla LIKE 'OB-CHK-%' OR nlpla LIKE
         'IB-OF1-1' OR (vlpla LIKE 'IB-IP2%' OR vlpla LIKE 'OB-IP2-%') AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF%') OR
        vlpla LIKE 'IB-%' AND nlpla = 'IB-OF1-2'
     THEN 1
     WHEN vlpla = 'DI-IP2-1' AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(nlpla, 'DI-IP2') OR
        STARTS_WITH(nlpla, 'DI-NO1') OR STARTS_WITH(vlpla, 'DI-IP2') AND STARTS_WITH(nlpla, 'OB-OF') OR vlpla LIKE
        'DI-%' AND nlpla = 'DI-OF1-1'
     THEN 2
     WHEN vlpla = 'P1-IP2-1' AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(nlpla, 'P1-IP2') OR
        STARTS_WITH(vlpla, 'P1-IP1') OR STARTS_WITH(nlpla, 'P1-NO1') OR STARTS_WITH(vlpla, 'P1-IP2') AND STARTS_WITH(nlpla
        , 'OB-OF')
     THEN 3
     WHEN vlpla = 'P2-IP2-1' AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(nlpla, 'P2-IP2') OR
        STARTS_WITH(vlpla, 'P2-IP1') OR STARTS_WITH(nlpla, 'P2-NO1') OR STARTS_WITH(vlpla, 'P2-IP2') AND STARTS_WITH(nlpla
        , 'OB-OF')
     THEN 4
     WHEN STARTS_WITH(vlpla, 'B1-IP2') OR STARTS_WITH(nlpla, 'B1-IP1') OR STARTS_WITH(vlpla, 'B1-IP1') OR STARTS_WITH(nlpla
       , 'B1-NO1')
     THEN 5
     WHEN STARTS_WITH(vlpla, 'B2-IP2') OR STARTS_WITH(nlpla, 'B2-IP1') OR STARTS_WITH(vlpla, 'B2-IP1') OR STARTS_WITH(nlpla
       , 'B2-NO1')
     THEN 6
     WHEN STARTS_WITH(nlpla, 'N1-IP2') AND IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(vlpla, 'N1-IP2') AND STARTS_WITH(nlpla
            , 'HF') OR STARTS_WITH(nlpla, 'OB-OF1') OR STARTS_WITH(nlpla, 'N1-NO1-%') AND procty = '8091' OR procty =
          '8091' AND vlpla LIKE 'HF-%' AND nlpla LIKE 'N1-NO1-%%' OR procty NOT IN ('8099', '9999') AND nlpla LIKE
        'N1-NO1-%%'
     THEN 7
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3|4]')
     THEN 9
     WHEN STARTS_WITH(nlpla, 'F1-OF1')
     THEN 10
     ELSE 99
     END
    WHEN client_id = 18 AND wh_id = 4
    THEN CASE
     WHEN STARTS_WITH(vlpla, 'IB-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'IB-IP2%' AND
             IFNULL(exccode, '') <> 'MLOC' OR vlpla LIKE 'IB-IP2%' AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF1%') OR
            nlpla LIKE 'IB-NO1%' AND vlpla <> 'HF%' AND procty = '8091' OR nlpla LIKE 'OB-CHK%' AND procty = '8091' OR (nlpla
            LIKE 'IB-NO1%' OR nlpla LIKE 'OB-CHK%') AND procty = '8091' AND procty NOT IN ('8099', '9999') OR vlpla LIKE
        'IB%' AND nlpla = 'IB-OF1-01'
     THEN 1
     WHEN vlpla = 'P1-IP2-1' AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'P1-IP1%' AND IFNULL(exccode
             , '') <> 'MLOC' OR STARTS_WITH(vlpla, 'P1-IP1') AND nlpla LIKE 'P1-IP2%' OR STARTS_WITH(vlpla, 'P1-IP2')
         AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF1%' OR nlpla LIKE 'F1-OF1%') OR (nlpla LIKE 'P1-NO1%' OR nlpla LIKE
           'OB-CHK') AND procty = '8091' OR (nlpla LIKE 'P1-NO1' OR nlpla LIKE 'OB-CHK') AND procty NOT IN ('8091',
         '8099', '9999')
     THEN 3
     WHEN vlpla = 'P2-IP2-1' AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'P2-IP1%' AND IFNULL(exccode
             , '') <> 'MLOC' OR STARTS_WITH(vlpla, 'P2-IP1') AND nlpla LIKE 'P2-IP2%' OR STARTS_WITH(vlpla, 'P2-IP2')
         AND (nlpla LIKE 'HF%' OR nlpla LIKE 'OB-OF1%' OR nlpla LIKE 'F1-OF1%') OR (nlpla LIKE 'P2-NO1%' OR nlpla LIKE
           'OB-CHK') AND procty = '8091' OR (nlpla LIKE 'P2-NO1' OR nlpla LIKE 'OB-CHK') AND procty NOT IN ('8091',
         '8099', '9999')
     THEN 4
     WHEN STARTS_WITH(vlpla, 'B1-IP2') OR nlpla LIKE 'B1-IP1-%' AND IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(vlpla,
           'B1-IP1') AND nlpla LIKE 'B1-NO1%' OR nlpla LIKE 'B1-PD1%' OR nlpla LIKE 'B1-NO1%' AND procty = '8091' OR
       nlpla LIKE 'B1-NO1'
     THEN 5
     WHEN STARTS_WITH(vlpla, 'B2-IP2') OR nlpla LIKE 'B2-IP1-%' AND IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(vlpla,
           'B2-IP1') AND nlpla LIKE 'B2-NO1%' OR nlpla LIKE 'B2-PD1%' OR nlpla LIKE 'B2-NO1%' AND procty = '8091' OR
       nlpla LIKE 'B2-NO1'
     THEN 6
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3|4]')
     THEN 9
     WHEN STARTS_WITH(nlpla, 'F1-OF1')
     THEN 10
     ELSE 99
     END
    WHEN client_id = 25 AND wh_id = 96
    THEN CASE
     WHEN (vlpla LIKE 'IB-IP2%' OR vlpla LIKE 'IB-IPN_2%') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR (vlpla LIKE
                'IB-IP2%' OR vlpla LIKE 'IB-IPN_2%') AND STARTS_WITH(nlpla, 'HF') OR (nlpla LIKE 'IB-IP2%' OR nlpla LIKE
               'IB-IPN_2%') AND IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(nlpla, 'IB-NO1') AND (procty <> '8090' OR NOT
               STARTS_WITH(vlpla, 'IB-IPN_2')) AND (procty <> '8091' OR STARTS_WITH(vlpla, 'HF')) AND procty NOT IN ('8099'
             , '9999') OR STARTS_WITH(nlpla, 'DI-NO1') AND (procty <> '8091' OR STARTS_WITH(vlpla, 'HF')) AND procty
           NOT IN ('8099', '9999') OR vltyp = '8180' AND (STARTS_WITH(nlpla, 'IB-NO1') AND procty = '8091' AND vlpla
              LIKE 'IB-%' AND NOT STARTS_WITH(vlpla, 'HF') OR STARTS_WITH(nlpla, 'IB-OF1') AND procty = '8091' AND vlpla
              LIKE 'IB-%' AND NOT STARTS_WITH(vlpla, 'HF')) OR STARTS_WITH(nlpla, 'IB-NO1') AND procty = '8090' AND
        STARTS_WITH(vlpla, 'IB-IPN_2') OR vlpla LIKE 'IB-%' AND nlpla = 'IB-OF1-01'
     THEN 1
     WHEN STARTS_WITH(vlpla, 'DI-IP2') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR (vlpla LIKE 'DI-IP2%' OR
              vlpla LIKE 'DI-IPN_2%') AND STARTS_WITH(nlpla, 'HF') OR STARTS_WITH(nlpla, 'DI-IP2') AND IFNULL(exccode, ''
            ) <> 'MLOC' OR vltyp = '8180' AND (STARTS_WITH(nlpla, 'IB-NO1') AND procty = '8091' AND vlpla LIKE 'DI-%'
            AND NOT STARTS_WITH(vlpla, 'HF') OR STARTS_WITH(nlpla, 'DI-OF1') AND procty = '8091' AND vlpla LIKE 'DI-%'
            AND NOT STARTS_WITH(vlpla, 'HF')) OR STARTS_WITH(nlpla, 'DI-NO1') AND procty = '8090' AND STARTS_WITH(vlpla
         , 'DI-IPN_2') OR vlpla LIKE 'DI-%' AND nlpla = 'IB-OF1-01'
     THEN 2
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3].*')
     THEN 9
     WHEN STARTS_WITH(nlpla, 'OB-PM1-01')
     THEN 11
     ELSE 99
     END
    WHEN client_id = 13 AND wh_id = 60
    THEN CASE
     WHEN STARTS_WITH(vlpla, 'IB-IP2%') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'IB-IP2-%' AND
             IFNULL(exccode, '') <> 'MLOC' OR vlpla LIKE 'IB-IP2-%' AND nlpla LIKE 'HF%' OR procty = '8091' AND vltyp =
              '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'IB-OF1-%') AND vlpla LIKE 'IB%' AND vlpla NOT LIKE 'HF%'
        OR nlpla LIKE '%IB-NO1-%' AND vlpla LIKE 'IB-IP2-%' AND procty NOT IN ('8099', '9999') OR nlpla LIKE '%IB-NO1-%'
           AND procty = '8091' AND vlpla LIKE 'HF%' OR vlpla LIKE 'IB%' AND nlpla = 'IB-OF1-01'
     THEN 1
     WHEN STARTS_WITH(vlpla, 'DI-IP%') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'DI-IP2-%' AND
             IFNULL(exccode, '') <> 'MLOC' OR vlpla LIKE 'DI-IP2-%' AND nlpla LIKE 'HF%' OR procty = '8091' AND vltyp =
              '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'IB-OF1-%') AND vlpla LIKE 'DI%' AND vlpla NOT LIKE 'HF%'
        OR nlpla LIKE '%IB-NO1-%' AND vlpla LIKE 'DI-IP2-%' AND procty NOT IN ('8099', '9999') OR nlpla LIKE '%IB-NO1-%'
          AND procty = '8091' OR vlpla LIKE 'DI%' AND nlpla = 'DI-OF1-01'
     THEN 2
     WHEN STARTS_WITH(vlpla, 'N1-IP2%') AND procty = '8090' AND STARTS_WITH(nlpla, 'HF') OR nlpla LIKE 'N1-IP2-%' AND
             IFNULL(exccode, '') <> 'MLOC' OR STARTS_WITH(vlpla, 'N1-IP2') AND nlpla LIKE 'HF%' OR procty = '8091' AND
           nlpla LIKE 'N1-NO1%' OR nlpla LIKE 'N1-NO1' AND procty NOT IN ('8099', '9999') OR nlpla LIKE 'N1-NO1' AND
          procty = '8091' AND vlpla LIKE 'HF%' OR vlpla LIKE 'N1%' AND nlpla = 'N1-OF1-01'
     THEN 7
     WHEN REGEXP_CONTAINS(nlpla , r'OB-OF1-0[1|2|3|4]')
     THEN 9
     WHEN STARTS_WITH(nlpla, 'F1-OF1')
     THEN 10
     ELSE 99
     END
    WHEN client_id = 23 AND wh_id = 18
    THEN CASE
     WHEN IFNULL(exccode, '') <> 'MLOC'
     THEN 2
     ELSE 99
     END
    ELSE NULL
    END AS conveyor_id,
    CASE
    WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <>
                   'MLOC' OR nlpla LIKE 'P2-IP1-%' AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <> 'MLOC' OR
                   vlpla LIKE 'P2-IP1-%' AND nlpla LIKE 'P2-NO1-%' AND STARTS_WITH(vlenr, '9') OR (nlpla LIKE 'F1-IP1-%'
                      OR nlpla LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode
                  , '') <> 'MLOC' OR (vlpla LIKE 'F1-IP1-%' OR vlpla LIKE 'B1-IP1-%' OR vlpla LIKE 'B2-IP1-%') AND (nlpla
                    LIKE 'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND STARTS_WITH(vlenr, '9')) OR (client_id
               , wh_id) = (8, 6) AND (nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IPN_2-%' OR nlpla LIKE 'DI-IPT-%' OR nlpla
                LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <> 'MLOC' OR (client_id, wh_id) = (10, 7) AND ((nlpla LIKE
                       'OB-IP2-%' OR nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <> 'MLOC'
                  OR vlpla LIKE 'DI-IP1-%' AND nlpla = 'DI-OF1-01' OR (nlpla LIKE 'P1-IP2-%' OR nlpla LIKE 'P2-IP2-%')
                   AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'P1-IP1-%' OR vlpla LIKE
                     'P2-IP1-%') AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%') AND STARTS_WITH(vlenr, '9') OR (nlpla
                    LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <>
                 'MLOC' OR (vlpla LIKE 'B1-IP1-%' OR vlpla LIKE 'B2-IP1-%') AND (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE
                   'B2-NO1-%') AND STARTS_WITH(vlenr, '9') OR nlpla LIKE 'N1-IP2-%' AND IFNULL(exccode, '') <> 'MLOC')
         OR (client_id, wh_id) = (18, 4) AND (nlpla LIKE 'IB-IP2-%' AND IFNULL(exccode, '') <> 'MLOC' OR (nlpla LIKE
                    'P1-IP1-%' OR nlpla LIKE 'P2-IP1-%') AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <> 'MLOC'
              OR (vlpla LIKE 'P1-IP1-%' OR vlpla LIKE 'P2-IP1-%') AND (nlpla LIKE 'P1-IP2-%' OR nlpla LIKE 'P2-IP2-%')
               AND STARTS_WITH(vlenr, '9') OR (nlpla LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr,
                '3') AND IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'B1-IP1-%' OR vlpla LIKE 'B2-IP1-%') AND (nlpla
                 LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND STARTS_WITH(vlenr, '9')) OR (client_id, wh_id) = (23, 18
           ) AND vlpla LIKE 'TI-IP1-%' OR (client_id, wh_id) = (25, 96) AND (nlpla LIKE 'IB-IP2-%' OR nlpla LIKE
              'DI-IP2-%' OR nlpla LIKE 'IB-IPN_2-%' OR nlpla LIKE 'DI-IPN_2-%') AND IFNULL(exccode, '') <> 'MLOC' OR (client_id
          , wh_id) = (13, 60) AND (nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <> 'MLOC' OR
       nlpla LIKE 'N1-IP2-%' AND IFNULL(exccode, '') <> 'MLOC'
    THEN 1
    ELSE 0
    END AS hu_checked,
    CASE
    WHEN (client_id, wh_id) = (1, 9) AND ((vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%') AND (nlpla LIKE 'HF-%' OR
                    nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01') OR vlpla LIKE 'P2-IP2-%' AND (nlpla LIKE 'HF-%' OR
                    nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01') OR (vlpla LIKE 'F1-IP2-%' OR vlpla LIKE 'B1-IP2-%' OR
                  vlpla LIKE 'B2-IP2-%') AND (nlpla LIKE 'F1-PD1-%' OR nlpla LIKE 'B1-PD1-%' OR nlpla LIKE 'B2-PD1-%'))
           OR (client_id, wh_id) = (8, 6) AND (vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%' OR vlpla LIKE 'IB-IPN_2-%'
               OR vlpla LIKE 'DI-IPN_2-%') AND nlpla LIKE 'HF-%' OR (client_id, wh_id) = (10, 7) AND ((vlpla LIKE
                    'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%' OR vlpla LIKE 'OB-IP2-%') AND (nlpla LIKE 'HF-%' OR nlpla LIKE
                   'OB-OF%') OR (vlpla LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%') AND (nlpla LIKE 'HF-%' OR nlpla LIKE
                   'OB-OF%') OR (vlpla LIKE 'B1-IP2-%' OR vlpla LIKE 'B2-IP2-%') AND (nlpla LIKE 'B1-PD1-%' OR nlpla
                  LIKE 'B2-PD1-%') OR vlpla LIKE 'N1-IP2-%' AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF%')) OR (client_id
            , wh_id) = (18, 4) AND (vlpla LIKE 'IB-IP2-%' AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF1-%') OR (vlpla
                 LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%') AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF1-%' OR nlpla LIKE
                 'F1-OF1-%') OR (vlpla LIKE 'B1-IP2-%' OR vlpla LIKE 'B2-IP2-%') AND (nlpla LIKE 'B1-PD1%' OR nlpla LIKE
                'B2-PD1%')) OR (client_id, wh_id) = (23, 18) AND vlpla LIKE 'TI-IP2-%' AND nlpla LIKE 'TI-PC%' OR (client_id
           , wh_id) = (25, 96) AND (vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%' OR vlpla LIKE 'IB-IPN_2-%' OR vlpla
            LIKE 'DI-IPN_2-%') AND nlpla LIKE 'HF-%' OR (client_id, wh_id) = (13, 60) AND (vlpla LIKE 'IB-IP2-%' OR vlpla
           LIKE 'DI-IP2-%') AND nlpla LIKE 'HF-%' OR vlpla LIKE 'N1-IP2-%' AND nlpla LIKE 'HF-%'
    THEN 1
    ELSE 0
    END AS hu_passed,
    CASE
    WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%') AND procty = '8091' AND vlpla
                  <> 'IB-SCN-01' AND vlpla NOT LIKE 'HF-%' OR nlpla LIKE 'P2-NO1-%' AND procty = '8091' OR (nlpla LIKE
                  'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8091') OR (client_id,
             wh_id) = (25, 96) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'IB-OF1-01') AND
                 procty = '8091' AND vltyp = '8180' AND vlpla NOT LIKE 'HF-%' OR procty = '8090' AND (nlpla LIKE
                  'IB-NO1-%' AND vlpla LIKE 'IB-IPN_2-%' OR nlpla LIKE 'DI-NO1-%' AND vlpla LIKE 'DI-IPN_2-%')) OR (client_id
            , wh_id) = (8, 6) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'DI-OF1-01') AND procty
                 = '8091' AND vltyp = '8180' AND vlpla NOT LIKE 'HF-%' OR procty = '8090' AND (nlpla LIKE 'IB-NO1-%' AND
                 (vlpla LIKE 'IB-IPN_2-%' OR vlpla LIKE 'IB-IPT-%') OR nlpla LIKE 'DI-NO1-%' AND (vlpla LIKE 'DI-IPN_2-%' OR
                   vlpla LIKE 'DI-IPT-%'))) OR (client_id, wh_id) = (10, 7) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE
                     'DI-NO1-%' OR nlpla LIKE 'OB-NO1-%' OR nlpla LIKE 'IB-OF1-1') AND procty = '8091' AND vlpla
                NOT LIKE 'HF-%' OR procty = '8091' AND vlpla LIKE 'OB-IP2-%' AND nlpla LIKE 'OB-CHK-%' OR procty =
               '8091' AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%' AND vlpla LIKE
                   'P1-IP2-%' AND procty IS NOT NULL) OR (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty =
              '8091' OR nlpla LIKE 'N1-NO1-%' AND procty = '8091') OR (client_id, wh_id) = (18, 4) AND (nlpla LIKE
               'IB-NO1-%' AND procty = '8091' AND vlpla NOT LIKE 'HF-%' OR procty = '8091' AND vlpla LIKE 'IB-IP2-%' AND
              nlpla LIKE 'OB-CHK-%' OR procty = '8091' AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE
                 'OB-CHK-%' AND (vlpla LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%') AND procty IS NOT NULL) OR (nlpla LIKE
              'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8091') OR (client_id, wh_id) = (13, 60) AND (procty =
               '8091' AND vltyp = '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'IB-OF1-%') AND vlpla LIKE 'IB%' AND
            vlpla NOT LIKE 'HF%' OR procty = '8091' AND vltyp = '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE
                'IB-OF1-%') AND vlpla LIKE 'DI%' AND vlpla NOT LIKE 'HF%' OR procty = '8091' AND nlpla LIKE 'N1-NO1%')
     OR (client_id, wh_id) = (23, 18) AND nlpla LIKE '%-NO1-%' AND procty = '8291' AND vlpla NOT LIKE 'TI-SC1%' AND
       vlpla NOT LIKE 'TF-%'
    THEN 1
    ELSE 0
    END AS nio_count,
    CASE
    WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%') AND (procty <> '8091' OR
                     vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999') OR nlpla LIKE 'P2-NO1-%' AND procty NOT IN ('8091'
                   , '8099', '9999') OR (nlpla LIKE 'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND
                 procty = '8090') OR (client_id, wh_id) = (25, 96) AND (nlpla LIKE 'IB-NO1-%' AND (procty <> '8091' OR
                     vlpla LIKE 'HF-%') AND (procty <> '8090' OR vlpla LIKE 'IB-IPN_2%') AND procty NOT IN ('8099', '9999'
                  ) OR nlpla LIKE 'DI-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND (procty <> '8090' OR vlpla
                    LIKE 'DI-IPN_2%') AND procty NOT IN ('8099', '9999')) OR (client_id, wh_id) = (8, 6) AND (nlpla LIKE
                 'IB-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999') OR nlpla LIKE
                 'DI-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999')) OR (client_id
             , wh_id) = (10, 7) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'OB-NO1-%' OR nlpla
                    LIKE 'OB-CHK-%') AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999') OR (nlpla
                     LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%') AND (procty <> '8091' OR vlpla
                    LIKE 'HF-%') AND procty NOT IN ('8091', '8099', '9999') OR (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE
                  'B2-NO1-%') AND procty = '8090' OR nlpla LIKE 'N1-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%')
              AND procty NOT IN ('8099', '9999')) OR (client_id, wh_id) = (18, 4) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla
                   LIKE 'OB-CHK-%') AND procty = '8091' AND vlpla LIKE 'HF-%' AND procty NOT IN ('8099', '9999') OR (nlpla
                  LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%') AND procty NOT IN ('8091', '8099',
                '9999') OR (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8090') OR (client_id, wh_id) =
           (13, 60) AND (nlpla LIKE '%IB-NO1-%' AND procty = '8091' AND vlpla LIKE 'HF-%' OR nlpla LIKE '%IB-NO1-%' AND
             procty NOT IN ('8099', '9999')) OR nlpla LIKE 'N1-NO1-%' AND procty NOT IN ('8099', '9999') OR nlpla LIKE
         'N1-NO1-%' AND procty IN ('8091') AND vlpla LIKE 'HF-%' OR (client_id, wh_id) = (23, 18) AND (nlpla LIKE
           '%-NO1-%' AND procty = '8291' AND vlpla NOT LIKE 'TF-%' OR nlpla LIKE '%-NO1-%' AND procty NOT IN ('8289',
           '9999'))
    THEN 1
    ELSE 0
    END AS nio_sonstige,
    CASE
    WHEN (client_id, wh_id) = (1, 9) AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-01' OR vlpla LIKE 'DI-%' AND nlpla
               LIKE 'RL-OF1-01') OR (client_id, wh_id) = (25, 96) AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-01' OR
               vlpla LIKE 'DI-%' AND nlpla LIKE 'IB-OF1-01') OR (client_id, wh_id) = (8, 6) AND (vlpla LIKE 'IB-%' AND
              nlpla LIKE 'DI-OF1-01' OR vlpla LIKE 'DI-%' AND nlpla LIKE 'DI-OF1-01') OR (client_id, wh_id) = (10, 7)
         AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-2' OR vlpla LIKE 'DI-%' AND nlpla LIKE 'DI-OF1-1') OR (client_id
           , wh_id) = (18, 4) AND vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-01' OR (client_id, wh_id) = (13, 60) AND (vlpla
            LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-%' OR vlpla LIKE 'DI-%' AND nlpla LIKE 'IB-OF1-%' OR vlpla LIKE 'N1-%'
          AND nlpla LIKE 'N1-OF1-%') OR (client_id, wh_id) = (23, 18) AND nlpla LIKE 'TI-OF1-01' AND vlpla NOT LIKE
       '%-NO1-%'
    THEN 1
    ELSE 0
    END AS send_out,
    CASE
    WHEN (client_id, wh_id) = (23, 18) AND vlpla LIKE '%-NO1-%' AND nlpla LIKE 'TI-OF1-01'
    THEN 1
    ELSE 0
    END AS nio_send_out
  FROM ldl_logop_data.t_sapewm_warehousetask_2 AS WHT
  WHERE tostat = 'C'
   AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (13, 60), (18, 4), (23, 18), (25, 96))
   AND (CASE
           WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, ''
                           ) <> 'MLOC' OR nlpla LIKE 'P2-IP1-%' AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <>
                          'MLOC' OR vlpla LIKE 'P2-IP1-%' AND nlpla LIKE 'P2-NO1-%' AND STARTS_WITH(vlenr, '9') OR (nlpla
                            LIKE 'F1-IP1-%' OR nlpla LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr,
                         '3') AND IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'F1-IP1-%' OR vlpla LIKE 'B1-IP1-%' OR
                          vlpla LIKE 'B2-IP1-%') AND (nlpla LIKE 'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE
                          'B2-NO1-%') AND STARTS_WITH(vlenr, '9')) OR (client_id, wh_id) = (8, 6) AND (nlpla LIKE
                         'IB-IP2-%' OR nlpla LIKE 'DI-IPN_2-%' OR nlpla LIKE 'DI-IPT-%' OR nlpla LIKE 'DI-IP2-%') AND
                    IFNULL(exccode, '') <> 'MLOC' OR (client_id, wh_id) = (10, 7) AND ((nlpla LIKE 'OB-IP2-%' OR nlpla
                              LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <> 'MLOC' OR vlpla LIKE
                           'DI-IP1-%' AND nlpla = 'DI-OF1-01' OR (nlpla LIKE 'P1-IP2-%' OR nlpla LIKE 'P2-IP2-%') AND
                          STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'P1-IP1-%' OR vlpla
                            LIKE 'P2-IP1-%') AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%') AND STARTS_WITH(vlenr
                         , '9') OR (nlpla LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr, '3') AND
                        IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'B1-IP1-%' OR vlpla LIKE 'B2-IP1-%') AND (nlpla
                          LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND STARTS_WITH(vlenr, '9') OR nlpla LIKE 'N1-IP2-%'
                       AND IFNULL(exccode, '') <> 'MLOC') OR (client_id, wh_id) = (18, 4) AND (nlpla LIKE 'IB-IP2-%' AND
                        IFNULL(exccode, '') <> 'MLOC' OR (nlpla LIKE 'P1-IP1-%' OR nlpla LIKE 'P2-IP1-%') AND
                        STARTS_WITH(vlenr, '3') AND IFNULL(exccode, '') <> 'MLOC' OR (vlpla LIKE 'P1-IP1-%' OR vlpla
                          LIKE 'P2-IP1-%') AND (nlpla LIKE 'P1-IP2-%' OR nlpla LIKE 'P2-IP2-%') AND STARTS_WITH(vlenr,
                       '9') OR (nlpla LIKE 'B1-IP1-%' OR nlpla LIKE 'B2-IP1-%') AND STARTS_WITH(vlenr, '3') AND IFNULL(exccode
                       , '') <> 'MLOC' OR (vlpla LIKE 'B1-IP1-%' OR vlpla LIKE 'B2-IP1-%') AND (nlpla LIKE 'B1-NO1-%' OR
                        nlpla LIKE 'B2-NO1-%') AND STARTS_WITH(vlenr, '9')) OR (client_id, wh_id) = (23, 18) AND vlpla
                 LIKE 'TI-IP1-%' OR (client_id, wh_id) = (25, 96) AND (nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%' OR
                    nlpla LIKE 'IB-IPN_2-%' OR nlpla LIKE 'DI-IPN_2-%') AND IFNULL(exccode, '') <> 'MLOC' OR (client_id,
                 wh_id) = (13, 60) AND (nlpla LIKE 'IB-IP2-%' OR nlpla LIKE 'DI-IP2-%') AND IFNULL(exccode, '') <>
               'MLOC' OR nlpla LIKE 'N1-IP2-%' AND IFNULL(exccode, '') <> 'MLOC'
           THEN 1
           ELSE 0
           END = 1 OR CASE
           WHEN (client_id, wh_id) = (1, 9) AND ((vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%') AND (nlpla LIKE 'HF-%'
                            OR nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01') OR vlpla LIKE 'P2-IP2-%' AND (nlpla LIKE
                           'HF-%' OR nlpla LIKE 'OB-OF%' OR nlpla LIKE 'RL-OF1-01') OR (vlpla LIKE 'F1-IP2-%' OR vlpla
                          LIKE 'B1-IP2-%' OR vlpla LIKE 'B2-IP2-%') AND (nlpla LIKE 'F1-PD1-%' OR nlpla LIKE 'B1-PD1-%'
                        OR nlpla LIKE 'B2-PD1-%')) OR (client_id, wh_id) = (8, 6) AND (vlpla LIKE 'IB-IP2-%' OR vlpla
                         LIKE 'DI-IP2-%' OR vlpla LIKE 'IB-IPN_2-%' OR vlpla LIKE 'DI-IPN_2-%') AND nlpla LIKE 'HF-%' OR (client_id
                    , wh_id) = (10, 7) AND ((vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%' OR vlpla LIKE 'OB-IP2-%')
                       AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF%') OR (vlpla LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%'
                          ) AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF%') OR (vlpla LIKE 'B1-IP2-%' OR vlpla LIKE
                         'B2-IP2-%') AND (nlpla LIKE 'B1-PD1-%' OR nlpla LIKE 'B2-PD1-%') OR vlpla LIKE 'N1-IP2-%' AND (nlpla
                        LIKE 'HF-%' OR nlpla LIKE 'OB-OF%')) OR (client_id, wh_id) = (18, 4) AND (vlpla LIKE 'IB-IP2-%'
                     AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF1-%') OR (vlpla LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%'
                        ) AND (nlpla LIKE 'HF-%' OR nlpla LIKE 'OB-OF1-%' OR nlpla LIKE 'F1-OF1-%') OR (vlpla LIKE
                       'B1-IP2-%' OR vlpla LIKE 'B2-IP2-%') AND (nlpla LIKE 'B1-PD1%' OR nlpla LIKE 'B2-PD1%')) OR (client_id
                   , wh_id) = (23, 18) AND vlpla LIKE 'TI-IP2-%' AND nlpla LIKE 'TI-PC%' OR (client_id, wh_id) = (25, 96
                  ) AND (vlpla LIKE 'IB-IP2-%' OR vlpla LIKE 'DI-IP2-%' OR vlpla LIKE 'IB-IPN_2-%' OR vlpla LIKE
                   'DI-IPN_2-%') AND nlpla LIKE 'HF-%' OR (client_id, wh_id) = (13, 60) AND (vlpla LIKE 'IB-IP2-%' OR
                  vlpla LIKE 'DI-IP2-%') AND nlpla LIKE 'HF-%' OR vlpla LIKE 'N1-IP2-%' AND nlpla LIKE 'HF-%'
           THEN 1
           ELSE 0
           END = 1 OR CASE
          WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%') AND procty = '8091' AND
                       vlpla <> 'IB-SCN-01' AND vlpla NOT LIKE 'HF-%' OR nlpla LIKE 'P2-NO1-%' AND procty = '8091' OR (nlpla
                        LIKE 'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8091') OR (client_id
                   , wh_id) = (25, 96) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'IB-OF1-01')
                      AND procty = '8091' AND vltyp = '8180' AND vlpla NOT LIKE 'HF-%' OR procty = '8090' AND (nlpla
                        LIKE 'IB-NO1-%' AND vlpla LIKE 'IB-IPN_2-%' OR nlpla LIKE 'DI-NO1-%' AND vlpla LIKE 'DI-IPN_2-%'))
               OR (client_id, wh_id) = (8, 6) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE
                        'DI-OF1-01') AND procty = '8091' AND vltyp = '8180' AND vlpla NOT LIKE 'HF-%' OR procty = '8090'
                     AND (nlpla LIKE 'IB-NO1-%' AND (vlpla LIKE 'IB-IPN_2-%' OR vlpla LIKE 'IB-IPT-%') OR nlpla LIKE
                       'DI-NO1-%' AND (vlpla LIKE 'DI-IPN_2-%' OR vlpla LIKE 'DI-IPT-%'))) OR (client_id, wh_id) = (10, 7
                 ) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'OB-NO1-%' OR nlpla LIKE
                         'IB-OF1-1') AND procty = '8091' AND vlpla NOT LIKE 'HF-%' OR procty = '8091' AND vlpla LIKE
                       'OB-IP2-%' AND nlpla LIKE 'OB-CHK-%' OR procty = '8091' AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE
                        'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%' AND procty = '8091' AND vlpla LIKE 'P1-IP2-%') OR (nlpla
                      LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8091' OR nlpla LIKE 'N1-NO1-%' AND procty
                   = '8091') OR (client_id, wh_id) = (18, 4) AND (nlpla LIKE 'IB-NO1-%' AND procty = '8091' AND vlpla
                    NOT LIKE 'HF-%' OR procty = '8091' AND vlpla LIKE 'IB-IP2-%' AND nlpla LIKE 'OB-CHK-%' OR procty =
                   '8091' AND (nlpla LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%' AND procty =
                       '8091' AND (vlpla LIKE 'P1-IP2-%' OR vlpla LIKE 'P2-IP2-%')) OR (nlpla LIKE 'B1-NO1-%' OR nlpla
                    LIKE 'B2-NO1-%') AND procty = '8091') OR (client_id, wh_id) = (13, 60) AND (procty = '8091' AND
                     vltyp = '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'IB-OF1-%') AND vlpla LIKE 'IB%' AND vlpla
                  NOT LIKE 'HF%' OR procty = '8091' AND vltyp = '8180' AND (nlpla LIKE 'IB-NO1-%' OR nlpla LIKE
                      'IB-OF1-%') AND vlpla LIKE 'DI%' AND vlpla NOT LIKE 'HF%' OR procty = '8091' AND nlpla LIKE
                 'N1-NO1%') OR (client_id, wh_id) = (23, 18) AND nlpla LIKE '%-NO1-%' AND procty = '8291' AND vlpla
              NOT LIKE 'TI-SC1%' AND vlpla NOT LIKE 'TF-%'
          THEN 1
          ELSE 0
          END = 1 OR CASE
         WHEN (client_id, wh_id) = (1, 9) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE 'DI-NO1-%') AND (procty <> '8091' OR
                          vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999') OR nlpla LIKE 'P2-NO1-%' AND procty
                       NOT IN ('8091', '8099', '9999') OR (nlpla LIKE 'F1-NO1-%' OR nlpla LIKE 'B1-NO1-%' OR nlpla LIKE
                        'B2-NO1-%') AND procty = '8090') OR (client_id, wh_id) = (25, 96) AND (nlpla LIKE 'IB-NO1-%' AND
                        (procty <> '8091' OR vlpla LIKE 'HF-%') AND (procty <> '8090' OR vlpla LIKE 'IB-IPN_2%') AND
                      procty NOT IN ('8099', '9999') OR nlpla LIKE 'DI-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%'
                          ) AND (procty <> '8090' OR vlpla LIKE 'DI-IPN_2%') AND procty NOT IN ('8099', '9999')) OR (client_id
                   , wh_id) = (8, 6) AND (nlpla LIKE 'IB-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND procty
                     NOT IN ('8099', '9999') OR nlpla LIKE 'DI-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND
                     procty NOT IN ('8099', '9999')) OR (client_id, wh_id) = (10, 7) AND ((nlpla LIKE 'IB-NO1-%' OR
                           nlpla LIKE 'DI-NO1-%' OR nlpla LIKE 'OB-NO1-%' OR nlpla LIKE 'OB-CHK-%') AND (procty <>
                         '8091' OR vlpla LIKE 'HF-%') AND procty NOT IN ('8099', '9999') OR (nlpla LIKE 'P1-NO1-%' OR
                          nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%') AND (procty <> '8091' OR vlpla LIKE 'HF-%')
                     AND procty NOT IN ('8091', '8099', '9999') OR (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND
                     procty = '8090' OR nlpla LIKE 'N1-NO1-%' AND (procty <> '8091' OR vlpla LIKE 'HF-%') AND procty
                    NOT IN ('8099', '9999')) OR (client_id, wh_id) = (18, 4) AND ((nlpla LIKE 'IB-NO1-%' OR nlpla LIKE
                        'OB-CHK-%') AND procty = '8091' AND vlpla LIKE 'HF-%' AND procty NOT IN ('8099', '9999') OR (nlpla
                       LIKE 'P1-NO1-%' OR nlpla LIKE 'P2-NO1-%' OR nlpla LIKE 'OB-CHK-%') AND procty NOT IN ('8091',
                     '8099', '9999') OR (nlpla LIKE 'B1-NO1-%' OR nlpla LIKE 'B2-NO1-%') AND procty = '8090') OR (client_id
                , wh_id) = (13, 60) AND (nlpla LIKE '%IB-NO1-%' AND procty = '8091' AND vlpla LIKE 'HF-%' OR nlpla LIKE
                  '%IB-NO1-%' AND procty NOT IN ('8099', '9999')) OR nlpla LIKE 'N1-NO1-%' AND procty NOT IN ('8099',
               '9999') OR nlpla LIKE 'N1-NO1-%' AND procty IN ('8091') AND vlpla LIKE 'HF-%' OR (client_id, wh_id) = (23
             , 18) AND (nlpla LIKE '%-NO1-%' AND procty = '8291' AND vlpla NOT LIKE 'TF-%' OR nlpla LIKE '%-NO1-%' AND
               procty NOT IN ('8289', '9999'))
         THEN 1
         ELSE 0
         END = 1 OR CASE
        WHEN (client_id, wh_id) = (1, 9) AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-01' OR vlpla LIKE 'DI-%' AND
                   nlpla LIKE 'RL-OF1-01') OR (client_id, wh_id) = (25, 96) AND (vlpla LIKE 'IB-%' AND nlpla LIKE
                   'IB-OF1-01' OR vlpla LIKE 'DI-%' AND nlpla LIKE 'IB-OF1-01') OR (client_id, wh_id) = (8, 6) AND (vlpla
                  LIKE 'IB-%' AND nlpla LIKE 'DI-OF1-01' OR vlpla LIKE 'DI-%' AND nlpla LIKE 'DI-OF1-01') OR (client_id
               , wh_id) = (10, 7) AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-2' OR vlpla LIKE 'DI-%' AND nlpla LIKE
                 'DI-OF1-1') OR (client_id, wh_id) = (18, 4) AND vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-01' OR (client_id
             , wh_id) = (13, 60) AND (vlpla LIKE 'IB-%' AND nlpla LIKE 'IB-OF1-%' OR vlpla LIKE 'DI-%' AND nlpla LIKE
                'IB-OF1-%' OR vlpla LIKE 'N1-%' AND nlpla LIKE 'N1-OF1-%') OR (client_id, wh_id) = (23, 18) AND nlpla
            LIKE 'TI-OF1-01' AND vlpla NOT LIKE '%-NO1-%'
        THEN 1
        ELSE 0
        END = 1 OR CASE
       WHEN (client_id, wh_id) = (23, 18) AND vlpla LIKE '%-NO1-%' AND nlpla LIKE 'TI-OF1-01'
       THEN 1
       ELSE 0
       END = 1)), NIOHIST AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   source_system AS src_sys,
   wh_id,
   huident AS hu_ident,
   log_seq,
   DATE(utc_timestamp) AS crtd_on_dt,
   cp AS com_point,
   hu_status AS hu_stat,
   hu_status_short AS hu_stat_short,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_sapewm_niohistory_2
  WHERE (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (13, 60), (18, 4), (23, 18), (25, 96))) (SELECT t1.client_id,
   t1.lidl_ctry,
   t1.wh_id,
   t1.wh_task_nr,
   t1.wh_task_item,
   t1.wh_task_stat,
   t1.wh_proc_type,
   t1.wh_proc_cat,
   t1.doc_nr,
   t1.doc_cat,
   t1.conf_dt,
   t1.conf_tm,
   t1.queue,
   t1.exc_cd,
   t1.src_strg_bin,
   t1.src_hu,
   t1.src_strg_type,
   t1.src_rsrc,
   t1.dest_strg_bin,
   t1.dest_hu,
   t1.dest_strg_type,
   t1.dest_rsrc,
   t1.dwh_created,
   t1.dwh_updated,
   nh.hu_ident,
   nh.log_seq,
   nh.crtd_on_dt,
   nh.com_point,
   nh.hu_stat_short,
    CASE
    WHEN t1.client_id <> 23
    THEN IF((nh.com_point LIKE 'IB-IP1%' OR nh.com_point LIKE 'DI-IP1%' OR nh.com_point LIKE 'B1-IP1%' OR nh.com_point
            LIKE 'F1-IP1%' OR nh.com_point LIKE 'B2-IP1%' OR nh.com_point LIKE 'P2-IP1%' OR nh.com_point LIKE 'TI-IP1%'
       ) AND (nh.hu_stat_short LIKE 'CLOW' OR nh.hu_stat_short LIKE 'COBE' OR nh.hu_stat_short = 'CFFR'), NULL, nh.hu_stat_short
     )
    WHEN t1.client_id = 23
    THEN IF(nh.com_point LIKE 'TI%' AND nh.hu_stat_short IS NOT NULL, nh.hu_stat_short, NULL)
    ELSE NULL
    END AS err_cd,
   ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
      , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
      IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item) AS row_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.hu_checked, NULL) AS hu_checked,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.hu_passed, NULL) AS hu_passed,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.nio_count, NULL) AS nio_count,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.nio_sonstige, NULL) AS nio_sonstige
   ,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.send_out, NULL) AS send_out,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
         , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1.wh_task_nr
         IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1, t1.nio_send_out, NULL) AS nio_send_out
   ,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_id AS STRING), CAST(t1.wh_task_nr AS STRING)
          , CAST(t1.wh_task_item AS STRING) ORDER BY t1.client_id IS NULL, t1.client_id, t1.wh_id IS NULL, t1.wh_id, t1_2
          .wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_task_item IS NULL, t1.wh_task_item)) = 1 AND (t1.hu_checked = 1 OR
            t1.hu_passed = 1 OR t1.nio_count = 1 OR t1.nio_sonstige = 1 OR t1.send_out = 1 OR t1.nio_send_out = 1), t1.conveyor_id
    , NULL) AS conveyor_id
  FROM NIO AS t1_2
   LEFT JOIN NIOHIST AS nh ON t1.client_id = nh.client_id AND t1.wh_id = nh.wh_id AND t1.src_hu = nh.hu_ident AND t1.conf_dt
       = nh.crtd_on_dt AND t1.nio_count = 1);