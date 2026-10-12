CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_WG_SUM_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,arthiertyp_id                            COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'
  ,wg_id                                    COMMENT 'ID der Warengruppe'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 '
  ,dat                                      COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD'
  ,wup_id                                   COMMENT 'Nummer des Warenumschlagsplatzes'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'
  ,kjmo                                     COMMENT 'Kalenderjahremonat, Format JJJJMM'
  ,umsatz_brutto                            COMMENT 'Umsatz incl. Mehrwertsteuerbetrag
'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag
'
  ,umsatz_wrg                               COMMENT 'Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR'
  ,umsatz_brutto_konz                       COMMENT 'Umsatz brutto in der Konzernwährung'
  ,umsatz_netto_konz                        COMMENT 'Umsatz netto in der Konzernwährung'
  ,quelle                                   COMMENT ''
  ,menge                                    COMMENT 'ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.'
)
COMMENT = 'TP1 MIS - Aggregationstabelle artbew_1 auf Ebene Warengruppe/Markt/Datum - MULTISET'
 AS 
    SELECT 
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

FROM DBP_DATA.ARTBEW_WG_SUM_1 ;