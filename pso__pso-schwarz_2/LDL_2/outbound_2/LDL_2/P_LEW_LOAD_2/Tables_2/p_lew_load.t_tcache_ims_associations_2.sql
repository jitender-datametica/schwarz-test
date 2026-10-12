CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_ims_associations_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='UID of the DWH client, FK to P_LEW_CORE.T_CLIENT_2'),
bic_zmlila STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Source data: Country_2 code: IMS-ESB-XML tag_2: object__info__country_id'),
associations__association__id STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Source data: Technical UID of the warehouse: IMS-ESB-XML tag_2: associations.association.id'),
associations__association__number BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Source data: Functional/business Nb. of the warehouse: IMS-ESB-XML tag_2: associations.association.number'),
associations__association__name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Source data: Name of the organization/WH: IMS-ESB-XML tag_2: association.assoc_name'),
associations__association__name2 STRING(100) COLLATE 'und:ci'
OPTIONS(description='Source data: Additional name part of the Organization/WH: IMS-ESB-XML tag_2: association.assoc_name2'),
associations__association__comment STRING(1000)
OPTIONS(description='Source data: Free text comment regarding Organization/WH (w/i Immo-Mgmt-System): IMS-ESB-XML tag_2: association.comments'),
transaction__timestamp DATETIME NOT NULL
OPTIONS(description='Source data change date: IMS-ESB-XML tag_2: IMS transaction__timestamp'),
extraction_ts DATETIME NOT NULL OPTIONS(description='DWH staging timestamp: stager file column: extraction_ts'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='UID of the last load that created or changed the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the initial record creation'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of  the last record change')
);