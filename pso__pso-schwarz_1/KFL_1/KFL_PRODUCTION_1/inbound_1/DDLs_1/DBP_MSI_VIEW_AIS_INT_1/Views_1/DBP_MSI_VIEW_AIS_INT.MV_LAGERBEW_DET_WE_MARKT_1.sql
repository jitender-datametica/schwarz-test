CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_LAGERBEW_DET_WE_MARKT_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	GP_ID,
	WE_MARKT_WE_VZ,
	WE_MARKT_WE_VZ_RET,
	WE_MARKT_WE_VZ_INKL_RET,
	WE_MARKT_VZ_VKN,
	WE_MARKT_VZ_VKN_RET,
	WE_MARKT_VZ_VKN_INKL_RET,
	POSTEN_KZ_PER
) AS
   --AP0210596/SPEC0280480 Erweiterung um Spalte gp_id / prescherad 16.12.2024
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.dat_buch AS dat,
   v01.gp_id,
  SUM(CASE WHEN v01.lager_bewart_id IN ('641', '647','301','311') THEN ABS(v01.menge_lagerbew_bme) ELSE 0 END) AS we_markt_we_vz,
  SUM(CASE WHEN v01.lager_bewart_id IN ('642', '648','302','312') THEN -1 * ABS(v01.menge_lagerbew_bme) ELSE 0 END) AS we_markt_we_vz_ret,
  we_markt_we_vz + we_markt_we_vz_ret AS we_markt_we_vz_inkl_ret,
  -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
  SUM( CASE
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 1 THEN  ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v05.umrechnungskurs * ABS(v01.betrag_vk_netto) 
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v06.umrechnungskurs * ABS(v01.betrag_vk_netto) 
  ELSE 0 END) AS we_markt_vz_vkn,
  SUM( CASE 
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 1 THEN -1 *ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v05.umrechnungskurs *ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v06.umrechnungskurs *ABS(v01.betrag_vk_netto)
  ELSE 0 END ) AS we_markt_vz_vkn_ret,
  we_markt_vz_vkn + we_markt_vz_vkn_ret AS we_markt_vz_vkn_inkl_ret,
  CASE
    WHEN v07.POSTEN_ID NOT IN ('1') THEN 'SO'
    ELSE 'PN'
  END :: CHAR(2) AS posten_kz_per
  
  FROM dbp_view.v_lagerbew_det_1 AS v01

  JOIN dbp_view.v_wup_1 AS v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   JOIN dbp_view.v_wup_1 AS v03
   ON v01.mandant_id_empfaenger = v03.mandant_id
   AND v01.empfaenger_id = v03.wup_id
   
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v04

   /*JOIN dbp_view.v_kurs_1 AS v05
   ON v01.wrg_id = v05.von_wrg_id
   AND v01.dat_buch BETWEEN v05.dat_von AND v05.dat_bis
   AND v05.kurstyp_id = 9
   AND v05.nach_wrg_id = 'EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v05
   ON v05.dat_bis = '9999-12-31'
   AND v01.wrg_id = v05.von_wrg_id
   AND v05.kurstyp_id = 3
   AND v05.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v06
   ON v01.dat_buch BETWEEN v06.dat_von AND v06.dat_bis
   AND v01.wrg_id = v06.von_wrg_id
   AND v06.kurstyp_id = 3
   AND v06.nach_wrg_id ='EUR'

   LEFT JOIN dbp_view.v_art_per_1 v07
	ON v01.art_id = v07.art_id
	AND v01.mandant_id = v07.mandant_id
	AND v01.dat_buch BETWEEN v07.dat_von-1 AND v07.dat_bis-1 

   WHERE v01.mandant_id <> 1
   AND v03.nb_id = -111 -- Empfaenger muss VZ sein
   AND v01.lager_bewart_id IN ('641', '647','301','311','642', '648','302','312')
   GROUP BY v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.dat_buch,
   v01.gp_id,
   posten_kz_per

   ----- DE 
   UNION ALL 
   SELECT mandant_id, 
           wup_id,
           nb_id,
           art_id,
           dat,
		   gp_id,
           SUM(faktura_menge_bme) AS we_markt_we_vz,
           SUM(faktura_menge_bme_ret) AS we_markt_we_vz_ret,
           we_markt_we_vz + we_markt_we_vz_ret AS we_markt_we_vz_inkl_ret,
           SUM(faktura_wert_ek_netto) AS we_markt_vz_vkn,
           SUM(faktura_wert_ek_netto_ret) AS we_markt_vz_vkn_ret,
           we_markt_vz_vkn + we_markt_vz_vkn_ret AS we_markt_vz_vkn_inkl_ret,
           posten_kz_per
           FROM
           (SELECT
             v01.mandant_id
            , v03.wup_id 
            , v03.nb_id
            , v01.art_id
            , CASE WHEN v08.hwg_id = 64 THEN v01.dat_preisfindung ELSE v01.dat_faktura END AS dat
			, v09.gp_id
            , (CASE WHEN v02.faktura_typ_id = 'N' THEN v01.menge_faktura_bme * -1 
                WHEN v02.faktura_typ_id NOT IN ('O','S') THEN  v01.menge_faktura_bme ELSE 0 END)::DECIMAL(18,3) AS faktura_menge_bme
            , (CASE WHEN v02.faktura_typ_id = 'O' THEN v01.menge_faktura_bme * -1 
                 WHEN v02.faktura_typ_id = 'S' THEN  v01.menge_faktura_bme ELSE 0 END)::DECIMAL(18,3) AS faktura_menge_bme_ret
            , (CASE WHEN v02.faktura_typ_id = 'N' THEN(v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * -1
                WHEN v02.faktura_typ_id NOT IN ('O','S') THEN  (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) ELSE 0 END)::DECIMAL(18,3) AS faktura_wert_ek_netto
            , (CASE WHEN v02.faktura_typ_id = 'O' THEN(v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * -1
            WHEN v02.faktura_typ_id = 'S' THEN  (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) ELSE 0 END)::DECIMAL(18,3) AS faktura_wert_ek_netto_ret

            ,CASE
                WHEN v10.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
                ELSE 'PN'
            END :: CHAR(2) AS POSTEN_KZ_PER
            FROM dbp_view.v_besch_faktura_det_1 v01
            
            JOIN dbp_view.v_besch_faktura_1 v02
            ON v01.faktura_beleg_id=v02.faktura_beleg_id
            AND v01.mandant_id = v02.mandant_id
            AND v01.dat_faktura_sap = v02.dat_faktura_sap
            AND v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'
            
            
            JOIN dbp_view.v_wup_1 v03
            ON TRY_CAST (v02.auftraggeber_id AS INTEGER) = v03.wup_id
            AND v01.mandant_id = v03.mandant_id
            
            JOIN dbp_view.v_art_wg_zu_per_1 v05
            ON v01.art_id = v05.art_id
            AND v01.mandant_id = v05.mandant_id
            AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis
            
            JOIN dbp_view.v_wg_per_1 v06
            ON v05.wg_id = v06.wg_id
            AND v05.mandant_id = v06.mandant_id
            AND CURRENT_DATE BETWEEN v06.dat_von AND v06.dat_bis
            
            JOIN dbp_view.v_owg_per_1 v07
            ON v06.owg_id = v07.owg_id
            AND v06.mandant_id = v07.mandant_id
            AND CURRENT_DATE BETWEEN v07.dat_von AND v07.dat_bis
            
            JOIN dbp_view.v_hwg_per_1 v08
            ON v07.hwg_id = v08.hwg_id
            AND v07.mandant_id = v08.mandant_id
            AND CURRENT_DATE BETWEEN v08.dat_von AND v08.dat_bis
            
            JOIN dbp_view.v_art_gp_nm_zu_per_1 v09
            ON v01.art_id = v09.art_id AND v01.wup_id = v09.wup_id AND dat BETWEEN v09.dat_von AND v09.dat_bis
            AND v01.mandant_id = v09.mandant_id
            --AND v01.dat_preisfindung BETWEEN v09.dat_von AND v09.dat_bis
            --AND v08.hwg_id = 64
            
            LEFT JOIN dbp_view.v_art_per_1 v10
            ON v01.art_id = v10.art_id
            AND v01.mandant_id = v10.mandant_id
            AND v01.dat_faktura BETWEEN v10.dat_von-1 AND v10.dat_bis-1 
            
            WHERE v01.mandant_id = 1
            -- 20100330 Filterung der IWT Fakturen
            AND v02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
            AND v01.nb_id <> 99
            AND ((v08.hwg_id = 64 AND v01.dat_preisfindung BETWEEN v09.dat_von AND v09.dat_bis)
            OR (v08.hwg_id != 64 AND v01.dat_faktura BETWEEN v09.dat_von AND v09.dat_bis))
        
        UNION ALL
        
           SELECT
           v01.mandant_id, 
           v02.wup_id, 
           v02.nb_id, 
           v01.art_id, 
           v01.dat_faktura AS dat,
           v03.gp_id ,
           
           CASE WHEN v01.menge_fakturiert > 0 THEN v01.menge_fakturiert ELSE 0 END AS menge_fakturiert, 
           CASE WHEN v01.menge_fakturiert < 0 THEN v01.menge_fakturiert ELSE 0 END AS menge_fakturiert_ret,

           CASE WHEN v01.zwsum_3_betrag > 0 THEN v01.zwsum_3_betrag ELSE 0 END AS md_faktura_ek_n, 
           CASE WHEN v01.zwsum_3_betrag < 0 THEN v01.zwsum_3_betrag ELSE 0 END AS md_faktura_ek_n_ret,

            CASE
            WHEN v06.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
            ELSE 'PN'
           END :: CHAR(2) AS POSTEN_KZ_PER
           FROM dbp_view.v_besch_faktura_medata_1 v01
        
           JOIN dbp_view.v_wup_1 v02
           ON v01.faktura_markt = v02.wup_id
           AND v01.mandant_id = v02.mandant_id
        
           JOIN dbp_view.v_art_gp_nm_zu_per_1 v03
           ON v01.art_id = v03.art_id
           AND v01.mandant_id = v03.mandant_id
           AND v01.dat_faktura BETWEEN v03.dat_von AND v03.dat_bis
           AND v01.wup_id = v03.wup_id
        
           JOIN dbp_view.v_art_1 v04
           ON v01.art_id = v04.art_id
           AND v01.mandant_id = v04.mandant_id
        
           JOIN dbp_view.v_mwst_per_1 v05
           ON v04.mwst_id = v05.mwst_id
           AND v04.mandant_id = v05.mandant_id
           AND v01.dat_faktura BETWEEN v05.dat_von AND v05.dat_bis
        
           LEFT JOIN dbp_view.v_art_per_1 v06
           ON v01.art_id = v06.art_id
           AND v01.mandant_id = v06.mandant_id
           AND v01.dat_faktura BETWEEN v06.dat_von-1 AND v06.dat_bis-1 
        
           WHERE v01.mandant_id = 1) AS DE_WE_Markt 
           GROUP BY mandant_id, 
           wup_id,
           nb_id,
           art_id,
           dat,
		   gp_id,
           posten_kz_per;