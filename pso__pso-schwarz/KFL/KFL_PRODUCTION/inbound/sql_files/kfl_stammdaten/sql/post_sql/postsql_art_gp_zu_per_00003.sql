--AW 2021-04-22 check OK
UPDATE DBP_DATA.art_gp_zu_per  
SET
     mutter_ek_id              = _mutter_ek_id
     ,TD_UPDATE = CURRENT_TIMESTAMP
FROM
(SELECT
     dat_von                   as _dat_von
    ,mandant_id                as _mandant_id
    ,art_id                    as _art_id
    ,mutter_ek_id              as _mutter_ek_id
FROM ${TEMP_TABLE} /*DBP_ETL.art_gp_zu_per_temp*/) t1 WHERE
     dat_bis                     = to_date('9999-12-31','YYYY-MM-DD')
   AND mandant_id                = _mandant_id
   AND art_id                    = _art_id
;

UPDATE DBP_DATA.art_gp_zu_per 
SET
     mutter_ek_id   = NULL

WHERE  mandant_id=1 
  AND (mandant_id, art_id) NOT in
	(SELECT mandant_id, art_id 
	 FROM ${TEMP_TABLE} /*DBP_ETL.art_gp_zu_per_temp*/
	 GROUP BY 1,2
	)
;

UPDATE DBP_DATA.art_gp_zu_per SET dat_von = to_date('20170101','YYYYMMDD') /*1170101*/
WHERE mandant_id = 1 AND 
      art_id IN (1280100, 1280200, 1280300, 1280400, 1280500, 1280600) AND
      dat_von = to_date('20180101','YYYYMMDD') /*1180101*/
;

