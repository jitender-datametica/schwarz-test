CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_sub_actiongroup_desc_1 (client_id, item_sub_actiongroup_id,
item_actiongroup_id, dat_valid_from, dat_valid_until, item_sub_actgroup_desc_at, item_sub_actgroup_desc_be,
item_sub_actgroup_desc_be_fr, item_sub_actgroup_desc_bg, item_sub_actgroup_desc_ch, item_sub_actgroup_desc_cy,
item_sub_actgroup_desc_cz, item_sub_actgroup_desc, item_sub_actgroup_desc_dk, item_sub_actgroup_desc_ee,
item_sub_actgroup_desc_es, item_sub_actgroup_desc_fi, item_sub_actgroup_desc_fr, item_sub_actgroup_desc_gb,
item_sub_actgroup_desc_gr, item_sub_actgroup_desc_hr, item_sub_actgroup_desc_hu, item_sub_actgroup_desc_ie,
item_sub_actgroup_desc_it, item_sub_actgroup_desc_lt, item_sub_actgroup_desc_lv, item_sub_actgroup_desc_ni,
item_sub_actgroup_desc_nl, item_sub_actgroup_desc_de, item_sub_actgroup_desc_pl, item_sub_actgroup_desc_pt,
item_sub_actgroup_desc_ro, item_sub_actgroup_desc_se, item_sub_actgroup_desc_si, item_sub_actgroup_desc_sk,
item_sub_actgroup_desc_cs, item_sub_actgroup_desc_mt, item_sub_actgroup_desc_us, item_sub_actgroup_desc_rs) AS SELECT
 client_id,
 item_sub_actiongroup_id,
 item_actiongroup_id,
 dat_valid_from,
 dat_valid_until,
 MAX(`A11867`) AS item_sub_actgroup_desc_at,
 MAX(`A11868`) AS item_sub_actgroup_desc_be,
 MAX(`A11868`) AS item_sub_actgroup_desc_be_fr,
 MAX(`A11869`) AS item_sub_actgroup_desc_bg,
 MAX(`A118610`) AS item_sub_actgroup_desc_ch,
 MAX(`A118611`) AS item_sub_actgroup_desc_cy,
 MAX(`A118612`) AS item_sub_actgroup_desc_cz,
 MAX(`A118613`) AS item_sub_actgroup_desc,
 MAX(`A118614`) AS item_sub_actgroup_desc_dk,
 MAX(`A118615`) AS item_sub_actgroup_desc_ee,
 MAX(`A118616`) AS item_sub_actgroup_desc_es,
 MAX(`A118617`) AS item_sub_actgroup_desc_fi,
 MAX(`A118618`) AS item_sub_actgroup_desc_fr,
 MAX(`A118619`) AS item_sub_actgroup_desc_gb,
 MAX(`A118620`) AS item_sub_actgroup_desc_gr,
 MAX(`A118621`) AS item_sub_actgroup_desc_hr,
 MAX(`A118622`) AS item_sub_actgroup_desc_hu,
 MAX(`A118623`) AS item_sub_actgroup_desc_ie,
 MAX(`A118624`) AS item_sub_actgroup_desc_it,
 MAX(`A118625`) AS item_sub_actgroup_desc_lt,
 MAX(`A118626`) AS item_sub_actgroup_desc_lv,
 MAX(`A118627`) AS item_sub_actgroup_desc_ni,
 MAX(`A118628`) AS item_sub_actgroup_desc_nl,
 MAX(`A118629`) AS item_sub_actgroup_desc_de,
 MAX(`A118630`) AS item_sub_actgroup_desc_pl,
 MAX(`A118631`) AS item_sub_actgroup_desc_pt,
 MAX(`A118632`) AS item_sub_actgroup_desc_ro,
 MAX(`A118633`) AS item_sub_actgroup_desc_se,
 MAX(`A118634`) AS item_sub_actgroup_desc_si,
 MAX(`A118635`) AS item_sub_actgroup_desc_sk,
 MAX(`A118636`) AS item_sub_actgroup_desc_cs,
 MAX(`A118637`) AS item_sub_actgroup_desc_mt,
 MAX(`A118638`) AS item_sub_actgroup_desc_us,
 MAX(`A118639`) AS item_sub_actgroup_desc_rs
FROM (SELECT client_id,
   item_sub_actiongroup_id,
   item_actiongroup_id,
   dat_valid_from,
   dat_valid_until,
    CASE
    WHEN language_id = 1
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A11867`,
    CASE
    WHEN language_id = 2
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A11868`,
    CASE
    WHEN language_id = 3
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A11869`,
    CASE
    WHEN language_id = 4
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118610`,
    CASE
    WHEN language_id = 5
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118611`,
    CASE
    WHEN language_id = 6
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118612`,
    CASE
    WHEN language_id = 7
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118613`,
    CASE
    WHEN language_id = 8
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118614`,
    CASE
    WHEN language_id = 9
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118615`,
    CASE
    WHEN language_id = 10
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118616`,
    CASE
    WHEN language_id = 11
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118617`,
    CASE
    WHEN language_id = 12
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118618`,
    CASE
    WHEN language_id = 13
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118619`,
    CASE
    WHEN language_id = 14
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118620`,
    CASE
    WHEN language_id = 15
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118621`,
    CASE
    WHEN language_id = 16
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118622`,
    CASE
    WHEN language_id = 17
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118623`,
    CASE
    WHEN language_id = 18
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118624`,
    CASE
    WHEN language_id = 19
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118625`,
    CASE
    WHEN language_id = 20
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118626`,
    CASE
    WHEN language_id = 21
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118627`,
    CASE
    WHEN language_id = 22
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118628`,
    CASE
    WHEN language_id = 23
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118629`,
    CASE
    WHEN language_id = 24
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118630`,
    CASE
    WHEN language_id = 25
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118631`,
    CASE
    WHEN language_id = 26
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118632`,
    CASE
    WHEN language_id = 27
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118633`,
    CASE
    WHEN language_id = 28
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118634`,
    CASE
    WHEN language_id = 29
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118635`,
    CASE
    WHEN language_id = 31
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118636`,
    CASE
    WHEN language_id = 32
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118637`,
    CASE
    WHEN language_id = 33
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118638`,
    CASE
    WHEN language_id = 34
    THEN item_sub_actgroup_desc
    ELSE NULL
    END AS `A118639`
  FROM ldl_p_lew_core_ac.v_wawi_itm_actiongroup_desc_1
  WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
  GROUP BY client_id,
   item_sub_actiongroup_id,
   item_actiongroup_id,
   item_sub_actgroup_desc,
   dat_valid_from,
   dat_valid_until,
   language_id) AS t2
GROUP BY client_id,
 item_sub_actiongroup_id,
 item_actiongroup_id,
 dat_valid_from,
 dat_valid_until;