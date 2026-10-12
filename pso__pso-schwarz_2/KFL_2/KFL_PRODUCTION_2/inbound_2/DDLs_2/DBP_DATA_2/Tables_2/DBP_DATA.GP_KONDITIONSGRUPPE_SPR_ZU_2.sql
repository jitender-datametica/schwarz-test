--==============================================================
-- Table: gp_konditionsgruppe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_konditionsgruppe_spr_zu_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 20:58:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_KONDITIONSGRUPPE_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   konditionsgruppe_id                 VARCHAR(10)      NOT NULL COMMENT 'Eindeutiger Schlüssel der Konditionsgruppen(Konditionsgruppen: Sammelbecken in denen Artikel_2 Zusammengefasst sind, die in einer ähnlichen Art_2 und Weise eine_2 Preisreduktion erfahren)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   gp_konditionsgruppe_bez             VARCHAR(100)     COMMENT 'Semantische Beschreibung der Kombination (Konditionsgruppe_Lieferant ): ergibts sich aus der Kombination aus Lieferantennummer (gp_2) und Konditionsnummer(Konditiongruppe_id). Die Konditionsnummer kann mehreren Lieferantennummern zugeordnet werden, jedoch mit unterschiedlicher Bezeichnung ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_KONDITIONSGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, gp_id, konditionsgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'diese Tabelle liefert die Bezeichnung für die Kombination gp_2 und Konditionsgruppe in verschiedenen Sprachen ';
