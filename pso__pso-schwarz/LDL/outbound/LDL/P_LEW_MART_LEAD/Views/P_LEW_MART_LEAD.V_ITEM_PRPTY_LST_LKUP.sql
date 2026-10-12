CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_item_prpty_lst_lkup (item_prpty_lst_id, item_prpty_lst_id_curr,
item_prpty_lst_id_cncat, item_prpty_lst_name_at, item_prpty_lst_name_be, item_prpty_lst_name_be_fr,
item_prpty_lst_name_bg, item_prpty_lst_name_ch, item_prpty_lst_name_cy, item_prpty_lst_name_cz, item_prpty_lst_name,
item_prpty_lst_name_dk, item_prpty_lst_name_ee, item_prpty_lst_name_es, item_prpty_lst_name_fi, item_prpty_lst_name_fr,
item_prpty_lst_name_gb, item_prpty_lst_name_gr, item_prpty_lst_name_hr, item_prpty_lst_name_hu, item_prpty_lst_name_ie,
item_prpty_lst_name_it, item_prpty_lst_name_lt, item_prpty_lst_name_lv, item_prpty_lst_name_ni, item_prpty_lst_name_nl,
item_prpty_lst_name_de, item_prpty_lst_name_pl, item_prpty_lst_name_pt, item_prpty_lst_name_ro, item_prpty_lst_name_se,
item_prpty_lst_name_si, item_prpty_lst_name_sk, item_prpty_lst_name_tr, item_prpty_lst_name_cs, item_prpty_lst_name_mt,
item_prpty_lst_name_us, item_prpty_lst_name_rs) AS SELECT item_prpty_lst_id,
 item_prpty_lst_id AS item_prpty_lst_id_cur,
 item_prpty_id_concat AS item_prpty_lst_id_cncat,
  CASE
  WHEN client_id = 1
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_at,
  CASE
  WHEN client_id = 2
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_be,
  CASE
  WHEN client_id = 2
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_be_fr,
  CASE
  WHEN client_id = 3
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_bg,
  CASE
  WHEN client_id = 4
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_ch,
  CASE
  WHEN client_id = 5
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_cy,
  CASE
  WHEN client_id = 6
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_cz,
 item_prpty_lst_name AS item_prpty_lst_name_expr,
  CASE
  WHEN client_id = 8
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_dk,
  CASE
  WHEN client_id = 9
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_ee,
  CASE
  WHEN client_id = 10
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_es,
  CASE
  WHEN client_id = 11
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_fi,
  CASE
  WHEN client_id = 12
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_fr,
  CASE
  WHEN client_id = 13
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_gb,
  CASE
  WHEN client_id = 14
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_gr,
  CASE
  WHEN client_id = 15
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_hr,
  CASE
  WHEN client_id = 16
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_hu,
  CASE
  WHEN client_id = 17
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_ie,
  CASE
  WHEN client_id = 18
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_it,
  CASE
  WHEN client_id = 19
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_lt,
  CASE
  WHEN client_id = 20
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_lv,
  CASE
  WHEN client_id = 21
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_ni,
  CASE
  WHEN client_id = 22
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_nl,
  CASE
  WHEN client_id = 23
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_de,
  CASE
  WHEN client_id = 24
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_pl,
  CASE
  WHEN client_id = 25
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_pt,
  CASE
  WHEN client_id = 26
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_ro,
  CASE
  WHEN client_id = 27
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_se,
  CASE
  WHEN client_id = 28
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_si,
  CASE
  WHEN client_id = 29
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_sk,
  CASE
  WHEN client_id = 30
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_tr,
  CASE
  WHEN client_id = 31
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_cs,
  CASE
  WHEN client_id = 32
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_mt,
  CASE
  WHEN client_id = 33
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_us,
  CASE
  WHEN client_id = 34
  THEN item_prpty_lst_local_name
  ELSE NULL
  END AS item_prpty_lst_name_expr_rs
FROM ldl_p_lew_mart_lead.t_item_prpty_lst_lkup;