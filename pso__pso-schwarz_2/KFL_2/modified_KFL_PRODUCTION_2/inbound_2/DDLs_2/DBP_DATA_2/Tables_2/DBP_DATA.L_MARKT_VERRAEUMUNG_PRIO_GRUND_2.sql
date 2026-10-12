--==============================================================
-- Table: l_markt_verraeumung_prio_grund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markt_verraeumung_prio_grund_2
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_MARKT_VERRAEUMUNG_PRIO_GRUND_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   verraeumung_prio_grund_id           VARCHAR(2)       NOT NULL COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_MARKT_VERRAEUMUNG_PRIO_GRUND PRIMARY KEY (mandant_id, verraeumung_prio_grund_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Verräumungs-Prioritätsgründe in der Filiale. Diese Tabelle listet die verschiedenen Gründe auf, die einen Artikel_2 im Lager als "kritisch" für die Verräumung auf die Verkaufsfläche einstufen.
             z.B. das Erreichen eines Nullbestands im Regal. Quelle: ZRS_LGBPRF_CUST (SAP)';
