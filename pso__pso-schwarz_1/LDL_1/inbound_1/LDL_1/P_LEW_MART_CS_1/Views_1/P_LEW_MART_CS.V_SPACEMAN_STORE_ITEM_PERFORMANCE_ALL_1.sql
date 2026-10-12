/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.v_spaceman_store_item_performance_all_1
#----------------------------------------------------------------------------
# History:
#  1.0  09.11.2020    Morris, Michael               20201109_2650_spaceman (REP4-7909) - Initial version
#  1.1  29.01.2021    Morris, Michael               Transfer to Snowflake
#  1.2  17.08.2022    Haus, Oliver                  Additional column item_status_id
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_spaceman_store_item_performance_all_1
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
  FROM (
/*
    Establish the latest version number of each record for the cy_week to be compared.
*/
        SELECT DISTINCT ex.export_cy_week
               , FIRST_VALUE(k.export_version) OVER (PARTITION BY k.export_cy_week, k.landeskurzel, k.filialnummer, k.artikelnummer_lang ORDER BY k.export_version DESC) AS export_version
               , ex.client_id
               , k.filialnummer
               , k.artikelnummer_lang
         FROM (
/*
    Establish the latest export_cy_week for each client_id
*/
               SELECT DISTINCT client_id                                                                 AS client_id
                     , MAX(export_cy_week)      OVER (PARTITION BY client_id)                            AS export_cy_week
                 FROM P_LEW_MART_CS.t_spaceman_store_item_performance_1
               ) AS ex
/*
    Read the export table and obtain all version numbers for the cy_week provided by the query (ex).
*/
          INNER JOIN P_LEW_MART_CS.t_spaceman_store_item_performance_1 AS k
             ON ex.export_cy_week = k.export_cy_week
            AND ex.client_id      = k.client_id
         ) AS k
/*
    Read the latest data from the export table.
*/
INNER JOIN P_LEW_MART_CS.t_spaceman_store_item_performance_1           AS d
   ON k.export_cy_week      = d.export_cy_week
  AND k.export_version      = d.export_version
  AND k.client_id           = d.client_id
  AND k.filialnummer        = d.filialnummer
  AND k.artikelnummer_lang  = d.artikelnummer_lang
;