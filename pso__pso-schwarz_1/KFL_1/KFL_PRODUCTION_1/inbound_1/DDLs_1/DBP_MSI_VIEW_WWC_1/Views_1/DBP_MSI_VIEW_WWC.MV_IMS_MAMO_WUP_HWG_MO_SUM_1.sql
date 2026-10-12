CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_IMS_MAMO_WUP_HWG_MO_SUM_1 as
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v04.wup_standort, v06.dat_massnahme_von AS start_bu, v06.dat_massnahme_bis AS eroeffnung, v01.kjmo, v01.zaehler_monat, v01.hwg_id, v02.qualifier_id, v05.qualifier_bez, v01.umsatz_netto_kum AS Umsatz_netto_kum, v01.umsatz_netto_vp_kum AS Umsatz_netto_kum_VJ, CASE WHEN v01.umsatz_netto_vp_kum <> 0 THEN TRUNC( (v01.umsatz_netto_kum - v01.umsatz_netto_vp_kum) / v01.umsatz_netto_vp_kum) * 100 ELSE NULL END AS Umsatz_netto_kum_DeltaVJ, v03.umsatz_netto_kum AS Umsatz_netto_ref_kum, v03.umsatz_netto_vp_kum AS Umsatz_netto_ref_kum_VJ, CASE WHEN v03.umsatz_netto_vp_kum <> 0 THEN TRUNC( (v03.umsatz_netto_kum - v03.umsatz_netto_vp_kum) / v03.umsatz_netto_vp_kum) * 100 ELSE NULL END AS Umsatz_netto_ref_kum_DeltaVJ, umsatz_netto_kum_DeltaVJ - umsatz_netto_ref_kum_DeltaVJ AS Umsatz_netto_kum_DeltaVJ_DeltaRef, v01.umsatz_netto_sa_kum AS Umsatz_netto_sa_kum, v01.umsatz_netto_sa_vp_kum AS Umsatz_netto_sa_kum_VJ, CASE WHEN v01.umsatz_netto_sa_vp_kum <> 0 THEN TRUNC( (v01.umsatz_netto_sa_kum - v01.umsatz_netto_sa_vp_kum) / v01.umsatz_netto_sa_vp_kum) * 100 ELSE NULL END AS Umsatz_netto_sa_kum_DeltaVJ, v03.umsatz_netto_sa_kum AS Umsatz_netto_sa_ref_kum, v03.umsatz_netto_sa_vp_kum AS Umsatz_netto_sa_ref_kum_VJ, CASE WHEN v03.umsatz_netto_sa_vp_kum <> 0 THEN TRUNC( (v03.umsatz_netto_sa_kum - v03.umsatz_netto_sa_vp_kum) / v03.umsatz_netto_sa_vp_kum) * 100 ELSE NULL END AS Umsatz_netto_sa_ref_kum_DeltaVJ, Umsatz_netto_sa_kum_DeltaVJ - Umsatz_netto_sa_ref_kum_DeltaVJ AS Umsatz_netto_sa_kum_DeltaVJ_DeltaRef, NULL AS Kunden_anzahl_kum --,v01.bonanzahl_sug_kum AS Kunden_anzahl_kum
   , NULL AS Kunden_anzahl_kum_VJ --,v01.bonanzahl_sug_vp_kum AS Kunden_anzahl_kum_VJ
   , NULL AS Kunden_anzahl_kum_DeltaVJ --,CASE WHEN v01.bonanzahl_sug_vp_kum <> 0 THEN (v01.bonanzahl_sug_kum - v01.bonanzahl_sug_vp_kum) / v01.bonanzahl_sug_vp_kum * 100 ELSE NULL END AS Kunden_anzahl_kum_DeltaVJ
   , NULL AS Kunden_anzahl_ref_kum --,v03.bonanzahl_sug_kum AS Kunden_anzahl_ref_kum
   , NULL AS Kunden_anzahl_ref_kum_VJ --,v03.bonanzahl_sug_vp_kum AS Kunden_anzahl_ref_kum_VJ
   , NULL AS Kunden_anzahl_ref_kum_DeltaVJ --,CASE WHEN v03.bonanzahl_sug_vp_kum <> 0 THEN (v03.bonanzahl_sug_kum - v03.bonanzahl_sug_vp_kum) / v03.bonanzahl_sug_vp_kum * 100 ELSE NULL END AS Kunden_anzahl_ref_kum_DeltaVJ
   , NULL AS Kunden_anzahl_kum_DeltaVJ_DeltaRef --,Kunden_anzahl_kum_DeltaVJ - Kunden_anzahl_ref_kum_DeltaVJ AS Kunden_anzahl_kum_DeltaVJ_DeltaRef
   , NULL AS VIS_umsatz_netto_kum --,v01.vis_umsatz_netto_kum AS VIS_umsatz_netto_kum
   , NULL AS VIS_umsatz_netto_kum_VJ --,v01.vis_umsatz_netto_vp_kum AS VIS_umsatz_netto_kum_VJ
   , NULL AS VIS_Umsatz_netto_kum_DeltaVJ --,CASE WHEN v01.vis_umsatz_netto_vp_kum <> 0 THEN (v01.vis_umsatz_netto_kum - v01.vis_umsatz_netto_vp_kum) / v01.vis_umsatz_netto_vp_kum * 100 ELSE NULL END AS VIS_Umsatz_netto_kum_DeltaVJ
   , NULL AS VIS_umsatz_netto_ref_kum --,v03.vis_umsatz_netto_kum AS VIS_umsatz_netto_ref_kum
   , NULL AS VIS_umsatz_netto_ref_kum_VJ --,v03.vis_umsatz_netto_vp_kum AS VIS_umsatz_netto_ref_kum_VJ
   , NULL AS VIS_Umsatz_netto_ref_kum_DeltaVJ --,CASE WHEN v03.vis_umsatz_netto_vp_kum <> 0 THEN (v03.vis_umsatz_netto_kum - v03.vis_umsatz_netto_vp_kum) / v03.vis_umsatz_netto_vp_kum * 100 ELSE NULL END AS VIS_Umsatz_netto_ref_kum_DeltaVJ
   , NULL AS VIS_Umsatz_netto_kum_DeltaVJ_DeltaRef --,VIS_Umsatz_netto_kum_DeltaVJ - VIS_Umsatz_netto_ref_kum_DeltaVJ AS VIS_Umsatz_netto_kum_DeltaVJ_DeltaRef
   , NULL AS Nettostunden_kum --,v01.vis_netto_stunden_kum AS Nettostunden_kum
   , NULL AS Nettostunden_kum_VJ --,v01.vis_netto_stunden_vp_kum AS Nettostunden_kum_VJ
   , NULL AS Nettostunden_kum_DeltaVJ --,CASE WHEN v01.vis_netto_stunden_vp_kum <> 0 THEN (v01.vis_netto_stunden_kum - v01.vis_netto_stunden_vp_kum) / v01.vis_netto_stunden_vp_kum * 100 ELSE NULL END AS Nettostunden_kum_DeltaVJ
   , NULL AS Nettostunden_ref_kum --,v03.vis_netto_stunden_kum AS Nettostunden_ref_kum
   , NULL AS Nettostunden_ref_kum_VJ --,v03.vis_netto_stunden_vp_kum AS Nettostunden_ref_kum_VJ
   , NULL AS Nettostunden_ref_kum_DeltaVJ --,CASE WHEN v03.vis_netto_stunden_vp_kum <> 0 THEN (v03.vis_netto_stunden_kum - v03.vis_netto_stunden_vp_kum) / v03.vis_netto_stunden_vp_kum * 100 ELSE NULL END AS Nettostunden_ref_kum_DeltaVJ
   , NULL AS Nettostunden_kum_DeltaVJ_DeltaRef --,Nettostunden_kum_DeltaVJ - Nettostunden_ref_kum_DeltaVJ AS Nettostunden_kum_DeltaVJ_DeltaRef
   , NULL AS Nettoleistung_kum --,CASE WHEN v01.vis_netto_stunden_kum <> 0 THEN v01.vis_umsatz_netto_kum / v01.vis_netto_stunden_kum ELSE NULL END AS Nettoleistung_kum
   , NULL AS Nettoleistung_kum_VJ --,CASE WHEN v01.vis_netto_stunden_vp_kum <> 0 THEN v01.vis_umsatz_netto_vp_kum / v01.vis_netto_stunden_vp_kum ELSE NULL END AS Nettoleistung_kum_VJ
   , NULL AS Nettoleistung_kum_DeltaVJ --,CASE WHEN Nettoleistung_kum_VJ <> 0 THEN (Nettoleistung_kum - Nettoleistung_kum_VJ) / Nettoleistung_kum_VJ * 100 ELSE NULL END AS Nettoleistung_kum_DeltaVJ
   , NULL AS Nettoleistung_ref_kum --,CASE WHEN v03.vis_netto_stunden_kum <> 0 THEN v03.vis_umsatz_netto_kum / v03.vis_netto_stunden_kum ELSE NULL END AS Nettoleistung_ref_kum
   , NULL AS Nettoleistung_ref_kum_VJ --,CASE WHEN v03.vis_netto_stunden_vp_kum <> 0 THEN v03.vis_umsatz_netto_vp_kum / v03.vis_netto_stunden_vp_kum ELSE NULL END AS Nettoleistung_ref_kum_VJ
   , NULL AS Nettoleistung_ref_kum_DeltaVJ --,CASE WHEN Nettoleistung_ref_kum_VJ <> 0 THEN (Nettoleistung_ref_kum - Nettoleistung_ref_kum_VJ) / Nettoleistung_ref_kum_VJ * 100 ELSE NULL END AS Nettoleistung_ref_kum_DeltaVJ
   , NULL AS Nettoleistung_kum_DeltaVJ_DeltaRef --,Nettoleistung_kum_DeltaVJ - Nettoleistung_ref_kum_DeltaVJ AS Nettoleistung_kum_DeltaVJ_DeltaRef
   , v01.umsatz_netto_kum - v01.ek_mep_kum AS Ertrag_kum, v01.umsatz_netto_vp_kum - v01.ek_mep_vp_kum AS Ertrag_kum_VJ, CASE WHEN Ertrag_kum_VJ <> 0 THEN TRUNC( (Ertrag_kum - Ertrag_kum_VJ) / Ertrag_kum_VJ) * 100 ELSE NULL END AS Ertrag_kum_DeltaVJ, v03.umsatz_netto_kum - v03.ek_mep_kum AS Ertrag_kum_ref, v03.umsatz_netto_vp_kum - v03.ek_mep_vp_kum AS Ertrag_kum_ref_VJ, CASE WHEN Ertrag_kum_ref_VJ <> 0 THEN TRUNC( (Ertrag_kum_ref - Ertrag_kum_ref_VJ) / Ertrag_kum_ref_VJ) * 100 ELSE NULL END AS Ertrag_kum_ref_DeltaVJ, Ertrag_kum_DeltaVJ - Ertrag_kum_ref_DeltaVJ AS Ertrag_kum_DeltaVJ_DeltaRef, CASE WHEN v01.umsatz_netto_kum <> 0 THEN TRUNC( (v01.umsatz_netto_kum - v01.ek_mep_kum) / v01.umsatz_netto_kum) ELSE NULL END AS mep_spanne_kum, CASE WHEN v01.umsatz_netto_vp_kum <> 0 THEN TRUNC( (v01.umsatz_netto_vp_kum - v01.ek_mep_vp_kum) / v01.umsatz_netto_vp_kum) ELSE NULL END AS mep_spanne_kum_VJ, mep_spanne_kum - mep_spanne_kum_VJ AS mep_spanne_kum_DeltaVJ, CASE WHEN v03.umsatz_netto_kum <> 0 THEN TRUNC(  (v03.umsatz_netto_kum - v03.ek_mep_kum) / v03.umsatz_netto_kum) ELSE NULL END AS mep_spanne_ref_kum, CASE WHEN v03.umsatz_netto_vp_kum <> 0 THEN TRUNC( (v03.umsatz_netto_vp_kum - v03.ek_mep_vp_kum) / v03.umsatz_netto_vp_kum) ELSE NULL END AS mep_spanne_ref_kum_VJ, mep_spanne_ref_kum - mep_spanne_ref_kum_VJ AS mep_spanne_ref_kum_DeltaVJ, mep_spanne_kum_DeltaVJ - mep_spanne_ref_kum_DeltaVJ AS mep_spanne_kum_DeltaVJ_DeltaRef, v01.umsatz_netto AS Umsatz_netto, v01.umsatz_netto_vp AS Umsatz_netto_VJ, CASE WHEN v01.umsatz_netto_vp <> 0 THEN TRUNC( (v01.umsatz_netto - v01.umsatz_netto_vp) / v01.umsatz_netto_vp) * 100 ELSE NULL END AS Umsatz_netto_DeltaVJ, v03.umsatz_netto AS Umsatz_netto_ref, v03.umsatz_netto_vp AS Umsatz_netto_ref_VJ, CASE WHEN v03.umsatz_netto_vp <> 0 THEN TRUNC( (v03.umsatz_netto - v03.umsatz_netto_vp) / v03.umsatz_netto_vp) * 100 ELSE NULL END AS Umsatz_netto_ref_DeltaVJ, Umsatz_netto_DeltaVJ - Umsatz_netto_ref_DeltaVJ AS Umsatz_netto_DeltaVJ_DeltaRef, v01.umsatz_netto_sa AS Umsatz_netto_sa, v01.umsatz_netto_sa_vp AS Umsatz_netto_sa_VJ, CASE WHEN v01.umsatz_netto_sa_vp <> 0 THEN TRUNC( (v01.umsatz_netto_sa - v01.umsatz_netto_sa_vp) / v01.umsatz_netto_sa_vp) * 100 ELSE NULL END AS Umsatz_netto_sa_DeltaVJ, v03.umsatz_netto_sa AS Umsatz_netto_sa_ref, v03.umsatz_netto_sa_vp AS Umsatz_netto_sa_ref_VJ, CASE WHEN v03.umsatz_netto_sa_vp <> 0 THEN TRUNC( (v03.umsatz_netto_sa - v03.umsatz_netto_sa_vp) / v03.umsatz_netto_sa_vp) * 100 ELSE NULL END AS Umsatz_netto_sa_ref_DeltaVJ, Umsatz_netto_sa_DeltaVJ - Umsatz_netto_sa_ref_DeltaVJ AS Umsatz_netto_sa_DeltaVJ_DeltaRef, NULL AS Kunden_anzahl --,v01.bonanzahl_sug AS Kunden_anzahl
   , NULL AS Kunden_anzahl_VJ --,v01.bonanzahl_sug_vp AS Kunden_anzahl_VJ
   , NULL AS Kunden_anzahl_DeltaVJ --,CASE WHEN v01.bonanzahl_sug_vp <> 0 THEN (v01.bonanzahl_sug - v01.bonanzahl_sug_vp) / v01.bonanzahl_sug_vp * 100 ELSE NULL END AS Kunden_anzahl_DeltaVJ
   , NULL AS Kunden_anzahl_ref --,v03.bonanzahl_sug AS Kunden_anzahl_ref
   , NULL AS Kunden_anzahl_ref_VJ --,v03.bonanzahl_sug_vp AS Kunden_anzahl_ref_VJ
   , NULL AS Kunden_anzahl_ref_DeltaVJ --,CASE WHEN v03.bonanzahl_sug_vp <> 0 THEN (v03.bonanzahl_sug - v03.bonanzahl_sug_vp) / v03.bonanzahl_sug_vp * 100 ELSE NULL END AS Kunden_anzahl_ref_DeltaVJ
   , NULL AS Kunden_anzahl_DeltaVJ_DeltaRef --,Kunden_anzahl_DeltaVJ - Kunden_anzahl_ref_DeltaVJ AS Kunden_anzahl_DeltaVJ_DeltaRef
   , NULL AS VIS_Umsatz_netto --,v01.vis_umsatz_netto AS VIS_Umsatz_netto
   , NULL AS VIS_Umsatz_netto_VJ --,v01.vis_umsatz_netto_vp AS VIS_Umsatz_netto_VJ
   , NULL AS VIS_Umsatz_netto_DeltaVJ --,CASE WHEN v01.vis_umsatz_netto_vp <> 0 THEN (v01.vis_umsatz_netto - v01.vis_umsatz_netto_vp) / v01.vis_umsatz_netto_vp * 100 ELSE NULL END AS VIS_Umsatz_netto_DeltaVJ
   , NULL AS VIS_Umsatz_netto_ref --,v03.vis_umsatz_netto AS VIS_Umsatz_netto_ref
   , NULL AS VIS_Umsatz_netto_ref_VJ --,v03.vis_umsatz_netto_vp AS VIS_Umsatz_netto_ref_VJ
   , NULL AS VIS_Umsatz_netto_ref_DeltaVJ --,CASE WHEN v03.vis_umsatz_netto_vp <> 0 THEN (v03.vis_umsatz_netto - v03.vis_umsatz_netto_vp) / v03.vis_umsatz_netto_vp * 100 ELSE NULL END AS VIS_Umsatz_netto_ref_DeltaVJ
   , NULL AS VIS_Umsatz_netto_DeltaVJ_DeltaRef --,VIS_Umsatz_netto_DeltaVJ - VIS_Umsatz_netto_ref_DeltaVJ AS VIS_Umsatz_netto_DeltaVJ_DeltaRef
   , NULL AS Nettostunden --,v01.vis_netto_stunden AS Nettostunden
   , NULL AS Nettostunden_VJ --,v01.vis_netto_stunden_vp AS Nettostunden_VJ
   , NULL AS Nettostunden_DeltaVJ --,CASE WHEN Nettostunden_VJ <> 0 THEN (Nettostunden - Nettostunden_VJ) / Nettostunden_VJ * 100 ELSE NULL END AS Nettostunden_DeltaVJ
   , NULL AS Nettostunden_ref --,v03.vis_netto_stunden AS Nettostunden_ref
   , NULL AS Nettostunden_ref_VJ --,v03.vis_netto_stunden_vp_kum AS Nettostunden_ref_VJ
   , NULL AS Nettostunden_ref_DeltaVJ --,CASE WHEN Nettostunden_ref_VJ <> 0 THEN (Nettostunden_ref - Nettostunden_ref_VJ) / Nettostunden_ref_VJ * 100 ELSE NULL END AS Nettostunden_ref_DeltaVJ
   , NULL AS Nettostunden_DeltaVJ_DeltaRef --,Nettostunden_DeltaVJ - Nettostunden_ref_DeltaVJ AS Nettostunden_DeltaVJ_DeltaRef
   , NULL AS Nettoleistung --,CASE WHEN v01.vis_netto_stunden <> 0 THEN v01.vis_umsatz_netto / v01.vis_netto_stunden ELSE NULL END AS Nettoleistung
   , NULL AS Nettoleistung_VJ --,CASE WHEN v01.vis_netto_stunden_vp <> 0 THEN v01.vis_umsatz_netto_vp / v01.vis_netto_stunden_vp ELSE NULL END AS Nettoleistung_VJ
   , NULL AS Nettoleistung_DeltaVJ --,CASE WHEN Nettoleistung_VJ <> 0 THEN (Nettoleistung - Nettoleistung_VJ) / Nettoleistung_VJ * 100 ELSE NULL END AS Nettoleistung_DeltaVJ
   , NULL AS Nettoleistung_ref --,CASE WHEN v03.vis_netto_stunden <> 0 THEN v03.vis_umsatz_netto / v03.vis_netto_stunden ELSE NULL END AS Nettoleistung_ref
   , NULL AS Nettoleistung_ref_VJ --,CASE WHEN v03.vis_netto_stunden_vp <> 0 THEN v03.vis_umsatz_netto_vp / v03.vis_netto_stunden_vp ELSE NULL END AS Nettoleistung_ref_VJ
   , NULL AS Nettoleistung_ref_DeltaVJ --,CASE WHEN Nettoleistung_ref_VJ <> 0 THEN (Nettoleistung_ref - Nettoleistung_ref_VJ) / Nettoleistung_ref_VJ * 100 ELSE NULL END AS Nettoleistung_ref_DeltaVJ
   , NULL AS Nettoleistung_DeltaVJ_DeltaRef --,Nettoleistung_DeltaVJ - Nettoleistung_ref_DeltaVJ AS Nettoleistung_DeltaVJ_DeltaRef
   , v01.umsatz_netto - v01.ek_mep AS Ertrag, v01.umsatz_netto_vp - v01.ek_mep_vp AS Ertrag_VJ, CASE WHEN Ertrag_VJ <> 0 THEN TRUNC( (Ertrag - Ertrag_VJ) / Ertrag_VJ) * 100 ELSE NULL END AS Ertrag_DeltaVJ, v03.umsatz_netto - v03.ek_mep AS Ertrag_ref, v03.umsatz_netto_vp - v03.ek_mep_vp AS Ertrag_ref_VJ, CASE WHEN Ertrag_ref_VJ <> 0 THEN TRUNC( (Ertrag_ref - Ertrag_ref_VJ) / Ertrag_ref_VJ) * 100 ELSE NULL END AS Ertrag_ref_DeltaVJ, Ertrag_DeltaVJ - Ertrag_ref_DeltaVJ AS Ertrag_DeltaVJ_DeltaRef, CASE WHEN v01.umsatz_netto <> 0 THEN TRUNC( (v01.umsatz_netto - v01.ek_mep) / v01.umsatz_netto) ELSE NULL END AS mep_spanne, CASE WHEN v01.umsatz_netto_vp <> 0 THEN TRUNC( (v01.umsatz_netto_vp - v01.ek_mep_vp) / v01.umsatz_netto_vp) ELSE NULL END AS mep_spanne_VJ, mep_spanne - mep_spanne_VJ AS mep_spanne_DeltaVJ, CASE WHEN v03.umsatz_netto <> 0 THEN TRUNC(  (v03.umsatz_netto - v03.ek_mep) / v03.umsatz_netto) ELSE NULL END AS mep_spanne_ref, CASE WHEN v03.umsatz_netto_vp <> 0 THEN TRUNC( (v03.umsatz_netto_vp - v03.ek_mep_vp) / v03.umsatz_netto_vp) ELSE NULL END AS mep_spanne_ref_VJ, mep_spanne_ref - mep_spanne_ref_VJ AS mep_spanne_ref_DeltaVJ, mep_spanne_DeltaVJ - mep_spanne_ref_DeltaVJ AS mep_spanne_DeltaVJ_DeltaRef

   FROM dbp_view.v_ims_mamo_wup_mo_sum_1 v01
   INNER JOIN dbp_view.v_ims_mamo_wup_qualifier_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   INNER JOIN dbp_view.v_ims_mamo_wup_qualifier_mo_sum_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND v01.nb_id = v03.nb_id
   AND v01.kjmo = v03.kjmo
   AND v01.hwg_id = v03.hwg_id
   INNER JOIN dbp_view.v_wup_1 v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   INNER JOIN dbp_view.v_ims_mamo_qualifier_1 v05
   ON v02.mandant_id = v05.mandant_id
   AND v02.qualifier_id = v05.qualifier_id
   INNER JOIN dbp_view.v_ims_mamo_wup_massnahme_per_1 v06
   ON v01.mandant_id = v06.mandant_id
   AND v01.wup_id = v06.wup_id
   AND v01.nb_id = v06.nb_id
   AND v06.modernisierung_art = 'MM_1';