DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_UMBEWERTUNG_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_UMBEWERTUNG_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
UMBEW_BELEG_ID INTEGER NOT NULL OPTIONS(description='Belegnummer der Umbewertung_2 aus SAP UBLNR'),
UMBEW_BELEG_POS_ID INTEGER NOT NULL OPTIONS(description='Positionsnummer des Belegs aus uzeil'),
KJ INTEGER NOT NULL OPTIONS(description='Kalenderjahr des Belegs aus ubjahr'),
PREIS_AEND_GRUND_ID INTEGER NOT NULL OPTIONS(description='ID des Preisänderungsgrunds, z-Bsp. 12. Aus pv_grund'),
ART_ID INTEGER NOT NULL OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_UMBEW DATE NOT NULL OPTIONS(description='Kalenderdatum der Umbewertung_2 im Format JJJJ-MM_2-TT. Aus vpdat'),
VK_BRUTTO_ALT NUMERIC(9,2) NOT NULL OPTIONS(description='alter Verkausfspreis VPALT aus USEG'),
MENGE_UMBEW NUMERIC(18,3) NOT NULL
OPTIONS(description='Bestandsmenge in Basismengeneinheit aus menge: Das Feld wird in SAP nicht mehr fortgeschrieben'),
DIFF_WERT_BESTAND_BRUTTO NUMERIC(18,2) NOT NULL
OPTIONS(description='Wert der Umbewertung_2 mit Steuern auf Basis der Bestandmenge aus USEG.VKSAD'),
DIFF_WERT_BESTAND_NETTO NUMERIC(18,2) NOT NULL
OPTIONS(description='Wert der Umbewertung_2 ohne Steuern auf Basis der Bestandmenge aus USEG.VKSADN'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
MENGE_ERF NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Erfassungsmengeneinheit zur VK_2-Preisumbewertung aus erfmg'),
MENGE_BESTAND_BME NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Gesamter bewerteter Bestand aus lbkum'),
WERT_BESTAND_BRUTTO_ALT NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Wert des gesamten bewerteten Bestands zum (Brutto)Verkaufspreis vor der Umbewertung_2 aus vksal_old'),
VERK_MENGE_EINH_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Verkaufsmengeneinheit zu menge_erf. Aus vrkme'),
BUCHUNGSKREIS_ID INTEGER NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
SOLL_HABEN_KZ STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg'),
ART_ID_BF INTEGER OPTIONS(description='Artikel_2, auf dem der Bestand geführt wird aus matbf. Referenz zu art_2'),
VK_BRUTTO_NEU NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='neuer Verkausfspreis vpneu aus USEG'),
WERT_BESTAND_NETTO_ALT NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Bestandswert zu netto alt aus vksaln_old'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, UMBEW_BELEG_ID, UMBEW_BELEG_POS_ID, KJ) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT_UMBEW
OPTIONS(description='WWC - Verkaufspreis-Umbewertungsbelege aus den Tabellen USEG und ZUSEG');