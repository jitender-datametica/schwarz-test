CREATE OR REPLACE VIEW FE_MSTR_SCM.V_ITEM_LOOKUP(
	CLIENT_ID COMMENT 'Identification of country',
	COUNTRY_ISO_CD COMMENT 'Abbreviation of country',
	NAN COMMENT 'national article number',
	IAN COMMENT 'International article number',
	ARTIKEL_BEZEICHNUNG COMMENT 'description of article name',
	ZIELREICHWEITE COMMENT 'target delivery time'
) AS
WITH all_ian_demand AS (
    SELECT DISTINCT
        cou.client_id
        ,d.land AS country_cd
        ,d.ian
        ,d.artikel_bezeichnung
    FROM core.t_demand_ordr_recvd_weekly d
    INNER JOIN core_rel.t_client cou
    ON cou.country_cd = d.land
)
SELECT 
    aid.client_id
    ,aid.country_cd
    ,IFNULL(itm.orig_item_nr,-1) AS nan
    ,aid.ian
    ,aid.artikel_bezeichnung
    ,IFNULL(sub.tgt_delivery_time_week_cnt,0) AS zielreichweite
FROM all_ian_demand aid
LEFT JOIN core_rel.t_item itm
ON aid.client_id = itm.client_id
AND aid.ian = IFNULL(itm.src_orig_item_nr_int,itm.orig_item_nr_int)
LEFT JOIN core_rel.t_subitemgroup_delivery_time_target sub
ON sub.subitemgrp_cd = itm.subitemgrp_cd
QUALIFY ROW_NUMBER() OVER (PARTITION BY aid.client_id, aid.ian ORDER BY nan DESC) = 1
UNION
SELECT
	itm.client_id
	,itm.country_iso_cd
    ,itm.orig_item_nr AS nan
    ,IFNULL(itm.src_orig_item_nr_int, itm.orig_item_nr_int) AS ian
    ,IFNULL(itm.item_descr,itm.item_name) AS artikel_bezeichnung
    ,IFNULL(sdt.tgt_delivery_time_week_cnt,0) AS zielreichweite
FROM core_rel.t_item itm
LEFT JOIN core_rel.t_subitemgroup_delivery_time_target sdt
ON itm.subitemgrp_cd = sdt.subitemgrp_cd
WHERE ((itm.client_id NOT IN (33) AND itm.case_size > 0 AND itm.subitemgrp_cd IS NOT NULL) OR itm.client_id = 33)
AND (
    NOT EXISTS (
        SELECT 1
        FROM all_ian_demand
        WHERE CONCAT(client_id, ian) = CONCAT(itm.client_id, IFNULL(itm.src_orig_item_nr_int, itm.orig_item_nr_int))
    )) 
QUALIFY ROW_NUMBER() OVER (PARTITION BY itm.client_id, ian, nan ORDER BY artikel_bezeichnung, itm.dwh_updated_tmsp DESC) = 1
;