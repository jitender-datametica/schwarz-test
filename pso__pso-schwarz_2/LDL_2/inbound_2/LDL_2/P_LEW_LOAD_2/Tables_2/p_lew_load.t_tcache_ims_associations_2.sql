CREATE TRANSIENT TABLE p_lew_load.t_tcache_ims_associations_2
(
   client_id NUMBER(38,0) NOT NULL COMMENT 'UID of the DWH client, FK to P_LEW_CORE.T_CLIENT_2',
   bic_zmlila VARCHAR(10) COLLATE 'en-ci' NOT NULL COMMENT 'Source data: Country_2 code: IMS-ESB-XML tag_2: object__info__country_id',
   associations__association__id VARCHAR(100) COLLATE 'en-ci' NOT NULL COMMENT 'Source data: Technical UID of the warehouse: IMS-ESB-XML tag_2: associations.association.id',
   associations__association__number NUMBER(38,0) NOT NULL COMMENT 'Source data: Functional/business Nb. of the warehouse: IMS-ESB-XML tag_2: associations.association.number',
   associations__association__name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Source data: Name of the organization/WH: IMS-ESB-XML tag_2: association.assoc_name',
   associations__association__name2 VARCHAR(100) COLLATE 'en-ci' COMMENT 'Source data: Additional name part of the Organization/WH: IMS-ESB-XML tag_2: association.assoc_name2',
   associations__association__comment VARCHAR(1000)  COMMENT 'Source data: Free text comment regarding Organization/WH (w/i Immo-Mgmt-System): IMS-ESB-XML tag_2: association.comments',
   transaction__timestamp TIMESTAMP_NTZ(0) NOT NULL COMMENT 'Source data change date: IMS-ESB-XML tag_2: IMS transaction__timestamp',
   extraction_ts TIMESTAMP_NTZ(6) NOT NULL COMMENT 'DWH staging timestamp: stager file column: extraction_ts',
   dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'UID of the last load that created or changed the record',
   dwh_created TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Timestamp of the initial record creation',
   dwh_updated TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Timestamp of  the last record change'
);