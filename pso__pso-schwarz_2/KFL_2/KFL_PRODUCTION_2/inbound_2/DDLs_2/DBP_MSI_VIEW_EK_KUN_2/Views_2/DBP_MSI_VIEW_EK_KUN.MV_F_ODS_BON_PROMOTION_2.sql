CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_F_ODS_BON_PROMOTION_2
-- AP0105214, SPEC0138698 - currency conversion added
-- AP0112499/SPEC0168243 sschuecke 27.09.2022
(
 mandant_id
,bon_id
,wrg_id
,wup_id
,bon_zeile
,bonuskauf_id
,konditionsart_id
,promotion_lfd_nr
,kl_art_id
,start_bon_zeile
,bon_dat
,menge_promo
,umsatz_promo_brutto
,betrag_promo_brutto
) 
AS
SELECT
 v01.mandant_id
,v01.bon_id
-- Ermittlung wrg_id durch Join auf ods_bon_kopf_2
-- Ermittlung wrg_id für Anzeige pro wrg_typ_id
,CASE WHEN v03.wrg_typ_id = 0 THEN v300.nach_wrg_id ELSE v05.default_wrg END AS wrg_id
,v01.wup_id
,v01.bon_zeile
,v01.bonuskauf_id
,v01.konditionsart_id
,v01.promotion_lfd_nr
,v01.kl_art_id
,v01.start_bon_zeile
,TO_CHAR(v01.START_BON_ZEILE,'YYYY-MM_2-DD') AS BON_DAT
,SUM(v01.menge_promo) AS menge_promo
-- AP0202325/SPEC0292700 Umstellung auf akt. Berichtskurs (vorher Tageskurs) / sschuecke 04.02.2025
-- Anpassung Ermittlung Werte für Rückrechnung HRK nach Umstellung auf EUR / funktioniert auch bei Umstellung weiterer Mandanten
,SUM (CASE WHEN v02.wrg_id <> 'EUR' AND v05.default_wrg = 'EUR' THEN v01.umsatz_promo_brutto * v300.umrechnungskurs 
		   WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN v01.umsatz_promo_brutto * v300.umrechnungskurs
           WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN v01.umsatz_promo_brutto * v400.umrechnungskurs
		   ELSE v01.umsatz_promo_brutto END) AS umsatz_promo_brutto

,SUM (CASE WHEN v02.wrg_id <> 'EUR' AND v05.default_wrg = 'EUR' THEN v01.betrag_promo_brutto * v300.umrechnungskurs 
		   WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN v01.betrag_promo_brutto * v300.umrechnungskurs
           WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN v01.betrag_promo_brutto * v400.umrechnungskurs
		   ELSE v01.betrag_promo_brutto END) AS betrag_promo_brutto

FROM dbp_v_ods.v_ods_promotion_2 v01
JOIN dbp_v_ods.v_ods_bon_kopf_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.bon_id = v02.bon_id
AND v01.wup_id = v02.wup_id
AND v01.bon_dat = v02.bon_dat

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v03
  
/*JOIN dbp_view.v_kurs_2 v04
ON v02.bon_dat BETWEEN v04.dat_von AND v04.dat_bis
AND v02.wrg_id = v04.von_wrg_id
AND v04.kurstyp_id = 9		-- (9= Tageskurs, 3= Berichtskurs)
AND v04.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_2 v400
   ON v02.bon_dat BETWEEN v400.dat_von AND v400.dat_bis
   AND wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

-- Join auf mandant_2 zwecks Ermittlung default_wrg
JOIN dbp_view.v_mandant_2 v05
ON v01.mandant_id = v05.mandant_id

GROUP BY
 v01.mandant_id
,v01.bon_id
,v01.wup_id
,v01.bon_zeile
,v01.bonuskauf_id
,v01.konditionsart_id
,v01.promotion_lfd_nr
,v01.kl_art_id
,v01.start_bon_zeile
,v300.nach_wrg_id
,v05.default_wrg
,v03.wrg_typ_id;
