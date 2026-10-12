--==============================================================
-- Table: cos_bonuskauf_kunde_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_kunde_zu_1
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 16:46:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSKAUF_KUNDE_ZU_1 (
   bonuskauf_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   crm_kunde_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM Kundenkarte-ID.',
   kauf_id                             VARCHAR(144)     NOT NULL DEFAULT '-1' COMMENT 'ID des kaufbaren Coupons (kaufbare Coupons).',
   anz_einloesung                      INTEGER     NOT NULL COMMENT 'Anzahl wie oft eingelöst.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   dat_kauf_rueckgabe                  TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit_1 wann Coupon zurückgegeben wurde (kaufbare Coupons).',
   dat_kauf                            TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit_1 wann Coupon gekauft wurde (kaufbare Coupons).',
   kauf_status_nr                      INTEGER     COMMENT 'Status_1 des kaufbaren Coupons (kaufbare Coupons).',
   anz_kaufbar                         INTEGER     COMMENT 'Anzahl kaufbare Coupons (kaufbare Coupons).',
   dat_kauf_einloesung                 TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit_1 der Einlösung (kaufbare Coupons).',
   status_aktiv_nr                     INTEGER     COMMENT 'Aktivierungsstatus in der App: 1 = aktiv; 2 = nicht aktiviert.',
   datzeit_status_aktivierung          TIMESTAMP_LTZ(9) COMMENT 'Enthält Aktivierungsdatum und -zeit_1 des Coupons.',
   status_einloesung                   INTEGER     COMMENT 'Einlösestatus: 0 = noch nicht eingelöst; 1 = teilweise eingelöst; 2 = eingelöst.',
   dat_status_einloesung               TIMESTAMP_LTZ(9) COMMENT 'Datum und Zeit_1 der Einlösung.',
   kontrollgruppe                      INTEGER     COMMENT 'Kontrollgruppe Reco.',
   kampagnen_id                        VARCHAR(20)      COMMENT 'Campaign ID.',
   checkout_fg                         INTEGER     COMMENT 'Flag: Handelt es sich um einen Checkout Coupon Coupon.',
   anz_kauf_ist                        INTEGER     COMMENT 'Häufigkeit bisheriger Einkäufe.',
   anz_kauf_soll                       INTEGER     COMMENT 'Häufigkeit noch offener Einkäufe.',
   sum_kauf_ist                        NUMBER(29,4)     COMMENT 'Bisherige Summe der Einkäufe.',
   sum_kauf_soll                       NUMBER(29,4)     COMMENT 'Noch offene Summe.',
   dat_update                          TIMESTAMP_LTZ(9) COMMENT 'Update Datum und Zeit_1 dieser Tabelle.',
   kampagnen_version                   INTEGER     COMMENT 'Kampagnenversion.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSKAUF_KUNDE_ZU PRIMARY KEY (mandant_id, bonuskauf_id, crm_kunde_id, kauf_id, anz_einloesung) NOT ENFORCED
)  COMMENT = 'Customer Coupon Assignments - Redemption Count-Size of Control Group Reco.';
