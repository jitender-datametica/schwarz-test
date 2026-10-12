INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
	 PROD_VARIANT_NR
	,GTIN
	,PROD_NR
	,PROD_KEY_TYPE_CD
	,PROD_VARIANT_KEY_TYPE_CD
	,PROD_VARIANT_NAME
	,PROD_VARIANT_TYPE_CD
	,WEIGHT_BASED_FG
	,LOGISTIC_VARIANT_TYPE_CD
	,CASE_SIZE_CNT
	,SALES_VARIANT_TYPE_CD
	,SALES_VARIANT_CONTENT_MEAS
	,UNIT_CNT
	,UNIT_CONTENT_MEAS
	,CONTENT_UOM_CD
	,NON_FOOD_VARIANT_TYPE_CD
	,SIZE_NAME
	,STYLE_NAME
	,KIND_NAME
	,FRUITS_AND_VEGETABLES_CLASS_CD
	,MIN_CALIBER_MEAS
	,MAX_CALIBER_MEAS
	,CALIBER_UOM_CD
	,COUNTRY_OF_ORIGIN_SID
---------------------------------
	,SOURCE_SYSTEM
	,EXTRACTION_DT
	,DWH_MAPPING_TMSP
	,TF_ERROR_FG
	,DELETED_FG
	,RECORD_ID
	,FILENAME
	,DWH_NODE_CD
	,DWH_LOAD_ID
)
with 
CBX_SALES_VARIANT as
(
	SELECT 
		PROD_VARIANT_NR                                      AS PROD_VARIANT_NR
		,GTIN                                                 AS GTIN
		,ITEM_IAN                                             AS PROD_NR
		,'CBX'                                                AS PROD_KEY_TYPE_CD
		,'CBX_SLS'                                            AS PROD_VARIANT_KEY_TYPE_CD
															  
		,PROD_VARIANT_NAME                                    AS PROD_VARIANT_NAME
		,'SALES_1'                                              AS PROD_VARIANT_TYPE_CD
		,FALSE                                                AS WEIGHT_BASED_FG
		,NULL                                                 AS LOGISTIC_VARIANT_TYPE_CD
		,NULL                                                 AS CASE_SIZE_CNT
		,'NON FOOD'                                           AS SALES_VARIANT_TYPE_CD
		,NULL                                                 AS SALES_VARIANT_CONTENT_MEAS
		,NULL                                                 AS UNIT_CNT
		,NULL                                                 AS UNIT_CONTENT_MEAS
		,NULL                                                 AS CONTENT_UOM_CD
		,NULL                                                 AS NON_FOOD_VARIANT_TYPE_CD
		,SIZE_NAME                                            AS SIZE_NAME
		,STYLE_NAME                                           AS STYLE_NAME
		,KIND_NAME                                            AS KIND_NAME
		,NULL                                                 AS FRUITS_AND_VEGETABLES_CLASS_CD
		,NULL                                                 AS MIN_CALIBER_MEAS
		,NULL                                                 AS MAX_CALIBER_MEAS
		,NULL                                                 AS CALIBER_UOM_CD
		,NULL                                                 AS COUNTRY_OF_ORIGIN_SID
		---------------------------------
		,'CBX'                                                AS SOURCE_SYSTEM
		,CURRENT_DATE                                         AS EXTRACTION_DT
		,COALESCE(CBX_ITEM_CHANGE_TMSP,CURRENT_TIMESTAMP)     AS DWH_MAPPING_TMSP
		,0                                                    AS TF_ERROR_FG
		,0                                                    AS DELETED_FG
		,0                                                    AS RECORD_ID
		,'t_${SRC_INPUT_TABLE}'                               AS FILENAME
		,'CBX'                                                AS DWH_NODE_CD
		,'${LOAD_ID}'                                         AS DWH_LOAD_ID 
	FROM 
	(
		SELECT 
			ltrim (ean.ldl_ean , '0')               		AS GTIN
			,i.item_no ||'|'||GTIN 							AS PROD_VARIANT_NAT_KEY_NR  -- in Prod_Variant_sid
			,i.item_no                              		AS ITEM_IAN                 -- in prod_sid
			,i.item_no ||'|'||GTIN 							AS PROD_VARIANT_NR
			
			,COALESCE(i.item_desc,i.short_desc)				AS PROD_VARIANT_NAME
			,COALESCE (s.ldl_product_desc ,i.item_desc)		AS PROD_VARIANT_DESCR
			,i.updated_on									AS CBX_ITEM_CHANGE_TMSP
			,si.ldl_name									AS SIZE_NAME
			
			
			,CASE WHEN v.ldl_lsv_code !='@' 
				   THEN ldl_lsv_name 
				   ELSE 'No variants defined.' 
			   END      
			   AS KIND_NAME
			,SUBSTRING(LISTAGG(distinct us.ldl_item_style_product_names , ' / ') within group (order by us.ldl_item_style_product_names),1,500) as STYLE_NAME
			
		FROM   
		(
			select * 
			from      ${TEMP_DB}.t_${SRC_INPUT_TABLE} i
			-- maybe it is issue
			WHERE i.item_no != '0'
			QUALIFY Row_Number() OVER (PARTITION BY i.item_no ORDER BY updated_on DESC) = 1 
				
		) i --t_mdm_item_1 & t_mdm_item_hist_1 ::  ETL.T_TCACHE_CBX_CNT_ITEM_1
		JOIN 
		(
			select 
				distinct 
				item_id
				,ldl_ean
				,ldl_item_unique_style_id
				,ldl_item_size_id 
			from ETL.T_TCACHE_CBX_ldl_item_article_ean_1
			WHERE ldl_ean IS NOT NULL
		) ean_1 
			ON i.id = ean.item_id --t_mdm_item_sku_ean_hist_1
		
		LEFT JOIN ETL.T_TCACHE_CBX_ldl_item_unique_style_1 us 
				ON ean.ldl_item_unique_style_id = us.id
		LEFT JOIN ETL.T_TCACHE_CBX_ldl_item_style_1 s         
				ON ean.ldl_item_unique_style_id = s.id
		LEFT JOIN ETL.T_TCACHE_CBX_ldl_item_size_1 si         
				ON ean.ldl_item_size_id = si.id --t_mdm_item_sku_1
		LEFT JOIN ETL.T_TCACHE_CBX_ldl_item_variant_1 v       
				ON i.ref_no = v.ldl_size_code
		
		GROUP BY 
			PROD_VARIANT_NAT_KEY_NR
			,GTIN
			,i.item_no  
			,PROD_VARIANT_NAME
			,PROD_VARIANT_DESCR
			,i.updated_on 
			,si.ldl_name 
			,KIND_NAME 
		QUALIFY Row_Number() OVER (PARTITION BY PROD_VARIANT_NR ORDER BY CBX_ITEM_CHANGE_TMSP DESC) = 1    
	)
)
,CBX_SALES_VARIANT_NF as
(
	SELECT 
		  i.item_no                                            AS PROD_VARIANT_NR
		, NULL                                                 AS GTIN
		, i.item_no                                            AS PROD_NR
		, 'CBX'                                                AS PROD_KEY_TYPE_CD
		, 'CBX_SLS_UNK'                                        AS PROD_VARIANT_KEY_TYPE_CD
															   
		, COALESCE(i.item_desc,i.short_desc)                   AS PROD_VARIANT_NAME
		, 'SALES_1'                                              AS PROD_VARIANT_TYPE_CD
		, FALSE                                                AS WEIGHT_BASED_FG
		, NULL                                                 AS LOGISTIC_VARIANT_TYPE_CD
		, NULL                                                 AS CASE_SIZE_CNT
		, 'NON FOOD'                                           AS SALES_VARIANT_TYPE_CD
		, NULL                                                 AS SALES_VARIANT_CONTENT_MEAS
		, NULL                                                 AS UNIT_CNT
		, NULL                                                 AS UNIT_CONTENT_MEAS
		, NULL                                                 AS CONTENT_UOM_CD
		, NULL                                                 AS NON_FOOD_VARIANT_TYPE_CD
		, NULL                                                 AS SIZE_NAME
		, NULL                                                 AS STYLE_NAME
		, NULL                                                 AS KIND_NAME
		, NULL                                                 AS FRUITS_AND_VEGETABLES_CLASS_CD
		, NULL                                                 AS MIN_CALIBER_MEAS
		, NULL                                                 AS MAX_CALIBER_MEAS
		, NULL                                                 AS CALIBER_UOM_CD
		, NULL                                                 AS COUNTRY_OF_ORIGIN_SID
		---------------------------------
		, 'CBX'                                                AS SOURCE_SYSTEM
		, CURRENT_DATE                                         AS EXTRACTION_DT
		, COALESCE(i.updated_on,CURRENT_TIMESTAMP)             AS DWH_MAPPING_TMSP
		, 0                                                    AS TF_ERROR_FG
		, 0                                                    AS DELETED_FG
		, 0                                                    AS RECORD_ID
		, 't_${SRC_INPUT_TABLE}'                               AS FILENAME
		, 'CBX'                                                AS DWH_NODE_CD
		, '${LOAD_ID}'                                         AS DWH_LOAD_ID 
	FROM      ${TEMP_DB}.t_${SRC_INPUT_TABLE} i --t_mdm_item_1 & t_mdm_item_hist_1 ::  ETL.T_TCACHE_CBX_CNT_ITEM_1
	QUALIFY Row_Number() OVER (PARTITION BY PROD_NR ORDER BY DWH_MAPPING_TMSP DESC) = 1    
)
,CBX_LOG as
(
	SELECT 
		  item_no ||'|'|| ldl_code                                        AS PROD_VARIANT_NR
		, NULL                                                            AS GTIN
		, item_no                                                         AS PROD_NR
		, 'CBX'                                                           AS PROD_KEY_TYPE_CD
		, 'CBX_LOG'                                                       AS PROD_VARIANT_KEY_TYPE_CD                                                          
		, COALESCE(item_desc,short_desc)                                  AS PROD_VARIANT_NAME
		, 'LOGISTIC'                                                      AS PROD_VARIANT_TYPE_CD
		, FALSE                                                           AS WEIGHT_BASED_FG
		, CASE WHEN Equal_Null(ldl_total_pack_ratio, ldl_assortment_size_quantities) THEN 'SINGLE'
			   ELSE 'MIXED'
		   END                                                 AS LOGISTIC_VARIANT_TYPE_CD
		, ldl_total_pack_ratio                                 AS CASE_SIZE_CNT
		, NULL                                                 AS SALES_VARIANT_TYPE_CD
		, NULL                                                 AS SALES_VARIANT_CONTENT_MEAS
		, NULL                                                 AS UNIT_CNT
		, NULL                                                 AS UNIT_CONTENT_MEAS
		, NULL                                                 AS CONTENT_UOM_CD
		, NULL                                                 AS NON_FOOD_VARIANT_TYPE_CD
		, NULL                                                 AS SIZE_NAME
		, NULL                                                 AS STYLE_NAME
		, NULL                                                 AS KIND_NAME
		, NULL                                                 AS FRUITS_AND_VEGETABLES_CLASS_CD
		, NULL                                                 AS MIN_CALIBER_MEAS
		, NULL                                                 AS MAX_CALIBER_MEAS
		, NULL                                                 AS CALIBER_UOM_CD
		, NULL                                                 AS COUNTRY_OF_ORIGIN_SID
		---------------------------------
		, 'CBX'                                                AS SOURCE_SYSTEM
		, CURRENT_DATE                                         AS EXTRACTION_DT
		, COALESCE(updated_on,CURRENT_TIMESTAMP)             AS DWH_MAPPING_TMSP
		, 0                                                    AS TF_ERROR_FG
		, 0                                                    AS DELETED_FG
		, 0                                                    AS RECORD_ID
		, 't_${SRC_INPUT_TABLE}'                               AS FILENAME
		, 'CBX'                                                AS DWH_NODE_CD
		, '${LOAD_ID}'                                         AS DWH_LOAD_ID 
	FROM 
		(
			SELECT 
				cast(try_cast(itm.item_no AS Number) AS String) AS item_no
				,ipm.ldl_code
				,itm.item_desc
				,itm.short_desc
				,itm.updated_on
				,CAST( ipm.ldl_total_pack_ratio as STRING) as ldl_total_pack_ratio
				,ipm.ldl_assortment_size_quantities
			FROM 
			( 
				SELECT 
					id
					,item_no
					,item_desc
					,short_desc
					,updated_on
				FROM etl.t_tcache_cbx_cnt_item_1
				WHERE try_cast( item_no AS Number) != 0
				QUALIFY row_Number() OVER (PARTITION BY item_no ORDER BY version DESC, revision DESC) = 1 
			) AS itm
				INNER JOIN ETL.T_TCACHE_CBX_LDL_ITEM_PACKING_METHOD_1 AS ipm
					ON itm.id = ipm.item_id
			QUALIFY row_number() OVER (
							PARTITION BY itm.item_no, ipm.ldl_code
							ORDER BY 
								CASE WHEN ipm.ldl_total_pack_ratio IS NOT NULL THEN 0 ELSE 1 END
								,ipm.ldl_seq
								,ipm.id) = 1
		) as Src
)
SELECT *
FROM CBX_SALES_VARIANT

UNION ALL

SELECT *
FROM CBX_SALES_VARIANT_NF

UNION ALL

SELECT *
FROM CBX_LOG

;



