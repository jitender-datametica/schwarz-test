
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_ALL_DESC

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 15550 $, $LastChangedBy: mmalinowski $ 
   #SubjectAreas#: Artikelstamm 
   #DescEnd# 
   */
   SELECT
   itm.client_id,
   itm.item_sid AS item_id,
   d.item_descr AS item_desc,
   CAST(COALESCE(TRY_TO_NUMBER(itm.config_item_cd), CASE WHEN itm.item_sid < 0 THEN itm.item_sid ELSE COALESCE(TO_NUMBER(itm.src_orig_item_nr), itm.item_sid) END) AS DECIMAL(18,0)) AS orig_item_nr,
   lang.language_id
   FROM p_lew_core_ac.v_item itm
   INNER JOIN p_lew_core_ac.v_item_descr d
   ON itm.client_id = d.client_id
   AND itm.item_sid = d.item_sid
   INNER JOIN p_lew_core_ac.v_client cli
   ON cli.client_id = itm.client_id
   INNER JOIN p_lew_core_ac.v_country ctry
   ON cli.country_sid = ctry.country_sid
   OR ctry.src_country_lidl_cd = 'INT' /* Stiftung */
   INNER JOIN p_lew_core_ac.v_report_language rlang
   ON d.lang_sid = rlang.lang_sid
   INNER JOIN p_lew_core_ac.v_map_lang_spras lang
   ON TRIM(lang.sap_lang_cd) = TRIM(rlang.iso_cd)
   AND (TRIM(ctry.src_country_lidl_cd) = TRIM(lang.language_iso_cd))
;
