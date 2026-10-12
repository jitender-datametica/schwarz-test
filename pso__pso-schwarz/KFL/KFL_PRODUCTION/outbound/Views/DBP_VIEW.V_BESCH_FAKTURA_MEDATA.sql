CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_medata (art_id OPTIONS(description='Artikel ID'),
mandant_id OPTIONS(description='Mandant im DWH'), faktura_markt
OPTIONS(description='bezieht sich auf den empfangenden wup'), dat_faktura
OPTIONS(description='Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt'),
wup_id OPTIONS(description='in diesem Fall der beliefernde wup - Medatalager'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), zwsum_3_betrag
OPTIONS(description='Einkaufspreis netto  bzw. EK-Aktion netto vermindert um die Reklapauschale.'), menge_fakturiert
OPTIONS(description='Fakturierte Menge in Verkaufseinheiten, Displays werden als 1 gerechnet'), ek_netto_bnk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'), ek_mep
OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'), logistikkostenzuschlag
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
betrag_ek_mep_vor_fwu
OPTIONS(description='Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'))
OPTIONS(DESCRIPTION = `TP2 AIS - FAKTURADATEN AUS MEDATA - LÄGERN (NICHT IN SAP)`) AS SELECT art_id,
 mandant_id,
 faktura_markt,
 dat_faktura,
 wup_id,
 nb_id,
 zwsum_3_betrag,
 menge_fakturiert,
 ek_netto_bnk,
 ek_mep,
 logistikkostenzuschlag,
 betrag_ek_mep_vor_fwu
FROM kfl_production_dbp_data.besch_faktura_medata;