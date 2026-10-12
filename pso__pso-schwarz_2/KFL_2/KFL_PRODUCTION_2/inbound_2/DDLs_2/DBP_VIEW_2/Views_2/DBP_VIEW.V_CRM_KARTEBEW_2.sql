CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_KARTEBEW_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,wup_id                                   COMMENT 'Mutter Wup_2 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
  ,kundenkarte_id                           COMMENT 'Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_2-TT.'
  ,loyalty_berechtigt_fg                    COMMENT 'Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_2 berechnet. (Logik für alte Daten folgt)'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,umsatz_netto_sa                          COMMENT 'SA Umsatz vermindert um den Mehrwertsteuerbetrag.'
  ,umsatz_netto_af                          COMMENT 'AF Umsatz vermindert um den Mehrwertsteuerbetrag.'
  ,umsatz_brutto_sa                         COMMENT 'SA Umsatz.'
  ,umsatz_brutto_af                         COMMENT 'AF Umsatz.'
  ,anz_bons                                 COMMENT 'Bons, die eine_2 Kundenkarte generiert.'
)
COMMENT = 'EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag_2 - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).'
 AS 
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

FROM DBP_DATA.CRM_KARTEBEW_2 ;