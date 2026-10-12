CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_MISS_ITEM_STORE_DAY_2 COMMENT = 'Store/Day list of missing items - Artikel_2 level'
(
  client_id        COMMENT 'MIS Client ID'
, loc_sid_wh       COMMENT 'S-Key der Gesellschaft'
, move_to_store_id COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id            COMMENT 'Gesellschaft ID'
, orig_store_nr    COMMENT 'Store ID'
, aspect_id        COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, dat_formdate     COMMENT 'Bezugsdatum'
, cy_month         COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear          COMMENT 'Geschäftsjahr'
, item_id          COMMENT 'S-Key der Artikel_2'
, currency_iso_cd  COMMENT '3 stelliger Währungs-Code'
, curr_tot_id      COMMENT 'Interner Währungs-Code'
, miss_item_fg     COMMENT 'Konstant: Immer 1'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a non-aggregated list of missing items.
#
#----------------------------------------------------------------------------
# History:
#  1.0     29.09.2022      Michael Morris             Initial Version
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , move_to_store_id
       , wh_id
       , orig_store_nr
       , aspect_id
       , dat_formdate
       , cy_month
       , busyear
       , item_id
       , currency_iso_cd
       , curr_tot_id
       , miss_item_fg
  FROM P_LEW_MART_LEAD.v_miss_item_store_day_2
;