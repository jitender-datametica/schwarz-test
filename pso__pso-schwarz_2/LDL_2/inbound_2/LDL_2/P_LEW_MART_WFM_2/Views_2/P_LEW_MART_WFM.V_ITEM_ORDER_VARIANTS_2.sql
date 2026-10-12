CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_ORDER_VARIANTS_2
(
    client_id
   ,mandant_2
   ,betriebsgesellschaft
   ,sammelartikel
   ,artikelvariante
   ,artikelart
   ,belieferart
   ,bestellbereich
   ,valid_var
   ,artikelstatus
   ,basis_me
   ,anliefer_me
   ,zaehler
   ,nenner
   ,unter_me
   ,log_variante
)
AS
SELECT
itm_info_per_loc.client_id                        AS client_id,
itm_info_per_loc.ec_cd                            AS mandant_2,
CAST(SUBSTR(loc.global_loc_id, 4, 4) AS INTEGER)  AS betriebsgesellschaft,
CAST(itm_info_per_loc.artikel_2        AS BIGINT)   AS sammelartikel,
CAST(itm_info_per_loc.vart           AS BIGINT)   AS artikelvariante,
itm_info_per_loc.aart                             AS artikelart,
itm_info_per_loc2.source_of_supply_cd             AS belieferart,
oa.order_area_nr                                  AS bestellbereich,
collate(LTRIM(collate(itm_info_per_loc2.rounding_profile_cd,''),'Y'),'en-ci')  AS valid_var,
CASE WHEN itm_state.item_marked_for_deletion_fg = 1 THEN '70'
    ELSE itm_state.item_status_cd  END                AS artikelstatus,
itm_info_per_loc.uom_cd_base                      AS basis_me,
itm_uom.uom_cd                                    AS anliefer_me,
itm_uom.conv_to_base_numerator                    AS zaehler,
itm_uom.conv_to_base_denominator                  AS nenner,
Coalesce(itm_uom.uom_cd_sub, '---')               AS unter_me,
itm_info_per_loc.log_var_cd                       AS log_variante

--base quantity, filter for valid rows in where condition
FROM (SELECT
itm_info_per_loc.client_id,
clnt.elwis_dwh_ec_cd                ec_cd,
itm_info_per_loc.item_sid,
itm_info_per_loc.loc_sid,
itm_info_per_loc.order_area_sid,
itm_info_per_loc.item_status_cd,
itm_info_per_loc.source_of_supply_cd,
itm_info_per_loc.rounding_profile_cd,
itm_info_per_loc.item_marked_for_deletion_fg,
itm.log_var_cd,
Max(itm2.item_sid) item_sid2        --remove duplicates
,
itm_base_item.src_matnr             artikel_2,
itm.src_matnr                       vart,
itm_type.src_mtart                  aart,
itm_hist.uom_cd_base
--base quantity, filter for valid rows in where condition
FROM p_lew_core_ac.v_item_info_per_location_hist_2 itm_info_per_loc

--join for filtering only sap countries
INNER JOIN p_lew_core_ac.v_client_migration_per_2 clnt
ON itm_info_per_loc.client_id     = clnt.client_id
AND Current_Date BETWEEN clnt.migration_dat_valid_from AND clnt.migration_dat_valid_to

--fetching item_2 information for each entry of item_info_per_location_hist, filter for log_var_cd in list and numeric business keys
INNER JOIN p_lew_core_ac.v_item_2 itm
ON itm_info_per_loc.client_id = itm.client_id
AND itm_info_per_loc.item_sid  = itm.item_sid
AND itm.log_var_cd IN (1,2,3)
--AND trycast(itm.src_matnr AS bigint) is not null    

--fetching the cross-configurable item_2 for each variant (config_item_cd is null for the cross_configurable item_2 itself) and filter for numeric business keys
INNER JOIN p_lew_core_ac.v_item_2 itm_base_item
ON itm.client_id = itm_base_item.client_id
AND Coalesce(itm.config_item_cd,itm.src_matnr) = itm_base_item.src_matnr
--AND trycast(itm_base_item.src_matnr AS bigint) is not null

LEFT OUTER JOIN p_lew_core_ac.v_item_2 itm2
ON itm.client_id = itm2.client_id
AND Coalesce(itm.config_item_cd, itm.src_matnr) = Coalesce(itm2.config_item_cd, itm2.src_matnr)
AND itm2.log_var_cd = 2

--fetching historical information for the cross-configurable item_2 for the current date
INNER JOIN p_lew_core_ac.v_item_hist_2 itm_hist
ON itm_base_item.client_id = itm_hist.client_id
AND itm_base_item.item_sid = itm_hist.item_sid
AND Current_Date BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to

--fetching the item_2 type
INNER JOIN p_lew_core_ac.v_item_type_2 itm_type
ON itm_hist.client_id = itm_type.client_id
AND itm_hist.item_type_sid = itm_type.item_type_sid

WHERE Current_Date BETWEEN itm_info_per_loc.dwh_valid_from AND itm_info_per_loc.dwh_valid_to
AND TRY_CAST(itm_base_item.src_matnr AS BIGINT) IS NOT NULL
AND TRY_CAST(itm.src_matnr AS BIGINT) IS NOT NULL

GROUP BY 1,2,3,4,5,6,7,8,9,10,12,13,14,15
) itm_info_per_loc

LEFT OUTER JOIN p_lew_core_ac.v_item_info_per_location_hist_2 itm_info_per_loc2
ON itm_info_per_loc.client_id = itm_info_per_loc2.client_id
AND itm_info_per_loc.loc_sid   = itm_info_per_loc2.loc_sid
AND itm_info_per_loc.item_sid2 = itm_info_per_loc2.item_sid
AND Current_Date BETWEEN itm_info_per_loc2.dwh_valid_from AND itm_info_per_loc2.dwh_valid_to

 --join against location_2 with filter to only fetch entries for the "Vorlagefiliale"
INNER JOIN p_lew_core_ac.v_location_2 loc
ON itm_info_per_loc.client_id = loc.client_id
AND itm_info_per_loc.loc_sid   = loc.loc_sid
AND loc.wh_store_mark      = 'A'
AND loc.global_loc_type_cd = 8

INNER JOIN p_lew_bil_ac.v_store_to_warehouse_2 st2wh
ON st2wh.client_id = loc.client_id
AND st2wh.loc_sid_store = loc.loc_sid
AND Current_Date BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to

--adding order_area information
LEFT OUTER JOIN p_lew_core_ac.v_order_area_2 AS oa
ON itm_info_per_loc2.client_id   = oa.client_id
AND itm_info_per_loc2.order_area_sid = oa.order_area_sid

--fetching historical information of the relation between items and their measures for the current date
INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist_2 itm_uom
ON itm_info_per_loc.client_id = itm_uom.client_id
AND itm_info_per_loc.item_sid  = itm_uom.item_sid
AND Current_Date BETWEEN itm_uom.dwh_valid_from AND itm_uom.dwh_valid_to

--fetching information of the measurement units
INNER JOIN p_lew_core_ac.v_unit_of_measurement_2 uom
ON itm_uom.client_id = uom.client_id
AND itm_uom.uom_sid   = uom.uom_sid

LEFT OUTER JOIN
(SELECT
itm_loc.client_id,
itm_loc.item_sid,
itm_loc.loc_sid,
itm_loc.item_status_cd,
itm_loc.item_marked_for_deletion_fg
FROM p_lew_core_ac.v_item_info_per_location_hist_2 itm_loc
--join against location_2 with filter to only fetch entries for the "Vorlagefiliale"
INNER JOIN p_lew_core_ac.v_location_2 loc
ON itm_loc.client_id = loc.client_id
AND itm_loc.loc_sid   = loc.loc_sid
AND loc.wh_store_mark = 'B'
WHERE Current_Date BETWEEN itm_loc.dwh_valid_from AND itm_loc.dwh_valid_to
) itm_state
ON itm_state.client_id = itm_info_per_loc.client_id
AND itm_state.loc_sid   = st2wh.loc_sid_wh
AND itm_state.item_sid  = itm_info_per_loc.item_sid
AND itm_info_per_loc.log_var_cd = 3
;





