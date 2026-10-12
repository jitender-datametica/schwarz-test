DROP TABLE IF EXISTS kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
gj INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
akt_gj INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
akt_mo INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Kalendermonats'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
akt_wo INTEGER NOT NULL OPTIONS(description='Zähler auf Basis der aktuellen Kalenderwoche'),
wtag_id INTEGER NOT NULL OPTIONS(description='Wochentag ID'),
akt_tag INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Tages'),
ums_netto NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_af NUMERIC(29,4) OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / Tage'),
ums_netto_sa NUMERIC(29,4) OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / Tag_1'),
ums_netto_wvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
ums_netto_af_wvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1'),
ums_netto_sa_wvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1'),
ums_netto_wvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
ums_netto_af_wvvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag_1'),
ums_netto_sa_wvvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag_1'),
ums_netto_kvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_af_kvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag_1'),
ums_netto_sa_kvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag_1'),
ums_netto_kvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
ums_netto_af_kvvj NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1'),
ums_netto_sa_kvvj NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1'),
ums_netto_plan NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
ums_netto_plan_extern NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz netto Planwert extern'),
ums_brutto NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto'),
ums_brutto_wvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'),
ums_brutto_wvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Wochentag im Vorvorjahr'),
ums_brutto_kvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
ums_brutto_kvvj NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vor-Vorjahr'),
anz_kunde INTEGER NOT NULL OPTIONS(description='Anzahl Kunden'),
anz_kunde_wvj INTEGER NOT NULL OPTIONS(description='Anzahl Kunden Wochentag im Vorjahr'),
anz_kunde_kvj INTEGER NOT NULL OPTIONS(description='Anzahl Kunden Kalendertag im Vorjahr'),
anz_offen INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage'),
anz_offen_wvj INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Wochentag im Vorjahr'),
anz_offen_wvvj INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Wochentag im Vor-Vorjahr'),
anz_offen_kvj INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vorjahr'),
anz_offen_kvvj INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'),
menge_absatz NUMERIC(29,3) OPTIONS(description='Menge an verkauften Artikel_1 auf Ebene Markt / Tag_1'),
menge_absatz_af NUMERIC(29,3) OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 auf Ebene Markt / Tag_1'),
menge_absatz_sa NUMERIC(29,3) OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion auf Ebene Markt / Tag_1'),
menge_absatz_wvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_af_wvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_sa_wvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_kvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_af_kvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_sa_kvj NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_1 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / Tag_1'),
menge_absatz_ohne_pfand_plan NUMERIC(29,3)
OPTIONS(description='Geplante Menge an verkauften Artikel_1 ohne Pfandartikel auf Ebene Markt / Tag_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, nb_id, wup_id, wrg_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='VIS - Aggregat auf Tagesebene - MULTISET - Beladung aus wup_plan_tag_1');