CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_PROJEKT_ABRG_DAT_ZU_1 AS
-- AL  20.06.2013 Init
-- Logik wenn alle PSP Elemente von einem Projekt eine_1 dat_asbschluss enthalten ==> nehme maximale
-- wenn mindestens ein PSP Element NULL in dem Feld dat_asbschluss enthält ==> abgr_dat =101 und über Lookup ausgeblendet als ''

   SELECT v01.mandant_id,
   v01. in_projekt_id,
   MAX(in_projekt_id_char) AS in_projekt_id_char,
   MAX(COALESCE(dat_abschluss, '9999-12-31')) AS dat_,
   CASE WHEN dat_='9999-12-31'
   THEN '2001'
   ELSE dat_
   END AS abrg_dat

   FROM dbp_view.v_in_projekt_1 v01
   JOIN dbp_view.v_in_psp_element_1 v02
   ON
   v01.in_projekt_id = v02.in_projekt_id AND
   v01.mandant_id  =  v02.mandant_id

   WHERE statistisch_fg=1
   GROUP BY  v01.mandant_id,
   v01. in_projekt_id;