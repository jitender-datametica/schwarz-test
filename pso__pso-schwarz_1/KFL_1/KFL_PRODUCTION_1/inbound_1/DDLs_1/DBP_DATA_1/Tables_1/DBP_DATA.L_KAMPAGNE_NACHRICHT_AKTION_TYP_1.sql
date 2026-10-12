--==============================================================
-- Table: l_kampagne_nachricht_aktion_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_kampagne_nachricht_aktion_typ_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_KAMPAGNE_NACHRICHT_AKTION_TYP_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   nachricht_aktion_typ_id             NUMBER(38,0)     NOT NULL COMMENT 'ID, die die Art_1 der ausgeführten Aktion_1 angibt, z. B. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked, etc..',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_KAMPAGNE_NACHRICHT_AKTION_TYP PRIMARY KEY (mandant_id, nachricht_aktion_typ_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die Referenzinformationen zu den verschiedenen Aktionstypen, die im Zusammenhang mit einer versendeten Nachricht auftreten können, z. B. Gesendet, Blockiert, Zugestellt, Geöffnet, usw.';
