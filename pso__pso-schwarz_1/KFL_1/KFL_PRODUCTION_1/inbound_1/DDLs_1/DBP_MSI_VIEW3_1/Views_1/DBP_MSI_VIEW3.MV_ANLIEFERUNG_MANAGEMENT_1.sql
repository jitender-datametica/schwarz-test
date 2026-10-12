CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ANLIEFERUNG_MANAGEMENT_1
-- 15.12.2016, AP0013930, SPEC0016091 - Mercareon Detail
-- 13.03.2017, INC1028275, Lagernummer aufgenommen, damit in Bericht-SQL kein Join zu anlieferung_management_det_1 erforderlich ist
-- wenn Join, dann wird Entladedauer aus Kopf vervielfacht (in det gibt es mehrere Einträge mit Lagernummer pro anlieferung_id
-- 21.03.2018, AP0025826, SPEC0035365 - difference between datzeit_entl_gebucht and datzeit_ankunft in minutes
(
anlieferung_id
,mandant_id
,entladestelle_id
,datzeit_entl_gebucht
,dat_entl_gebucht
,datzeit_ankunft
,datzeit_tor
,datzeit_entl_beginn
,datzeit_entl_ende
,datzeit_ausfahrt
,anlieferung_status1_id
,anlieferung_status2_id
,sako_fg
,retoure_kz
,anlieferung_spediteur_id
,wup_id
,nb_id
,lagernummer_id
,entladedauer_min
,gebucht_ankunft_min
)
AS
   SELECT v01.anlieferung_id, v01.mandant_id, v01.entladestelle_id, v01.datzeit_entl_gebucht, CAST (v01.datzeit_entl_gebucht AS DATE)  AS dat_entl_gebucht, v01.datzeit_ankunft, v01.datzeit_tor, v01.datzeit_entl_beginn, v01.datzeit_entl_ende, v01.datzeit_ausfahrt, v01.anlieferung_status1_id, v01.anlieferung_status2_id, v01.sako_fg, v01.retoure_kz, v01.anlieferung_spediteur_id, v02.wup_id, v02.nb_id, v02.lagernummer_id
   ,CAST(CASE WHEN v01.datzeit_entl_beginn IS NOT NULL AND v01.datzeit_entl_ende IS NOT NULL AND v01.datzeit_entl_ende > v01.datzeit_entl_beginn
   THEN 
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entl_beginn, v01.datzeit_entl_ende)):DAY * 1440 ) +
   + (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entl_beginn, v01.datzeit_entl_ende)):HOUR * 60 ) +
   + (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entl_beginn, v01.datzeit_entl_ende)):MINUTE   )
   
   ELSE 0
   END AS NUMBER(38,5)) AS entladedauer_min
   , CAST(CASE WHEN datzeit_entl_gebucht IS NOT NULL AND v01.datzeit_ankunft IS NOT NULL
   THEN 
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_ankunft, v01.datzeit_entl_gebucht)):DAY * 1440 ) +
   + (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_ankunft, v01.datzeit_entl_gebucht)):HOUR * 60 )+
   + (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_ankunft, v01.datzeit_entl_gebucht)):MINUTE   )
   
   ELSE 0
   END AS NUMBER(38,5)) AS gebucht_ankunft_min

   FROM dbp_view.v_anlieferung_management_1 v01
   INNER JOIN (SELECT mandant_id, anlieferung_id, wup_id, nb_id, lagernummer_id
   FROM dbp_view.v_anlieferung_management_det_1
   GROUP BY mandant_id
   ,anlieferung_id
   ,wup_id
   ,nb_id
   ,lagernummer_id
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.anlieferung_id = v02.anlieferung_id;