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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_spaceman_store_item_performance (export_cy_week, export_version, client_id,
landeskurzel, filialnummer, artikelnummer_kurz, artikelnummer_lang, artikelbezeichnung, abverkauf_woche, umsatz_woche,
vk_brutto, koliinhalt, palletenfaktor, marken, wg_bezeichnung, uwg, artikelfamilie, markenart, ab1, ab2, ab3, ab4, ob,
item_status_id, export_tstmp, export_full_tstmp, exported_fg) AS SELECT D.export_cy_week,
 D.export_version,
 D.client_id,
 D.landeskurzel,
 D.filialnummer,
 D.artikelnummer_kurz,
 D.artikelnummer_lang,
 D.artikelbezeichnung,
 D.abverkauf_woche,
 D.umsatz_woche,
 D.vk_brutto,
 D.koliinhalt,
 D.palletenfaktor,
 D.marken,
 D.wg_bezeichnung,
 D.uwg,
 D.artikelfamilie,
 D.markenart,
 D.ab1,
 D.ab2,
 D.ab3,
 D.ab4,
 D.ob,
 D.item_status_id,
 D.export_tstmp,
 D.export_full_tstmp,
 D.exported_fg
FROM (SELECT DISTINCT client_id,
   MAX(export_version) OVER (PARTITION BY CAST(client_id AS STRING), CAST(export_cy_week AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS export_version_0,
   export_cy_week
  FROM (SELECT DISTINCT client_id,
     export_version,
     MAX(export_cy_week) OVER (PARTITION BY CAST(client_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS export_cy_week
    FROM ldl_p_lew_mart_cs.t_spaceman_store_item_performance) AS e) AS ex
 INNER JOIN ldl_p_lew_mart_cs.t_spaceman_store_item_performance AS D ON ex.export_cy_week = D.export_cy_week AND ex.export_version_0
     = D.export_version AND ex.client_id = D.client_id;