/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_leftoverpallets
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_leftoverpallets (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='wh_nr as a digit Source warehouse number,(datastore_data:lagernummer)'), id
OPTIONS(description='Primary Key'), uu_id OPTIONS(description='Default SYS_GUID() Used by the ALMA webservice'), lane_id
OPTIONS(description='ID of the selected lane References T1216_LANES.C1216_ID'), store
OPTIONS(description='Entered store number'), ambient OPTIONS(description='Number saved for the column Ambient'), bulk
OPTIONS(description='Number saved for the column Bulk'), nf OPTIONS(description='Number saved for the column Ambient'),
relocations OPTIONS(description='Number saved for the column Relocations'), others
OPTIONS(description='Number saved for the column Others'), comment
OPTIONS(description='Entered comment (optional, may be null)'), unblocking_fg
OPTIONS(description='Displays if a Leftover Pallet is inactive /greyed out'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ALMA - THIS TABLE SAVES ALL LEFTOVER PALLET RECORDS`) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 id,
 uu_id,
 lane_id,
 store,
 ambient,
 bulk,
 nf,
 relocations,
 others,
 comment,
 unblocking_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_alma_leftoverpallets;