/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  13.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_thm_1
OPTIONS(DESCRIPTION = 'MULTI LANGUAGE REFERENCE VIEW FOR THM', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true)
AS
SELECT client_id,
 orig_thm_nr,
 MAX(factor_ep) AS factor_ep,
 MAX(CASE
   WHEN language_id IN (7)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc,
 MAX(CASE
   WHEN language_id IN (1)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_at,
 MAX(CASE
   WHEN language_id IN (2)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_be,
 MAX(CASE
   WHEN language_id IN (12)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_be_fr,
 MAX(CASE
   WHEN language_id IN (3)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_bg,
 MAX(CASE
   WHEN language_id IN (4)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_ch,
 MAX(CASE
   WHEN language_id IN (5)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_cy,
 MAX(CASE
   WHEN language_id IN (6)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_cz,
 MAX(CASE
   WHEN language_id IN (8)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_dk,
 MAX(CASE
   WHEN language_id IN (9)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_es,
 MAX(CASE
   WHEN language_id IN (11)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_fi,
 MAX(CASE
   WHEN language_id IN (12)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_fr,
 MAX(CASE
   WHEN language_id IN (13)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_gr,
 MAX(CASE
   WHEN language_id IN (15)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_hr,
 MAX(CASE
   WHEN language_id IN (16)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_it,
 MAX(CASE
   WHEN language_id IN (19)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_lt,
 MAX(CASE
   WHEN language_id IN (20)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_lv,
 MAX(CASE
   WHEN language_id IN (21)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_ni,
 MAX(CASE
   WHEN language_id IN (22)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_nl,
 MAX(CASE
   WHEN language_id IN (23)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_de,
 MAX(CASE
   WHEN language_id IN (24)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_pl,
 MAX(CASE
   WHEN language_id IN (25)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_pt,
 MAX(CASE
   WHEN language_id IN (26)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_ro,
 MAX(CASE
   WHEN language_id IN (27)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_se,
 MAX(CASE
   WHEN language_id IN (28)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_si,
 MAX(CASE
   WHEN language_id IN (29)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_sk,
 MAX(CASE
   WHEN language_id IN (31)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_cs,
 MAX(CASE
   WHEN language_id IN (32)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_mt,
 MAX(CASE
   WHEN language_id IN (33)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_us,
 MAX(CASE
   WHEN language_id IN (34)
   THEN thm_desc
   ELSE NULL
   END) AS thm_desc_rs
FROM (SELECT OCS.client_id,
   COALESCE(THM_CLIENT.orig_thm_nr, THM_GLOBAL.orig_thm_nr) AS orig_thm_nr,
   COALESCE(THM_CLIENT.factor_ep, THM_GLOBAL.factor_ep) AS factor_ep,
   COALESCE(THM_CLIENT.language_id, THM_GLOBAL.language_id) AS language_id,
   COALESCE(THM_CLIENT.thm_desc, THM_GLOBAL.thm_desc) AS thm_desc
  FROM ldl_p_lew_core_ac.v_wawi_org_client_skey_1 AS OCS
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_thm_1 AS THM_CLIENT ON OCS.client_id = THM_CLIENT.client_id
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_thm_1 AS THM_GLOBAL ON THM_CLIENT.client_id IS NULL AND THM_GLOBAL.client_id = 7
     ) AS t
GROUP BY client_id,
 orig_thm_nr;


