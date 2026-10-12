CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_schwarz_produktion_email_2 (id, test_object_id, branch_id,
source_system_primary_key, source_system_id, country_id, is_relevant, maktx, matkl, mstae, werks, content_hash_code,
werk_split, ref_mail_sp_werk_id, ref_mail_sp_wg_id, ref_mail_sp_matart_id) AS ((((((SELECT t1.id,
       t1.test_object_id,
       t1.branch_id,
       t1.source_system_primary_key,
       t1.source_system_id,
       t1.country_id,
       t1.is_relevant,
       t1.maktx,
       t1.matkl,
       t1.mstae,
       t1.werks,
       t1.content_hash_code,
       t1.value AS werk_split,
       MWERK.id AS ref_mail_sp_werk_id,
       MWG.id AS ref_mail_sp_wg_id,
       MMTART.id AS ref_mail_sp_matart_id
      FROM (SELECT A.id,
         A.test_object_id,
         A.branch_id,
         A.source_system_primary_key,
         A.source_system_id,
         A.country_id,
         A.is_relevant,
         A.maktx,
         A.matkl,
         A.mstae,
         A.werks,
         A.content_hash_code,
         A.mtart,
         t.seq,
          ORDINALITY + 1 AS index,
         VALUE AS value
        FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
         INNER JOIN (SELECT 1 AS seq) AS t ON TRUE
         INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_2
       INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t1.test_object_id = E.test_object_id
       INNER JOIN idq_production_idq_results.ref_mail_sp_werk_2 AS MWERK ON t1.value = MWERK.werk
       INNER JOIN idq_production_idq_results.ref_mail_sp_wg_2 AS MWG ON t1.matkl = MWG.wg
       INNER JOIN idq_production_idq_results.ref_mail_sp_matart_2 AS MMTART ON t1.mtart = MMTART.matart
      UNION DISTINCT
      SELECT t4.id,
       t4.test_object_id,
       t4.branch_id,
       t4.source_system_primary_key,
       t4.source_system_id,
       t4.country_id,
       t4.is_relevant,
       t4.maktx,
       t4.matkl,
       t4.mstae,
       t4.werks,
       t4.content_hash_code,
       t4.value AS werk_split,
       MWERK.id AS ref_mail_sp_werk_id,
       MWG.id AS ref_mail_sp_wg_id,
       1 AS ref_mail_sp_matart_id
      FROM (SELECT A.id,
         A.test_object_id,
         A.branch_id,
         A.source_system_primary_key,
         A.source_system_id,
         A.country_id,
         A.is_relevant,
         A.maktx,
         A.matkl,
         A.mstae,
         A.werks,
         A.content_hash_code,
         A.mtart,
         t3.seq,
          ORDINALITY + 1 AS index,
         VALUE AS value
        FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
         INNER JOIN (SELECT 1 AS seq) AS t3 ON TRUE
         INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
       INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t4.test_object_id = E.test_object_id
       INNER JOIN idq_production_idq_results.ref_mail_sp_werk_2 AS MWERK ON t4.value = MWERK.werk
       INNER JOIN idq_production_idq_results.ref_mail_sp_wg_2 AS MWG ON t4.matkl = MWG.wg)
     UNION DISTINCT
     SELECT t7.id,
      t7.test_object_id,
      t7.branch_id,
      t7.source_system_primary_key,
      t7.source_system_id,
      t7.country_id,
      t7.is_relevant,
      t7.maktx,
      t7.matkl,
      t7.mstae,
      t7.werks,
      t7.content_hash_code,
      t7.value AS werk_split,
      MWERK.id AS ref_mail_sp_werk_id,
      1 AS ref_mail_sp_wg_id,
      MMTART.id AS ref_mail_sp_matart_id
     FROM (SELECT A.id,
        A.test_object_id,
        A.branch_id,
        A.source_system_primary_key,
        A.source_system_id,
        A.country_id,
        A.is_relevant,
        A.maktx,
        A.matkl,
        A.mstae,
        A.werks,
        A.content_hash_code,
        A.mtart,
        t6.seq,
         ORDINALITY + 1 AS index,
        VALUE AS value
       FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
        INNER JOIN (SELECT 1 AS seq) AS t6 ON TRUE
        INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t7
      INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t7.test_object_id = E.test_object_id
      INNER JOIN idq_production_idq_results.ref_mail_sp_werk_2 AS MWERK ON t7.value = MWERK.werk
      INNER JOIN idq_production_idq_results.ref_mail_sp_matart_2 AS MMTART ON t7.mtart = MMTART.matart)
    UNION DISTINCT
    SELECT t10.id,
     t10.test_object_id,
     t10.branch_id,
     t10.source_system_primary_key,
     t10.source_system_id,
     t10.country_id,
     t10.is_relevant,
     t10.maktx,
     t10.matkl,
     t10.mstae,
     t10.werks,
     t10.content_hash_code,
     t10.value AS werk_split,
     MWERK.id AS ref_mail_sp_werk_id,
     1 AS ref_mail_sp_wg_id,
     1 AS ref_mail_sp_matart_id
    FROM (SELECT A.id,
       A.test_object_id,
       A.branch_id,
       A.source_system_primary_key,
       A.source_system_id,
       A.country_id,
       A.is_relevant,
       A.maktx,
       A.matkl,
       A.mstae,
       A.werks,
       A.content_hash_code,
       A.mtart,
       t9.seq,
        ORDINALITY + 1 AS index,
       VALUE AS value
      FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
       INNER JOIN (SELECT 1 AS seq) AS t9 ON TRUE
       INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t10
     INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t10.test_object_id = E.test_object_id
     INNER JOIN idq_production_idq_results.ref_mail_sp_werk_2 AS MWERK ON t10.value = MWERK.werk)
   UNION DISTINCT
   SELECT t13.id,
    t13.test_object_id,
    t13.branch_id,
    t13.source_system_primary_key,
    t13.source_system_id,
    t13.country_id,
    t13.is_relevant,
    t13.maktx,
    t13.matkl,
    t13.mstae,
    t13.werks,
    t13.content_hash_code,
    t13.value AS werk_split,
    1 AS ref_mail_sp_werk_id,
    MWG.id AS ref_mail_sp_wg_id,
    MMTART.id AS ref_mail_sp_matart_id
   FROM (SELECT A.id,
      A.test_object_id,
      A.branch_id,
      A.source_system_primary_key,
      A.source_system_id,
      A.country_id,
      A.is_relevant,
      A.maktx,
      A.matkl,
      A.mstae,
      A.werks,
      A.content_hash_code,
      A.mtart,
      t12.seq,
       ORDINALITY + 1 AS index,
      VALUE AS value
     FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
      INNER JOIN (SELECT 1 AS seq) AS t12 ON TRUE
      INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t13
    INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t13.test_object_id = E.test_object_id
    INNER JOIN idq_production_idq_results.ref_mail_sp_wg_2 AS MWG ON t13.matkl = MWG.wg
    INNER JOIN idq_production_idq_results.ref_mail_sp_matart_2 AS MMTART ON t13.mtart = MMTART.matart)
  UNION DISTINCT
  SELECT t16.id,
   t16.test_object_id,
   t16.branch_id,
   t16.source_system_primary_key,
   t16.source_system_id,
   t16.country_id,
   t16.is_relevant,
   t16.maktx,
   t16.matkl,
   t16.mstae,
   t16.werks,
   t16.content_hash_code,
   t16.value AS werk_split,
   1 AS ref_mail_sp_werk_id,
   MWG.id AS ref_mail_sp_wg_id,
   1 AS ref_mail_sp_matart_id
  FROM (SELECT A.id,
     A.test_object_id,
     A.branch_id,
     A.source_system_primary_key,
     A.source_system_id,
     A.country_id,
     A.is_relevant,
     A.maktx,
     A.matkl,
     A.mstae,
     A.werks,
     A.content_hash_code,
     A.mtart,
     t15.seq,
      ORDINALITY + 1 AS index,
     VALUE AS value
    FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
     INNER JOIN (SELECT 1 AS seq) AS t15 ON TRUE
     INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t16
   INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t16.test_object_id = E.test_object_id
   INNER JOIN idq_production_idq_results.ref_mail_sp_wg_2 AS MWG ON t16.matkl = MWG.wg)
 UNION DISTINCT
 SELECT t19.id,
  t19.test_object_id,
  t19.branch_id,
  t19.source_system_primary_key,
  t19.source_system_id,
  t19.country_id,
  t19.is_relevant,
  t19.maktx,
  t19.matkl,
  t19.mstae,
  t19.werks,
  t19.content_hash_code,
  t19.value AS werk_split,
  1 AS ref_mail_sp_werk_id,
  1 AS ref_mail_sp_wg_id,
  MMTART.id AS ref_mail_sp_matart_id
 FROM (SELECT A.id,
    A.test_object_id,
    A.branch_id,
    A.source_system_primary_key,
    A.source_system_id,
    A.country_id,
    A.is_relevant,
    A.maktx,
    A.matkl,
    A.mstae,
    A.werks,
    A.content_hash_code,
    A.mtart,
    t18.seq,
     ORDINALITY + 1 AS index,
    VALUE AS value
   FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
    INNER JOIN (SELECT 1 AS seq) AS t18 ON TRUE
    INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t19
  INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t19.test_object_id = E.test_object_id
  INNER JOIN idq_production_idq_results.ref_mail_sp_matart_2 AS MMTART ON t19.mtart = MMTART.matart)
UNION DISTINCT
SELECT t22.id,
 t22.test_object_id,
 t22.branch_id,
 t22.source_system_primary_key,
 t22.source_system_id,
 t22.country_id,
 t22.is_relevant,
 t22.maktx,
 t22.matkl,
 t22.mstae,
 t22.werks,
 t22.content_hash_code,
 t22.value AS werk_split,
 1 AS ref_mail_sp_werk_id,
 1 AS ref_mail_sp_wg_id,
 1 AS ref_mail_sp_matart_id
FROM (SELECT A.id,
   A.test_object_id,
   A.branch_id,
   A.source_system_primary_key,
   A.source_system_id,
   A.country_id,
   A.is_relevant,
   A.maktx,
   A.matkl,
   A.mstae,
   A.werks,
   A.content_hash_code,
   A.mtart,
   t21.seq,
    ORDINALITY + 1 AS index,
   VALUE AS value
  FROM idq_production_idq_results.idq_addinfo_schwarz_produktion_article_2 AS A
   INNER JOIN (SELECT 1 AS seq) AS t21 ON TRUE
   INNER JOIN UNNEST(SPLIT(A.WERKS, '|')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t22
 INNER JOIN idq_production_idq_results.check_error_info_current_2 AS E ON t22.test_object_id = E.test_object_id
 INNER JOIN idq_production_idq_results.ref_mail_sp_matart_2 AS MMTART ON TRUE;