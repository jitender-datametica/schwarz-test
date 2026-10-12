CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_DAT_EK_CP_SUM_ABSCH_DE_2(
	MANDANT_ID,
	ART_ID,
	BEWART_ID,
	BEWART_DET_ID,
	WUP_ID,
	NB_ID,
	DAT,
	WRG_ID,
	PREIS_ABSCHRIFT_NETTO,
   POSTEN_ID_PER,
	POSTEN_KZ_PER
) AS
   SELECT
   v01.mandant_id
   ,v01.art_id
   ,v01.bewart_id
   ,v01.bewart_det_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.dat
   ,v01.wrg_id
   ,v01.preis_abschrift_netto
   --Erweiterung um Posten_id und Posten_KZ - NSR4967339 prescherad 14.01.2025
   ,CASE
        WHEN v01.BEWART_ID = 1001
        AND v02.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN ''
        ELSE 'PN'
    END  AS POSTEN_ID_PER
    ,CASE
        WHEN v02.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO'
        ELSE 'PN'
    END AS POSTEN_KZ_PER

   FROM dbp_view.v_artbew_dat_ek_cp_sum_2 v01
   
   LEFT JOIN dbp_view.v_art_per_2 v02
   ON (v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat BETWEEN v02.dat_von-1 AND v02.dat_bis-1)
  
   WHERE wup_bereinigt_fg = 0
   AND v01.mandant_id = 1;