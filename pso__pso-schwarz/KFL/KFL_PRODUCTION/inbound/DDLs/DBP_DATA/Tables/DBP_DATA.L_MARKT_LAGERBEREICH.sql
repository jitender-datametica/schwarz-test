--==============================================================
-- Table: l_markt_lagerbereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markt_lagerbereich
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_MARKT_LAGERBEREICH (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   markt_lagerbereich_id               NUMBER(38,0)     NOT NULL COMMENT 'Lagerbereich ID in der Filiale.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_MARKT_LAGERBEREICH PRIMARY KEY (mandant_id, markt_lagerbereich_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Lagerbereichen in der Filiale. Wird manuell beladen. Z.B. 1=Nährmittel; 2=Konserven/Essig/Öl; usw.';
