CREATE OR REPLACE VIEW p_lew_process.v_wawi_tobelist_p2wk_2
(
   country_iso_cd
  ,country_id
  ,wh_id
  ,client_id
  ,loc_sid_wh
  ,interface_desc
  ,interface_key
  ,system_key
  ,EJR
  ,test_flag
)
AS
------------------------------------------------------------------------------------------------------------------
-- Logik wurde aus der Viewdefintion x_process_view.v_wawi_tobelist_p2wk_2 uebernommen  und um client_id, loc_sid_wh
-- Erweitert.
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- 1. SELECT client_id and wh_id where org_store_nr <> wh_id (wh has no pseudo store)
-- and has been used in the last 14 days
-- set EJR = 1
------------------------------------------------------------------------------------------------------------------
SELECT
rc.country_iso_cd AS country_iso_cd,
rc.country_id AS country_id,
l.src_wh_id AS wh_id,
oss.client_id,
oss.wh_loc_sid AS loc_sid_wh,
NULL AS interface_desc,
NULL AS interface_key,
NULL AS system_key,
1 AS EJR,
0 AS test_flag
FROM p_lew_core_ac.v_wawi_org_store_skey_2 oss

INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 rcc
ON oss.client_id = rcc.client_id

INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 rc
ON rcc.country_id = rc.country_id

INNER JOIN p_lew_core_ac.v_location_2 l
ON oss.client_id = l.client_id
  AND oss.wh_loc_sid = l.loc_sid

WHERE Current_Date BETWEEN oss.dat_rec_start AND oss.dat_rec_end
  AND oss.orig_store_nr <> l.src_wh_id -- keine Pseudostores
  AND (rc.country_iso_cd, l.src_wh_id) IN
  (SELECT
country_iso_cd,
wh_id
FROM p_lew_process_ac.v_wawi_sys_dc_trans_dayend_int_2
    WHERE dat_dayend > Current_Date - 14
  )
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

UNION

----------------------------------------------------------------------------------------------------------
-- 2. SELECT client_id and wh_id
-- that not in 1. SELECT (wh has pseudo store)
-- and has been used in the last 14 days
-- set EJR = 0
----------------------------------------------------------------------------------------------------------
SELECT
rc.country_iso_cd AS country_iso_cd,
rc.country_id AS country_id,
l.src_wh_id AS wh_id,
ow.client_id,
ow.wh_loc_sid AS loc_sid_wh,
NULL AS interface_desc,
NULL AS interface_key,
NULL AS system_key,
0 AS EJR,
0 AS test_flag
FROM p_lew_core_ac.v_wawi_org_wh_2 ow

INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 rcc
ON ow.client_id = rcc.client_id

INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 rc
ON rcc.country_id = rc.country_id

INNER JOIN p_lew_core_ac.v_location_2 l
ON ow.client_id = l.client_id
  AND ow.wh_loc_sid = l.loc_sid

WHERE Current_Date BETWEEN ow.dat_rec_start AND ow.dat_rec_end
  AND (ow.client_id, l.src_wh_id) NOT IN
  (SELECT
oss.client_id,
l.src_wh_id
FROM p_lew_core_ac.v_wawi_org_store_skey_2 oss

INNER JOIN p_lew_core_ac.v_location_2 l
ON oss.client_id = l.client_id
  AND oss.wh_loc_sid = l.loc_sid

WHERE Current_Date BETWEEN oss.dat_rec_start AND oss.dat_rec_end
  AND oss.orig_store_nr <> l.src_wh_id
)
AND ow.wawi_data_fg = 1
AND l.src_wh_id <> 0
AND (rc.country_iso_cd, l.src_wh_id) IN
(SELECT
country_iso_cd,
wh_id
FROM p_lew_process_ac.v_wawi_sys_dc_trans_dayend_int_2
    WHERE dat_dayend > Current_Date - 14
  )

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

UNION

-------------------------------------------------------------------------------------------------------------
-- 3. SELECT client_id and wh_id where wh_id = 0 (whole country_2)
-- set EJR = 0
-------------------------------------------------------------------------------------------------------------
SELECT
rc.country_iso_cd AS country_iso_cd,
rc.country_id AS country_id,
l.src_wh_id AS wh_id,
oss.client_id,
oss.wh_loc_sid AS loc_sid_wh,
NULL AS interface_desc,
NULL AS interface_key,
NULL AS system_key,
0 AS EJR,
0 AS test_flag
FROM p_lew_core_ac.v_wawi_org_store_skey_2 oss

INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 rcc
ON oss.client_id = rcc.client_id

INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 rc
ON rcc.country_id = rc.country_id

INNER JOIN p_lew_core_ac.v_location_2 l
ON oss.client_id = l.client_id
  AND oss.wh_loc_sid = l.loc_sid

WHERE Current_Date BETWEEN oss.dat_rec_start AND oss.dat_rec_end
  AND l.src_wh_id = 0

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
;

