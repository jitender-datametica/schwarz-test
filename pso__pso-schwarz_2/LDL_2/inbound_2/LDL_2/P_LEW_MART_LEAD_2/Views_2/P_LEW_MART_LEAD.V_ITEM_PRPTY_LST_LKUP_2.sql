CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITEM_PRPTY_LST_LKUP_2
/*
#DescStart#
#$Revision: 13725 $, $LastChangedBy: mmalinowski $
#SubjectAreas#: Access Layer
#DescEnd#
*/

(
  item_prpty_lst_id
, item_prpty_lst_id_curr
, item_prpty_lst_id_cncat
, item_prpty_lst_name_AT
, item_prpty_lst_name_BE
, item_prpty_lst_name_BE_FR
, item_prpty_lst_name_BG
, item_prpty_lst_name_CH
, item_prpty_lst_name_CY
, item_prpty_lst_name_CZ
, item_prpty_lst_name
, item_prpty_lst_name_DK
, item_prpty_lst_name_EE
, item_prpty_lst_name_ES
, item_prpty_lst_name_FI
, item_prpty_lst_name_FR
, item_prpty_lst_name_GB
, item_prpty_lst_name_GR
, item_prpty_lst_name_HR
, item_prpty_lst_name_HU
, item_prpty_lst_name_IE
, item_prpty_lst_name_IT
, item_prpty_lst_name_LT
, item_prpty_lst_name_LV
, item_prpty_lst_name_NI
, item_prpty_lst_name_NL
, item_prpty_lst_name_DE
, item_prpty_lst_name_PL
, item_prpty_lst_name_PT
, item_prpty_lst_name_RO
, item_prpty_lst_name_SE
, item_prpty_lst_name_SI
, item_prpty_lst_name_SK
, item_prpty_lst_name_TR
, item_prpty_lst_name_CS
, item_prpty_lst_name_MT
, item_prpty_lst_name_US
, item_prpty_lst_name_RS
)
AS
   SELECT
     item_prpty_lst_id
   , item_prpty_lst_id AS item_prpty_lst_id_cur
   , item_prpty_id_concat
   , CASE WHEN client_id = 1  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_AT
   , CASE WHEN client_id = 2  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_BE
   , CASE WHEN client_id = 2  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_BE_FR
   , CASE WHEN client_id = 3  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_BG
   , CASE WHEN client_id = 4  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_CH
   , CASE WHEN client_id = 5  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_CY
   , CASE WHEN client_id = 6  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_CZ
   , item_prpty_lst_name                                                      AS item_prpty_lst_name_expr
   , CASE WHEN client_id = 8  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_DK
   , CASE WHEN client_id = 9  THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_EE
   , CASE WHEN client_id = 10 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_ES
   , CASE WHEN client_id = 11 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_FI
   , CASE WHEN client_id = 12 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_FR
   , CASE WHEN client_id = 13 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_GB
   , CASE WHEN client_id = 14 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_GR
   , CASE WHEN client_id = 15 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_HR
   , CASE WHEN client_id = 16 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_HU
   , CASE WHEN client_id = 17 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_IE
   , CASE WHEN client_id = 18 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_IT
   , CASE WHEN client_id = 19 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_LT
   , CASE WHEN client_id = 20 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_LV
   , CASE WHEN client_id = 21 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_NI
   , CASE WHEN client_id = 22 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_NL
   , CASE WHEN client_id = 23 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_DE
   , CASE WHEN client_id = 24 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_PL
   , CASE WHEN client_id = 25 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_PT
   , CASE WHEN client_id = 26 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_RO
   , CASE WHEN client_id = 27 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_SE
   , CASE WHEN client_id = 28 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_SI
   , CASE WHEN client_id = 29 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_SK
   , CASE WHEN client_id = 30 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_TR
   , CASE WHEN client_id = 31 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_CS
   , CASE WHEN client_id = 32 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_MT
   , CASE WHEN client_id = 33 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_US
   , CASE WHEN client_id = 34 THEN item_prpty_lst_local_name ELSE NULL END AS item_prpty_lst_name_expr_RS
   FROM p_lew_mart_lead.t_item_prpty_lst_lkup_2
;