/*
CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.T_WAWI_PRECORE_ITEM_TEMP AS 
(
SELECT CASE WHEN a.ctrcode='CS' THEN 'ES' ELSE a.ctrcode END AS COUNTRY, CAST(artnrvier AS Number) AS itemnr,
 
a.* , min_gueltig_ab
    FROM ETL.t_wawi_precore_artikel AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on a.ctrcode=b.ctrcode and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY COUNTRY, itemnr ORDER BY  artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. The sorting by artikelnr is for the code to always pick the same item variant
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
        /* Collect data on item variant level and deduplicate for item in the last step */
        SELECT
               CASE WHEN art.ctrcode = 'CS' THEN 'ES' ELSE art.ctrcode END AS country
             , try_cast(art.artnrvier AS Number) AS itemnr
             , art.extraction_tmsp
             , fg.itemgrpnr
             , fg.family_code
          FROM ETL.T_WAWI_PRECORE_ARTIKEL AS art
          INNER JOIN ETL.T_WAWI_PRECORE_T214_ITEMADDINFO AS itma
             ON art.ctrcode   = itma.ctrcode
            AND art.artikelnr = itma.itemnr
          INNER JOIN ETL.T_WAWI_PRECORE_T038_ITEMFAMILY AS fg
             ON itma.ctrcode = fg.ctrcode
            AND itma.family_id = fg.family_id
          QUALIFY Row_Number() OVER (PARTITION BY country, try_cast(art.artnrvier AS Number)
                                       ORDER BY art.ctrcode DESC /* prefer ES before CS */
                                              , art.gueltig_ab DESC
                                              , art.inhalt_karton
                                              , art.extraction_tmsp DESC
                                       ) = 1
         ) AS src
      INNER JOIN META.T_WAWI_ITEM_KEY AS ik
         ON ik.wawi_item_nat_key_nr = src.country || '|' || src.itemnr
        AND ik.wawi_item_key_type_cd = 'WAWI'
        AND ik.dwh_valid_fg
      INNER JOIN META.T_PRODUCT_GROUP_KEY AS pgk
         ON pgk.prod_grp_key_type_cd = 'IFG'
        /* Could be simplified later */
        AND Try_Cast(Split_Part(pgk.prod_grp_nat_key_nr, '|', 1) AS Number) || '|' || Try_Cast(Split_Part(pgk.prod_grp_nat_key_nr, '|', 2) AS Number)
            = src.itemgrpnr::Number || '|' || src.family_code::Number
        AND pgk.dwh_valid_fg
