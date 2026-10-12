/* dummy_1 region_1 for country_1 level in aspect id 1 and 2 */ -- VGES (Vetriebs-Gesellschaften)

-- BGES (Beliefernde Gesellschaften)

/* #DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
CREATE OR REPLACE VIEW ldl_s_conl.v_ref_gl_region_merge_1 AS SELECT client_id
 -- techn. Schlüssel zur Referenzierung des Landes
,
 gl_region_id -- Regions_id
,
 gl_region_desc -- Name der Region_1
,
 gl_last_name -- Nachname des GL
,
 gl_first_name -- Vorname des GL
,
 1 AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_gl_region_1
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()))
UNION ALL
SELECT client_id -- techn. Schlüssel zur Referenzierung des Landes
,
 gl_region_id -- Regions_id
,
 gl_region_desc -- Name der Region_1
,
 gl_last_name -- Nachname des Geschäftsleiters
,
 gl_first_name -- Vorname des Geschäftsleiters
,
 2 AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_gl_region_1
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()))
UNION ALL
SELECT CLNT.client_id,
  - 1 * CLNT.client_id AS gl_region_id,
  '#' || TRIM(CNTR.country_iso_cd) AS gl_region_desc,
 CAST(CNTR.country_iso_cd AS STRING) AS gl_last_name,
 '#' AS gl_first_name,
 multiply.row_no AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1
 AND CLNT.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_store_1" ***/