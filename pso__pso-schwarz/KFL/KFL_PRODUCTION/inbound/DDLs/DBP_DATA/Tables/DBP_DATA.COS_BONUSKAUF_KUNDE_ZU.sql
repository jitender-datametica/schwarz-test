--==============================================================
-- Table: cos_bonuskauf_kunde_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_kunde_zu
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 16:46:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSKAUF_KUNDE_ZU (
   bonuskauf_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   crm_kunde_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM Kundenkarte-ID.',
   kauf_id                             VARCHAR(144)     NOT NULL DEFAULT '-1' COMMENT 'ID des kaufbaren Coupons (kaufbare Coupons).',
   anz_einloesung                      NUMBER(38,0)     NOT NULL COMMENT 'Anzahl wie oft eingelöst.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   dat_kauf_rueckgabe                  TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit wann Coupon zurückgegeben wurde (kaufbare Coupons).',
   dat_kauf                            TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit wann Coupon gekauft wurde (kaufbare Coupons).',
   kauf_status_nr                      NUMBER(38,0)     COMMENT 'Status des kaufbaren Coupons (kaufbare Coupons).',
   anz_kaufbar                         NUMBER(38,0)     COMMENT 'Anzahl kaufbare Coupons (kaufbare Coupons).',
   dat_kauf_einloesung                 TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit der Einlösung (kaufbare Coupons).',
   status_aktiv_nr                     NUMBER(38,0)     COMMENT 'Aktivierungsstatus in der App: 1 = aktiv; 2 = nicht aktiviert.',
   datzeit_status_aktivierung          TIMESTAMP_LTZ(9) COMMENT 'Enthält Aktivierungsdatum und -zeit des Coupons.',
   status_einloesung                   NUMBER(38,0)     COMMENT 'Einlösestatus: 0 = noch nicht eingelöst; 1 = teilweise eingelöst; 2 = eingelöst.',
   dat_status_einloesung               TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit der Einlösung.',
   kontrollgruppe                      NUMBER(38,0)     COMMENT 'Kontrollgruppe Reco.',
   kampagnen_id                        VARCHAR(20)      COMMENT 'Campaign ID.',
   checkout_fg                         NUMBER(38,0)     COMMENT 'Flag: Handelt es sich um einen Checkout Coupon Coupon.',
   anz_kauf_ist                        NUMBER(38,0)     COMMENT 'Häufigkeit bisheriger Einkäufe.',
   anz_kauf_soll                       NUMBER(38,0)     COMMENT 'Häufigkeit noch offener Einkäufe.',
   sum_kauf_ist                        NUMBER(18,4)     COMMENT 'Bisherige Summe der Einkäufe.',
   sum_kauf_soll                       NUMBER(18,4)     COMMENT 'Noch offene Summe.',
   dat_update                          TIMESTAMP_LTZ(9) COMMENT 'Update Datum und Zeit dieser Tabelle.',
   kampagnen_version                   NUMBER(38,0)     COMMENT 'Kampagnenversion.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSKAUF_KUNDE_ZU PRIMARY KEY (mandant_id, bonuskauf_id, crm_kunde_id, kauf_id, anz_einloesung) NOT ENFORCED
)  COMMENT = 'Customer Coupon Assignments - Redemption Count-Size of Control Group Reco.';
