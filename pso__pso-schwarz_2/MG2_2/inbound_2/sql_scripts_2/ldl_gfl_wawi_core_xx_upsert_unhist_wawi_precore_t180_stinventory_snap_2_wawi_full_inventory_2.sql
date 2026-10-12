TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        ctrcode,
	wh_nr,
	c180_id,
	c180_inventorydate,
	c180_storenr,
	c182_datefrom,
	c182_dateuntil,
	c182_turnoverval_net,
	c182_diffval_net,
        c182_inventoryval_net,

	inv_natural_key,
	inv_key_type_cd,
	int_org_natural_key,
	int_org_key_type_cd,
	country_org_natural_key,
	country_org_key_type_cd,
        extraction_tmsp,
 
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
   SELECT
    t180.ctrcode -- for join & int_org lkp & inv_key lkp & country_org lkp
,   t180.wh_nr -- for join & inv_key lkp
,   t180.c180_id -- for join & inv_key lkp
,   t180.c180_inventorydate -- inv mapping
,   t180.c180_storenr -- int_org lkp
,   t182.c182_datefrom --inv mapping
,   t182.c182_dateuntil --inv mapping
,   t182.c182_turnoverval_net --stat mapping
,   t182.c182_diffval_net --stat mapping
,   t182.c182_inventoryval_net --stat mapping

,   t180.ctrcode || '|' || t180.wh_nr || '|' || t180.c180_id as inv_natural_key
,   'FULL' as inv_key_type_cd
,   t180.ctrcode || '|' || t180.c180_storenr as int_org_natural_key
,   'STORE' as int_org_key_type_cd
,   t180.ctrcode as country_org_natural_key
,   'COUNTRY_2' as country_org_key_type_cd
,   t180.extraction_tmsp as extraction_tmsp

,   'WAWI_WH' as source_system
,   current_date as extraction_dt
,   null as dwh_mapping_tmsp
,   0 as tf_error_fg
,   0 as deleted_fg
,   0 as record_id
,   't_${SRC_INPUT_TABLE}' as filename
,   'WAWI_WH' as dwh_node_cd
,   '${LOAD_ID}' as dwh_load_id
FROM
           etl_process.t_wawi_precore_t180_stinventory_snap_2 as t180
INNER JOIN etl_process.t_wawi_precore_t182_sic_inventory_snap_2 as t182 
        ON t180.ctrcode = t182.ctrcode
        AND t180.wh_nr = t182.wh_nr
        AND t180.c180_id = t182.c182_id
WHERE
	t180.c180_inv_flag = 71
    AND t182.c182_status = 64
;
