--==============================================================
-- Table: ims_invest_plan_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_invest_plan_det_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_INVEST_PLAN_DET_1 (
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr, auf das die Kosten geplant werden, Format JJJJ
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   hr_plan_gesamt_kz                   INTEGER     NOT NULL COMMENT 'Kennzeichen für eine_1 Hochrechnung (=1) oder Plan (=0) oder Gesamtplan (=2) oder Ursprung Gesamt Maßnahmen Plan (=3)',
   excel_zeile                         INTEGER     NOT NULL COMMENT 'Nummer der Zeile aus dem zugrunde liegenden Excel-Sheet zur eindeutigen Identifizierung',
   berichts_pos_invest_grp_id          INTEGER     NOT NULL COMMENT 'Die Berichtsposition- Gruppierung  wird direkt im DWH gepflegt ',
   in_massnahme_typ_id                 VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eins Massnahmetyps',
   plan_betrag                         NUMBER(29,4)     COMMENT 'geplanter Betrag',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   sparte_id                           INTEGER     COMMENT 'ID der Sparte',
   psp_id                              INTEGER     COMMENT 'eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_INVEST_PLAN_DET PRIMARY KEY (mandant_id, hr_plan_gesamt_kz, excel_zeile, gj) NOT ENFORCED
)  COMMENT = 'IMS - Detailtabelle der Planung - wird aus Excel geladen';
