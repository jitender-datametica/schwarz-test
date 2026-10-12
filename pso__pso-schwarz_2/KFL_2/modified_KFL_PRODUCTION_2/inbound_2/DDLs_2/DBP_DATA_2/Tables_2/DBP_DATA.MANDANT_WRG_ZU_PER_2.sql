--==============================================================
-- Table: mandant_wrg_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mandant_wrg_zu_per_2
   generated from Powerdesigner on Mittwoch, 28. September 2022 14:44:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MANDANT_WRG_ZU_PER_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH.',
   wrg_id                              VARCHAR(3)      NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR.',
   dat_von                             DATE            DEFAULT CAST('1900-01-01' AS DATE) NOT NULL COMMENT 'Beginn Gültigkeitsperiode.',
   dat_bis                             DATE            DEFAULT CAST('9999-12-31' AS DATE) NOT NULL COMMENT 'Ende Gültigkeitsperiode.',
   von_wrg_id                          VARCHAR(3)      COMMENT 'Währung, die vom Quellsystem kommt und für welche die on-the-fly Konvertierung stattfinden soll. Im Grunde die abgelöste Währung.
            Kurzbezeichnung der Währung, z.B. CZK, EUR.',
   umrechnungskurs                     NUMBER(29,5)    COMMENT 'Umrechnungskurs mit dem von Spalte von_wrg_id in wrg_id umgerechnet werden soll. In der Regel, der vom Land_2 offiziell verwendete Wechselkurs.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MANDANT_WRG_ZU_PER PRIMARY KEY (mandant_id, wrg_id, dat_von) NOT ENFORCED
)  COMMENT = 'AIS - Tabelle hat mehrere Zwecke:
             1. Historisierte Zuordnung von Währung zu Mandant. Wird herangezogen, sollte die Quelle zu währungsrelevanten Daten keine Währungsinformation liefern. (Das sollte eigentlich in der Tabelle mandant_2 passieren, aber die Umstellung ist zu aufwendig.)
             2. Bildet im Backend die Basis für eine_2 automatische Währungskonvertierung bei Währungswechsel eines Landes und speichert dafür den vom Land_2 offiziell angegebenen Wechselkurs.
             Nicht zu verwechseln mit der regulären Wechselkurstabelle kurs_2, in der auch die Konvertierung anders berechnet wird.';
