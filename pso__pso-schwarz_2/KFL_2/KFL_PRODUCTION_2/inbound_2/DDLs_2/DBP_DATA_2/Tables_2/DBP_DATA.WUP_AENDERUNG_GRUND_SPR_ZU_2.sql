--==============================================================
-- Table: wup_aenderung_grund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_aenderung_grund_spr_zu_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 11:46:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_AENDERUNG_GRUND_SPR_ZU_2 (
   wup_aenderung_grund_id              NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Code fuer den Grund der WUP_2 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_2 ID.
            Moegliche Auspraegungen:
            0 = keine Aenderung
            1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)
            2 = Umzug (seit Einfuehrung der Filialumgliederungen)
            3 = Umgliederung
            4 = Abriss / Neubau',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   wup_aenderung_grund_bez             VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung des Änderungsgrundes der WUP_2 ID in jeweiliger Sprache.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_AENDERUNG_GRUND_SPR_ZU PRIMARY KEY (wup_aenderung_grund_id, spr_id) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle zwischen den Änderungsgrunde der WUP_2 ID und der Sprache. Beinhaltet von der Sprache abhängige Bezeichnungen der Gründe.';