/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_SIG_WEEKDAY_HOUR_SALES_DELTA
#----------------------------------------------------------------------------
# History:        
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#  2.0  07.10.2021    Martin Murtenthaler        redo changes on Preprod
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_wfm.v_store_sig_weekday_hour_sales_delta COMMENT='Verkäufe Delta'
(
  country_cd         COMMENT 'ISO-Code Land'
 ,src_orig_store_nr  COMMENT 'Filiale'
 ,uwg                COMMENT 'Unterwarengruppe'
 ,wochentag          COMMENT 'Wochentag'
 ,stunde             COMMENT 'Stunde'
 ,verkauf            COMMENT 'Verkaufsanteil bis zu dieser Stunde'
)
AS
SELECT
  a.country_cd
 ,a.src_orig_store_nr
 ,a.uwg
 ,a.wochentag
 ,a.stunde
 ,a.verkauf
FROM p_lew_mart_wfm.t_store_sig_weekday_hour_sales  a
INNER JOIN p_lew_core_ac.v_client cli
ON cli.country_cd=a.country_cd
INNER JOIN p_lew_process_ac.v_wfm_export_specification expospecs
ON expospecs.client_id=cli.client_id
INNER JOIN p_lew_process_ac.v_wfm_last_export expolast
ON expolast.export_specification=expospecs.export_specification
AND expolast.process_name='export_wfm_store_sig_weekday_hour_sales'
AND expolast.process_specification='delta'
AND expolast.last_export_tmsp<=a.load_ts;