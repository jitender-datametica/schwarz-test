create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_ZB.V_ZB_FAKT_PROJEKT_GEWERK_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KOSTENPROGNOSE COMMENT 'Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.',
	BETRAG_ZEK COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEK_MANUALLY COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (wird manuell im Dashboard eingetragen)',
	BETRAG_ZEA COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)',
	BETRAG_AKTUELLES_BUDGET COMMENT 'Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.',
	BETRAG_OBJEKTFREIGABE_BUDGET COMMENT 'Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.',
	BETRAG_OBJEKTFREIGABE_AKTUALISIERUNG COMMENT 'Dummywert',
	BETRAG_VERTRAG COMMENT 'Betrag der Vertragswerte auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NETTO COMMENT 'Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NACHTRAG_NETTO COMMENT 'Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''K'' in dbp_data.zb_projekt_ist_kosten_1)',
	BETRAG_AKTUELLE_HOCHRECHNUNG COMMENT 'Aktuelle Hochrechnung',
	ABW_HOCHRECHNUNG_BUDGET,
	BETRAG_RUECKSTELLUNG COMMENT 'Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''R'' in dbp_data.zb_projekt_ist_kosten_1)',
	ANMERKUNG_TXT COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.',
	TD_UPDATE COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
) as 
    WITH cti AS (
    SELECT 
        g.mandant_id,
        g.projekt_nr,
        g.gewerk_id,
        g.wrg_typ_id,
        g.wrg_id,
        g.betrag_kostenprognose,
        g.betrag_zek AS betrag_zek,
        ts1.betrag_zek AS betrag_zek_manually,
        g.betrag_zea,
        g.betrag_aktuelles_budget,
        g.betrag_objektfreigabe_budget,
        0 AS betrag_objektfreigabe_aktualisierung,
        g.betrag_vertrag,
        g.betrag_bestellung_netto,
        g.betrag_bestellung_nachtrag_netto,
        g.betrag_obligo,
    
        
        CASE 
            WHEN g.gewerk_id < 8 THEN g.betrag_buchung 
            WHEN g.gewerk_id = 8 THEN g.betrag_baukostenzuschuss 
            WHEN g.gewerk_id = 9 THEN g.betrag_foerderung 
            ELSE 0 
        END AS betrag_buchung,
        g.betrag_rueckstellung,
       ts1.anmerkung_txt,
        g.td_insert,
        g.td_update
    FROM DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_1 g 
    LEFT JOIN DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_1 ts1 
        ON g.mandant_id = ts1.mandant_id 
        AND g.projekt_nr = ts1.projekt_nr 
        AND g.gewerk_id = ts1.gewerk_id       
        AND g.wrg_typ_id = ts1.wrg_typ_id
        AND g.wrg_id = ts1.wrg_id
    WHERE
        g.td_insert = (
            SELECT MAX(t2.td_insert)
            FROM DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_1 
            AS t2
        )
),
cti2 AS (
    
    SELECT 
          mandant_id,
          projekt_nr,
          gewerk_id,
          wrg_typ_id,
          wrg_id,
          betrag_kostenprognose,
          betrag_zek,
          betrag_zek_manually,
          CASE WHEN (Coalesce(betrag_aktuelles_budget, betrag_objektfreigabe_budget, betrag_objektfreigabe_aktualisierung, 0) - betrag_buchung - betrag_obligo - betrag_zek_manually) > 0
          THEN (Coalesce(betrag_aktuelles_budget, betrag_objektfreigabe_budget ,betrag_objektfreigabe_aktualisierung, 0) - betrag_buchung - betrag_obligo - betrag_zek_manually)
          ELSE 0 END AS betrag_zea, 
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
    FROM cti
),
cti21 AS (
    SELECT 
           mandant_id,
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
           (betrag_buchung + COALESCE(betrag_obligo,0) + COALESCE(betrag_zek_manually, 0) + COALESCE(betrag_zea,0)) AS betrag_aktuelle_hochrechnung,
           betrag_rueckstellung,
           anmerkung_txt,
           td_insert,
           td_update
    FROM cti2
)

SELECT 
     mandant_id,
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
        THEN (betrag_buchung - betrag_aktuelle_hochrechnung)*(-1)
        WHEN betrag_objektfreigabe_budget > 0
        THEN (betrag_objektfreigabe_budget - betrag_aktuelle_hochrechnung)*(-1)
        WHEN betrag_objektfreigabe_aktualisierung > 0
        THEN (betrag_objektfreigabe_aktualisierung - betrag_aktuelle_hochrechnung)*(-1)
        ELSE 0
    END AS abw_hochrechnung_budget,   
         betrag_rueckstellung,
         anmerkung_txt,
         td_insert,
         td_update
FROM cti21;
