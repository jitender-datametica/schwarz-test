CREATE OR REPLACE TABLE AKTION_1 (
	AKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	AKTIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Kommt aus der Tabelle WAKH.akart
            Angabe, die eine_1 Aktion_1 nach technischen Gesichtspunkten klassifiziert.
            Die Aktionsart umfaßt folgende Werte:
            ZF: 	Food
            ZFI: 	Fisch
            ZFL: 	Fleisch
            ZNF:	Nonfood
            ZWG:	Wurst und Geflügel
            ',
	WERBE_KAT_ID NUMBER(38,0) COMMENT 'Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung',
	DAT_VON DATE COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_1-TT
            ',
	DAT_BIS DATE COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT
            ',
	PREISAKTIVIERT_FG NUMBER(38,0) COMMENT 'abgeleitet WAKH_1-VKGST (wird auf 1 gesetzt, wenn WAKH_1-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2_1',
	KJWO_VON NUMBER(38,0) NOT NULL COMMENT 'Start-Kalenderwoche der Aktion_1 entsprechend dat_von. Redundant, zur Steigerung der Performance',
	AKTION_TYP_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot_1, KDN bei Loyaltypromotion, KDP bei Couponaktion',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AKTION primary key (AKTION_ID, MANDANT_ID, BEWART_ID)
);