--==============================================================
-- Table: vis_tag_umsatz_wg_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_umsatz_wg_2
   generated from Powerdesigner on Dienstag, 8. April 2025 18:46:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_tag_umsatz_wg_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
wtag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag ID'),
ums_netto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_af BIGNUMERIC(38,4) OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa BIGNUMERIC(38,4) OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_wvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
ums_netto_af_wvj BIGNUMERIC(38,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_wvj BIGNUMERIC(38,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_wvvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
ums_netto_af_wvvj BIGNUMERIC(38,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_wvvj BIGNUMERIC(38,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_kvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_af_kvj BIGNUMERIC(38,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_kvj BIGNUMERIC(38,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_kvvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
ums_netto_af_kvvj BIGNUMERIC(38,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_kvvj BIGNUMERIC(38,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_brutto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz brutto'),
ums_brutto_kvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
ums_brutto_wvj BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'),
menge_absatz BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_sa BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_kvj BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_kvj BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_sa_kvj BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_wvj BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Wochentag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_wvj BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_sa_wvj BIGNUMERIC(38,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, nb_id, wup_id, wg_id, arthiertyp_id, wrg_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='VIS - Aggregat auf Tagesebene');