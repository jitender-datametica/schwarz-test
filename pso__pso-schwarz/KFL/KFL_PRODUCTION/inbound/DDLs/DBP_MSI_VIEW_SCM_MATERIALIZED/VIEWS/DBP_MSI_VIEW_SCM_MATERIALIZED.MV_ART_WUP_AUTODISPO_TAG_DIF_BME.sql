create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_AUTODISPO_TAG_DIF_BME(
	MANDANT_ID,
	KUNDE_ID,
	ART_ID,
	WG_ID,
	DAT,
	DIF_KOMM_MULT,
	DIF_KOMM_ADD,
	DIF_KOMM_ABS,
	DIF_MULT,
	DIF_ADD,
	DIF_ABS,
	ANZ_DIF_MULT,
	ANZ_DIF_ADD,
	ANZ_DIF_ABS,
	DIF_KOMM_MULT_EXP,
	DIF_KOMM_ADD_EXP,
	DIF_KOMM_ABS_EXP,
	DIF_MULT_EXP,
	DIF_ADD_EXP,
	DIF_ABS_EXP,
	ANZ_DIF_MULT_EXP,
	ANZ_DIF_ADD_EXP,
	ANZ_DIF_ABS_EXP
) as
SELECT 
  f.mandant_id
 ,f.kunde_id 
 ,f.art_id 
 ,wg.wg_id
 ,f.dat
  
 , MAX(CASE WHEN ts.dif_typ_id =1 THEN ts.dif_kommentar END) AS dif_komm_mult
 , MAX(CASE WHEN ts.dif_typ_id =2 THEN ts.dif_kommentar END) AS dif_komm_add
 , MAX(CASE WHEN ts.dif_typ_id =3 THEN ts.dif_kommentar END) AS dif_komm_abs
 , EXP(SUM(LN(CASE WHEN ts.dif_typ_id =1 THEN ts.dif_wert END))) AS dif_mult  
 , SUM(CASE WHEN ts.dif_typ_id =2 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_add 
 , AVG(CASE WHEN ts.dif_typ_id =3 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_abs 
 , SUM(CASE WHEN ts.dif_typ_id =1 THEN 1 ELSE 0 END) AS anz_dif_mult
 , SUM(CASE WHEN ts.dif_typ_id =2 THEN 1 ELSE 0 END) AS anz_dif_add
 , SUM(CASE WHEN ts.dif_typ_id =3 THEN 1 ELSE 0 END) AS anz_dif_abs
 
 , MAX(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_mult_exp
 , MAX(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_add_exp
 , MAX(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN ts.dif_kommentar END) AS dif_komm_abs_exp
 , EXP(SUM(LN(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN ts.dif_wert END))) AS dif_mult_exp 
 , SUM(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_add_exp 
 , AVG(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN ts.dif_wert/f.egalisierungsfaktor END) AS dif_abs_exp 
 , SUM(CASE WHEN ts.dif_typ_id =1 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_mult_exp
 , SUM(CASE WHEN ts.dif_typ_id =2 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_add_exp
 , SUM(CASE WHEN ts.dif_typ_id =3 AND ts.dif_status_id = 1 THEN 1 ELSE 0 END) AS anz_dif_abs_exp
 
 FROM DBP_VIEW.v_art_wup_autodispo_flw_tag f 

  JOIN (SELECT w.mandant_id
            ,w.wup_id
            ,t.dat
            ,w.vkl_id
            ,w.vs_id
      FROM DBP_VIEW.v_wup w
      JOIN DBP_VIEW.v_tag t 
        ON t.wtag_id <> 7
      LEFT JOIN DBP_VIEW.v_wupcal_ereignis_zu we
        ON w.mandant_id = we.mandant_id 
       AND w.wup_id     = we.wup_id 
       AND t.dat        = we.dat
      WHERE w.mandant_id=1
        AND t.dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE +30  
        AND COALESCE(we.offen,1) = 1
     ) w  
  ON f.mandant_id = w.mandant_id 
 AND f.kunde_id   = w.wup_id
 AND f.dat        = w.dat  


JOIN DBP_VIEW.v_art a 
  ON f.art_id         = a.art_id
  AND f.mandant_id    = a.mandant_id
  AND a.artikeltyp_id <> 12
 
JOIN DBP_VIEW.v_art_wg_zu_per wg 
  ON f.art_id         = wg.art_id
 AND f.dat BETWEEN wg.dat_von AND wg.dat_bis       
 AND wg.mandant_id    = f.mandant_id
 AND wg.arthiertyp_id = 2
 
LEFT JOIN DBP_VIEW.v_art_art_gruppe_flw agf 
  ON f.mandant_id = agf.mandant_id
 AND f.art_id     = agf.art_id
 
JOIN DBP_MSI_V_VIEW.v_wup_denorm wd
  ON f.mandant_id = wd.mandant_id 
 AND f.kunde_id   = wd.wup_id
 
JOIN DBP_VIEW.v_wup_marktmerkmal_zu_per mm
  ON f.mandant_id       = mm.mandant_id
 AND f.kunde_id         = mm.wup_id
 AND mm.marktmerkmal_id = '0051'
 AND f.dat BETWEEN mm.dat_von AND mm.dat_bis         

JOIN DBP_VIEW.v_marktmerkmal_wert_spr_zu mmw
  ON mm.marktmerkmal_id   = mmw.marktmerkmal_id
 AND mm.marktmerkmal_wert = mmw.marktmerkmal_wert
 AND mmw.spr_id           = 22
 
 JOIN DBP_VIEW.v_ts_autodispo_dif ts 
  ON f.dat BETWEEN ts.dat_von AND ts.dat_bis
 AND ts.mandant_id_kunde = f.mandant_id
 AND ts.menge_einh_id    = f.menge_einh_id
 
 
 
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
          
      ) 
      
 
 
 AND (CASE WHEN ts.art_id <> -1                     THEN ts.art_id::VARCHAR(20) 
                     WHEN ts.art_gruppe_id <> '-1'  THEN ts.art_gruppe_id::VARCHAR(20)
                     WHEN ts.wg_id <> -1            THEN ts.wg_id::VARCHAR(20) 
                     ELSE '0' END 
       
  =
      CASE WHEN ts.art_id <> -1                   THEN f.art_id::VARCHAR(20)
	                 WHEN ts.art_gruppe_id <> '-1'  THEN COALESCE(agf.art_gruppe_id::VARCHAR(20),'-1')
                     WHEN ts.wg_id <> -1          THEN wg.wg_id::VARCHAR(20)
                     ELSE '0' END 
      ) 
  
  AND (ts.sa_af_fg = CASE WHEN ts.sa_af_fg = -1 THEN -1 ELSE f.sa_af_fg END)
 
  
  AND (ts.wup_id_vz = CASE WHEN ts.wup_id_vz = -1 THEN -1 ELSE f.wup_id END)
  
  
  
  LEFT JOIN ( SELECT ac.mandant_id, ac.art_id, ac.art_cluster_id 
			FROM DBP_VIEW.v_ts_scm_art_cluster_zu ac
			JOIN DBP_VIEW.v_ts_scm_l_art_cluster lac
			  ON ac.mandant_id     = lac.mandant_id
			 AND ac.art_cluster_id = lac.art_cluster_id 
			 AND lac.art_cluster_del_fg=0 ) ac
  ON f.mandant_id = ac.mandant_id
 AND f.art_id     = ac.art_id
 AND ts.art_cluster_id = ac.art_cluster_id 
  
 LEFT JOIN ( SELECT wc.mandant_id, wc.wup_cluster_id, wc.wup_id 
			FROM DBP_VIEW.v_ts_scm_wup_cluster_zu wc
 			JOIN DBP_VIEW.v_ts_scm_l_wup_cluster lwc
			  ON wc.mandant_id     = lwc.mandant_id
			 AND wc.wup_cluster_id = lwc.wup_cluster_id 
			 AND lwc.wup_cluster_del_fg = 0 ) wc
  ON f.mandant_id = wc.mandant_id
 AND w.wup_id     = wc.wup_id
 AND ts.wup_cluster_id = wc.wup_cluster_id 

WHERE  ts.dif_status_id IN (0,1) 

AND f.mandant_id=1


AND CASE WHEN ts.wup_cluster_id > 0 THEN wc.wup_cluster_id ELSE ts.wup_cluster_id END = ts.wup_cluster_id
AND CASE WHEN ts.art_cluster_id > 0 THEN ac.art_cluster_id ELSE ts.art_cluster_id END = ts.art_cluster_id


GROUP BY f.mandant_id
        ,f.kunde_id 
        ,f.art_id 
		,wg.wg_id
        ,f.dat;