CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IMS_STANDORT_DAT_GR_KAUF_ZU_1
-- 26.08.2013 twie: Ermittlung Datum Grundstückskauf pro Standort
-- Dazu dat_buch ermitteln, an dem erstmals Istkosten auf Berichtsposition 90 Grund und Boden für diesen Standort gebucht wurden

AS
   SELECT
     v01.standort_id,
     v01. mandant_id,
     MIN(CASE 
           WHEN v04.berichts_position_invest_id = 90 -- GuB (Grund und Boden)
                THEN v04.dat_buch
           ELSE to_date('9999-12-31','YYYY-MM_1-DD')
         END) AS dat_,
     CASE 
          WHEN dat_ = '9999-12-31'
             THEN to_date('1900-01-01','YYYY-MM_1-DD')
          ELSE dat_
     END AS dat_gr_kauf
   FROM  dbp_view.v_ims_standort_1 v01
   LEFT OUTER JOIN  dbp_view.v_in_projekt_1 v02 
   ON v01.standort_id = v02.standort_id 
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN  dbp_view.v_in_psp_element_1 v03 
   ON v02.in_projekt_id = v03.in_projekt_id 
   AND v02.mandant_id = v03.mandant_id 
   --Neue Projekte nur statistisch
   AND  v03.statistisch_fg  = 1
   LEFT OUTER JOIN  dbp_view.v_ist_kosten_det_1 v04  
   ON v03.psp_id = v04.psp_id 
   AND v03.mandant_id = v04.mandant_id 
   --Alles was nicht auf PSP gebucht wird, ist für IMS Auswertungen nicht relevant
   AND  v04.psp_id <> -1  
   -- HB3 und Steuerliche Sichten werden ausgeschlossen
   AND NOT upper(collate(v04.kostenart_id,''))  LIKE ANY ('I%', 'S%')   
   --Auszuschliessenden Kostenarten
   AND TRIM(collate(v04.kostenart_id,''), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002')
   GROUP BY
   v01.standort_id
   ,v01. mandant_id;