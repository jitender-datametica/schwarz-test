--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.wup_1 
 SET 	getraenkemarkt_fg = _getraenkemarkt_fg
 FROM (SELECT
        mandant_id as _mandant_id,
	wup_id as _wup_id,
	getraenkemarkt_fg as _getraenkemarkt_fg	
      FROM ${TEMP_TABLE}/*DBP_ETL.wup_temp*/
      ) dt1
 WHERE 	mandant_id = _mandant_id 
   AND	wup_id = _wup_id 
   AND  nb_id = 0 
   AND  dat_von IS NOT NULL;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.wup_1 
 SET 	wup_name_e 			= _wup_name_e,
	wup_str 			= _wup_str,
	wup_plz 			= _wup_plz,
	wup_stadt 			= _wup_stadt,
	land_id 			= _land_id,
	vw_id 				= _vw_id,
	wup_typ_id 			= _wup_typ_id,
	bewertungskreis_id 		= _bewertungskreis_id,
	verkaufsorganisation_id 	= _verkaufsorganisation_id,
	haupt_wup_id 			= _haupt_wup_id,
	nb_id 				= _nb_id,
        mandant_id_ursprung             = _mandant_id_ursprung
 FROM (
SELECT
	nb_id as _nb_id,
	wup_plz as _wup_plz,
	land_id as _land_id,
	wup_stadt as _wup_stadt,
	wup_str as _wup_str,
	haupt_wup_id as _haupt_wup_id,
	bewertungskreis_id as _bewertungskreis_id,
	mandant_id as _mandant_id,
	wup_typ_id as _wup_typ_id,
	verkaufsorganisation_id as _verkaufsorganisation_id,
	wup_id as _wup_id,
	wup_name_e as _wup_name_e,
	vw_id as _vw_id,
        mandant_id_ursprung as _mandant_id_ursprung
 FROM ${TEMP_TABLE} /*DBP_ETL.wup_temp*/
) dt1
 WHERE 	mandant_id 	= _mandant_id 
   AND 	wup_id 		= _wup_id
;

