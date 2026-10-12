create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	AKTION_ID VARCHAR(10) NOT NULL COMMENT 'Unique identifier of the NFMD campaign.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	WUP_ID NUMBER(38,0) COMMENT 'Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
	DISCOUNT_TYPE_NAME VARCHAR(50) COMMENT 'Describes the discount type for this article in the given store and promotion campaing. \""nfmd\"" - is the initial discount. \""second_discount\"" means the price of the product has been reduced for a second time in the same promotion.',
	KJWO_WW NUMBER(38,0) COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW.',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR.',
	MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL NUMBER(38,5) COMMENT 'New promotion price - maintained via the frontend (brutto/netto .. which currency).',
	MODEL_PRICE_GROSS_LOCAL_VAL NUMBER(38,5) COMMENT 'Price recommended by the model.',
	MANUAL_PROMO_PRICE_DT DATE COMMENT 'Date when the new price becomes effective - maintained via the frontend (can we change to type DATE. Is MSTR fine to write this type).',
	LAST_TRANSFER_TMSP TIMESTAMP_NTZ(9) COMMENT 'Timestamp of the last  export to SAP.',
	USER_ID VARCHAR(255) COMMENT 'AD name of the user who created the record.',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Timestamp when the record was created.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_NFMD_MANUAL_PRICE_RELEASE primary key (MANDANT_ID, AKTION_ID, ART_ID)
)COMMENT='The release of the changed price and its validity_1 date are written in this table at Article-Market (Store)-Promotion Campaign level.'
;
