create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPANNE_WB_LBD_1(
	DAT,
	BELEG_WB_ID,
	BELEG_WB_POS_ID,
	MANDANT_ID,
	SYSTEM_ID,
	ABS_ID,
	RCV_ID,
	ART_ID,
	BEW_ART_WB_ID,
	VK_BRUTTO,
	EK_NETTO,
	EK_NETTO_HYB,
	MWST,
	MWST_ID,
	SPANNE_WB_HERKUNFT_ID,
	MENGE,
	BELASTUNGSART_ID,
	BELASTUNGSART_VD_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.11.2013 twie: als 3. Teil die besch_rech_det_kont_1 dazu, um GOW (Gutschrift ohne Waren)- und ROW (Rechnung ohne Waren) -Buchungen mit auszugeben
-- 01.12.2017 twie: NSR0041699 row_grund_id ist char
-- 04.12.2017 twie: SPEC0028737 row_grund_id 158 ergänzt
-- 07.09.2018 msag SPEC0039852 row_grund_id 159 ergänzt
-- 19.10.2018 twie: SPEC0041626 Im 3. Select die Sachkonten pro MWSt ID auf eigenen Artikel_1 aufgeteilt, dem die jeweilige mwst_id zugeordnet ist.
-- 26.10.2018 twie: SPEC0041626 sap_mwst_id ist CHAR
-- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID
--17.01.2019 msag:NSR0486412 bei row_grund 158 und 159 Faktor ergänzt
--07.02.2019 msag:SPEC0047906 Ergänzung von Sachkonten ,316001 bis 312020
--27.02.2019 lwei: SPEC0067463 Buchungsdatum gegen Leistungsdatum ausgetauscht. Betrifft nur die ROWs daher letzter union.
--29.06.2020 msag SPEC0079605 Ergänzung der MWST ID's '53' und '94"" bei Leistungsdatum im Zeitraum 01.07.2020 - 31.12.2020
--21.12.2022 twie: SPEC0064436 Bei Filter auf empfaenger_id in der lagerbew_det_1 ein Coalesce eingebaut, damit NULL Einträge nicht rausfallen
--23.02.2023 twie: SPEC0064436 Filter vom 21.12.2022 nochmal aufgeteilt, Coalesce nur bei lager_bewart_id 317-320, sonst vorherige Logik behalten
--01.03.2023 twie: SPEC0064436 ek_netto Sonderlogik für Hybridbericht, dafür eigenes Feld ek_netto_hyb
--09.03.2023 twie: SPEC0064436 ek_netto Sonderlogik geändert, wird jetzt für bestimmte Bewegungsarten aus art_gp_wup_zu_per_1 geholt
--22.03.2023 twie: SPEC0064436 Da es in der art_gp_wup_zu_per_1 mehre Lieferanten pro Zeitraum geben kann, den führenden Lieferant über die art_gp_nm_zu_per_1 ermitteln
--17.08.2023 twie: SPEC0211574 Die beiden Joins auf art_gp_wup_zu_per_1 und art_gp_nm_zu_per_1 auf LEFT OUTER umstellen statt INNER, da sonst Daten für Bericht 6.04 rausfallen
--                 Dies hat wahrscheinlich zur Folge dass die Ermittlung für Bericht 6.12 nicht mehr korrekt funktioniert, wird aber in Kauf genommen da es ein produktives Problem mit 6.04 gibt
--                 Als dauerhafte Lösung ist zu überlegen in 2 Selects aufzuteilen mit getrennter Logik, für 6.12 mit Bewegungsarten 317-320 und für 6.04 mit den restlichen Bew.arten
--06.10.2023 prescherad: SPEC0211574, aufteilen auf 2 getrennte Statements (jeweils für Bericht 6.4 und 6.12)
--15.12.2023 prescherad: SPEC0211574, Preisfindungslogik analog AIS implementieren
--15.03.2024 prescherad: SPEC0211574, menge_erf durch menge_lagerbew_bme aus Quelle v_lagerbew_det_1 ersetzen
--24.04.2024 prescherad; SPEC0211574, EK Preis mit Komponentenmenge multipilizieren
--30.04.2024 prescherad; SPEC0211574, Sonderlogik für Pfand OWG 1092 einbauen

    SELECT
            v01.dat,
            TRUNC( v01.bsch_id / 10000) AS beleg_wb_id,
            CAST (v01.bsch_pos_id AS INTEGER) AS beleg_pos_id,
            v01.mandant_id,
            7 AS system_id,
            v01.gp_id AS abs_id,
            v01.wup_id AS rcv_id,
            v01.art_id,
            v01.lager_bewart_id AS bew_art_wb_id,
            CASE WHEN v01.menge_rech = 0 THEN 0 ELSE v01.vk_n * (100 + v03.mwst) / 100 END AS vk_brutto,
            v01.ek_n AS ek_netto,
			v01.ek_n AS ek_netto_hyb,
            v03.mwst,
            v03.mwst_id,
            2 AS spanne_wb_herkunft_id,
            v01.menge_rech AS menge,
            v01.lager_bewart_id AS belastungsart_id,
            1 AS belastungsart_vd_id
        FROM dbp_view.v_bsch_rech_det_1 v01

        JOIN dbp_view.v_art_1 v02
        ON v01.art_id = v02.art_id
        AND v01.mandant_id = v02.mandant_id

        JOIN dbp_view.v_mwst_per_1 v03
        ON v02.mwst_id = v03.mwst_id
        AND v02.mandant_id = v03.mandant_id
        AND v01.dat BETWEEN v03.dat_von AND v03.dat_bis

        WHERE v01.mandant_id =1

    UNION ALL

        SELECT
        v01.dat_buch,
        v01.lagerbew_beleg_id,
        v01.lagerbew_beleg_pos_id,
        v01.mandant_id,
        7 system_id,
        COALESCE(v01.empfaenger_id, 0) AS abs_id,
        v01.wup_id         AS  rcv_id,
        v01.art_id,
        v01.lager_bewart_id,
        CASE WHEN v01.betrag_verkauf = 0 THEN v01.betrag_verkauf_ist ELSE v01.betrag_verkauf END AS vk_brutto,
        CASE WHEN v02.wg_art_fg = 1 THEN v01.betrag_verkauf * 0.90 ELSE v01.betrag_lagerbew END AS ek_netto,
		--Sonderlogik für Hybridbericht für diese Bewart_1
        CASE WHEN v01.lager_bewart_id IN ('317','318','319','320') AND v01.bezugsweg_id = 1  AND v01.owg_id != 1092
             THEN (v01.ek_netto_bnk_gp * v01.komponentenmenge_gp)* v01.menge_lagerbew_bme
			 WHEN v01.lager_bewart_id IN ('317','318','319','320') AND v01.bezugsweg_id <> 1  AND v01.owg_id != 1092
             THEN COALESCE (v01.ek_netto_bnk_vz,v01.ek_netto_bnk_gp) * COALESCE(v01.komponentenmenge_vz,v01.komponentenmenge_gp) * v01.menge_lagerbew_bme 
			 WHEN v01.lager_bewart_id IN ('317','318','319','320') AND v01.owg_id = 1092 
			 THEN v01.betrag_verkauf
			 --sonst Standardlogik für ek_netto wie oben
			 WHEN v01.lager_bewart_id NOT IN ('317','318','319','320') AND v02.wg_art_fg = 1 THEN v01.betrag_verkauf * 0.90
		ELSE v01.betrag_lagerbew
		END AS ek_netto_hyb,
        v03.mwst,
        v03.mwst_id,
        2 AS spanne_wb_herkunft_id,
        v01.menge_lagerbew_bme,
        v01.lager_bewart_id AS belastungsart_id,
        1 AS belastungsart_vd_id
        FROM (
        --MCan: Folgender derived table wird per Join-Index optimiert. Bei Änderung sollten der Join-Index angepasst werden!
        --Teil für Bewegungsarten ('317','318','319','320') für Bericht 6.12 Metrik EK Preis Netto
		SELECT
            v11.dat_buch,
            v11.mandant_id,
            v11.lagerbew_beleg_id,
            v11.lagerbew_beleg_pos_id,
            v11.wup_id,
            v11.empfaenger_id,
            v11.art_id,
            v11.lager_bewart_id,
            v11.betrag_verkauf,
            v11.betrag_verkauf_ist,
            v11.betrag_vk_netto,
            v11.betrag_lagerbew,
            v11.menge_lagerbew_bme,
            ek_mapping.bezugsweg_id,
            ek_vz.ek_netto_bnk AS ek_netto_bnk_vz ,
            ek_gp.ek_netto_bnk AS ek_netto_bnk_gp,
			ek_vz.komponentenmenge AS komponentenmenge_vz,
			ek_gp.komponentenmenge AS komponentenmenge_gp,
			owg.owg_id
        FROM dbp_view.v_lagerbew_det_1 v11
        
		LEFT JOIN dbp_data.art_wg_zu_per_1 wg
		ON v11.mandant_id = wg.mandant_id 
		AND v11.art_id = wg.art_id
		AND v11.dat_buch BETWEEN wg.dat_von AND wg.dat_bis
		AND arthiertyp_id = 2

		JOIN dbp_data.wg_per_1 owg
		ON v11.mandant_id = owg.mandant_id 
		AND wg.wg_id = owg.wg_id
        AND v11.dat_buch BETWEEN owg.dat_von AND owg.dat_bis
		
        JOIN dbp_view.v_art_gp_nm_zu_per_1 ek_mapping         
        ON v11.mandant_id=ek_mapping.mandant_id
        AND v11.art_id=ek_mapping.art_id       
        AND v11.wup_ID=ek_mapping.wup_ID
        AND v11.dat_buch BETWEEN ek_mapping.dat_von AND ek_mapping.dat_bis

        LEFT OUTER JOIN  dbp_view.v_art_gp_wup_zu_per_1 ek_vz          
		ON ek_mapping.mandant_id=ek_vz.mandant_id 
		AND ek_mapping.art_id=ek_vz.art_id         
		AND ek_mapping.gp_id=ek_vz.gp_id
		AND v11.dat_buch BETWEEN ek_vz.dat_von AND ek_vz.dat_bis
		--ermittelt den auf VZ Ebene güliten EK Preis, Lieferung über Verteilzentrum 
		AND ek_mapping.vz_wup_id = ek_vz.wup_id
		AND ek_vz.wup_id > -1
 
		LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_1 ek_gp          
		ON ek_mapping.mandant_id=ek_gp.mandant_id 
		AND ek_mapping.art_id=ek_gp.art_id         
		AND ek_mapping.gp_id=ek_gp.gp_id
		AND v11.dat_buch BETWEEN ek_gp.dat_von AND ek_gp.dat_bis
		--ermittelt den denzetralen EK_Preis, Direktlieferung von Lieferant an Filiale 
		AND ek_gp.wup_id = -1
        
        WHERE v11.lager_bewart_id IN ('317','318','319','320')
        AND v11.mandant_id =  1
		
		--Teil für alle Bewegungsarten ungleich ('317','318','319','320') für Bericht 6.04 
		UNION ALL 
		
		SELECT
            v11.dat_buch,
            v11.mandant_id,
            v11.lagerbew_beleg_id,
            v11.lagerbew_beleg_pos_id,
            v11.wup_id,
            v11.empfaenger_id,
            v11.art_id,
            v11.lager_bewart_id,
            v11.betrag_verkauf,
            v11.betrag_verkauf_ist,
            v11.betrag_vk_netto,
            v11.betrag_lagerbew,
            v11.menge_lagerbew_bme,
            '0',
            '0',
            '0',
			'0',
			'0',
			'0'
	        FROM dbp_view.v_lagerbew_det_1 v11
        
        WHERE v11.lager_bewart_id IN ('101','102','161','162','301','302','303','304','901','902','905','906','907','908','912','915','916')
        AND v11.mandant_id =  1
        ) v01

        JOIN dbp_view.v_art_1 v02
            ON v01.mandant_id = v02.mandant_id AND
            v01.art_id = v02.art_id

            JOIN dbp_view.v_mwst_per_1 v03
            ON v02.mwst_id = v03.mwst_id
            AND v02.mandant_id = v03.mandant_id
            AND v01.dat_buch BETWEEN v03.dat_von AND v03.dat_bis

            WHERE
            NOT ((wup_id BETWEEN 6900 AND 6914)  OR wup_id = 9201) AND
            
            --empfaenger_id in Tabelle kann NULL sein, deshalb Coalesce um sie nicht auszufiltern
            --aber nur für Belastungsarten (lager_beart_id) 317 - 320
           ( 	((v01.lager_bewart_id BETWEEN 317 AND 320)
            	AND NOT ((COALESCE(v01.empfaenger_id, 0) BETWEEN 6900 AND 6914)  OR COALESCE(v01.empfaenger_id, 0)=9201))
            OR
			--bei allen anderen Belastungsarten sollen die Daten mit empfaenger_id = NULL weiterhin ausgefiltert werden,deshalb ohne Coalesce
            	((v01.lager_bewart_id NOT BETWEEN 317 AND 320)
            	AND NOT ((v01.empfaenger_id BETWEEN 6900 AND 6914) OR v01.empfaenger_id=9201))
            )
            
    UNION ALL

        SELECT


        -- br.dat_buch
        --Aenderung nach Ruecksprache mit Barbara Koehler; jetzt fuer RBCO-Datensaetze
        -- bzw. ROW-Gründe nur das Leistungserstellungsdatum.
        br.dat_leist_erstellung,
        brdk.rech_beleg_id AS  beleg_wb_id,
        brdk.kontierungsblock_nr AS beleg_wb_pos_id,
        brdk.mandant_id,
        7 AS system_id,
        br.gp_id AS abs_id,
        br.wup_id AS rcv_id,
        --eigener Artikel_1 pro mwst_id, dafür mwst_id abziehen
        brdk.wg_id * -1000 - v03.mwst_id AS art_id,
        'ROW' AS bew_art_wb_id,
        CASE
        WHEN brdk.row_grund_id = 158 THEN brdk.betrag_beleg*1.23*(1+(v03.mwst/100))
        WHEN brdk.row_grund_id = 159 THEN brdk.betrag_beleg*0.8*(1+(v03.mwst/100))
        ELSE brdk.betrag_beleg END AS vk_brutto,
        brdk.betrag_beleg AS ek_netto,
		brdk.betrag_beleg AS ek_netto_hyb,
        v03.mwst,
        v03.mwst_id,
        2 AS spanne_wb_herkunft_id,
        brdk.menge,
        'ROW' AS belastungsart_id,
        1 AS belastungsart_vd_id
        FROM dbp_view.v_besch_rech_det_kont_1 brdk

        JOIN dbp_view.v_besch_rech_1 br
        ON br.mandant_id = brdk.mandant_id
        AND br.rech_beleg_id = brdk.rech_beleg_id
        AND br.gj = brdk.gj

        --zur SAP MWSt. ID der Fakttabelle die DWH MWSt. ID mappen und den MWSt. Satz ermitteln
        JOIN
        dbp_view.v_mwst_per_1 v03
        ON CASE
        WHEN brdk.sap_mwst_id IN ('76', '78', '95', '96') THEN 1
        WHEN brdk.sap_mwst_id IN ('53', '55', '94', '97') THEN 2
        WHEN brdk.sap_mwst_id IN ('71', '74') THEN 3
        WHEN brdk.sap_mwst_id IN ('99') THEN 9
        ELSE 1 END = v03.mwst_id
        AND brdk.mandant_id = v03.mandant_id
        AND  br.dat_buch BETWEEN v03.dat_von AND v03.dat_bis

        WHERE brdk.mandant_id = 1

        AND RIGHT(brdk.sachkonto_id,6) IN (
        '314602'
        ,'314603'
        ,'314604'
        ,'314605'
        ,'314606'
        ,'314607'
        ,'314608'
        ,'314609'
        ,'314610'
        ,'314611'
        ,'314612'
        ,'314616'
        ,'314617'
        ,'314621'
        ,'314622'
        ,'314623'
        ,'314624'
        ,'316001'
        ,'316002'
        ,'316003'
        ,'316004'
        ,'316005'
        ,'316006'
        ,'316007'
        ,'316008'
        ,'316009'
        ,'316010'
        ,'316011'
        ,'316012'
        ,'316013'
        ,'316014'
        ,'312006'
        ,'312007'
        ,'312008'
        ,'312009'
        ,'312010'
        ,'312011'
        ,'312012'
        ,'312013'
        ,'312014'
        ,'312015'
        ,'312016'
        ,'312017'
        ,'312018'
        ,'312019'
        ,'312020'
        )

        AND brdk.row_grund_id IN (
        '100'
        ,'101'
        ,'103'
        ,'104'
        ,'105'
        ,'106'
        ,'107'
        ,'108'
        ,'109'
        ,'110'
        ,'111'
        ,'112'
        ,'114'
        ,'116'
        ,'119'
        ,'120'
        ,'142'
        ,'158'
        ,'159'
        ,'160'
        ,'161'
        ,'199'
);
