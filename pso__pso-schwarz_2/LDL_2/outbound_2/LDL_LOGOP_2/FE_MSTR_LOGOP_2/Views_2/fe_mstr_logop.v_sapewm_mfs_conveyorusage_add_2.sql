/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_conveyorusage_add_2
Description		|	SAP EWM MFS - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_conveyorusage_add_2 (client_id
OPTIONS(description='Client ID'), lidl_ctry OPTIONS(description='Country_2 code'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task'), wh_task_item
OPTIONS(description='Warehouse Task Item_2'), wh_task_stat OPTIONS(description='Warehouse Task Status_2'), wh_proc_type
OPTIONS(description='Warehouse Process Type'), wh_proc_cat OPTIONS(description='Warehouse Process Category'), doc_nr
OPTIONS(description='Document'), doc_cat OPTIONS(description='Document Category for Document-Related Stocks'), conf_dt
OPTIONS(description='Confirmation date'), conf_tm OPTIONS(description='Confirmation time'), conf_hr
OPTIONS(description='Confirmation hour'), queue OPTIONS(description='Queue'), exc_cd
OPTIONS(description='Exception Code'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit_2'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit_2'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), ct_id
OPTIONS(description='Conveyor type ID')) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 wh_id,
 tanum AS wh_task_nr,
 tapos AS wh_task_item,
 tostat AS wh_task_stat,
 procty AS wh_proc_type,
 trart AS wh_proc_cat,
 docno AS doc_nr,
 CAST(itemno AS STRING) AS doc_cat,
 confirmed_date AS conf_dt,
 confirmed_time AS conf_tm,
 TIME_TRUNC(confirmed_time, HOUR) AS conf_hr,
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
  WHEN (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (18, 4), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'IB-IP2-%'
       AND procty = '8090' OR (client_id, wh_id) = (25, 96) AND nlpla LIKE 'HF%' AND (vlpla LIKE 'IB-IP2-%' OR vlpla
        LIKE 'IB-IPN_2-%') AND procty = '8090'
  THEN 1
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (10, 7), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'DI-IP2-%' AND
     procty = '8090' OR (client_id, wh_id) = (8, 6) AND nlpla LIKE 'HF%' AND (vlpla LIKE 'DI-IP2-%' OR vlpla LIKE
         'DI-IPN_2-%' OR vlpla LIKE 'DI-IPT-%') AND procty = '8090'
  THEN 2
  WHEN (client_id, wh_id) = (1, 9) AND nlpla LIKE 'HF%' AND vlpla LIKE 'P2-IP2-%' AND procty IN ('8090', '8098')
  THEN 3
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND procty = '8090' AND nlpla LIKE 'HF%' AND vlpla LIKE 'P1-IP2-%'
  THEN 31
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND procty = '8090' AND nlpla LIKE 'HF%' AND vlpla LIKE 'P2-IP2-%'
  THEN 32
  WHEN (client_id, wh_id) = (1, 9) AND procty IN ('8090', '8098') AND vlpla LIKE 'F1-IP2-%' AND nlpla LIKE 'F1-PD1-%'
  THEN 41
  WHEN (client_id, wh_id) = (1, 9) AND procty = '8090' AND vlpla LIKE 'B1-IP2-%' AND nlpla LIKE 'B1-PD1-%'
  THEN 42
  WHEN (client_id, wh_id) = (1, 9) AND procty = '8090' AND vlpla LIKE 'B2-IP2-%' AND nlpla LIKE 'B2-PD1-%'
  THEN 43
  WHEN (client_id, wh_id) = (10, 7) AND procty = '8090' AND (nlpla, vlpla) IN (('B1-PD1-1', 'B1-IP2-1'), ('B1-PD1-7',
      'B1-IP2-7'), ('B1-PD1-8', 'B1-IP2-8'))
  THEN 44
  WHEN (client_id, wh_id) = (10, 7) AND procty = '8090' AND nlpla = 'B2-PD1-%' AND vlpla = 'B2-IP2-%'
  THEN 45
  WHEN (client_id, wh_id) = (18, 4) AND procty = '8090' AND (nlpla, vlpla) IN (('B1-PD1-02', 'B1-IP2-02'), ('B1-PD1-04'
      , 'B1-IP2-04'), ('B1-PD1-06', 'B1-IP2-06'))
  THEN 46
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7), (18, 4)) AND procty <> '8087' AND nlpla LIKE 'OB-OF1-%'
      AND vltyp = '8180'
  THEN 5
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7)) AND procty = '8087' AND nlpla LIKE 'OB-OF1-%'
  THEN 6
  WHEN (client_id, wh_id) = (25, 96) AND nlpla LIKE 'OB-PM1-%' AND procty = '8084'
  THEN 7
  WHEN (client_id, wh_id) = (8, 6) AND nlpla = 'DP-IP1-02'
  THEN 8
  WHEN (client_id, wh_id) = (8, 6) AND nlpla = 'DP-IP1-01'
  THEN 9
  WHEN (client_id, wh_id) IN ((10, 7), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'N1-IP2-%' AND procty = '8090'
  THEN 10
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND nlpla LIKE 'F1-OF1-%'
  THEN 11
  WHEN (client_id, wh_id) IN ((13, 60)) AND (nlpla LIKE 'RP-PM1-%' OR nlpla LIKE 'RP-OF1-%' OR nlpla LIKE 'OB-OF1%') AND
    procty IN ('8084', '8081', '8087')
  THEN 12
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'N1-OF1%' AND procty NOT IN ('8097', '8088')
  THEN 13
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-OF1-%' AND procty = '8092' AND vltyp = '8180'
  THEN 14
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-HPD-%' AND procty IN ('8082', '8083')
  THEN 15
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-HPB-%' AND procty IN ('8082', '8083') AND nltyp = '8141'
  THEN 151
  ELSE NULL
  END AS ct_id
FROM ldl_logop_data.t_sapewm_warehousetask_2
WHERE tostat = 'C'
 AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (18, 4), (13, 60), (25, 96))
 AND confirmed_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 360 DAY) AND (CURRENT_DATE)
 AND CASE
  WHEN (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (18, 4), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'IB-IP2-%'
       AND procty = '8090' OR (client_id, wh_id) = (25, 96) AND nlpla LIKE 'HF%' AND (vlpla LIKE 'IB-IP2-%' OR vlpla
        LIKE 'IB-IPN_2-%') AND procty = '8090'
  THEN 1
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (10, 7), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'DI-IP2-%' AND
     procty = '8090' OR (client_id, wh_id) = (8, 6) AND nlpla LIKE 'HF%' AND (vlpla LIKE 'DI-IP2-%' OR vlpla LIKE
         'DI-IPN_2-%' OR vlpla LIKE 'DI-IPT-%') AND procty = '8090'
  THEN 2
  WHEN (client_id, wh_id) = (1, 9) AND nlpla LIKE 'HF%' AND vlpla LIKE 'P2-IP2-%' AND procty IN ('8090', '8098')
  THEN 3
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND procty = '8090' AND nlpla LIKE 'HF%' AND vlpla LIKE 'P1-IP2-%'
  THEN 31
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND procty = '8090' AND nlpla LIKE 'HF%' AND vlpla LIKE 'P2-IP2-%'
  THEN 32
  WHEN (client_id, wh_id) = (1, 9) AND procty IN ('8090', '8098') AND vlpla LIKE 'F1-IP2-%' AND nlpla LIKE 'F1-PD1-%'
  THEN 41
  WHEN (client_id, wh_id) = (1, 9) AND procty = '8090' AND vlpla LIKE 'B1-IP2-%' AND nlpla LIKE 'B1-PD1-%'
  THEN 42
  WHEN (client_id, wh_id) = (1, 9) AND procty = '8090' AND vlpla LIKE 'B2-IP2-%' AND nlpla LIKE 'B2-PD1-%'
  THEN 43
  WHEN (client_id, wh_id) = (10, 7) AND procty = '8090' AND (nlpla, vlpla) IN (('B1-PD1-1', 'B1-IP2-1'), ('B1-PD1-7',
      'B1-IP2-7'), ('B1-PD1-8', 'B1-IP2-8'))
  THEN 44
  WHEN (client_id, wh_id) = (10, 7) AND procty = '8090' AND nlpla = 'B2-PD1-%' AND vlpla = 'B2-IP2-%'
  THEN 45
  WHEN (client_id, wh_id) = (18, 4) AND procty = '8090' AND (nlpla, vlpla) IN (('B1-PD1-02', 'B1-IP2-02'), ('B1-PD1-04'
      , 'B1-IP2-04'), ('B1-PD1-06', 'B1-IP2-06'))
  THEN 46
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7), (18, 4)) AND procty <> '8087' AND nlpla LIKE 'OB-OF1-%'
      AND vltyp = '8180'
  THEN 5
  WHEN (client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7)) AND procty = '8087' AND nlpla LIKE 'OB-OF1-%'
  THEN 6
  WHEN (client_id, wh_id) = (25, 96) AND nlpla LIKE 'OB-PM1-%' AND procty = '8084'
  THEN 7
  WHEN (client_id, wh_id) = (8, 6) AND nlpla = 'DP-IP1-02'
  THEN 8
  WHEN (client_id, wh_id) = (8, 6) AND nlpla = 'DP-IP1-01'
  THEN 9
  WHEN (client_id, wh_id) IN ((10, 7), (13, 60)) AND nlpla LIKE 'HF%' AND vlpla LIKE 'N1-IP2-%' AND procty = '8090'
  THEN 10
  WHEN (client_id, wh_id) IN ((10, 7), (18, 4)) AND nlpla LIKE 'F1-OF1-%'
  THEN 11
  WHEN (client_id, wh_id) IN ((13, 60)) AND (nlpla LIKE 'RP-PM1-%' OR nlpla LIKE 'RP-OF1-%' OR nlpla LIKE 'OB-OF1%') AND
    procty IN ('8084', '8081', '8087')
  THEN 12
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'N1-OF1%' AND procty NOT IN ('8097', '8088')
  THEN 13
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-OF1-%' AND procty = '8092' AND vltyp = '8180'
  THEN 14
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-HPD-%' AND procty IN ('8082', '8083')
  THEN 15
  WHEN (client_id, wh_id) IN ((13, 60)) AND nlpla LIKE 'OB-HPB-%' AND procty IN ('8082', '8083') AND nltyp = '8141'
  THEN 151
  ELSE NULL
  END IS NOT NULL;