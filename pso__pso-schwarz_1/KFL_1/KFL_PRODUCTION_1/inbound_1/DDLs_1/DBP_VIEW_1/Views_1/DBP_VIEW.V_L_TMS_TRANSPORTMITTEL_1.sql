CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_TRANSPORTMITTEL_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_transportmittel_id                   COMMENT 'ID des Transportmittels (KEY0 / Werte: 0-50)'
  ,tms_transportmittel_lfd_nr               COMMENT 'ID des Transportmittels im Quellsystem.'
  ,art_id                                   COMMENT 'Artikel_1-ID  des Transportmittels einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'
  ,tms_transportmittel_name                 COMMENT 'Name des Transportmittels'
  ,tms_transportmittel_bez                  COMMENT 'Kurzbezeichnung des Transportmittels'
)
COMMENT = 'TMS - Lookuptabelle für die Transportmittel'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_transportmittel_id,
        tms_transportmittel_lfd_nr,
        art_id,
        tms_transportmittel_name,
        tms_transportmittel_bez

FROM DBP_DATA.L_TMS_TRANSPORTMITTEL_1 ;