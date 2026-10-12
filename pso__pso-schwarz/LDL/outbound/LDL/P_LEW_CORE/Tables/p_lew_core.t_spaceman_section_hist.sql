CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section_hist (
spaceman_section_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key: identifies the spaceman section in the space management            SPACEMAN:TBLAPSECTION.SECTIONID'),
section_group_level_5_nr BIGNUMERIC(38,0),
section_status_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='code for the section status (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)'),
section_name STRING(100) OPTIONS(description='name of the section            SPACEMAN:TBLAPSECTION.NAME'),
section_name_de STRING(100) OPTIONS(description='German name of the section            SPACEMAN:TBLAPSECTION.EXTDESC17'),
section_width_meas BIGNUMERIC(38,5)
OPTIONS(description='width of the spaceman sectiopn in the unit given in uom_cd_width            SPACEMAN:TBLAPSECTION.WIDTH'),
uom_cd_width STRING(20)
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode            here inch for USA, cm for all other countries'),
uom_sid_width BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key UNIT OF MEASUREMENT'),
section_update_tmsp DATETIME
OPTIONS(description='Last time when the record was updated by a source (PAS). In the past there were cases when changes made in spaceman were not reflected in the PAS within the expected timeframe, but had significant delays.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (spaceman_section_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='logical part of the available shelf space in a store');