create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_OFFENE_BEST_DISPO_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	ART_ID,
	DAT_LIEF_NEXT_DISPO,
	DAT_LIEF_MAX_DISPO,
	MENGE_BEST_BME_OFFEN_DISPO,
	MENGE_BEST_KOLLI_OFFEN_DISPO,
	ANZ_BEST_POS_DISPO,
	DIFF_TAGE_DISPO,
	MENGE_BEST_BME_OFFEN_NEXT_DISPO,
	MENGE_BEST_KOLLI_OFFEN_NEXT_DISPO
) as
--LOGIC ALSO USED IN DBX_MSI_VIEW_SCM.mv_reichweitenliste_1 -> always make sure this is consistent! | difference: this is only AS-IS, other view can do AS-WAS according to dat_plan, too
SELECT 
 open_orders.mandant_id
,open_orders.wup_id
,open_orders.nb_id
,open_orders.gp_id
,open_orders.art_id
,MAX(CASE WHEN open_orders.rn = 1 THEN open_orders.dat_lief END) AS dat_lief_next_dispo
,MAX(CASE WHEN art_id_next is null THEN open_orders.dat_lief END) AS dat_lief_max_dispo
,SUM(open_orders.menge_best_bme) AS menge_best_bme_offen_dispo
,SUM(open_orders.menge_best_kolli) AS menge_best_kolli_offen_dispo
,SUM(open_orders.anz_best_pos) AS anz_best_pos_dispo
,dat_lief_max_dispo - dat_lief_next_dispo AS diff_tage_dispo
,SUM(CASE WHEN open_orders.rn = 1 THEN open_orders.menge_best_bme END) AS menge_best_bme_offen_next_dispo
,SUM(CASE WHEN open_orders.rn = 1 THEN open_orders.menge_best_kolli END) AS menge_best_kolli_offen_next_dispo
FROM
    (
    SELECT mandant_id
          ,wup_id
          ,nb_id
          ,gp_id
          ,art_id
          ,dat_lief
          ,menge_best_bme
          ,menge_best_kolli
          ,anz_best_pos
          ,ROW_NUMBER() OVER (PARTITION BY mandant_id,wup_id,nb_id,gp_id,art_id ORDER BY dat_lief) AS rn	
          ,MAX(art_id) OVER (PARTITION BY mandant_id,wup_id,nb_id,gp_id,art_id ORDER BY dat_lief ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS art_id_next 
    FROM
        ( 
        SELECT mandant_id
              ,wup_id
              ,nb_id
              ,gp_id
              ,CAST(art_id AS INTEGER) AS art_id
              ,dat_lief
              ,SUM(CAST(menge_best_gesamt AS DECIMAL(18,3))) AS menge_best_bme
              ,SUM(CAST(menge_best_gesamt AS DECIMAL(18,3))/ umrech_faktor_best_bme) AS menge_best_kolli
              ,Count(*) AS anz_best_pos
        FROM   DBP_VIEW.v_vz_best_vor_1
        WHERE  dat_lief >= CURRENT_DATE -1 AND dat_plan = CURRENT_DATE -1
        GROUP BY mandant_id
                ,wup_id
                ,nb_id
                ,gp_id
                ,art_id
               ,dat_lief
         ) t0 
     ) open_orders
GROUP BY open_orders.mandant_id
        ,open_orders.wup_id
        ,open_orders.nb_id
        ,open_orders.gp_id
        ,open_orders.art_id;