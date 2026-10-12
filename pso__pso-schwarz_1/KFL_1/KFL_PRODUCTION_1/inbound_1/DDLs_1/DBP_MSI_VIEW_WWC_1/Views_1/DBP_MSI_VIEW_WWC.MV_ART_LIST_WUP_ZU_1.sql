CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_LIST_WUP_ZU_1
(
art_id
,mandant_id
,wup_id
,nb_id
,dat_erstlistung
,dat_von
,dat_bis
,listungs_kz
,list_quelle_id
)
AS
   SELECT
   v01.art_id, v01.mandant_id, v02.wup_id, v02.nb_id, COALESCE(v03.dat_erstlistung,CAST(NULL AS DATE)) AS dat_erstlistung, COALESCE(v03.dat_von,CAST(NULL AS DATE)) AS dat_von, COALESCE(v03.dat_bis,CAST(NULL AS DATE)) AS dat_bis, COALESCE(v03.listungs_kz, 4) AS listungs_kz, COALESCE(v03.list_quelle_id,'') AS list_quelle_id

   FROM dbp_view.v_art_1 v01
   INNER JOIN dbp_view.v_wup_1 v02
   ON v01.mandant_id= v02.mandant_id
   LEFT JOIN (SELECT mandant_id, art_id, wup_id, MIN(CASE WHEN CURRENT_DATE BETWEEN dat_von AND dat_bis THEN 1
   WHEN dat_bis > CURRENT_DATE THEN 2
   WHEN dat_bis < CURRENT_DATE THEN 3
   END) AS listungs_kz, MIN(dat_von) AS dat_erstlistung, MAX(dat_von) AS dat_von, MAX(dat_bis) AS dat_bis, MAX(list_quelle_id) AS list_quelle_id

   FROM dbp_view.v_art_list_wup_zu_per_1 v33
   GROUP BY mandant_id
   ,art_id
   ,wup_id
   ) v03
   ON v01.art_id=v03.art_id
   AND v02.wup_id=v03.wup_id
   AND v01.mandant_id=v03.mandant_id

   WHERE v01.mandant_id <> 1;