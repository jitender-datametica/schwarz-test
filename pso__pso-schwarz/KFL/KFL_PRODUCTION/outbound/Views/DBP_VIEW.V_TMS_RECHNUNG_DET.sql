CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_rechnung_det (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_rech_beleg_id
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr'), tms_rech_beleg_pos_id
OPTIONS(description='Rechnungspositionsnummer. Aus plrpos.beleg_posnr'), tms_rech_pos_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_rechnung_det im Quellsystem. Aus plrpos.rpos_id'), dat_tms_rech_beleg
OPTIONS(description='Belegdatum'), preis_einzel OPTIONS(description='Preis pro Einheit (Ansatz)'),
betrag_vor_rabattabzug OPTIONS(description='Rechungsbetrag vor Rabattabzug'), betrag_netto
OPTIONS(description='Nettoendbetrag der Belegposition'), mwst OPTIONS(description='MwSt-Satz'), tms_konto_id
OPTIONS(description='Konto ID, entspricht der Kostenart (Basispreis, Zuschlag Kühlung,…)'), bewertungseinheit_cd
OPTIONS(description='Bewertungseinheit (nicht SAP-Mengeneinheiten, z. B. auch L-St. für Ladestellen möglich)'),
tms_rech_org_pos_id OPTIONS(description='Organisatorische Positionsnummer'), tms_rech_pos_txt
OPTIONS(description='Rechnungspositionstext'), tms_rech_pos_leist_typ_cd OPTIONS(description='Leistungsart'),
tms_rech_pos_leist_typ_bez OPTIONS(description='Bezeichnung zur Leistungsart'), menge_effektiv
OPTIONS(description='Effektive Menge'), menge_frachtpflichtig OPTIONS(description='Frachtpflichtige Menge'), tms_tour_id
OPTIONS(description='Tournummer'), dat_tour OPTIONS(description='Tourdatum'), bewertungseinheit_id
OPTIONS(description='Eine abstrakte ID, um alles zusammenzufassen, was bewertet wird (entspricht i.d.R. einer Tour, ist aber nicht die Tournummer). Einheit bezieht sich hier auf die Einheit, die bewertet wird, z. B. eine Tour (evtl. kann Wanko auch mehrere Touren zusammenfassen - de facto ist es aber eine 1:1-Beziehung).'),
reklamation_fg OPTIONS(description='Kennzeichen: Reklamation'), bearbeitet_fg
OPTIONS(description='Kennzeichen: Wurde Bearbeitet'), reklamation_txt OPTIONS(description='Text zur Reklamation'),
tms_rech_pos_referenz_lfd_nr
OPTIONS(description='Laufende Nummer der ursprünglichen Rechnungsposition, auf die sich diese (meistens als Reklamation oder Ablehnung einer Reklamation erfasste) Position bezieht. Bezieht sich immer auf eine Position innerhalb derselben Rechnung.'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT DIE DETAILLIERTE INFORMATIONEN ZU EINZELNEN RECHNUNGSPOSITIONEN, EINSCHLIESSLICH TMS-TOURBEZEICHNUNG, MENGE, PREIS UND MEHRWERTSTEUERSATZ. AUS DER QUELLE PLRPOS (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_rech_beleg_id,
 tms_rech_beleg_pos_id,
 tms_rech_pos_lfd_nr,
 dat_tms_rech_beleg,
 preis_einzel,
 betrag_vor_rabattabzug,
 betrag_netto,
 mwst,
 tms_konto_id,
 bewertungseinheit_cd,
 tms_rech_org_pos_id,
 tms_rech_pos_txt,
 tms_rech_pos_leist_typ_cd,
 tms_rech_pos_leist_typ_bez,
 menge_effektiv,
 menge_frachtpflichtig,
 tms_tour_id,
 dat_tour,
 bewertungseinheit_id,
 reklamation_fg,
 bearbeitet_fg,
 reklamation_txt,
 tms_rech_pos_referenz_lfd_nr
FROM kfl_production_dbp_data.tms_rechnung_det;