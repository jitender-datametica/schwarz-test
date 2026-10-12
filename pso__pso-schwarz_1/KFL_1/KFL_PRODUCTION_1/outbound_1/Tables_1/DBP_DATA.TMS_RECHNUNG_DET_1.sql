--==============================================================
-- Table: tms_rechnung_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_det_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_rechnung_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_rech_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr'),
tms_rech_beleg_pos_id STRING(8) NOT NULL OPTIONS(description='Rechnungspositionsnummer. Aus plrpos.beleg_posnr'),
tms_rech_pos_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_rechnung_det_1 im Quellsystem. Aus plrpos.rpos_id'),
dat_tms_rech_beleg DATE NOT NULL OPTIONS(description='Belegdatum'),
preis_einzel NUMERIC(18,3) OPTIONS(description='Preis pro Einheit (Ansatz)'),
betrag_vor_rabattabzug NUMERIC(18,3) OPTIONS(description='Rechungsbetrag vor Rabattabzug'),
betrag_netto NUMERIC(18,3) OPTIONS(description='Nettoendbetrag der Belegposition'),
mwst NUMERIC(9,2) OPTIONS(description='MwSt-Satz'),
tms_konto_id BIGNUMERIC(38,0) OPTIONS(description='Konto_1 ID, entspricht der Kostenart_1 (Basispreis, Zuschlag Kühlung,…)'),
bewertungseinheit_cd STRING(20)
OPTIONS(description='Bewertungseinheit (nicht SAP-Mengeneinheiten, z. B. auch L-St. für Ladestellen möglich)'),
tms_rech_org_pos_id BIGNUMERIC(38,0) OPTIONS(description='Organisatorische Positionsnummer'),
tms_rech_pos_txt STRING(300) OPTIONS(description='Rechnungspositionstext'),
tms_rech_pos_leist_typ_cd STRING(8) OPTIONS(description='Leistungsart'),
tms_rech_pos_leist_typ_bez STRING(30) OPTIONS(description='Bezeichnung zur Leistungsart'),
menge_effektiv NUMERIC(18,3) OPTIONS(description='Effektive Menge'),
menge_frachtpflichtig NUMERIC(18,3) OPTIONS(description='Frachtpflichtige Menge'),
tms_tour_id BIGNUMERIC(38,0) OPTIONS(description='Tournummer'),
dat_tour DATE OPTIONS(description='Tourdatum'),
bewertungseinheit_id BIGNUMERIC(38,0)
OPTIONS(description='Eine_1 abstrakte ID, um alles zusammenzufassen, was bewertet wird (entspricht i.d.R. einer Tour_1, ist aber nicht die Tournummer). Einheit bezieht sich hier auf die Einheit, die bewertet wird, z. B. eine_1 Tour_1 (evtl. kann Wanko auch mehrere Touren zusammenfassen - de facto ist es aber eine_1 1:1-Beziehung).'),
reklamation_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Reklamation'),
bearbeitet_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Wurde Bearbeitet'),
reklamation_txt STRING(300) OPTIONS(description='Text zur Reklamation'),
tms_rech_pos_referenz_lfd_nr BIGNUMERIC(38,0)
OPTIONS(description='Laufende Nummer der ursprünglichen Rechnungsposition, auf die sich diese (meistens als Reklamation oder Ablehnung einer Reklamation erfasste) Position bezieht. Bezieht sich immer auf eine_1 Position innerhalb derselben Rechnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tms_rech_beleg_id, system_id, tms_rech_beleg_pos_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die detaillierte Informationen zu einzelnen Rechnungspositionen, einschließlich TMS-Tourbezeichnung, Menge, Preis und Mehrwertsteuersatz. Aus der Quelle plrpos (WANKO)');