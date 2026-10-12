--==============================================================
-- Table: ims_invest_plan_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_invest_plan_det_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_INVEST_PLAN_DET_2 (
   gj                                  NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahr, auf das die Kosten geplant werden, Format JJJJ
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   hr_plan_gesamt_kz                   NUMBER(38,0)     NOT NULL COMMENT 'Kennzeichen für eine_2 Hochrechnung (=1) oder Plan (=0) oder Gesamtplan (=2) oder Ursprung Gesamt Maßnahmen Plan (=3)',
   excel_zeile                         NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Zeile aus dem zugrunde liegenden Excel-Sheet zur eindeutigen Identifizierung',
   berichts_pos_invest_grp_id          NUMBER(38,0)     NOT NULL COMMENT 'Die Berichtsposition- Gruppierung  wird direkt im DWH gepflegt ',
   in_massnahme_typ_id                 VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eins Massnahmetyps',
   plan_betrag                         NUMBER(18,4)     COMMENT 'geplanter Betrag',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   sparte_id                           NUMBER(38,0)     COMMENT 'ID der Sparte',
   psp_id                              NUMBER(38,0)     COMMENT 'eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_INVEST_PLAN_DET PRIMARY KEY (mandant_id, hr_plan_gesamt_kz, excel_zeile, gj) NOT ENFORCED
)  COMMENT = 'IMS - Detailtabelle der Planung - wird aus Excel geladen';
