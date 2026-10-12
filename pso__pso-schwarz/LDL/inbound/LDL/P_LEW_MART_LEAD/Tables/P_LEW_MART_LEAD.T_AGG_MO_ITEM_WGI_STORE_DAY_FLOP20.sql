/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_MO_ITEM_WGI_STORE_DAY_FLOP20 CLUSTER BY (client_id, dat_formdate) COMMENT = 'Aggregierte Abschriften - Schlüssel: client_id/store_id/dat_formdate'
(
  client_id                    NUMBER(38,0)   NOT NULL         COMMENT 'MIS Client ID'
, loc_sid_store                NUMBER(38,0)   NOT NULL         COMMENT 'S-Key der Location, hier der Filiale'
, dat_formdate                 DATE           NOT NULL         COMMENT 'Bezugsdatum'
, cy_week                      NUMBER(38,0)   NOT NULL         COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJWW"'
, cy_week_partial_week_id      NUMBER(38,0)   NOT NULL         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                     NUMBER(38,0)   NOT NULL         COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'
, busyear                      NUMBER(38,0)   NOT NULL         COMMENT 'Geschäftsjahr'
, currency_iso_cd              VARCHAR(3)     COLLATE 'en-ci'  COMMENT '3 stelliger ISO-Währungs-Code'
, orig_item_nr                 NUMBER(38,0)   NOT NULL         COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
, sales_net_val_day            DECIMAL(38,5)                   COMMENT 'Umsatz Tagesebene'
, sales_net_val_pw             DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene'
, sales_net_val_mth            DECIMAL(38,5)                   COMMENT 'Umsatz Monatsebene'
, sales_net_val_day_py         DECIMAL(38,5)                   COMMENT 'Umsatz Tagesebene VJ'
, sales_net_val_pw_py          DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene VJ'
, sales_net_val_mth_py         DECIMAL(38,5)                   COMMENT 'Umsatz Monatsebene VJ'
, sales_net_val_mth_cum        DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene Monat aufgel. (für Berechnung Umsatz Monat aufgel.)'
, sales_net_val_by_cum         DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene GJ aufgel. (für Berechnung Umsatz GJ aufgel.)'
, sales_net_val_mth_cum_py     DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene Monat VJ aufgel. (für Berechnung Umsatz Monat VJ aufgel.)'
, sales_net_val_by_cum_py      DECIMAL(38,5)                   COMMENT 'Umsatz Teilwochenebene GJ VJ aufgel. (für Berechnung Umsatz GJ VJ aufgel.)'
, itemgroup_int_id             NUMBER(38,0)   NOT NULL         COMMENT 'Warengruppe ID'
, val_rtl_net_sfo_store_day    DECIMAL(38,5)                   COMMENT 'Tagessumme der Abschriften in Landeswährung'
, val_rtl_net_sfo_store_pw     DECIMAL(38,5)                   COMMENT 'Teilwochensumme der Abschriften in Landeswährung'
, val_rtl_net_sfo_store_mth    DECIMAL(38,5)                   COMMENT 'Monatssumme der Abschriften in Landeswährung'
, val_rtl_net_sfo_store_day_py DECIMAL(38,5)                   COMMENT 'Tagessumme der Abschriften in Landeswährung VJ'
, val_rtl_net_sfo_store_wk_py  DECIMAL(38,5)                   COMMENT 'Teilwochensumme der Abschriften in Landeswährung VJ'
, val_rtl_net_sfo_store_mth_py DECIMAL(38,5)                   COMMENT 'Monatssumme der Abschriften in Landeswährung VJ'
, val_rtl_net_sfo_store_mth_cum     DECIMAL(38,5)              COMMENT 'Abschriften Teilwochenebene Monat aufgel. (für Berechnung Abschriften Monat aufgel.)'
, val_rtl_net_sfo_store_by_cum      DECIMAL(38,5)              COMMENT 'Abschriften Teilwochenebene GJ aufgel. (für Berechnung Abschriften GJ aufgel.)'
, val_rtl_net_sfo_store_mth_cum_py  DECIMAL(38,5)              COMMENT 'Abschriften Teilwochenebene Monat VJ aufgel. (für Berechnung Abschriften Monat VJ aufgel.)'
, val_rtl_net_sfo_store_by_cum_py   DECIMAL(38,5)              COMMENT 'Abschriften Teilwochenebene GJ VJ aufgel. (für Berechnung Abschriften GJ VJ aufgel.)'
, val_rtl_net_sfo_qty_day      DECIMAL(38,5)                   COMMENT 'Tagessumme der Abschriften in Stk/kg'
, val_rtl_net_sfo_qty_pw       DECIMAL(38,5)                   COMMENT 'Wochensumme der Abschriften in Stk/kg'
, val_rtl_net_sfo_qty_mth      DECIMAL(38,5)                   COMMENT 'Monatssumme der Abschriften in Stk/kg'
, val_rtl_net_sfo_qty_mth_cum  DECIMAL(38,5)                   COMMENT 'Monat aufgelaufen der Abschriften in Stk/kg Teilwochenebene'
, val_rtl_net_sfo_pct_day      DECIMAL(38,5)                   COMMENT 'Tagessumme der Abschriften in %'
, val_rtl_net_sfo_pct_pw       DECIMAL(38,5)                   COMMENT 'Teilwochensumme der Abschriften in %'
, val_rtl_net_sfo_pct_mth      DECIMAL(38,5)                   COMMENT 'Monatssumme der Abschriften in %'
, dwh_valid_from               DATE          NOT NULL          COMMENT 'Startdatum der Validität für Artikel'
, dwh_valid_to                 DATE          NOT NULL          COMMENT 'Enddatum der Validität für Artikel'
, dwh_updated                  TIMESTAMP                       COMMENT 'Technischer Zeitstempel'
)
;