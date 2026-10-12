CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_SHELF_CAPACITY_FAM_STORE_DAY_2 COMMENT = 'Aggregated Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/artikel_2 familie'
(
  client_id                   COMMENT 'MIS Client ID'
, wh_id                       COMMENT 'Gesellschaft ID'
, aspect_id                   COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, move_to_store_id            COMMENT 'S-Key der Location_2, hier der Filiale'
, orig_store_nr               COMMENT 'Fachliche Store ID'
, dat_formdate                COMMENT 'Bezugsdatum'
, cy_week                     COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, cy_week_partial_week_id     COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                    COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear                     COMMENT 'Geschäftsjahr'
, currency_iso_cd             COMMENT '3 stelliger ISO-Währungs-Code'
, curr_tot_id                 COMMENT 'Interner Währungs-Code'
, item_familygroup_id         COMMENT 'Artikelfamilie ID'
, restantenquote_fil_pct      COMMENT 'Durchschnitt aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_2 restantenquote_fil'
, regelfuellmenge_0_cnt       COMMENT 'Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_2 regelfuellmenge_0_fg'
, skipped_cnt                 COMMENT 'Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_2 skipped_fg'
, dwh_updated                 COMMENT 'Technische Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an Aggregated Restantenquote data with the granularity of store/day/artikel_2 familie
#
#-----------------------------------------------------------------------------
# History:
#  1.0     18.01.2023      Michael Morris             Initial Version.
#
#-----------------------------------------------------------------------------
*/
SELECT DISTINCT  asm.client_id
       , asm.wh_id
       , asm.aspect_id
       , asm.move_to_store_id
       , asm.orig_store_nr
       , d.dat_formdate
       , d.cy_week
       , d.cy_week_partial_week_id
       , d.cy_month
       , d.busyear
       , d.currency_iso_cd
       , d.curr_tot_id
       , d.item_familygroup_id
       , d.restantenquote_fil_pct
       , d.regelfuellmenge_0_cnt
       , d.skipped_cnt
       , d.dwh_updated

  FROM P_LEW_MART_LEAD_AC.v_org_store_merge_2      AS asm

 INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_2 AS osm
    ON asm.client_id     = osm.client_id
   AND asm.store_id      = osm.move_to_store_id

 INNER JOIN P_LEW_MART_LEAD.t_agg_shelf_capacity_fam_store_day_2  AS d
    ON asm.client_id     = d.client_id
   AND osm.store_id      = d.loc_sid_store
;