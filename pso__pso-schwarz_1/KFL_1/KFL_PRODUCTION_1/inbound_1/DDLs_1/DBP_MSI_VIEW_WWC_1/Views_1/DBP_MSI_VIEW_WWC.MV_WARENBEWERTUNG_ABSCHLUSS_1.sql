CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WARENBEWERTUNG_ABSCHLUSS_1
-- 22.06.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 wup_id
,nb_id
,mandant_id
,system_id
,buchungskreis_id
,dat_aenderung
,art_id
,gp_id
,version_id
,dat_von
,dat_bis
,gld
,menge_bestand_bme
,wert_bestand
,proz_inventurfort
,betrag_inventurfort
,inventurfort_wert_bestand
,inventurfort_menge_bestand_bme
,apm_art_fg
,apm_wg
,proz_apm_art
,proz_apm_korr
,proz_apm_korr_art
,proz_apm_hwg
,proz_apm_hwg_pa
,proz_apm_ja_pa
,proz_apm_ges
,betrag_apm_art
,betrag_apm_pa
,apm_wert_bestand
,ausg_wg_nwp
,ek_34n
,inf_value
,ek_2n_1
,nw_abwert
,wnn_value
,ausg_wg_vfb
,proz_abschlag
,betrag_vk_netto_vp
,betrag_vk_wert
,betrag_abw_vf
,betrag_gesamt
,ausg_wg_rw
,dat_erster_vk
,tage
,umsatz_menge
,menge_hr
,kj_reichweite
,menge_abverkauf_gm
,proz_rw                       
,rw_abschl
,best_abw
,umsatz_lw
,abverkauf_fg
,cluster_reichweite
,cluster_reichweite_order
,sum_abw
)
AS
--NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
--18.07.2023, SPEC0204140, prescherad: Spalte Summe Abwertung ergänzt
--04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
--20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
--22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI 969006 für CZ und DE
--19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
--14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
--07.08.2025, SPEC0325089, prescherad: Aufnahme gp_id
SELECT
V01.wup_id
,V01.nb_id
,V01.mandant_id
,V01.system_id
,V01.buchungskreis_id
,V01.dat_aenderung
,V01.art_id
,V03.gp_id
,V01.version_id
,V01.dat_von
,V01.dat_bis
,V01.gld
,V01.menge_bestand_bme
,V01.wert_bestand
,V01.proz_inventurfort
,V01.betrag_inventurfort
,V01.inventurfort_wert_bestand
,V01.inventurfort_menge_bestand_bme
,V01.apm_art_fg
,V01.apm_wg
,V01.proz_apm_art
,V01.proz_apm_korr
,V01.proz_apm_korr_art
,V01.proz_apm_hwg
,V01.proz_apm_hwg_pa
,V01.proz_apm_ja_pa
,V01.proz_apm_ges
,V01.betrag_apm_art
,V01.betrag_apm_pa
,V01.apm_wert_bestand
,V01.ausg_wg_nwp
,V01.ek_34n
,V01.inf_value
,V01.ek_2n_1
,V01.nw_abwert
,V01.wnn_value
,V01.ausg_wg_vfb
,V01.proz_abschlag
,V01.betrag_vk_netto_vp
,V01.betrag_vk_wert
,V01.betrag_abw_vf
,V01.betrag_gesamt
,V01.ausg_wg_rw
,V01.dat_erster_vk
,V01.tage
,V01.umsatz_menge
,V01.menge_hr
,V01.kj_reichweite
,V01.menge_abverkauf_gm
,V01.proz_rw                       
,V01.rw_abschl
,V01.best_abw
,V01.umsatz_lw
,V01.abverkauf_fg
,CASE WHEN abverkauf_fg = '1' THEN 'Verk. = 0'
      WHEN kj_reichweite < 0.083 THEN 'Verk. < 1 M.'
      WHEN kj_reichweite > 0 AND kj_reichweite <= 0.5 THEN '0 - 0.5'
      WHEN kj_reichweite > 0.5 AND kj_reichweite <= 1 THEN '0.5 - 1'
      WHEN kj_reichweite > 1 AND kj_reichweite <= 2 THEN '1 - 2'
      WHEN kj_reichweite > 2 AND kj_reichweite <= 3 THEN '2 - 3'
	  WHEN kj_reichweite > 3 AND kj_reichweite <= 4 THEN '3 - 4'
	  WHEN kj_reichweite > 4 AND kj_reichweite <= 5 THEN '4 - 5'
	  WHEN kj_reichweite > 5 AND kj_reichweite <= 6 THEN '5 - 6'
	  WHEN kj_reichweite > 6 AND kj_reichweite <= 7 THEN '6 - 7'
	  WHEN kj_reichweite > 7 AND kj_reichweite <= 8 THEN '7 - 8'
	  WHEN kj_reichweite > 8 AND kj_reichweite <= 9 THEN '8 - 9'
	  WHEN kj_reichweite > 9 THEN '> 9'
 END AS cluster_reichweite
,CASE WHEN abverkauf_fg = '1' THEN 2
      WHEN kj_reichweite < 0.083 THEN 1
      WHEN kj_reichweite > 0 AND kj_reichweite <= 0.5 THEN 3
      WHEN kj_reichweite > 0.5 AND kj_reichweite <= 1 THEN 4
      WHEN kj_reichweite > 1 AND kj_reichweite <= 2 THEN 5
      WHEN kj_reichweite > 2 AND kj_reichweite <= 3 THEN 6
	  WHEN kj_reichweite > 3 AND kj_reichweite <= 4 THEN 7
	  WHEN kj_reichweite > 4 AND kj_reichweite <= 5 THEN 8
	  WHEN kj_reichweite > 5 AND kj_reichweite <= 6 THEN 9
	  WHEN kj_reichweite > 6 AND kj_reichweite <= 7 THEN 10
	  WHEN kj_reichweite > 7 AND kj_reichweite <= 8 THEN 11
	  WHEN kj_reichweite > 8 AND kj_reichweite <= 9 THEN 12
	  WHEN kj_reichweite > 9 THEN 13
END AS cluster_reichweite_order
,V01.sum_abw 
FROM DBP_VIEW.v_warenbewertung_abschluss_1 V01

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v03
ON v01.art_id = v03.art_id
AND v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id
AND v01.dat_aenderung BETWEEN v03.dat_von AND v03.dat_bis

--Suhsi RO ausfiltern
INNER JOIN DBP_VIEW.V_art_wg_zu_per_1 V02
ON v01.Art_ID=v02.art_id
AND v01.mandant_id = v02.mandant_id
   -- Wenn nicht Mandant_1 1,7 dann alles   
AND (v02.MANDANT_ID NOT IN (1,7)
   -- Wenn  Mandant_1 1,7 dann  kein Sushi/Shop in Shop 
      OR (V02.MANDANT_ID IN (1,7) AND TO_VARCHAR(V02.wg_id,'FM000')|| TO_VARCHAR(V02.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_1 7 dann alles   
AND (v02.MANDANT_ID != 7
   -- Wenn  Mandant_1 7 dann kein Pfand 
      OR v02.MANDANT_ID = 7 AND TO_VARCHAR(v02.wg_id,'FM000') !='980')
--Ausfiltern Shop in Shop
AND V02.wg_id!=961
--Ausfiltern E-Loading alle Mandaten ungleich 1
 AND (v02.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant_1 ungleich 1 dann ohne E-loading 
      OR (v02.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V02.wg_id,'FM000')|| TO_VARCHAR(v02.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
   )   
AND V02.arthiertyp_id = 2
AND V02.dat_bis = '9999-12-31';