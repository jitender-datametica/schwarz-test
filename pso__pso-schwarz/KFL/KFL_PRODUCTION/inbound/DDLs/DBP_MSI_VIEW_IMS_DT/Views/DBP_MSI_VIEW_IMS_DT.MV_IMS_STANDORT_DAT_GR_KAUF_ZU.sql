CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_IMS_STANDORT_DAT_GR_KAUF_ZU
(
	STANDORT_ID,
	MANDANT_ID,
	DAT_,
	DAT_GR_KAUF
)
AS
-- 26.08.2013 twie: Ermittlung Datum Grundstückskauf pro Standort
-- Dazu dat_buch ermitteln, an dem erstmals Istkosten auf Berichtsposition 90 Grund und Boden für diesen Standort gebucht wurden

   SELECT
     v01.standort_id,
     v01. mandant_id,
     MIN(CASE 
           WHEN v04.berichts_position_invest_id = 90 -- GuB (Grund und Boden)
                THEN v04.dat_buch
           ELSE TO_DATE('9999-12-31','YYYY-MM-DD')
         END) AS dat_,
     CASE 
          WHEN dat_ = '9999-12-31'
             THEN TO_DATE('1900-01-01','YYYY-MM-DD')
          ELSE dat_
     END AS dat_gr_kauf
   FROM  dbp_view.v_ims_standort v01
   LEFT OUTER JOIN  dbp_view.v_in_projekt v02 
   ON v01.standort_id = v02.standort_id 
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN  dbp_view.v_in_psp_element v03 
   ON v02.in_projekt_id = v03.in_projekt_id 
   AND v02.mandant_id = v03.mandant_id 
   --Neue Projekte nur statistisch
   AND  v03.statistisch_fg  = 1
   LEFT OUTER JOIN  dbp_view.v_ist_kosten_det v04  
   ON v03.psp_id = v04.psp_id 
   AND v03.mandant_id = v04.mandant_id 
   --Alles was nicht auf PSP gebucht wird, ist für IMS Auswertungen nicht relevant
   AND  v04.psp_id <> -1  
   -- HB3 und Steuerliche Sichten werden ausgeschlossen
   AND NOT UPPER(COLLATE(v04.kostenart_id,''))  LIKE ANY ('I%', 'S%')   
   --Auszuschliessenden Kostenarten
   AND TRIM(COLLATE(v04.kostenart_id,''), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002')
   GROUP BY
   v01.standort_id
   ,v01. mandant_id
   ;