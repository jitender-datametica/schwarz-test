--==============================================================
-- Table: ma_kostenstelle_lohnart_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ma_kostenstelle_lohnart_zu_per_1
   generated from Powerdesigner on Mittwoch, 22. März 2023 15:54:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MA_KOSTENSTELLE_LOHNART_ZU_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTL',
   mitarbeiter_id                      VARCHAR(20)      NOT NULL COMMENT 'Eindeutige anonymisierte ID des Mitarbeiters',
   lohnart_id                          VARCHAR(5)       NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART',
   zeitart_id                          VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'ID der Zeitart; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ZTART ',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahresmonat, Format YYYYMM',
   kostenstelle_von_id                 VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTVON ',
   kostenstelle_nach_id                VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle An - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTAN ',
   abrechnung_fuer_periode             NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / FPPER ',
   abrechnungstyp_fuer_periode         VARCHAR(5)       NOT NULL DEFAULT '-1' COMMENT 'Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ABRTYP ',
   zahlung_dat                         DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / BONDT ',
   krk_id                              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Globale ID des Kostenrechnungskreises',
   abrechnung_in_periode               NUMBER(38,0)     DEFAULT -1 COMMENT 'Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / INPER ',
   anzahl_lohnart                      NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Anzahl bezahlte Stunden_1 resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL',
   system_id                           NUMBER(38,0)     COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MA_KOSTENSTELLE_LOHNART_ZU_PER PRIMARY KEY (mandant_id, kostenstelle_id, mitarbeiter_id, lohnart_id, zeitart_id, kjmo, kostenstelle_von_id, kostenstelle_nach_id, zahlung_dat, abrechnungstyp_fuer_periode, abrechnung_fuer_periode) NOT ENFORCED
)  COMMENT = 'SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Mitarbeiter / Kostenstellenebene - 1. Quelle SAP HCM: ZHR_00_DWH_PAY_V. Direktanbindung über AbInitio; 2. Quelle manueller Sharepointupload';
