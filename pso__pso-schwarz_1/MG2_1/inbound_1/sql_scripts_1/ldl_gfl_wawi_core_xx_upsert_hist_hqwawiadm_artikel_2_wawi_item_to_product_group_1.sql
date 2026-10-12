/*
CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.T_WAWI_PRECORE_ITEM_TEMP AS 
(
SELECT CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(a.wawi_instanz_kzl,2) END AS COUNTRY_1, CAST(artnrvier AS Number) AS itemnr,
 
a.* , min_gueltig_ab
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on a.delete_fg IS NULL AND LEFT(a.wawi_instanz_kzl,2)=b.wawi_instanz_kzl and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY COUNTRY_1, itemnr ORDER BY  artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. The sorting by artikelnr is for the code to always pick the same item_1 variant
)
;
*/

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    wawi_item_sid, 
    prod_grp_type_cd,
    prod_grp_sid,
    -- FRAMEWORK AND TECHNICAL COLUMNS
    source_system,
    extraction_dt,
    dwh_mapping_tmsp,
    tf_error_fg,
    deleted_fg,
    record_id,
    filename,
    dwh_node_cd,
    dwh_load_id)
     SELECT ik.wawi_item_sid AS wawi_item_sid
          , 'IFG' AS prod_grp_type_cd
          , pgk.prod_grp_sid AS prod_grp_sid
          , 'WAWI' AS source_system
          , CURRENT_DATE AS extraction_dt
          , src.extraction_tmsp AS dwh_mapping_tmsp
          , 0 AS tf_error_fg
          , 0 AS deleted_fg
          , 0 AS record_id
          , 't_${SRC_INPUT_TABLE}' AS filename
          , 'WAWI_HQ' AS dwh_node_cd
          , '${LOAD_ID}' AS dwh_load_id
    FROM (
        /* Collect data on item_1 variant level and deduplicate for item_1 in the last step */
        SELECT
               CASE WHEN art.wawi_instanz_kzl = 'CS' THEN 'ES' ELSE LEFT(art.wawi_instanz_kzl,2) END AS country_1
             , try_cast(art.artnrvier AS Number) AS itemnr
             , art.extraction_tmsp
             , fg.c038_itemgrpnr AS itemgrpnr
             , fg.c038_family_code AS family_code
          FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1  AS art_1
          INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo_1 AS itma
             ON art.wawi_instanz_kzl   = itma.wawi_instanz_kzl
            AND art.artikelnr = itma.c214_itemnr
          INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t038_itemfamily_1 AS fg
             ON itma.wawi_instanz_kzl = fg.wawi_instanz_kzl
            AND itma.c214_family_id = fg.c038_family_id
		  WHERE art.delete_fg IS NULL AND itma.delete_fg IS NULL AND fg.delete_fg IS NULL 
          QUALIFY Row_Number() OVER (PARTITION BY country_1, try_cast(art.artnrvier AS Number)
                                       ORDER BY art.wawi_instanz_kzl DESC /* prefer ES before CS */
                                              , art.gueltig_ab DESC
                                              , art.inhalt_karton
                                              , art.extraction_tmsp DESC
                                       ) = 1
         ) AS src
      INNER JOIN META.T_WAWI_ITEM_KEY_1 AS ik
         ON ik.wawi_item_nat_key_nr = src.country_1 || '|' || src.itemnr
        AND ik.wawi_item_key_type_cd = 'WAWI'
        AND ik.dwh_valid_fg
      INNER JOIN META.T_PRODUCT_GROUP_KEY_1 AS pgk
         ON pgk.prod_grp_key_type_cd = 'IFG'
        /* Could be simplified later */
        AND Try_Cast(Split_Part(pgk.prod_grp_nat_key_nr, '|', 1) AS Number) || '|' || Try_Cast(Split_Part(pgk.prod_grp_nat_key_nr, '|', 2) AS Number)
            = src.itemgrpnr::Number || '|' || src.family_code::Number
        AND pgk.dwh_valid_fg

