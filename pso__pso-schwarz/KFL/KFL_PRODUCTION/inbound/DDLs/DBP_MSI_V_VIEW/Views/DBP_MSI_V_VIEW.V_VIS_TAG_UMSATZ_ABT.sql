CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_VIS_TAG_UMSATZ_ABT (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,dat                                      COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,wup_id                                   COMMENT 'Nummer des Warenumschlagsplatzes'
  ,arthiertyp_id                            COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,abt_id                                   COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'
  ,kjmo                                     COMMENT 'Kalenderjahremonat, Format JJJJMM'
  ,kjwo                                     COMMENT 'Kalenderjahreswoche, Format JJJJWW'
  ,ums_netto                                COMMENT 'Umsatz netto'
  ,ums_netto_wvj                            COMMENT 'Umsatz netto Wochentag im Vorjahr'
  ,ums_netto_wvvj                           COMMENT 'Umsatz netto Wochentag im Vorvorjahr'
  ,ums_netto_kvj                            COMMENT 'Umsatz netto Kalendertag im Vorjahr'
  ,ums_netto_kvvj                           COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr'
)
COMMENT = 'VIS - Aggregat auf Tagesebene - MULTISET'
 AS 
    SELECT 
        mandant_id,
        dat,
        nb_id,
        wup_id,
        arthiertyp_id,
        wrg_id,
        abt_id,
        kjmo,
        kjwo,
        ums_netto,
        ums_netto_wvj,
        ums_netto_wvvj,
        ums_netto_kvj,
        ums_netto_kvvj
		
FROM DBP_MSI_DATA.VIS_TAG_UMSATZ_ABT ;