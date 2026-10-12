/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_SPACEMAN_STORE_ITEM_PERFORMANCE_ALL
#----------------------------------------------------------------------------
# History:
#  1.0  09.11.2020    Morris, Michael               20201109_2650_spaceman (REP4-7909) - Initial version
#  1.1  29.01.2021    Morris, Michael               Transfer to Snowflake
#  1.2  17.08.2022    Haus, Oliver                  Additional column item_status_id
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_spaceman_store_item_performance_all (export_cy_week, export_version,
client_id, landeskurzel, filialnummer, artikelnummer_kurz, artikelnummer_lang, artikelbezeichnung, abverkauf_woche,
umsatz_woche, vk_brutto, koliinhalt, palletenfaktor, marken, wg_bezeichnung, uwg, artikelfamilie, markenart, ab1, ab2,
ab3, ab4, ob, item_status_id, export_tstmp, export_full_tstmp, exported_fg) AS SELECT *
FROM ldl_p_lew_mart_cs.v_spaceman_store_item_performance_all AS D;