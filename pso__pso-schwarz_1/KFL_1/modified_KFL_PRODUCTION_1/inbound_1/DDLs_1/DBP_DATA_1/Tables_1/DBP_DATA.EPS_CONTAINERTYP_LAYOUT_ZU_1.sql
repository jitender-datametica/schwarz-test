--==============================================================
-- Table: eps_containertyp_layout_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_layout_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_CONTAINERTYP_LAYOUT_ZU_1 (
   mandant_id                          INTEGER     NOT NULL,
   containertyp_id                     INTEGER     NOT NULL COMMENT 'ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   layout_kz                           INTEGER     COMMENT 'Kennzeichen des Layouts (Etikett, Plakat)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_CONTAINERTYP_LAYOUT_ZU PRIMARY KEY (mandant_id, containertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Lookuptabelle für die Bezeichnung der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung';

