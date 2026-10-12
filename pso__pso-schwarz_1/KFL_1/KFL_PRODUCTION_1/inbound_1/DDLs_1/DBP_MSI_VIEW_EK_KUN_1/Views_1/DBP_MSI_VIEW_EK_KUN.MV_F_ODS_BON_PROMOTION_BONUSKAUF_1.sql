CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_F_ODS_BON_PROMOTION_BONUSKAUF_1
--AP0144054/SPEC0168968 Redesign Entfernen nicht verwendeter Felder - sschuecke 03.11.2022
(
 mandant_id
,bonuskauf_id
,bon_dat
,wrg_id
,menge_promo
,umsatz_promo_brutto
) 
AS
SELECT
 v01.mandant_id
,v01.bonuskauf_id
-- Anpassung Format, da nicht passend zu mv_cos_coupon_1 / ssch1303 29.12.2023
--,TO_CHAR(v01.START_BON_ZEILE,'YYYY-MM_1-DD') AS BON_DAT
,TO_DATE (v01.start_bon_zeile) AS bon_dat
,CASE WHEN v04.wrg_typ_id = 0 THEN v05.nach_wrg_id ELSE v06.DEFAULT_WRG END AS wrg_id
,SUM(CASE WHEN v03.bonuskauf_partner_fg = 0 THEN v01.menge_promo ELSE 0 END) AS menge_promo
,SUM(CASE WHEN v02.wrg_id <> 'EUR' AND v06.default_wrg = 'EUR' AND  v03.bonuskauf_partner_fg = 0 THEN v01.umsatz_promo_brutto * v05.umrechnungskurs
          WHEN v04.wrg_typ_id = 0 AND v03.bonuskauf_partner_fg = 0 THEN v01.umsatz_promo_brutto * v05.umrechnungskurs
          WHEN v04.wrg_typ_id = 1 AND v03.bonuskauf_partner_fg = 0 THEN v01.umsatz_promo_brutto ELSE 0 END) AS umsatz_promo_brutto

FROM dbp_v_ods.v_ods_promotion_1 v01
JOIN dbp_v_ods.v_ods_bon_kopf_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.bon_id = v02.bon_id
AND v01.wup_id = v02.wup_id
AND v01.bon_dat = v02.bon_dat
JOIN DBP_VIEW.V_COS_BONUSKAUF_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.bonuskauf_id = v03.bonuskauf_id

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v04
  
JOIN dbp_view.v_kurs_1 v05
ON v02.BON_DAT BETWEEN v05.dat_von AND v05.dat_bis
AND v02.wrg_id = v05.von_wrg_id
AND v05.kurstyp_id = 9 -- (9= Tageskurs, 3= Berichtskurs)
AND v05.nach_wrg_id ='EUR'

JOIN dbp_view.v_mandant_1 v06
ON v01.mandant_id = v06.mandant_id

GROUP BY
 v01.mandant_id
,v01.bonuskauf_id
,v01.START_BON_ZEILE
,v05.nach_wrg_id
,v06.default_wrg
,v04.wrg_typ_id
,v03.bonuskauf_partner_fg;