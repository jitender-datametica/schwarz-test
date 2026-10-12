--==============================================================
-- Table: l_hydra_lohnart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_lohnart_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:16:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_HYDRA_LOHNART_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   lohnart_id                          VARCHAR(4)       NOT NULL COMMENT 'Lohnart/Wage Type  (H100, H200 oder H300)',
   lohnart_bez                         VARCHAR(30)      COMMENT 'Bezeichnung der Lohnart (description of the wage type)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_HYDRA_LOHNART PRIMARY KEY (mandant_id, lohnart_id) NOT ENFORCED
)  COMMENT = 'Code and translations for Wage Type(regular salary/base wage, personal bonus, group bonus). Source system is different from the source system that provides data for L_LOHNART_1 and different teams use and manage the two systems independently. So same code might have different meaning in the two systems - this is why we create this "hydra_" trable
             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table';
