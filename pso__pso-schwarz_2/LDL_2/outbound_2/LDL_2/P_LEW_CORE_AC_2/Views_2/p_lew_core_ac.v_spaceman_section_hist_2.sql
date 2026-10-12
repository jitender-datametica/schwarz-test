CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section_hist_2 (spaceman_section_sid
OPTIONS(description='surrogate key: identifies the spaceman section in the space management\nSPACEMAN:TBLAPSECTION.SECTIONID'),
section_group_level_5_nr, section_status_cd
OPTIONS(description='code for the section status_2 (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)'),
section_name OPTIONS(description='name of the section\nSPACEMAN:TBLAPSECTION.NAME'), section_name_de
OPTIONS(description='German name of the section\nSPACEMAN:TBLAPSECTION.EXTDESC17'), section_width_meas
OPTIONS(description='width of the spaceman sectiopn in the unit_2 given in uom_cd_width\nSPACEMAN:TBLAPSECTION.WIDTH'),
uom_cd_width
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode\nhere inch for USA, cm for all other countries'),
uom_sid_width OPTIONS(description='Surrogate Key UNIT_2 OF MEASUREMENT'), section_update_tmsp
OPTIONS(description='Last time when the record was updated by a source (PAS). In the past there were cases when changes made in spaceman were not reflected in the PAS within the expected timeframe, but had significant delays.'),
deleted_fg OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'), dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id OPTIONS(description='technical column required by the used ETL framework\nstatic 7 for all rows'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'), section_update_dt
OPTIONS(description='last time when the record was updated by a source (pas). in the past there were cases when changes made in spaceman were not reflected in the pas within the expected timeframe, but had significant delays.'))
OPTIONS(DESCRIPTION = `LOGICAL PART OF THE AVAILABLE SHELF SPACE IN A STORE`) AS SELECT spaceman_section_sid,
 section_group_level_5_nr,
 section_status_cd,
 section_name,
 section_name_de,
 section_width_meas,
 uom_cd_width,
 uom_sid_width,
 section_update_tmsp,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 DATE(DATE(section_update_tmsp)) AS section_update_dt
FROM ldl_p_lew_core.t_spaceman_section_hist_2;