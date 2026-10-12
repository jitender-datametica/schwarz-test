--==============================================================
-- Table: abschriftart_thema_int_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_thema_int_spr_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_THEMA_INT_SPR_ZU_1 (
   abschriftart_thema_int_id           INTEGER     NOT NULL COMMENT 'ID des Abschriftenart-Thema (z.B. 1=Totalabschriften VT; 2=Totalabschriften EK; 3=Preisänderungen; etc.)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   abschriftart_thema_int_bez          VARCHAR(30)      COLLATE 'en-ci' COMMENT 'ID des Abschriftenart-Thema (z.B. 1=Totalabschriften VT; 2=Totalabschriften EK; 3=Preisänderungen; etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_THEMA_INT_SPR_ZU PRIMARY KEY (abschriftart_thema_int_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprach-Tabelle für Einheitliche Abschriftenarten Thema  KL international';

