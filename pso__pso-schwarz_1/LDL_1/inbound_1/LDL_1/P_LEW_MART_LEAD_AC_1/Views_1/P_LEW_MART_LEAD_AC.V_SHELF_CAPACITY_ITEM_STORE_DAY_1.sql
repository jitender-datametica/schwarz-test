CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_SHELF_CAPACITY_ITEM_STORE_DAY_1 COMMENT = 'Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/item_sid'
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
, item_sid                    COMMENT 'S-Key für Item_1 Id'
, orig_item_nr                COMMENT 'Ursprüngliche Artikelnummer (fachlice Schlüssel)'
, case_size                   COMMENT 'Case Size (Kolli)'
, itemgroup_int_id            COMMENT 'Warengruppe ID'
, subitemgroup_id             COMMENT 'Unterwarengruppe ID'
, item_familygroup_id         COMMENT 'Artikelfamilie ID'
, bestand_filiale_kolli       COMMENT 'Bestand in Kolli (Bestand in Stk. / Case Size)'
, regalfuellmenge_kolli       COMMENT 'Regalfüllmenge in Kolli'
, restbestand_kolli           COMMENT 'Regalfüllmenge in Kolli - Bestand in Kolli'
, restantenquote_fil_pct      COMMENT '(restbestand_stk / regalfuellmenge_stk) 100 - Solange restbestand_stk positive ist.'
, regelfuellmenge_0_fg        COMMENT '0 - regalfuellmenge_kolli > 0, 1 - regalfuellmenge_kolli = 0'
, skipped_fg                  COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = Fehlende Bestandsdatensatz'
, dwh_updated                 COMMENT 'Technische Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an Restantenquote data with the granularity of store/day/item_sid
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
       , item_sid
       , orig_item_nr
       , case_size
       , itemgroup_int_id
       , subitemgroup_id
       , item_familygroup_id
       , bestand_filiale_kolli
       , regalfuellmenge_kolli
       , restbestand_kolli
       , restantenquote_fil_pct
       , regelfuellmenge_0_fg
       , skipped_fg
       , dwh_updated
  FROM P_LEW_MART_LEAD.v_shelf_capacity_item_store_day_1
;