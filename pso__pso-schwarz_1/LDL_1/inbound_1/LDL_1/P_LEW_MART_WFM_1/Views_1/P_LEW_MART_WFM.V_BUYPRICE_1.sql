/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_BUYPRICE_1
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_BUYPRICE_1		
AS		
  SELECT  
    cty.country_iso_cd                                                                                    AS country_iso_cd		
   ,COALESCE (wh_loc.src_wh_id, -1)                                                                       AS wh_id		
   ,CAST(i.orig_item_nr AS BIGINT)                                                                        AS item_1		
   ,CAST(sup.orig_supplier_nr AS BIGINT)                                                                  AS supplier_nr		
   ,bp.dat_valid_from                                                                                     AS valid_from		
   ,bp.dat_valid_until                                                                                    AS valid_until		
   ,CAST(bp.price_buying /  (cur.unit_currency_exchange * cur.rate_currency_exchange) AS DECIMAL(18,4))   AS buyprice		
   ,CAST(bp.price_buying AS DECIMAL(18,4))                                                                AS buyprice_orig		
   ,c.currency_iso_cd                                                                                     AS currency_iso		
  FROM p_lew_core_ac.v_wawi_itm_sup_wh_buying_price_1 bp		
  		
  /* Join for selecting WH_ID */		
  INNER JOIN p_lew_core_ac.v_location_1 wh_loc		
     ON bp.client_id = wh_loc.client_id		
    AND bp.wh_loc_sid= wh_loc.loc_sid		
		
  /* Join for selecting item_1 information as orig_item_nr */		
  INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_1 i		
     ON bp.client_id = i.client_id		
    AND bp.item_sid = i.item_sid		
    AND Current_Date BETWEEN i.dat_rec_start AND i.dat_rec_end		
     		
  /* Join for selecting currency exchange rate data, also validity_1 period */		
  INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_currency_rate_1 cur		
     ON cur.client_id = bp.client_id		
    AND cur.currency_nr = bp.currency_nr		
  		
  /* Join for selecting subitemgroup_id in order to restrict resulting data to relevant item_1 groups */		
  INNER JOIN p_lew_core_ac.v_wawi_itm_item_1 iitem		
     ON bp.client_id = iitem.client_id		
    AND bp.item_sid = iitem.item_sid		
    AND Current_Date BETWEEN iitem.dat_rec_start AND iitem.dat_rec_end		
  		 
  /* Join for selecting supplier_nr */		
  INNER JOIN p_lew_core_ac.v_wawi_sup_supplier_skey_1 sup		
     ON bp.client_id = sup.client_id		
    AND bp.sup_sid = sup.sup_sid		
    AND Current_Date BETWEEN sup.dat_rec_start AND sup.dat_rec_end		
  		
  /* Join for selecting country_1 iso code */		
  INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_currency_1 c		
     ON bp.client_id = c.client_id		
    AND bp.currency_nr = c.currency_nr		
  		
  /* Join for selecting country_1 id in order to select country_1 code */		
  INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_1 cc		
     ON bp.client_id = cc.client_id		
  		
  /* Join for selecting country_1 code */		
  INNER JOIN p_lew_core_ac.v_wawi_ref_country_1 cty		
     ON cc.country_id = cty.country_id		
  		
  /* Join for restriction to select data only from not(!) migrated countries */		
  INNER JOIN p_lew_core_ac.v_client_migration_per_1  sap_migration_client		
     ON bp.client_id = sap_migration_client.client_id		
    AND (Current_Date < sap_migration_client.migration_dat_valid_from		
         OR Current_Date > sap_migration_client.migration_dat_valid_to		
        )		
     		
  /* only such prices which validity_1 period started within the last 3 years */		
 WHERE (bp.dat_valid_from >= (Current_Date - 1095) OR CURRENT_DATE BETWEEN bp.dat_valid_from AND bp.dat_valid_until)		
   /* restrict to only technical valid purchase prices */		
   AND bp.dat_valid_from BETWEEN cur.dat_valid_from AND cur.dat_valid_until		
   /* only data with current date within validity_1 period */		
   AND Current_Date BETWEEN i.dat_rec_start AND i.dat_rec_end		
   AND Current_Date BETWEEN sup.dat_rec_start AND sup.dat_rec_end		
   AND Current_Date BETWEEN iitem.dat_rec_start AND iitem.dat_rec_end		
   AND (iitem.subitemgroup_id BETWEEN 100 AND 128 OR iitem.subitemgroup_id BETWEEN 200 AND 389)		
   /* only the highest purchase price per combination of Land_1, WHID, ORIG_ITEM_NR, Supplier_nr, valid_from is to be selected */		
  QUALIFY      1 = Row_Number() Over(PARTITION BY country_iso_cd, wh_id, item_1, supplier_nr, valid_from ORDER BY buyprice DESC, valid_until DESC)		
  ;