create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.INVENTUR_WARENVERLUST_KALK_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Der \""WUP_2\"" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.',
	INVENTURART_ID NUMBER(38,0) NOT NULL COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON DATE NOT NULL COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	DAT_INVENTUR_BIS DATE NOT NULL COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	GJ NUMBER(38,0) COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	BETRAG_VK_NETTO_INVENTUR_DIFF_KALK NUMBER(38,4) COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_INVENTUR_WARENVERLUST_KALK primary key (MANDANT_ID, WUP_ID, NB_ID, INVENTURART_ID, DAT_INVENTUR_BIS, OWG_ID)
)COMMENT='Die Tabelle basiert auf Excel und enthält Kalkulatorische Abgrenzung aus dem CO für Jahres- und Zwischeninventuren. Die Tabelle deckt einen Sonderfall ab. Es wird nur Daten für Mandant_2 DE geben und wahrscheinlich nur für zwei Inventur_2-Arten, Jahresinventur und möglicherweise Zwischeninventur. CO muss in Deutschland kalkulatorische Abgrenzungen auf die Inventur_2-Differenzen buchen. Das heißt die eigentlichen systemischen Inventur_2-Werte werden um diesen Wert erhöht oder verringert.'
;
