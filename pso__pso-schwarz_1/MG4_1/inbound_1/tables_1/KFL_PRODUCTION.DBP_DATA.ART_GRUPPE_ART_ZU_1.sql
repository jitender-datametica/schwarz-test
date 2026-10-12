create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_GRUPPE_ART_ZU_1 (
	ART_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Artikel_1-Gruppierung (System generiert im DWH)',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - ID einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	UMRECH_FAKTOR NUMBER(38,5) NOT NULL DEFAULT 0 COMMENT 'Umrechnungsfaktor Standardmäßig immer 1. Kann jedoch vom User geändert werden, z. B. um verschiedene Gebinde korrekt zu berechnen. Kann Wert mit Dezimalstellen sein.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_GRUPPE_ART_ZU primary key (ART_GRUPPE_ID, MANDANT_ID, ART_ID)
)COMMENT='EK-INT - Artikelzuordnung zu Artikel_1-Gruppierungen (Zusammenfassung von Artikelnummern in diverse Gruppen für das Reporting / manueller Upload - langfristig Ablösung durch PIM)'
;