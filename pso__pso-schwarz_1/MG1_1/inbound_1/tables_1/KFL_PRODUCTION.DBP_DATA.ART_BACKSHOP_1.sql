create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_BACKSHOP_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BESTELL_ART_ID NUMBER(38,0) NOT NULL COMMENT 'Bestellartikel = ein Artikel_1 der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art_1',
	INHALT_MENGE NUMBER(9,3) COMMENT 'Menge des Artkels in Stück',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BACKSHOP primary key (MANDANT_ID, BESTELL_ART_ID)
)COMMENT='VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek'
;