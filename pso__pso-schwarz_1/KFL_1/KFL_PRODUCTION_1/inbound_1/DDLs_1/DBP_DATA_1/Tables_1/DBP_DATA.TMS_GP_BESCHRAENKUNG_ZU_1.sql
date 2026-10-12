--==============================================================
-- Table: tms_gp_beschraenkung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_gp_beschraenkung_zu_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_GP_BESCHRAENKUNG_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_gp_id                           VARCHAR(30)      NOT NULL COMMENT 'ID des Geschäftspartners (Kundennummer). Aus plkd.nr',
   tms_gp_typ_cd                       VARCHAR(3)       NOT NULL COMMENT 'Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)',
   tms_beschraenkung_id                NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …',
   tms_beschraenkung_pos_nr            NUMBER(38,0)     COMMENT 'Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. bes1 = 1, bes2 = 2, …',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_GP_BESCHRAENKUNG_ZU PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd, tms_beschraenkung_id) NOT ENFORCED
)  COMMENT = 'TMS - Zuordnungstabelle für Geschäftspartner mit Einschränkungen, um die für den Geschäftspartner geltenden Einschränkungen zu definieren. Aus der Quelle plkd (WANKO)';
