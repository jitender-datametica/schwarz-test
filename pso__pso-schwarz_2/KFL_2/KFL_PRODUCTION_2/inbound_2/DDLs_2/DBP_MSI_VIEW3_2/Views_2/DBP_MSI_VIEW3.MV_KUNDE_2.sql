CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_KUNDE_2(
	KUNDE_ID,
	AKTUELL_WUP_ID,
	IS_AKT_WUP_ID_FG,
	MANDANT_ID_KUNDE,
	NB_ID,
	KUNDE_BEZ,
	DAT_VON,
	DAT_BIS,
	BUCHUNGSKREIS_ID,
	VERKAUFSORGANISATION_ID,
	WUP_TYP_ID,
	NACHT_ANLIEFERUNG_FLG,
	BREITENGRAD,
	LAENGENGRAD
) AS

-- 2015.09.01. srom0404: INC0480245, Erweiterung um Gastro-Betriebe (nb_id = 2)
--                       laengengrad und breitengrad auch gleich mitgenommen
--2024-01-31, INC7963291, dknop, adding  wup_id='-3' 
--2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id, is_akt_wup_id_fg

   SELECT
   v01.wup_id, aktuell_wup_id, CASE WHEN aktuell_wup_id = v01.wup_id THEN 1 ELSE 0 END AS is_akt_wup_id_fg, v01.mandant_id, v01.nb_id, CASE WHEN v01.nb_id = -1 THEN '---' ELSE v01.wup_standort END AS kunde_bez, v01.dat_von, v01.dat_bis, v01.buchungskreis_id, v01.verkaufsorganisation_id, v01.wup_typ_id, COALESCE(v02.nacht_anlieferung_flg,0) AS nacht_anlieferung_flg, v01.breitengrad, v01.laengengrad
   FROM dbp_view.v_wup_2 v01
   LEFT JOIN (SELECT  t1.mandant_id, t2.wup_id, 1 AS nacht_anlieferung_flg
   FROM dbp_view.v_ginfo_flaeche_per_2 t1_2
   INNER JOIN dbp_view.v_techn_platz_per_2 t2
   ON t1.mandant_id = t2.mandant_id
   AND t1.techn_platz_id = t2.techn_platz_id
   WHERE t1.ginfo_flaeche_typ_id = 'SNF'
   AND t1.ginfo_flaeche_id = '04.04'
   AND t1.ginfo_flaeche_brutto > 0
   AND t1.dat_bis = '9999-12-31'
   AND t2.dat_bis = '9999-12-31'
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   WHERE (v01.nb_id IN (2, 0, -111) AND v01.wup_id > 0)
   OR (v01.nb_id = -1 AND v01.wup_id = 0)
   
   UNION
 
   SELECT
  -3 AS wup_id
  ,-3 AS aktuell_wup_id
  ,1
  ,mandant_id
  ,-1 AS nb_id
  ,'nicht numerisch oder leer' AS kunde_bez
  ,TO_DATE('2000-01-01') AS dat_von
  ,TO_DATE('9999-12-31') AS dat_bis
  ,NULL AS buchungskreis_id
  ,NULL AS verkaufsorganisation_id
  ,0 AS wup_typ_id
  ,0 AS nacht_anlieferung_flg
  ,NULL AS breitengrad
  ,NULL AS laengengrad
  
  FROM dbp_view.v_mandant_2
  
   
   ;