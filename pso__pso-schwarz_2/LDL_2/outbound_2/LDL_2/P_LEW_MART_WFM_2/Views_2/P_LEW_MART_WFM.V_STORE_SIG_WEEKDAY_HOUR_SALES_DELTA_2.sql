/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_SIG_WEEKDAY_HOUR_SALES_DELTA_2
#----------------------------------------------------------------------------
# History:        
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#  2.0  07.10.2021    Martin Murtenthaler        redo changes on Preprod
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_sig_weekday_hour_sales_delta_2 (country_cd
OPTIONS(description='ISO-Code Land_2'), src_orig_store_nr OPTIONS(description='Filiale'), uwg
OPTIONS(description='Unterwarengruppe'), wochentag OPTIONS(description='Wochentag'), stunde
OPTIONS(description='Stunde'), verkauf OPTIONS(description='Verkaufsanteil bis zu dieser Stunde'))
OPTIONS(DESCRIPTION = `VERKÄUFE DELTA`) AS SELECT A.country_cd,
 A.src_orig_store_nr,
 A.uwg,
 A.wochentag,
 A.stunde,
 A.verkauf
FROM ldl_p_lew_mart_wfm.t_store_sig_weekday_hour_sales_2 AS A
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON A.country_cd = CLI.country_cd
 INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPOSPECS ON CLI.client_id = EXPOSPECS.client_id
 INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS EXPOLAST ON EXPOSPECS.export_specification = EXPOLAST.export_specification
      AND EXPOLAST.process_name = 'export_wfm_store_sig_weekday_hour_sales' AND EXPOLAST.process_specification = 'delta'
     AND A.load_ts >= EXPOLAST.last_export_tmsp;