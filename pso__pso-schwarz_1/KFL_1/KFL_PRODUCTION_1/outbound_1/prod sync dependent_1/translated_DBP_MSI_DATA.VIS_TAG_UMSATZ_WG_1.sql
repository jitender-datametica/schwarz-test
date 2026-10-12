DROP TABLE IF EXISTS kfl_production_dbp_msi_data.vis_tag_umsatz_wg_1;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.vis_tag_umsatz_wg_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abt_id INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
gj INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
wtag_id INTEGER NOT NULL OPTIONS(description='Wochentag ID'),
ums_netto NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_af NUMERIC(29,4) OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_sa NUMERIC(29,4) OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_wvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
ums_netto_af_wvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_sa_wvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_wvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
ums_netto_af_wvvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_sa_wvvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_kvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_af_kvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_sa_kvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_kvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
ums_netto_af_kvvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_netto_sa_kvvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
ums_brutto NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto'),
ums_brutto_kvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
ums_brutto_wvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'),
menge_absatz NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 auf Ebene Markt / TAG_1 / Warengruppe'),
menge_absatz_sa NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion auf Ebene Markt / TAG_1 / Warengruppe'),
menge_absatz_kvj NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_kvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
menge_absatz_sa_kvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
menge_absatz_wvj NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Wochentag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_wvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
menge_absatz_sa_wvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, nb_id, wup_id, wg_id, arthiertyp_id, wrg_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='VIS - Aggregat auf Tagesebene');