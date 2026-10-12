--==============================================================
-- Table: l_kampagne_rhythmus_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_kampagne_rhythmus_typ_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_KAMPAGNE_RHYTHMUS_TYP_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   kampagne_rhythmus_typ_id            INTEGER     NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_2, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_KAMPAGNE_RHYTHMUS_TYP PRIMARY KEY (mandant_id, kampagne_rhythmus_typ_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle dient zur Kategorisierung und Klassifizierung verschiedener Arten von Rhythmen, die den Start einer Kampagne_2 auslösen können.';
