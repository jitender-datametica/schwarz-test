/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_mat_itm_orig_item_desc_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  18.12.2017    Harald Wieber            Change the Stiftung Language from DE to @
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  29.01.2018    Toth.Gabriel             Refactored
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  02.02.2018    Toth,Gabriel             Applied dat_valid_from Logic from v_itm_item_2
#  1.7  05.02.2018    Toth,Gabriel             Finetuning of dat_valid_from_logic
#  1.8  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_orig_item_desc_2
#  1.9  05.03.2018    Ueding,Michael           Logikanpassung fuer Stiftungssprache
# 1.10  02.05.2018    Arnold,Arne              Logik für DAT_VALID_FROM erweitert
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
# 1.12  13.01.2022    Bachmann,Torsten         Adjust logic: Get desc from mapped item_2 instead of config_item
#                                              IT4You: INC3998056
# 1.13  17.01.2022    Morris, Michael          New country_2 Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_orig_item_desc_2 (client_id, orig_item_nr, dat_valid_from,
item_desc_at, item_desc_be, item_desc_bg, item_desc_ch, item_desc_cy, item_desc_cz, item_desc, item_desc_dk,
item_desc_ee, item_desc_es, item_desc_fi, item_desc_fr, item_desc_gb, item_desc_gr, item_desc_hr, item_desc_hu,
item_desc_ie, item_desc_it, item_desc_lt, item_desc_lv, item_desc_ni, item_desc_nl, item_desc_de, item_desc_pl,
item_desc_pt, item_desc_ro, item_desc_se, item_desc_si, item_desc_sk, item_desc_cs, item_desc_mt, item_desc_us,
item_desc_rs) AS /* bei Stiftung keinen Landesindikator */
/* prio 1 if description for config_item_cd equals the description for item_sid for client language */
/* Ermittlung Land_2 des Clienten */ /* the description for item_sid */ /* nur numerische Artikel_2 */ SELECT client_id,
 orig_item_nr,
 dat_valid_from,
 MAX(`A11866`) AS item_desc_at,
 MAX(`A11867`) AS item_desc_be,
 MAX(`A11868`) AS item_desc_bg,
 MAX(`A11869`) AS item_desc_ch,
 MAX(`A118610`) AS item_desc_cy,
 MAX(`A118611`) AS item_desc_cz,
 MAX(`A118612`) AS item_desc,
 MAX(`A118613`) AS item_desc_dk,
 MAX(`A118614`) AS item_desc_ee,
 MAX(`A118615`) AS item_desc_es,
 MAX(`A118616`) AS item_desc_fi,
 MAX(`A118617`) AS item_desc_fr,
 MAX(`A118618`) AS item_desc_gb,
 MAX(`A118619`) AS item_desc_gr,
 MAX(`A118620`) AS item_desc_hr,
 MAX(`A118621`) AS item_desc_hu,
 MAX(`A118622`) AS item_desc_ie,
 MAX(`A118623`) AS item_desc_it,
 MAX(`A118624`) AS item_desc_lt,
 MAX(`A118625`) AS item_desc_lv,
 MAX(`A118626`) AS item_desc_ni,
 MAX(`A118627`) AS item_desc_nl,
 MAX(`A118628`) AS item_desc_de,
 MAX(`A118629`) AS item_desc_pl,
 MAX(`A118630`) AS item_desc_pt,
 MAX(`A118631`) AS item_desc_ro,
 MAX(`A118632`) AS item_desc_se,
 MAX(`A118633`) AS item_desc_si,
 MAX(`A118634`) AS item_desc_sk,
 MAX(`A118635`) AS item_desc_cs,
 MAX(`A118636`) AS item_desc_mt,
 MAX(`A118637`) AS item_desc_us,
 MAX(`A118638`) AS item_desc_rs
FROM (SELECT A.client_id,
   ROUND(CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
   COALESCE(WIIA.dat_valid_from, A.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, PARSE_DATE('%d.%m.%Y'
     , '31.12.9999')) AS dat_valid_from,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 1
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A11866`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 2
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A11867`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 3
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A11868`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 4
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A11869`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 5
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118610`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 6
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118611`,
    CASE
    WHEN CL.lang_cd = '@'
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118612`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 8
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118613`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 9
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118614`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END IN (10, 31)
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118615`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 11
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118616`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 12
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118617`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 13
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118618`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 14
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118619`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 15
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118620`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 16
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118621`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END IN (17, 21)
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118622`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END IN (18, 32)
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118623`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 19
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118624`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 20
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118625`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 21
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118626`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 22
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118627`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 23
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118628`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 24
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118629`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 25
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118630`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 26
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118631`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 27
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118632`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 28
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118633`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 29
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118634`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 31
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118635`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 32
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118636`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 33
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118637`,
    CASE
    WHEN CASE
      WHEN CL.lang_cd = '@'
      THEN 0
      ELSE CLI.client_id
      END = 34
    THEN COALESCE(NULLIF(D.item_descr, 'XX'), NULLIF(B0.item_descr, 'XX'))
    ELSE NULL
    END AS `A118638`
  FROM ldl_p_lew_core_ac.v_item_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON A.client_id
    /* Ermittlung Sprache, Auffaechern auf Land_2 und Stiftung */ = CLI.client_id
   INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CL ON CLI.country_sid = CL.country_sid OR CL.src_country_lidl_cd =
     'INTEGER ' /* Stiftung */
     /* previously, desc was taken from config_item with higher prio. Now, we're_2 using mapped item_2 instead */
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS MKEY ON A.client_id = MKEY.client_id AND A.item_sid = MKEY.item_sid
     /* Optional: DAT_VALID_FROM aus WaWI bestimmen. Dies ist für Dummy_2 Artikel_2 (CASE_SIZE = -1) notwendig, deren fachlicher Schlüssel später aktualisiert wird. */
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WIIA ON A.client_id = WIIA.client_id AND A.item_sid = WIIA.item_sid
     /* check, if item_2 is deleted which lowers the prio */
   LEFT JOIN ldl_p_lew_core_ac.v_item_hist_2 AS IHIST ON A.client_id = IHIST.client_id AND A.item_sid = IHIST.item_sid AND
     CURRENT_DATE BETWEEN IHIST.dwh_valid_from AND IHIST.dwh_valid_to
     /* here comes the dat_valid_from logic originaly used by v_itm_item_2 */
   LEFT JOIN (SELECT A0.client_id,
     A0.item_sid,
     B.src_dat_valid_from
    FROM ldl_p_lew_core_ac.v_item_2 AS A0
     INNER JOIN ldl_p_lew_core_ac.v_item_2 AS B ON A0.client_id = B.client_id AND B.item_sid_config = COALESCE(A0.item_sid_config
         , A0.item_sid) AND B.src_dat_valid_from IS NOT NULL
    WHERE NOT EXISTS (SELECT 1
      FROM ldl_p_lew_core_ac.v_item_2 AS C
      WHERE client_id = A0.client_id
       AND item_sid_config = COALESCE(A0.item_sid_config, A0.item_sid)
       AND (src_dat_valid_from > A0.src_dat_valid_from OR src_dat_valid_from = A0.src_dat_valid_from AND item_sid > A0.item_sid
            ))) AS dwf1 ON A.client_id = dwf1.client_id AND A.item_sid = dwf1.item_sid
   LEFT JOIN (SELECT client_id,
     ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
     MAX(src_dat_valid_from) AS src_dat_valid_from
    FROM ldl_p_lew_core_ac.v_item_2 AS C
    WHERE src_dat_valid_from IS NOT NULL
     AND CAST(src_case_size AS FLOAT64) >= 0
    GROUP BY client_id,
     origi) AS dwf2 ON A.client_id = dwf2.client_id AND dwf2.origi = ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd
         , A.src_matnr) AS BIGNUMERIC), 0) AND A.log_var_cd IS NOT NULL
   LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS B0 ON A.client_id = B0.client_id AND A.item_sid = B0.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_item_2 AS C1 ON A.client_id = C1.client_id AND A.config_item_cd
     /* the description for config_item_cd */ = C1.src_matnr
   LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS D ON MKEY.client_id = D.client_id AND MKEY.item_sid_map = D.item_sid
  WHERE ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) IS NOT NULL
  QUALIFY (MIN(CASE
        WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
        THEN 1 /* prio 2 if description for config_item_cd has client language */
        WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') <> CL.lang_cd
        THEN 2 /* prio 3 if description for item_sid_cd has client language */
        WHEN COALESCE(D.lang_cd, '') <> CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
        THEN 3 /* else prio 99 */
        ELSE 99
        END + IFNULL(IHIST.deleted_fg, 0)) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(ROUND(ROUND(CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC)
           , 0), 0) AS STRING), COALESCE(WIIA.dat_valid_from, A.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from
         , PARSE_DATE('%d.%m.%Y', '31.12.9999')) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = CASE
      WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
      THEN 1 /* prio 2 if description for config_item_cd has client language */
      WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') <> CL.lang_cd
      THEN 2 /* prio 3 if description for item_sid_cd has client language */
      WHEN COALESCE(D.lang_cd, '') <> CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
      THEN 3 /* else prio 99 */
      ELSE 99
      END + IFNULL(IHIST.deleted_fg, 0)) AS t9
GROUP BY client_id,
 orig_item_nr,
 dat_valid_from;