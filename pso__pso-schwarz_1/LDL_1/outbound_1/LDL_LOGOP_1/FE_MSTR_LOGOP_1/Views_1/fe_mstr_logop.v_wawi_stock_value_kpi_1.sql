CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_stock_value_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_1 nr'), bez_lang OPTIONS(description='Item_1 description - long'), bez_kurz
OPTIONS(description='Item_1 description - short'), deutschtext OPTIONS(description='Item_1 description - DE'), artgrupnr
OPTIONS(description='Item_1 group nr'), artgrupbez OPTIONS(description='Item_1 group description - DE'), artgrupbez_en
OPTIONS(description='Item_1 group description - EN'), lptyp OPTIONS(description='Storage Type - DE'), lptyp_en
OPTIONS(description='Storage Type - EN'), autodispo_flg OPTIONS(description='Is it relevant for AutoDispo: Yes/No'), wgi
OPTIONS(description='Storage Type - DE'), wgi_en OPTIONS(description='Storage Type - EN'), reported_date
OPTIONS(description='T067 and DA Date'), pieceqty_cal OPTIONS(description='Stock Expected'), pieceqty_real
OPTIONS(description='Stock Counted'), pieceqty_diff OPTIONS(description='Stock Difference'), valid_seq
OPTIONS(description='Valid Sequences of Tech Differences'), retail_price
OPTIONS(description='Retail Price from Bestandartikel_1'), dwh_valid_from OPTIONS(description='Valid from date'),
dwh_valid_to OPTIONS(description='Valid to date'), dwh_updated OPTIONS(description='Record updated at'), curr_sign
OPTIONS(description='Currency Sign'))
OPTIONS(DESCRIPTION = `KPI VIEW BASED ON AGGREGATED INVENTUR_1 VIEW AND ARTICLE LOOKUP VIEW`) AS SELECT AGG.client_id,
 AGG.wh_id,
 AGG.artikelnr,
 LAR.bez_lang,
 LAR.bez_kurz,
 LAR.deutschtext,
 LAR.artgrupnr,
 LAR.artgrupbez,
 LAR.artgrupbez_en,
 LAR.lptyp,
 LAR.lptyp_en,
 LAR.autodispo_flg,
 LAR.wgi,
 LAR.wgi_en,
 AGG.reported_date,
 IFNULL(AGG.pieceqty_cal, 0) AS pieceqty_cal,
 IFNULL(AGG.pieceqty_real, 0) AS pieceqty_real,
 IFNULL(AGG.pieceqty_diff, 0) AS pieceqty_diff,
 AGG.valid_seq,
 AGG.retail_price,
 AGG.dwh_valid_from,
 AGG.dwh_valid_to,
 AGG.dwh_updated,
 CUR.curr_sign
FROM ldl_logop_fe_mstr_logop.v_wawi_stock_value_agg_1 AS AGG
 INNER JOIN ldl_logop_fe_mstr_logop.v_lu_wawi_artikel_1 AS LAR ON AGG.client_id = LAR.client_id AND AGG.artikelnr = LAR.artikelnr
   
 INNER JOIN ldl_logop_data.t_wawi_currency_1 AS CUR ON AGG.client_id = CUR.client_id;