CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_AUTODISPO_TAG_DIF_BME_2
-- 2020-09-03, AP0068964, nwag2310, Ersterstellung, this is the "magical" part where the difs are being resolved to level art_2/wup_2/kunde/dat/bme
-- 2020-09-07, AP0068964, nwag2310, added Art. Gruppe_2 Resolving
-- 2020-09-08, AP0068964, nwag2310, added VKL_2 Resolving
-- 2020-09-10, AP0068964, nwag2310, solved performance issue -> switch to art_2 gruppe_2 flw + inner join
-- 2020-09-12, AP0068964, srom0404, ts.mandant_id umstellen auf ts.mandant_id_kunde, ts.wup_id auf ts.wup_id_kunde
-- 2020-09-14, AP0068964, nwag2310, added FLW resolving
-- 2020-09-15, AP0068964, nwag2310, Sonn- und Feiertage ausklammern + Performance
-- 2020-11-04, AP0068964, nwag2310, Extra-Felder für export / dif_status raus / nur gelistete artikel_2
-- 2020-11-11, AP0068964, nwag2310, VK_2-Listung/Bestelllistung aus Faktentabelle statt WLK1_2
-- 2020-03-11, AP0084960, nwag2310, added resolving of custom art_2/wup_2-groups
-- 2020-04-20, AP0084960, nwag2310, bugfix resolving of custom art_2/wup_2-groups
-- 2020-05-03, AP0084960, nwag2310, added resolving of werbegruppe + frische-mgr
-- 2020-05-07, AP0084960, nwag2310, only active clusters
-- 2020-06-01, AP0084960, srom0404, JOIN condition in store -> store cluster branch & product cluster -> artikelgruppe char casted and trim, additional code formating
-- 2020-06-22, AP0084960, nwag2310, removed trims for performance, changed cluster resolving (left joins at the end to avoid duplications)
-- 2020-08-11, AP0084960, nwag2310, extended to varchar(20) - wup_2 id was cut off ++ werbegruppe markt at given instead of infinite
-- 2022-01-18, richternic: Typcast VARCHAR in JOIN CASE WHEN anpassen 
-- 2023-02-08, dknop, adding filter mandant_id=1
-- 2025-03-18, nwag, AGF optional, filter removed
-- 2025-06-11, nwag, not DIFs on Displays (ATYP 12)
-- 2025-07-01, nwag, keine Prüfung mehr auf kDiS und/oder VK_2-Listung nach RS_2 mit Sarah Weiprecht
-- 2025-07-11, nwag, Performance opt.
AS
SELECT 
  f.mandant_id
 ,f.kunde_id 
 ,f.art_id 
 ,wg.wg_id
 ,f.dat
  -- simulation:
 , MAX(CASE WHEN ts.dif_typ_id =1 THEN ts.dif_kommentar END) AS dif_komm_mult
 , MAX(CASE WHEN ts.dif_typ_id =2 THEN ts.dif_kommentar END) AS dif_komm_add
 , MAX(CASE WHEN ts.dif_typ_id =3 THEN ts.dif_kommentar END) AS dif_komm_abs
 , EXP(SUM(LN(CASE WHEN ts.dif_typ_id =1 THEN ts.dif_wert END))) AS dif_mult  --mult. davor: else 1 -> test...
 , SUM(CASE WHEN ts.dif_typ_id =2 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_add --add.
 , AVG(CASE WHEN ts.dif_typ_id =3 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_abs --abs.
 , SUM(CASE WHEN ts.dif_typ_id =1 THEN 1 ELSE 0 END) AS anz_dif_mult
 , SUM(CASE WHEN ts.dif_typ_id =2 THEN 1 ELSE 0 END) AS anz_dif_add
 , SUM(CASE WHEN ts.dif_typ_id =3 THEN 1 ELSE 0 END) AS anz_dif_abs
 -- export:
 , MAX(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_mult_exp
 , MAX(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_add_exp
 , MAX(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_abs_exp
 , EXP(SUM(LN(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN ts.dif_wert END))) AS dif_mult_exp --mult. davor: else 1 -> test...
 , SUM(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_add_exp --add.
 , AVG(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_abs_exp --abs.
 , SUM(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_mult_exp
 , SUM(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_add_exp
 , SUM(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_abs_exp
 
 FROM DBP_VIEW.v_art_wup_autodispo_flw_tag_2 f 
 
JOIN dbp_view.v_tag_2 t 
  ON f.dat        = t.dat
  AND t.akt_tag BETWEEN -7 AND +30
  AND t.wtag_id <> 7 

      
 JOIN DBP_VIEW.v_wup_2 w
    ON f.mandant_id = w.mandant_id 
     AND f.kunde_id   = w.wup_id
     AND f.nb_id_kunde = w.nb_id
  
 LEFT JOIN DBP_VIEW.v_wupcal_ereignis_zu_2 we
        ON w.mandant_id = we.mandant_id 
       AND w.wup_id     = we.wup_id 
       AND f.dat        = we.dat

JOIN DBP_VIEW.v_art_2 a 
  ON f.art_id         = a.art_id
  AND f.mandant_id    = a.mandant_id
  AND a.artikeltyp_id <> 12
 
JOIN DBP_VIEW.v_art_wg_zu_per_2 wg 
  ON f.art_id         = wg.art_id
 AND f.dat BETWEEN wg.dat_von AND wg.dat_bis       
 AND wg.mandant_id    = f.mandant_id
 AND wg.arthiertyp_id = 2
 
LEFT JOIN DBP_VIEW.v_art_art_gruppe_flw_2 agf 
  ON f.mandant_id = agf.mandant_id
 AND f.art_id     = agf.art_id
 
JOIN DBP_MSI_V_VIEW.v_wup_denorm_2 wd
  ON f.mandant_id = wd.mandant_id 
 AND f.kunde_id   = wd.wup_id
 
JOIN DBP_VIEW.v_wup_marktmerkmal_zu_per_2 mm_2
  ON f.mandant_id       = mm.mandant_id
 AND f.kunde_id         = mm.wup_id
 AND mm.marktmerkmal_id = '0051'
 AND f.dat BETWEEN mm.dat_von AND mm.dat_bis         

JOIN DBP_VIEW.v_marktmerkmal_wert_spr_zu_2 mmw
  ON mm.marktmerkmal_id   = mmw.marktmerkmal_id
 AND mm.marktmerkmal_wert = mmw.marktmerkmal_wert
 AND mmw.spr_id           = 22
 
 JOIN DBP_VIEW.v_ts_autodispo_dif_2  ts 
  ON f.dat BETWEEN ts.dat_von AND ts.dat_bis
 AND ts.mandant_id_kunde = f.mandant_id
 AND ts.menge_einh_id    = f.menge_einh_id
 
 -- ORDER: store -> vkl_2 -> werbegruppe -> frische_manager -> region_2 -> mandant_2
 -- ACHTUNG_ VARCHAR()-Anpassung fuer Snowflake 
 AND ((CASE WHEN ts.wup_id_kunde <> -1                   THEN ts.wup_id_kunde::VARCHAR(20)
	                 WHEN ts.vkl_id <> -1                  THEN ts.vkl_id::VARCHAR(20)
                     WHEN ts.werbegruppe_fleisch <> '-1' THEN ts.werbegruppe_fleisch::VARCHAR(20)
                     WHEN ts.frische_manager_id <> -1    THEN ts.frische_manager_id::VARCHAR(20)
                     WHEN ts.vs_id <> -1                 THEN ts.vs_id::VARCHAR(20) 
                     ELSE ts.mandant_id_kunde::VARCHAR(20) 
                END 
               ) 
          
      = 
      (CASE WHEN ts.wup_id_kunde <> -1                    THEN w.wup_id::VARCHAR(20)
                     WHEN ts.vkl_id <> -1                 THEN w.vkl_id::VARCHAR(20)
                     WHEN ts.werbegruppe_fleisch <> '-1'  THEN mmw.marktmerkmal_wert::VARCHAR(20)
                     WHEN ts.frische_manager_id <> -1     THEN wd.frische_manager_id::VARCHAR(20)
                     WHEN ts.vs_id <> -1                  THEN w.vs_id::VARCHAR(20) 
                     ELSE w.mandant_id::VARCHAR(20) 
                  END 
                ) 
          
      ) -- WHOLE AND branch  
      
 -- ORDER: product  -> artikelgruppe -> whole prod. group --> whole supplier_2 (FLW)
 -- Achtung: VARCHAR()-Anpassung für Snowflake
 AND (CASE WHEN ts.art_id <> -1                     THEN ts.art_id::VARCHAR(20) 
                     WHEN ts.art_gruppe_id <> '-1'  THEN ts.art_gruppe_id::VARCHAR(20)
                     WHEN ts.wg_id <> -1            THEN ts.wg_id::VARCHAR(20) 
                     ELSE '0' END 
       
  =
      CASE WHEN ts.art_id <> -1                   THEN f.art_id::VARCHAR(20)
	                 WHEN ts.art_gruppe_id <> '-1'  THEN COALESCE(agf.art_gruppe_id::VARCHAR(20),'-1')
                     WHEN ts.wg_id <> -1          THEN wg.wg_id::VARCHAR(20)
                     ELSE '0' END 
      ) -- WHOLE AND branch
  -- SA (promotion) / AF (non-promotion) / both 
  AND (ts.sa_af_fg = CASE WHEN ts.sa_af_fg = -1 THEN -1 ELSE f.sa_af_fg END)
 
  -- alle FLW oder ein bestimmtes
  AND (ts.wup_id_vz = CASE WHEN ts.wup_id_vz = -1 THEN -1 ELSE f.wup_id END)
  
  --da artikel_2 und märkte mehreren clustern zugeordnet sein können, müssen diese beiden joins nachgelagert erfolgen um eine_2 vermehrfachung der difs zu vermeiden
  
  LEFT JOIN DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_ART_CLUSTER_ZU_2 ac
  ON f.mandant_id = ac.mandant_id
 AND f.art_id     = ac.art_id
 AND ts.art_cluster_id = ac.art_cluster_id 
 AND ts.art_cluster_id > 0
 
 LEFT JOIN DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_WUP_CLUSTER_ZU_2  wc
  ON f.mandant_id = wc.mandant_id
 AND w.wup_id     = wc.wup_id
 AND ts.wup_cluster_id = wc.wup_cluster_id 
 AND ts.wup_cluster_id > 0
 
WHERE  ts.dif_status_id IN (0,1) 
--AND (f.kdis = 0 OR verkaufslistung_fg = 1) 
AND f.mandant_id=1
AND COALESCE(we.offen,1) = 1
--wenn eine_2 pflege auf clusterebene stattgefunden hat soll dieses als filter wirken, sonst nicht:
AND CASE WHEN ts.wup_cluster_id > 0 THEN wc.wup_cluster_id ELSE ts.wup_cluster_id END = ts.wup_cluster_id
AND CASE WHEN ts.art_cluster_id > 0 THEN ac.art_cluster_id ELSE ts.art_cluster_id END = ts.art_cluster_id

GROUP BY f.mandant_id
        ,f.kunde_id 
        ,f.art_id 
    		,wg.wg_id
        ,f.dat;