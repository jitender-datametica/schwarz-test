CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SPACEMAN_SECTION_HIST_2(
  SPACEMAN_SECTION_SID COMMENT 'surrogate key: identifies the spaceman section in the space management\nSPACEMAN:TBLAPSECTION.SECTIONID'
, SECTION_GROUP_LEVEL_5_NR
, SECTION_STATUS_CD COMMENT 'code for the section status_2 (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)'
, SECTION_NAME COMMENT 'name of the section\nSPACEMAN:TBLAPSECTION.NAME'
, SECTION_NAME_DE COMMENT 'German name of the section\nSPACEMAN:TBLAPSECTION.EXTDESC17'
, SECTION_WIDTH_MEAS COMMENT 'width of the spaceman sectiopn in the unit_2 given in uom_cd_width\nSPACEMAN:TBLAPSECTION.WIDTH'
, UOM_CD_WIDTH COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode\nhere inch for USA, cm for all other countries'
, UOM_SID_WIDTH COMMENT 'Surrogate Key UNIT_2 OF MEASUREMENT'
, SECTION_UPDATE_TMSP COMMENT 'Last time when the record was updated by a source (PAS). In the past there were cases when changes made in spaceman were not reflected in the PAS within the expected timeframe, but had significant delays.'
, DELETED_FG COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1'
, DWH_VALID_FROM COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
, DWH_VALID_TO COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
, CLIENT_ID COMMENT 'technical column required by the used ETL framework\nstatic 7 for all rows'
, DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
, DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.'
, DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
, SECTION_UPDATE_DT COMMENT 'last time when the record was updated by a source (pas). in the past there were cases when changes made in spaceman were not reflected in the pas within the expected timeframe, but had significant delays.'

) COMMENT='logical part of the available shelf space in a store'
 AS 
 SELECT
   spaceman_section_sid
  ,section_group_level_5_nr
  ,section_status_cd
  ,section_name
  ,section_name_de
  ,section_width_meas
  ,uom_cd_width
  ,uom_sid_width
  ,section_update_tmsp
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
  ,CAST(TO_DATE(section_update_tmsp) AS DATE) AS section_update_dt
FROM P_LEW_CORE.T_SPACEMAN_SECTION_HIST_2
;