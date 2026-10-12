CREATE TABLE P_LEW_CORE.T_SPACEMAN_SECTION_HIST (
   spaceman_section_sid                NUMBER(38,0)     NOT NULL COMMENT 'surrogate key: identifies the spaceman section in the space management
            SPACEMAN:TBLAPSECTION.SECTIONID',
   section_group_level_5_nr            NUMBER(38,0),
   section_status_cd                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'code for the section status (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)',
   section_name                        VARCHAR(100)     COMMENT 'name of the section
            SPACEMAN:TBLAPSECTION.NAME',
   section_name_de                     VARCHAR(100)     COMMENT 'German name of the section
            SPACEMAN:TBLAPSECTION.EXTDESC17',
   section_width_meas                  NUMBER(38,5)     COMMENT 'width of the spaceman sectiopn in the unit given in uom_cd_width
            SPACEMAN:TBLAPSECTION.WIDTH',
   uom_cd_width                        VARCHAR(20)      COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
            here inch for USA, cm for all other countries',
   uom_sid_width                       NUMBER(38,0)     COMMENT 'Surrogate Key UNIT OF MEASUREMENT',
   section_update_tmsp                 TIMESTAMP_NTZ(9) COMMENT 'Last time when the record was updated by a source (PAS). In the past there were cases when changes made in spaceman were not reflected in the PAS within the expected timeframe, but had significant delays.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SPACEMAN_SECTION_HIST PRIMARY KEY (spaceman_section_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'logical part of the available shelf space in a store';
