CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_F_ODS_BON_KOPF_KUNDE_TAG_SUM_2
--SPEC0055903, mcie1607, taking umsatz from crm_kartebew.
--SPEC0055903, left outer join to crm_l_konto_2
--SPEC0055903, mcie1607, 12.12.2019, added anz_bons column
--SPEC0072295, mcie1607, 12.03.2020, added join by mandant_id with crm_l_kundenkarte_2
--SPEC0066544, mcie1607, 06.04.2020, added left outer join to mv_werbewoche_kl_2
-- 24.03.2021 AP0076707, SPEC0093377, Pawel Staniszewski, add new field kjwo_ww
-- SPEC0169673 wrg_2 changed to wrg_id

AS
SELECT
    k.mandant_id               
   ,k.wup_id
   ,k.nb_id
   ,k.wrg_id
   ,k.kundenkarte_id
   ,k.crm_kundenkarte_art_id
   ,k.crm_konto_id
   ,k.crm_konto_typ_id
   ,k.dat
   ,v03.kjwo_ww
   ,SUM(k.anz_bons) AS anz_bons
   -- AP0202325/SPEC0292700 Umstellung auf akt. Berichtskurs (vorher Tageskurs) / sschuecke 04.02.2025
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_netto_sa
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_netto_sa* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_netto_sa* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_netto_sa END) AS ums_netto_sa
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_netto_af
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_netto_af* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_netto_af* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_netto_af END) AS ums_netto_af
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_brutto_sa
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_brutto_sa* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_brutto_sa* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_brutto_sa END) AS ums_brutto_sa
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_brutto_af
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_brutto_af* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN k.umsatz_brutto_af* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_brutto_af END) AS ums_brutto_af
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_netto_af + k.umsatz_netto_sa
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN (k.umsatz_netto_af + k.umsatz_netto_sa)* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN (k.umsatz_netto_af + k.umsatz_netto_sa)* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_netto_af + k.umsatz_netto_sa END) AS ums_netto
   ,SUM(CASE WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1,5)THEN  k.umsatz_brutto_af + k.umsatz_brutto_sa
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1,5) THEN (k.umsatz_brutto_af+ k.umsatz_brutto_sa)* v300.umrechnungskurs
             WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1,5) THEN (k.umsatz_brutto_af+ k.umsatz_brutto_sa)* v400.umrechnungskurs
             WHEN v02.wrg_typ_id = 1 THEN  k.umsatz_brutto_af+ k.umsatz_brutto_sa END) AS ums_brutto


FROM DBP_MSI_VIEW_EK_KUN.TBL_MV_CRM_F_ODS_BON_KOPF_KUNDE_TAG_SUM_2 k

/*--Umrechnung Landeswährung/Euro
JOIN dbp_view.v_kurs_2 kurs_2
    ON k.dat BETWEEN kurs.dat_von AND kurs.dat_bis
    AND k.wrg_id = kurs.von_wrg_id
    AND kurs.kurstyp_id = 9
    AND kurs.nach_wrg_id ='EUR'*/
    
   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND k.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_2 v400
   ON k.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND k.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

-- Ermittlung eingestellte Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02

LEFT OUTER JOIN dbp_view.v_werbewoche_kl_2 v03
ON k.dat=v03.dat AND k.mandant_id=v03.mandant_id

GROUP BY
    k.mandant_id               
   ,k.wup_id                    
   ,k.nb_id
   ,k.wrg_id
   ,k.kundenkarte_id
   ,k.crm_kundenkarte_art_id
   ,k.crm_konto_id
   ,k.crm_konto_typ_id
   ,k.dat
   ,v03.kjwo_ww;