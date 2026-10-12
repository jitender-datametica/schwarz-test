--==============================================================
-- Table: kostenstelle_lohnart_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kostenstelle_lohnart_zu_per_1
   generated from Powerdesigner on Mittwoch, 22. März 2023 15:49:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KOSTENSTELLE_LOHNART_ZU_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus ZHR_00_DWH_PSU / KOSTL',
   lohnart_id                          VARCHAR(5)       NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART',
   zeitart_id                          VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'ID der Zeitart, Quelltabelle/feld: ZHR_00_DWH_PSU / ZTART',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahresmonat, Format YYYYMM',
   kostenstelle_von_id                 VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTVON',
   kostenstelle_nach_id                VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Nach - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTAN',
   abrechnung_fuer_periode             NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / FPPER',
   abrechnungstyp_fuer_periode         VARCHAR(5)       NOT NULL DEFAULT '-1' COMMENT 'Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PSU / ABRTYP',
   zahlung_dat                         DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PSU / BONDT',
   krk_id                              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Globale ID des Kostenrechnungskreises',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   abrechnung_in_periode               NUMBER(38,0)     DEFAULT -1 COMMENT 'Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / INPER',
   anzahl_lohnart                      NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Anzahl bezahlte Stunden_1 resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL',
   betrag_lohnart                      NUMBER(18,2)     DEFAULT 0 COMMENT 'Lohnkosten in Landeswährung je Lohnart für Überstundenzuschläge, Quelltabelle/feld: ZHR_00_DWH_PSU / BETRAG',
   system_id                           NUMBER(38,0)     COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KOSTENSTELLE_LOHNART_ZU_PER PRIMARY KEY (mandant_id, kostenstelle_id, lohnart_id, zeitart_id, kjmo, kostenstelle_von_id, kostenstelle_nach_id, zahlung_dat, abrechnungstyp_fuer_periode, abrechnung_fuer_periode) NOT ENFORCED
)  COMMENT = 'SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Kostenstellenebene - 1. Quelle in SAP HCM: ZHR_00_DWH_PSU - Direktanbindung über AbInitio;  2. Quelle manueller Sharepointupload';
