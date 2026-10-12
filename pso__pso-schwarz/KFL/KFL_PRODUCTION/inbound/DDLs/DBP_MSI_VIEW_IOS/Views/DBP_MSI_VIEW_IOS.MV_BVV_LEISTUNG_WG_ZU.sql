CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_LEISTUNG_WG_ZU as
   -- leist_wg_zu (KEINE QUELLE)
   -- Gruppierung/Klassifizierung von inWG, abhaengig von der Endung eines PSP-Elements
   -- 16.10.2015 kkaiser: neu im Projekt 533, mandantenabhängig nur fuer Zuordnung zu inWG
   -- 20151217 ssch0611 : CASE/Umlaute angepasst
   -- 20180613 nfis0811:  Internationalisierung - Auslagerung Bezeichnungen

   SELECT
   v01.mandant_id, v01.bvv_leist_id, v02.psp_end_nr, v01.in_wg_id
   FROM dbp_view.v_leistung_psp_wg_zu v01
   JOIN dbp_view.v_l_bvv_leistung v02
   ON v01.bvv_leist_id = v02.bvv_leist_id;