/* #----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  13.10.2017    Meister,Ulrich logic moved from mart_msi to lew_bil llll ll
#  1.2  18.09.2017    -                        Generiert aus Teradata
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  18.09.2017    -                        Generiert aus Teradata
#  1.5  05.12.2017    Proch, Marika            Änderung des BIL-Layers
#  1.6  21.12.2017    Proch,Marika             Austausch des BIL-Layers
#  1.7  10.01.2018    Proch,Marika             Änderung der desc von max auf min
#  1.8  08.02.2018    Proch,Marika             Änderung der Logik für die itemgroup_int_remark
#  1.0  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_itemgroup_int
#  1.9  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  2.0  08.03.2021    Piotr Krawczyk           Used DE/US description for itemgroup_int
#  2.1  24.03.2021    Torsten Bachmann         Further adjustment for description for WGI 0
#  2.2  17.12.2021    Michael Morris           Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_itemgroup_int AS /* Datentypangleichung */
/* pick best der verfügbaren Bezeichnungen pro client_id durch Maximumbestimmung */ SELECT CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC)
 AS itemgroup_int_id,
 MAX(COALESCE(itemgroup_desc_lidl_long, itemgroup_desc_lidl)) AS itemgroup_int_remark,
 MAX(CASE
   WHEN client_id = 1
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_at,
 MAX(CASE
   WHEN client_id = 2
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_be,
 MAX(CASE
   WHEN client_id = 3
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_bg,
 MAX(CASE
   WHEN client_id = 4
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_ch,
 MAX(CASE
   WHEN client_id = 5
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_cy,
 MAX(CASE
   WHEN client_id = 6
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_cz,
 MAX(CASE
   WHEN client_id = 23 AND CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) <> 0
   THEN CONCAT(CAST(CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS STRING), ' ',
    itemgroup_desc_lidl)
   WHEN client_id = 33 AND CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) = 0
   THEN '0 Administration'
   WHEN client_id = 33 AND CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) = - 2000
   THEN CONCAT(CAST(CAST(ROUND(CAST(src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS STRING), ' ',
    item_grp_int_name)
   ELSE NULL
   END) AS itemgroup_int_desc,
 MAX(CASE
   WHEN client_id = 8
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_dk,
 MAX(CASE
   WHEN client_id = 9
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_ee,
 MAX(CASE
   WHEN client_id = 10
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_es,
 MAX(CASE
   WHEN client_id = 11
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_fi,
 MAX(CASE
   WHEN client_id = 12
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_fr,
 MAX(CASE
   WHEN client_id = 13
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_gb,
 MAX(CASE
   WHEN client_id = 14
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_gr,
 MAX(CASE
   WHEN client_id = 15
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_hr,
 MAX(CASE
   WHEN client_id = 16
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_hu,
 MAX(CASE
   WHEN client_id = 17
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_ie,
 MAX(CASE
   WHEN client_id = 18
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_it,
 MAX(CASE
   WHEN client_id = 19
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_lt,
 MAX(CASE
   WHEN client_id = 20
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_lv,
 MAX(CASE
   WHEN client_id = 21
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_ni,
 MAX(CASE
   WHEN client_id = 22
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_nl,
 MAX(CASE
   WHEN client_id = 23
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_de,
 MAX(CASE
   WHEN client_id = 24
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_pl,
 MAX(CASE
   WHEN client_id = 25
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_pt,
 MAX(CASE
   WHEN client_id = 26
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_ro,
 MAX(CASE
   WHEN client_id = 27
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_se,
 MAX(CASE
   WHEN client_id = 28
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_si,
 MAX(CASE
   WHEN client_id = 29
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_sk,
 MAX(CASE
   WHEN client_id = 31
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_cs,
 MAX(CASE
   WHEN client_id = 32
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_mt,
 MAX(CASE
   WHEN client_id = 33
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_us,
 MAX(CASE
   WHEN client_id = 34
   THEN itemgroup_desc_default
   ELSE NULL
   END) AS itemgroup_int_desc_rs
FROM ldl_p_lew_bil_ac.v_itemgroup_international
GROUP BY itemgroup_int_id;