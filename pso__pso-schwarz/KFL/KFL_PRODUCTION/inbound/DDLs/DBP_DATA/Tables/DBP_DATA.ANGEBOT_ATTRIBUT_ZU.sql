--==============================================================
-- Table: angebot_attribut_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_attribut_zu
   generated from Powerdesigner on Donnerstag, 27. Februar 2025 11:24:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_ATTRIBUT_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
   angebot_attribut_id                 NUMBER(38,0)     NOT NULL COMMENT 'ID des Attributs',
   angebot_attribut_txt                VARCHAR(500)     NOT NULL COMMENT 'Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_ATTRIBUT_ZU PRIMARY KEY (mandant_id, angebot_attribut_id, angebot_nr) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle zwischen einem Angebot und dem jeweils verknüpften Attribut um weitere Informationen dem Angebot hinzuzufügen.';
