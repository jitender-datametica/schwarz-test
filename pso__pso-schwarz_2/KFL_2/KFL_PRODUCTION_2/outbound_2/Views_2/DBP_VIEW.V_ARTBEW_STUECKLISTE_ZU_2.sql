CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_stueckliste_zu_2 (art_id
OPTIONS(description='ID der Artikelnummer per Stueckliste_2 mit Referenz zur Tabelle art_2'), mandant_id
OPTIONS(description='Mandant_2 im DWH'), wup_id OPTIONS(description='Nummer des Marktes'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='Datum des Abverkaufs, Format YYYY-MM_2-DD'), komponente_art_id
OPTIONS(description='Artikelnummer der Stuecklistenkomponente mit referenz zur Tabelle art_2'), umrech_faktor
OPTIONS(description='Umrechnungsfaktor für die Komponenten in einem VK_2-Set.'), menge_komponente_in_vk_set
OPTIONS(description='Gewichstwert in der Mengeneinheit der Komponente in der Stückliste bzw. Verkaufsset (VK_2-Set) anteilig ihrer Menge.'),
stueckliste_id OPTIONS(description='Eindeutige ID der Stueckliste_2'), wrg_id
OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag. Anteil aus Abverkauf auf Basis EKN1'),
umsatz_mwst_betrag
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
menge OPTIONS(description='berechneter Wert aus Menge Abverkauf * Menge Komponente * Umrechnungsfaktor'), ek_brutto
OPTIONS(description='Einkaufspreis brutto (bedeutung vgl. Kalkulationsschema).'), ek_netto
OPTIONS(description='Einkaufspreis netto (bedeutung vgl. Kalkulationsschema).'), ek_nettonetto
OPTIONS(description='Einkaufspreis nettonetto ((Bedeutung vgl. Kalkulationsschema).'), ek_kal_basis
OPTIONS(description='Kalkulationsbasis ((Bedeutung vgl. Kalkulationsschema).'), ek_mep
OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'), ek_mep_vor_fwu
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis OPTIONS(description='Kaufland Einstandspreis ((Bedeutung vgl. Kalkulationsschema).'), logkostenzuschlag
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
ek_netto_bnk OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk_sachk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten(Bedeutung vgl. Kalkulationsschema).'),
bq_findung_id OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.'), umrechnungskurs
OPTIONS(description='Umrechnungskurs zur Umrechnung Landeswährung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
umrechnungskurs_hist OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '), bonusbasis
OPTIONS(description='Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA'))
OPTIONS(DESCRIPTION = `AIS KMO - HIER WERDEN DIE STUECKLISTENARTIKEL AUS ARTBEW_2 IN IHRE POSITIONEN AUFGELOEST, UM DIESE DETAILLIERT AUSWERTEN ZU KOENNEN.`)
AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat,
 komponente_art_id,
 umrech_faktor,
 menge_komponente_in_vk_set,
 stueckliste_id,
 wrg_id,
 umsatz_netto,
 umsatz_mwst_betrag,
 menge,
 ek_brutto,
 ek_netto,
 ek_nettonetto,
 ek_kal_basis,
 ek_mep,
 ek_mep_vor_fwu,
 einstandspreis,
 logkostenzuschlag,
 ek_netto_bnk,
 ek_netto_bnk_sachk,
 bq_findung_id,
 umrechnungskurs,
 umrechnungskurs_hist,
 bonusbasis
FROM kfl_production_dbp_data.artbew_stueckliste_zu_2;