/*
#
# @ LIDL Stiftung & Co. KG - DWH / MIS
#
# Interface: DDL for #X_LEW_MART_CS#.v_spaceman_store_item_performance
#
# History:
#  1.0  09.11.2020    Morris, Michael               20201109_2650_spaceman (REP4-7909) - Initial version
#  1.1  29.01.2021    Morris, Michael               Transfer to Snowflake.
#  1.2  17.08.2022    Haus, Oliver                  Additional column item_status_id
#  1.3  07.03.2024    Paneru, Raman                 Abverkauf_woche and Umsatz_woche added 
#
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_spaceman_store_item_performance
(
   export_cy_week
 , export_version
 , client_id
 , landeskurzel
 , filialnummer
 , artikelnummer_kurz
 , artikelnummer_lang
 , artikelbezeichnung
 , abverkauf_woche
 , umsatz_woche
 , vk_brutto
 , koliinhalt
 , palletenfaktor
 , marken
 , wg_bezeichnung
 , uwg
 , artikelfamilie
 , markenart
 , ab1
 , ab2
 , ab3
 , ab4
 , ob
 , item_status_id
 , export_tstmp
 , export_full_tstmp
 , exported_fg
) AS
SELECT    d.export_cy_week
       ,  d.export_version
       ,  d.client_id
       ,  d.landeskurzel
       ,  d.filialnummer
       ,  d.artikelnummer_kurz
       ,  d.artikelnummer_lang
       ,  d.artikelbezeichnung
       ,  d.abverkauf_woche 
       ,  d.umsatz_woche
       ,  d.vk_brutto
       ,  d.koliinhalt
       ,  d.palletenfaktor
       ,  d.marken
       ,  d.wg_bezeichnung
       ,  d.uwg
       ,  d.artikelfamilie
       ,  d.markenart
       ,  d.ab1
       ,  d.ab2
       ,  d.ab3
       ,  d.ab4
       ,  d.ob
	   ,  d.item_status_id
       ,  d.export_tstmp
       ,  d.export_full_tstmp
       ,  d.exported_fg
  FROM 
  (
/*
    Establish the highest export_version for the last export_cy_week per client_id
*/
                       SELECT DISTINCT e.client_id                                                        AS client_id
                               , MAX(e.export_version)  OVER (PARTITION BY e.client_id, e.export_cy_week) AS export_version
                               , e.export_cy_week                                                         AS export_cy_week
                         FROM (
/*
    Establish the latest export_cy_week for each client_id.
*/
                              SELECT DISTINCT client_id                                                                 AS client_id
                                    , export_version                                                                    AS export_version
                                    , MAX(export_cy_week)      OVER (PARTITION BY client_id)                            AS export_cy_week
                                FROM P_LEW_MART_CS.t_spaceman_store_item_performance
                                ) AS e
        ) AS ex
/*
    Read the export table for the cy_week and export_version provided by the query (ex).
*/
INNER JOIN P_LEW_MART_CS.t_spaceman_store_item_performance AS d
   ON ex.export_cy_week = d.export_cy_week
  AND ex.export_version = d.export_version
  AND ex.client_id      = d.client_id 
; 