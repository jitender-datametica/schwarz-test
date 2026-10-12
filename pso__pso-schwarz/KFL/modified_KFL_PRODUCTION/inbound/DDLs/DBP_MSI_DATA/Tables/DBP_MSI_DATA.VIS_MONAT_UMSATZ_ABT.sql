--==============================================================
-- Table: vis_monat_umsatz_abt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_umsatz_abt
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:02:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_MONAT_UMSATZ_ABT (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr',
   akt_gj                              INTEGER     NOT NULL COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres',
   akt_mo                              INTEGER     NOT NULL COMMENT 'Zahlenfolge, die den Abstand eines Monats zum laufenden Monat darstellt. Der aktuelle Monat hat den Wert 0, der vorige Monat -1 und der nächste Monat den Wert 1',
   mo_kj                               INTEGER     NOT NULL COMMENT 'Laufender Monat im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12',
   ums_netto                           NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_kvj                       NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_kvvj                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   ums_netto_plan                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Planwert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_MONAT_UMSATZ_ABT PRIMARY KEY (mandant_id, wup_id, nb_id, wrg_id, kjmo, abt_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Monatsebene - MULTISET';
