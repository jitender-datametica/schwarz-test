CREATE OR REPLACE VIEW DBP_VIEW.V_BESCH_FAKTURA_MEDATA_1 (
   art_id                                   COMMENT 'Artikel_1 ID'
  ,mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,faktura_markt                            COMMENT 'bezieht sich auf den empfangenden wup_1'
  ,dat_faktura                              COMMENT 'Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt'
  ,wup_id                                   COMMENT 'in diesem Fall der beliefernde wup_1 - Medatalager'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,zwsum_3_betrag                           COMMENT 'Einkaufspreis netto  bzw. EK-Aktion_1 netto vermindert um die Reklapauschale.'
  ,menge_fakturiert                         COMMENT 'Fakturierte Menge in Verkaufseinheiten, Displays werden als 1 gerechnet'
  ,ek_netto_bnk                             COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'
  ,ek_mep                                   COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'
  ,logistikkostenzuschlag                   COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'
  ,betrag_ek_mep_vor_fwu                    COMMENT 'Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'
)
COMMENT = 'TP2 AIS - Fakturadaten aus Medata - Lägern (nicht in SAP)'
 AS 
    SELECT 
        art_id,
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

FROM DBP_DATA.BESCH_FAKTURA_MEDATA_1 ;