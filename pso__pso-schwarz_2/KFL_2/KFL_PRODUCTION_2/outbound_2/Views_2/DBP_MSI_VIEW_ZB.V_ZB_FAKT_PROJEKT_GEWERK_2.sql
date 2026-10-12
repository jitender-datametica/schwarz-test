CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_fakt_projekt_gewerk_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'), wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_kostenprognose
OPTIONS(description='Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.'), betrag_zek
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zek_manually
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (wird manuell im Dashboard eingetragen)'),
betrag_zea
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'),
betrag_aktuelles_budget OPTIONS(description='Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.'),
betrag_objektfreigabe_budget
OPTIONS(description='Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.'),
betrag_objektfreigabe_aktualisierung OPTIONS(description='Dummywert'), betrag_vertrag
OPTIONS(description='Betrag der Vertragswerte auf Ebene Projekt und Gewerk'), betrag_bestellung_netto
OPTIONS(description='Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk'), betrag_bestellung_nachtrag_netto
OPTIONS(description='Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk'), betrag_obligo
OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'), betrag_buchung
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'K\' in dbp_data.zb_projekt_ist_kosten_2)'),
betrag_aktuelle_hochrechnung OPTIONS(description='Aktuelle Hochrechnung'), abw_hochrechnung_budget, betrag_rueckstellung
OPTIONS(description='Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'R\' in dbp_data.zb_projekt_ist_kosten_2)'),
anmerkung_txt OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.'), td_update
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')) AS
WITH CTI AS (SELECT G.mandant_id,
   G.projekt_nr,
   G.gewerk_id,
   G.wrg_typ_id,
   G.wrg_id,
   G.betrag_kostenprognose,
   G.betrag_zek,
   TS1.betrag_zek AS betrag_zek_manually,
   G.betrag_zea,
   G.betrag_aktuelles_budget,
   G.betrag_objektfreigabe_budget,
   0 AS betrag_objektfreigabe_aktualisierung,
   G.betrag_vertrag,
   G.betrag_bestellung_netto,
   G.betrag_bestellung_nachtrag_netto,
   G.betrag_obligo,
    CASE
    WHEN G.gewerk_id < 8
    THEN G.betrag_buchung
    WHEN G.gewerk_id = 8
    THEN G.betrag_baukostenzuschuss
    WHEN G.gewerk_id = 9
    THEN G.betrag_foerderung
    ELSE 0
    END AS betrag_buchung,
   G.betrag_rueckstellung,
   TS1.anmerkung_txt,
   G.td_insert,
   G.td_update
  FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_2 AS G
   LEFT JOIN kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_2 AS TS1 ON G.mandant_id = TS1.mandant_id AND G.projekt_nr =
        TS1.projekt_nr AND G.gewerk_id = TS1.gewerk_id AND G.wrg_typ_id = TS1.wrg_typ_id AND G.wrg_id = TS1.wrg_id
  WHERE G.td_insert = (SELECT MAX(td_insert)
     FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_2 AS T2)), CTI2 AS (SELECT mandant_id,
   projekt_nr,
   gewerk_id,
   wrg_typ_id,
   wrg_id,
   betrag_kostenprognose,
   betrag_zek,
   betrag_zek_manually,
    CASE
    WHEN COALESCE(betrag_aktuelles_budget, betrag_objektfreigabe_budget, betrag_objektfreigabe_aktualisierung) -
        betrag_buchung - betrag_obligo - betrag_zek_manually > 0
    THEN COALESCE(betrag_aktuelles_budget, betrag_objektfreigabe_budget, betrag_objektfreigabe_aktualisierung) -
       betrag_buchung - betrag_obligo - betrag_zek_manually
    ELSE 0
    END AS betrag_zea,
   betrag_aktuelles_budget,
   betrag_objektfreigabe_budget,
   betrag_objektfreigabe_aktualisierung,
   betrag_vertrag,
   betrag_bestellung_netto,
   betrag_bestellung_nachtrag_netto,
   betrag_obligo,
   betrag_buchung,
   betrag_rueckstellung,
   anmerkung_txt,
   td_insert,
   td_update
  FROM CTI), CTI21 AS (SELECT mandant_id,
   projekt_nr,
   gewerk_id,
   wrg_typ_id,
   wrg_id,
   betrag_kostenprognose,
   betrag_zek,
   betrag_zek_manually,
   betrag_zea,
   betrag_aktuelles_budget,
   betrag_objektfreigabe_budget,
   betrag_objektfreigabe_aktualisierung,
   betrag_vertrag,
   betrag_bestellung_netto,
   betrag_bestellung_nachtrag_netto,
   betrag_obligo,
   betrag_buchung,
      betrag_buchung + COALESCE(betrag_obligo, 0) + COALESCE(betrag_zek_manually, 0) + COALESCE(betrag_zea, 0) AS
   betrag_aktuelle_hochrechnung,
   betrag_rueckstellung,
   anmerkung_txt,
   td_insert,
   td_update
  FROM CTI2) (SELECT mandant_id,
   projekt_nr,
   gewerk_id,
   wrg_typ_id,
   wrg_id,
   betrag_kostenprognose,
   betrag_zek,
   betrag_zek_manually,
   betrag_zea,
   betrag_aktuelles_budget,
   betrag_objektfreigabe_budget,
   betrag_objektfreigabe_aktualisierung,
   betrag_vertrag,
   betrag_bestellung_netto,
   betrag_bestellung_nachtrag_netto,
   betrag_obligo,
   betrag_buchung,
   betrag_aktuelle_hochrechnung,
    CASE
    WHEN betrag_buchung > 0
    THEN (betrag_buchung - betrag_aktuelle_hochrechnung) * -1
    WHEN betrag_objektfreigabe_budget > 0
    THEN (betrag_objektfreigabe_budget - betrag_aktuelle_hochrechnung) * -1
    WHEN betrag_objektfreigabe_aktualisierung > 0
    THEN (betrag_objektfreigabe_aktualisierung - betrag_aktuelle_hochrechnung) * -1
    ELSE 0
    END AS abw_hochrechnung_budget,
   betrag_rueckstellung,
   anmerkung_txt,
   td_insert,
   td_update
  FROM CTI21);