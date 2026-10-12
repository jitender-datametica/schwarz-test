/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ITEM_PRICE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-12-09 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ITEM_PRICE
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_wawi_item_price AS SELECT DISTINCT PP.client_id,
 PP.item_sid,
 PP.pricegroup_id,
 PP.dat_valid_from,
 PP.dat_valid_until,
 PP.vat_id,
 vat.vat_desc,
 vat.pct_vat,
 CAST(IF(100.00 = 0, 0, SAFE_DIVIDE(COALESCE(vat.pct_vat, 0.0), 100.00)) AS BIGNUMERIC) AS vat_factor,
 PP.tare_cd,
 PP.price_retail AS item_unit_price_gross,
 COALESCE(PP.price_retail_net, ldl_p_lew_mart_pit.f_gross2net(PP.price_retail, CAST(IF(100.00 = 0, 0, SAFE_DIVIDE(COALESCE(vat.pct_vat, 0.0), 100.00)) AS BIGNUMERIC)
   )) AS item_unit_price_net,
 PP.val_refund,
 PP.val_net_refund,
 PP.val_beverage_tax,
 PP.load_id
FROM ldl_p_lew_core.t_wawi_itm_price AS PP
 LEFT JOIN (SELECT client_id,
   vat_id,
   vat_desc,
   pct_vat
  FROM ldl_p_lew_core.t_wawi_ref_vat
  WHERE client_id = language_id
   AND dat_rec_end = DATE('9999-12-31')
  GROUP BY client_id,
   vat_id,
   vat_desc,
   pct_vat) AS vat ON PP.client_id = vat.client_id AND PP.vat_id = vat.vat_id
WHERE PP.dat_valid_from <= PP.dat_valid_until;

