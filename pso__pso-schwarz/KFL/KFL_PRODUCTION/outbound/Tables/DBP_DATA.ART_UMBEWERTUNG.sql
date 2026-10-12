--==============================================================
-- Table: art_umbewertung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umbewertung
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_umbewertung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
umbew_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer der Umbewertung aus SAP UBLNR'),
umbew_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer des Belegs aus uzeil'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr des Belegs aus ubjahr'),
preis_aend_grund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Preisänderungsgrunds, z-Bsp. 12. Aus pv_grund'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_umbew DATE NOT NULL OPTIONS(description='Kalenderdatum der Umbewertung im Format JJJJ-MM-TT. Aus vpdat'),
vk_brutto_alt NUMERIC(9,2) NOT NULL OPTIONS(description='alter Verkausfspreis VPALT aus USEG'),
menge_umbew NUMERIC(18,3) NOT NULL
OPTIONS(description='Bestandsmenge in Basismengeneinheit aus menge: Das Feld wird in SAP nicht mehr fortgeschrieben'),
diff_wert_bestand_brutto NUMERIC(18,2) NOT NULL
OPTIONS(description='Wert der Umbewertung mit Steuern auf Basis der Bestandmenge aus USEG.VKSAD'),
diff_wert_bestand_netto NUMERIC(18,2) NOT NULL
OPTIONS(description='Wert der Umbewertung ohne Steuern auf Basis der Bestandmenge aus USEG.VKSADN'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_erf NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Erfassungsmengeneinheit zur VK-Preisumbewertung aus erfmg'),
menge_bestand_bme NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Gesamter bewerteter Bestand aus lbkum'),
wert_bestand_brutto_alt NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Wert des gesamten bewerteten Bestands zum (Brutto)Verkaufspreis vor der Umbewertung aus vksal_old'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Verkaufsmengeneinheit zu menge_erf. Aus vrkme'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg'),
art_id_bf BIGNUMERIC(38,0) OPTIONS(description='Artikel, auf dem der Bestand geführt wird aus matbf. Referenz zu art'),
vk_brutto_neu NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='neuer Verkausfspreis vpneu aus USEG'),
wert_bestand_netto_alt NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Bestandswert zu netto alt aus vksaln_old'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, umbew_beleg_id, umbew_beleg_pos_id, kj) NOT ENFORCED
) CLUSTER BY mandant_id, dat_umbew
OPTIONS(description='WWC - Verkaufspreis-Umbewertungsbelege aus den Tabellen USEG und ZUSEG');