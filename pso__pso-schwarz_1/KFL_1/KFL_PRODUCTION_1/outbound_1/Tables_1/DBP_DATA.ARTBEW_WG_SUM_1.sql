--==============================================================
-- Table: artbew_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_wg_sum_1
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_wg_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_1 '),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
umsatz_brutto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz incl. Mehrwertsteuerbetrag            '),
umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag            '),
umsatz_wrg STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR'),
umsatz_brutto_konz NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz brutto in der Konzernwährung'),
umsatz_netto_konz NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz netto in der Konzernwährung'),
quelle BIGNUMERIC(38,0) DEFAULT 0,
menge NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='TP1 MIS - Aggregationstabelle artbew_1 auf Ebene Warengruppe/Markt/Datum - MULTISET');