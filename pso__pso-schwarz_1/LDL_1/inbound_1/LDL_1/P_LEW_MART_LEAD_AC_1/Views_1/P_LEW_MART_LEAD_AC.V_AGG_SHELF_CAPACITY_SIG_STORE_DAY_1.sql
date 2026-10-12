CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_SHELF_CAPACITY_SIG_STORE_DAY_1 COMMENT = 'Aggregated Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/sig'
(
  client_id                   COMMENT 'MIS Client ID'
, wh_id                       COMMENT 'Gesellschaft ID'
, aspect_id                   COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, move_to_store_id            COMMENT 'S-Key der Location_1, hier der Filiale'
, orig_store_nr               COMMENT 'Fachliche Store ID'
, dat_formdate                COMMENT 'Bezugsdatum'
, cy_week                     COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, cy_week_partial_week_id     COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                    COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                     COMMENT 'Geschäftsjahr'
, currency_iso_cd             COMMENT '3 stelliger ISO-Währungs-Code'
, curr_tot_id                 COMMENT 'Interner Währungs-Code'
, subitemgroup_id             COMMENT 'Unterwarengruppe ID'
, restantenquote_fil_pct      COMMENT 'Durchschnitt aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 restantenquote_fil'
, regelfuellmenge_0_cnt       COMMENT 'Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 regelfuellmenge_0_fg'
, skipped_cnt                 COMMENT 'Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 skipped_fg'
, dwh_updated                 COMMENT 'Technische Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an Aggregated Restantenquote data with the granularity of store/day/sig
#
#-----------------------------------------------------------------------------
# History:
#  1.0     18.01.2023      Michael Morris             Initial Version.
#
#-----------------------------------------------------------------------------
*/
SELECT   client_id
       , wh_id
       , aspect_id
       , move_to_store_id
       , orig_store_nr
       , dat_formdate
       , cy_week
       , cy_week_partial_week_id
       , cy_month
       , busyear
       , currency_iso_cd
       , curr_tot_id
       , subitemgroup_id
       , restantenquote_fil_pct
       , regelfuellmenge_0_cnt
       , skipped_cnt
       , dwh_updated
  FROM P_LEW_MART_LEAD.v_agg_shelf_capacity_sig_store_day_1
;