CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_SUPPLIER_RELATION_2
(
      country_lidl_cd
    , supplier_nr
    , item_nr
    , wh_id
)
AS
SELECT
clnt.src_country_lidl_cd country_lidl_cd
,base_union.supplier_nr
,TRY_CAST(Coalesce(itm.config_item_cd, itm.src_orig_item_nr, itm.src_matnr) AS BIGINT) item_nr
,Coalesce(loc.src_wh_id,-1) AS wh_id
FROM
(
SELECT
itm_sup_wh_data.client_id
,itm_sup_wh_data.item_sid
,TRY_CAST(supl.src_orig_supplier_nr AS BIGINT)        AS supplier_nr
,itm_sup_wh_data.wh_loc_sid
FROM p_lew_core_ac.v_wawi_itm_sup_wh_data_2 itm_sup_wh_data
INNER JOIN p_lew_core_ac.v_supplier_2 supl
ON itm_sup_wh_data.client_id = supl.client_id
AND itm_sup_wh_data.sup_sid = supl.sup_sid
INNER JOIN p_lew_core_ac.v_client_migration_per_2 sap_migration_config
ON itm_sup_wh_data.client_id = sap_migration_config.client_id
AND (    Current_Date < sap_migration_config.migration_dat_valid_from
     OR Current_Date > sap_migration_config.migration_dat_valid_to
   )
WHERE Current_Date BETWEEN itm_sup_wh_data.dat_rec_start AND itm_sup_wh_data.dat_rec_end
AND Current_Date BETWEEN itm_sup_wh_data.dat_valid_from AND itm_sup_wh_data.dat_valid_until
) AS base_union
INNER JOIN p_lew_core_ac.v_item_2 itm
ON base_union.client_id = itm.client_id
AND base_union.item_sid = itm.item_sid
INNER JOIN p_lew_core_ac.v_location_2 loc
ON base_union.client_id = loc.client_id
AND base_union.wh_loc_sid = loc.loc_sid
INNER JOIN p_lew_core_ac.v_client_2 clnt
ON base_union.client_id = clnt.client_id

WHERE itm.item_sid > 0
AND COALESCE(TRY_CAST(itm.config_item_cd AS BIGINT), TRY_CAST(itm.src_orig_item_nr AS BIGINT), TRY_CAST(itm.src_matnr AS BIGINT)) > 0

GROUP BY
     clnt.src_country_lidl_cd
    ,base_union.supplier_nr
    , TRY_CAST(Coalesce(itm.config_item_cd, itm.src_orig_item_nr, itm.src_matnr) AS BIGINT)
,Coalesce(loc.src_wh_id,-1)
;