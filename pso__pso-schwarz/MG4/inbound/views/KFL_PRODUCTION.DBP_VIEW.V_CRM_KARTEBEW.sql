create or replace view KFL_PRODUCTION.DBP_VIEW.V_CRM_KARTEBEW(
	MANDANT_ID COMMENT 'Mandant im DWH.',
	WUP_ID COMMENT 'Mutter Wup ID wird verwendet fur Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	KUNDENKARTE_ID COMMENT 'Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.',
	DAT COMMENT 'Datum im Format JJJJ-MM-TT.',
	LOYALTY_BERECHTIGT_FG COMMENT 'Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf berechnet. (Logik für alte Daten folgt)',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	UMSATZ_NETTO_SA COMMENT 'SA Umsatz vermindert um den Mehrwertsteuerbetrag.',
	UMSATZ_NETTO_AF COMMENT 'AF Umsatz vermindert um den Mehrwertsteuerbetrag.',
	UMSATZ_BRUTTO_SA COMMENT 'SA Umsatz.',
	UMSATZ_BRUTTO_AF COMMENT 'AF Umsatz.',
	ANZ_BONS COMMENT 'Bons, die eine Kundenkarte generiert.'
) as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        kundenkarte_id,
        dat,
        loyalty_berechtigt_fg,
        wrg_id,
        umsatz_netto_sa,
        umsatz_netto_af,
        umsatz_brutto_sa,
        umsatz_brutto_af,
        anz_bons

FROM DBP_DATA.CRM_KARTEBEW ;