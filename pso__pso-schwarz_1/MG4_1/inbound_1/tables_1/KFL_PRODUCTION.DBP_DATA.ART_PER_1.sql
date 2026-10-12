create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_PER_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Datum, von dem an der Zustand gilt. Initial wird das dat_von aus der Tabelle art_1 eingetragen',
	DAT_BIS DATE NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Datum, bis zu dem der Zustand gueltig war/ist. Bei aktuellen Eintraegen der 31.12.9999',
	MUTTER_WB_ID NUMBER(38,0) COMMENT 'Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des fuehrenden Artikels (auch: Mutterartikel) hinterlegt',
	POSTEN_ID VARCHAR(2) COLLATE 'en-ci' COMMENT 'Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN',
	IPN_ID NUMBER(18,0) COMMENT 'Internationale Produktnummer zum Artikel_1 (MAW1.ZZEK_IPN)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MWST_ID NUMBER(38,0) COMMENT 'Mehrwertsteuer-Kennzeichen historisiert',
	OUG_ID NUMBER(38,0) COMMENT 'Kennzeichen Obst und Gemuese',
	IWT_ID VARCHAR(1) DEFAULT '' COMMENT 'IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country_1 for its own use (''''/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country_1 (I)',
	constraint PK_ART_PER primary key (ART_ID, MANDANT_ID, DAT_VON)
)COMMENT='TP2_AIS - Einzelne Attribute der Tabelle art_1 werden im DWH historisiert'
;