CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_wg_sum_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), arthiertyp_id
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id OPTIONS(description='ID der Warengruppe'), umrechnungskurs_hist
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '), dat
OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD'), wup_id
OPTIONS(description='Nummer des Warenumschlagsplatzes'), bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
kjmo OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), umsatz_brutto
OPTIONS(description='Umsatz incl. Mehrwertsteuerbetrag'), umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'), umsatz_wrg
OPTIONS(description='Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR'), umsatz_brutto_konz
OPTIONS(description='Umsatz brutto in der Konzernwährung'), umsatz_netto_konz
OPTIONS(description='Umsatz netto in der Konzernwährung'), quelle OPTIONS(description=''), menge
OPTIONS(description='ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.'))
OPTIONS(DESCRIPTION = `TP1 MIS - AGGREGATIONSTABELLE ARTBEW_2 AUF EBENE WARENGRUPPE/MARKT/DATUM - MULTISET`) AS SELECT
 mandant_id,
 nb_id,
 arthiertyp_id,
 wg_id,
 umrechnungskurs_hist,
 dat,
 wup_id,
 bewart_id,
 kjmo,
 umsatz_brutto,
 umsatz_netto,
 umsatz_wrg,
 umsatz_brutto_konz,
 umsatz_netto_konz,
 quelle,
 menge
FROM kfl_production_dbp_data.artbew_wg_sum_2;