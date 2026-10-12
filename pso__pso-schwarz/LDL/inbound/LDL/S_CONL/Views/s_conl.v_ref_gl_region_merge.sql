CREATE OR REPLACE VIEW s_conl.v_ref_gl_region_merge
AS
/*
#DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
client_id -- techn. Schlüssel zur Referenzierung des Landes
,
gl_region_id  -- Regions_id
,
gl_region_desc  -- Name der Region
,
gl_last_name -- Nachname des GL
,
gl_first_name -- Vorname des GL
,
1 AS aspect_id -- BGES (Beliefernde Gesellschaften)

FROM p_lew_core_ac.v_wawi_ref_gl_region
WHERE client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user))

UNION ALL
SELECT
client_id -- techn. Schlüssel zur Referenzierung des Landes
,
gl_region_id -- Regions_id
,
gl_region_desc -- Name der Region
,
gl_last_name  -- Nachname des Geschäftsleiters
,
gl_first_name -- Vorname des Geschäftsleiters
,
2 AS aspect_id -- VGES (Vetriebs-Gesellschaften)

FROM p_lew_core_ac.v_wawi_ref_gl_region
WHERE client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user))

UNION ALL
/* dummy region for country level in aspect id 1 and 2 */
SELECT
client_id                                         AS client_id,
-1*client_id                                      AS gl_region_id,
'#'|| TRIM( cntr.country_iso_cd)
AS gl_region_desc,
CAST(cntr.country_iso_cd AS VARCHAR(30))          AS gl_last_name,
'#'                          AS gl_first_name,
multiply.row_no                                   AS aspect_id
FROM p_lew_core_ac.v_wawi_ref_client_country AS clnt

INNER JOIN p_lew_core_ac.v_wawi_ref_country  AS cntr
ON clnt.country_id = cntr.country_id

CROSS JOIN (SELECT
1 AS row_no
FROM (SELECT
1 AS one) SUB1
UNION ALL
SELECT
2 AS row_no
FROM (SELECT
1 AS two) SUB2
) AS multiply
WHERE cntr.dashboard_relevant_fg = 1
	and client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_store" ***/

