/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_STORE_SIG_WEEKDAY_HOUR_SALES_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_wfm_ac.v_store_sig_weekday_hour_sales_delta_2 COMMENT='Verkäufe Delta'
(
  country_cd         COMMENT 'ISO-Code Land_2'
 ,src_orig_store_nr  COMMENT 'Filiale'
 ,uwg                COMMENT 'Unterwarengruppe'
 ,wochentag          COMMENT 'Wochentag'
 ,stunde             COMMENT 'Stunde'
 ,verkauf            COMMENT 'Verkaufsanteil bis zu dieser Stunde'
)
AS
SELECT
  country_cd
 ,src_orig_store_nr
 ,uwg
 ,wochentag
 ,stunde
 ,verkauf
FROM p_lew_mart_wfm.v_store_sig_weekday_hour_sales_delta_2
;