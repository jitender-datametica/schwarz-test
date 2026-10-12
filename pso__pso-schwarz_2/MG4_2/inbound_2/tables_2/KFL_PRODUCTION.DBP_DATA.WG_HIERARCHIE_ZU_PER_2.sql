create or replace TABLE KFL_PRODUCTION.DBP_DATA.WG_HIERARCHIE_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_HIERARCHIE_EBENE_ID NUMBER(38,0) NOT NULL COMMENT 'eindeutige ID der Ebene einer Warengruppenhierarchie',
	WG_HIERARCHIE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppen Hierarchie',
	WG_HIERARCHIE_MUTTER_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Elternelements',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
	DAT_BIS DATE NOT NULL COMMENT 'Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WG_HIERARCHIE_ZU_PER primary key (MANDANT_ID, ARTHIERTYP_ID, WG_HIERARCHIE_EBENE_ID, WG_HIERARCHIE_ID, DAT_VON)
)COMMENT='TP2_AIS - Stammdaten der Warengruppenhierarchien'
;