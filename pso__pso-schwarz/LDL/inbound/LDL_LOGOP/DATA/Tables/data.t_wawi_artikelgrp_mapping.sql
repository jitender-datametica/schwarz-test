CREATE TABLE DATA.T_WAWI_ARTIKELGRP_MAPPING(
	ARTGRUPNR NUMBER(38,0) COMMENT 'Item group nr',
	ARTGRUPBEZ VARCHAR(100) COMMENT 'Item group description - DE',
	ARTGRUPBEZ_EN VARCHAR(100) COMMENT 'Item group description - EN',
	LPTYP VARCHAR(100) COMMENT 'Storage Type - DE',
	LPTYP_EN VARCHAR(100) COMMENT 'Storage Type - EN',
	AUTODISPO_FLG VARCHAR(18) COMMENT 'Is it relevant for AutoDispo: Yes/No',
	WGI VARCHAR(100) COMMENT 'Storage Type - DE',
	WGI_EN VARCHAR(100) COMMENT 'Storage Type - EN'
)COMMENT='WAWI - Article Group and Storage Type Mapping'
;
