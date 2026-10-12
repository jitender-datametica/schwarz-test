--==============================================================
-- Table: l_rohstoff_gruppe_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_gruppe_typ_2
   generated from Powerdesigner on Donnerstag, 22. Mai 2025 09:53:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ROHSTOFF_GRUPPE_TYP_2 (
   rohstoff_gruppe_typ_id              INTEGER     NOT NULL COMMENT 'ID des Gruppierungstyps eines Rohstoffs.',
   rohstoff_gruppe_typ_bez             VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Gruppierungstyps eines Rohstoffs.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ROHSTOFF_GRUPPE_TYP PRIMARY KEY (rohstoff_gruppe_typ_id) NOT ENFORCED
)  COMMENT = 'Lookup Tabelle für Gruppierungstyp eines Rohstoffs - KFL Kategorie, KFL Subkategorie, MINTEC Kategorie, MINTEC Subkategorie';
