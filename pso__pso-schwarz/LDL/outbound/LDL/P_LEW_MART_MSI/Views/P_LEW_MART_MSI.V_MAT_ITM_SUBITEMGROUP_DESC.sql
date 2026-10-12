/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi_v_mat_itm_subitemgroup_desc
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.1  28.11.2017    Proch, Marika            Nutzung des neuen BIL-Layers
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.0  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_subitmgroup_desc
#                                              Stiftungssprache MIN anstatt MAX
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country LV
#  1.4  06.08.2021    Bachmann, Torsten        REP3-9088 INC3348712 - UWG Bonkennzahlen describtion
#                                              Change logic for display subitemgroup description
#  1.5  17.12.2021    Morris, Michael          Add Estonia EE
#----------------------------------------------------------------------------
# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_subitemgroup_desc AS /* Datentypangleichung */ SELECT
 subitemgroup_id,
 MAX(`A11864`) AS subitemgroup_desc_at,
 MAX(`A11865`) AS subitemgroup_desc_be,
 MAX(`A11866`) AS subitemgroup_desc_bg,
 MAX(`A11867`) AS subitemgroup_desc_ch,
 MAX(`A11868`) AS subitemgroup_desc_cy,
 MAX(`A11869`) AS subitemgroup_desc_cz,
 MIN(subitemgroup_desc_lidl) AS subitemgroup_desc,
 MAX(`A118610`) AS subitemgroup_desc_dk,
 MAX(`A118611`) AS subitemgroup_desc_ee,
 MAX(`A118612`) AS subitemgroup_desc_es,
 MAX(`A118613`) AS subitemgroup_desc_fi,
 MAX(`A118614`) AS subitemgroup_desc_fr,
 MAX(`A118615`) AS subitemgroup_desc_gb,
 MAX(`A118616`) AS subitemgroup_desc_gr,
 MAX(`A118617`) AS subitemgroup_desc_hr,
 MAX(`A118618`) AS subitemgroup_desc_hu,
 MAX(`A118619`) AS subitemgroup_desc_ie,
 MAX(`A118620`) AS subitemgroup_desc_it,
 MAX(`A118621`) AS subitemgroup_desc_lt,
 MAX(`A118622`) AS subitemgroup_desc_ni,
 MAX(`A118623`) AS subitemgroup_desc_nl,
 MAX(`A118624`) AS subitemgroup_desc_lv,
 MAX(`A118625`) AS subitemgroup_desc_de,
 MAX(`A118626`) AS subitemgroup_desc_pl,
 MAX(`A118627`) AS subitemgroup_desc_pt,
 MAX(`A118628`) AS subitemgroup_desc_ro,
 MAX(`A118629`) AS subitemgroup_desc_se,
 MAX(`A118630`) AS subitemgroup_desc_si,
 MAX(`A118631`) AS subitemgroup_desc_sk,
 MAX(`A118632`) AS subitemgroup_desc_cs,
 MAX(`A118633`) AS subitemgroup_desc_mt,
 MAX(`A118634`) AS subitemgroup_desc_us,
 MAX(`A118635`) AS subitemgroup_desc_rs,
 MAX(`A11864`) AS subitemgroup_short_desc_at,
 MAX(`A11865`) AS subitemgroup_short_desc_be,
 MAX(`A11866`) AS subitemgroup_short_desc_bg,
 MAX(`A11867`) AS subitemgroup_short_desc_ch,
 MAX(`A11868`) AS subitemgroup_short_desc_cy,
 MAX(`A11869`) AS subitemgroup_short_desc_cz,
 MIN(subitemgroup_desc_lidl) AS subitemgroup_short_desc,
 MAX(`A118610`) AS subitemgroup_short_desc_dk,
 MAX(`A118611`) AS subitemgroup_short_desc_ee,
 MAX(`A118612`) AS subitemgroup_short_desc_es,
 MAX(`A118613`) AS subitemgroup_short_desc_fi,
 MAX(`A118614`) AS subitemgroup_short_desc_fr,
 MAX(`A118615`) AS subitemgroup_short_desc_gb,
 MAX(`A118616`) AS subitemgroup_short_desc_gr,
 MAX(`A118617`) AS subitemgroup_short_desc_hr,
 MAX(`A118618`) AS subitemgroup_short_desc_hu,
 MAX(`A118619`) AS subitemgroup_short_desc_ie,
 MAX(`A118620`) AS subitemgroup_short_desc_it,
 MAX(`A118621`) AS subitemgroup_short_desc_lt,
 MAX(`A118622`) AS subitemgroup_short_desc_ni,
 MAX(`A118624`) AS subitemgroup_short_desc_lv,
 MAX(`A118623`) AS subitemgroup_short_desc_nl,
 MAX(`A118625`) AS subitemgroup_short_desc_de,
 MAX(`A118626`) AS subitemgroup_short_desc_pl,
 MAX(`A118627`) AS subitemgroup_short_desc_pt,
 MAX(`A118628`) AS subitemgroup_short_desc_ro,
 MAX(`A118629`) AS subitemgroup_short_desc_se,
 MAX(`A118630`) AS subitemgroup_short_desc_si,
 MAX(`A118631`) AS subitemgroup_short_desc_sk,
 MAX(`A118632`) AS subitemgroup_short_desc_cs,
 MAX(`A118633`) AS subitemgroup_short_desc_mt,
 MAX(`A118634`) AS subitemgroup_short_desc_us,
 MAX(`A118635`) AS subitemgroup_short_desc_rs
FROM (SELECT CAST(ROUND(CAST(src_subitemgrp_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS subitemgroup_id,
   FIRST_VALUE(subitemgroup_desc_lidl) OVER (PARTITION BY src_subitemgrp_cd ORDER BY CASE
       WHEN subitemgroup_desc_lidl LIKE TRIM(src_subitemgrp_cd) || '%'
       THEN 1
       ELSE 2
       END IS NULL DESC, CASE
       WHEN subitemgroup_desc_lidl LIKE TRIM(src_subitemgrp_cd) || '%'
       THEN 1
       ELSE 2
       END DESC, subitemgroup_desc_lidl IS NULL, subitemgroup_desc_lidl RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS subitemgroup_desc_lidl,
    CASE
    WHEN client_id = 1
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11864`,
    CASE
    WHEN client_id = 2
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11865`,
    CASE
    WHEN client_id = 3
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11866`,
    CASE
    WHEN client_id = 4
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11867`,
    CASE
    WHEN client_id = 5
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11868`,
    CASE
    WHEN client_id = 6
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A11869`,
    CASE
    WHEN client_id = 8
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118610`,
    CASE
    WHEN client_id = 9
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118611`,
    CASE
    WHEN client_id = 10
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118612`,
    CASE
    WHEN client_id = 11
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118613`,
    CASE
    WHEN client_id = 12
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118614`,
    CASE
    WHEN client_id = 13
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118615`,
    CASE
    WHEN client_id = 14
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118616`,
    CASE
    WHEN client_id = 15
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118617`,
    CASE
    WHEN client_id = 16
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118618`,
    CASE
    WHEN client_id = 17
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118619`,
    CASE
    WHEN client_id = 18
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118620`,
    CASE
    WHEN client_id = 19
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118621`,
    CASE
    WHEN client_id = 21
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118622`,
    CASE
    WHEN client_id = 22
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118623`,
    CASE
    WHEN client_id = 20
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118624`,
    CASE
    WHEN client_id = 23
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118625`,
    CASE
    WHEN client_id = 24
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118626`,
    CASE
    WHEN client_id = 25
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118627`,
    CASE
    WHEN client_id = 26
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118628`,
    CASE
    WHEN client_id = 27
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118629`,
    CASE
    WHEN client_id = 28
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118630`,
    CASE
    WHEN client_id = 29
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118631`,
    CASE
    WHEN client_id = 31
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118632`,
    CASE
    WHEN client_id = 32
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118633`,
    CASE
    WHEN client_id = 33
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118634`,
    CASE
    WHEN client_id = 34
    THEN subitemgroup_desc_default
    ELSE NULL
    END AS `A118635`
  FROM ldl_p_lew_bil_ac.v_subitemgroup) AS t
GROUP BY subitemgroup_id;